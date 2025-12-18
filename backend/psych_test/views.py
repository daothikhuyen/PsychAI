from django.shortcuts import render
from rest_framework import viewsets, status
from rest_framework.response import Response
from firebase_admin import firestore
from permission.authentication import FirebaseAuthentication
from backend.utils.firestore_utils import serialize_doc
from datetime import datetime
from predict.views import PredictAIViewSet
from user_auth.views import UserViewSet
from rest_framework.permissions import IsAuthenticated

db = firestore.client()

# Create your views here.
class PsychTestViewSet(viewsets.GenericViewSet,viewsets.ViewSet):
    authentication_classes = [FirebaseAuthentication]
    permission_classes = [IsAuthenticated] 

    def interpret_overall(self, prediction_id, dass_result):
        predict_ai = PredictAIViewSet()
        emotion = predict_ai.get_final_emotion(prediction_id)
        if emotion:
            emotion_lower = emotion.lower()
        else:
            raise ValueError(f"Không tìm thấy thông tin cảm xúc")
            
        depression_level = dass_result["depression"]["level"]
        stress_level = dass_result["stress"]["level"]
        anxiety_level = dass_result["anxiety"]["level"]

        # Case of depression
        if emotion_lower == "Buồn" and depression_level in ["Vừa", "Nặng", "Rất nặng"]:
            return "Có dấu hiệu trầm cảm, nên nghỉ ngơi và chia sẻ với người thân hoặc chuyên gia."

        # In case of stable psychology
        elif emotion_lower == "Vui vẻ" and all(d["level"] == "Bình thường" for d in dass_result.values()):
            return "Tâm lý ổn định, cảm xúc tích cực. Tiếp tục duy trì nhé!"

        # High stress situations
        elif emotion_lower == "Tức giân" and stress_level in ["Nặng", "Rất nặng"]:
            return "Căng thẳng cao, cần thư giãn hoặc thay đổi môi trường làm việc."

        # High anxiety cases
        elif emotion_lower in ["Lo lắng", "Ngạc nhiên"] and anxiety_level in ["Nặng", "Rất nặng"]:
            return "Lo âu cao, nên hít thở sâu, thư giãn và chia sẻ cảm xúc với người tin cậy."

        # The remaining cases
        else:
            return "Cảm xúc của bạn hiện chưa tốt lắm, nên theo dõi thêm về cảm xúc và giấc ngủ."

    #return the results after taking the test
    def classify_dass21(self,score, prediction_id):
        levels = {
            "stress" : [(0,14, "Bình thường"), (15,18, "Nhẹ"), (19,25, "Vừa"), (26,33, "Nặng"), (34,999, "Rất nặng")],
            "anxiety" : [(0,7, "Bình thường"), (8,9, "Nhẹ"), (10,14, "Vừa"), (15,19, "Nặng"), (20,999, "Rất nặng")],
            "depression" : [(0,9, "Bình thường"), (10,13, "Nhẹ"), (14,20, "Vừa"), (21,27, "Nặng"), (28,999, "Rất nặng")]
        }

        result = {}
        for scale, value in score.items():
            for(low, high, label) in levels[scale]:
                if low <= value * 2 <= high:
                    result[scale] = {"score": value, "level" : label}
                    break
        return self.interpret_overall(prediction_id, result)
    
    def retrieve(self, request, pk=None):
        try:
            # Get all test cases with prediction_id
            test_docs = list(db.collection('dass21_tests')
                            .where("prediction_id", "==", pk)
                            .stream())
            
            if not test_docs:
                return Response({"error": "Không tìm thấy bài test nào"}, status=status.HTTP_404_NOT_FOUND)
            
            # Get the first test (if there is only 1 prediction_id)
            test_doc = test_docs[0]
            test_data = serialize_doc(test_doc)
            
            # Get related answers
            ans_docs = list(db.collection('dass21_answers')
                                .where("test_id", "==", test_doc.id)
                                .stream())
            answers = [serialize_doc(a) for a in ans_docs]

            return Response({
                "test": test_data,
                "answers": answers
            }, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
  

    def list(self, request):
        try:
            doc_ques = db.collection('psych_questions').stream()
            doc_ans = db.collection('psych_answers').stream()

            result_ques = []
            for question in doc_ques:
                result_ques.append(serialize_doc(question))

            result_ans = []
            for answer in doc_ans:
                result_ans.append(serialize_doc(answer))

            return Response({"questions": result_ques, "answers": result_ans}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def create(self, request):
        user = request.user
        is_auth = UserViewSet()
        data = request.data
        user_id = user.uid
        prediction_id = data.get("prediction_id")
        answers = data.get("answers", [])

        user = is_auth.get_user_by_firebase(user_id)
        if isinstance(user, Response):
            return user 
        
        if not answers :
            return Response({"error": "Bạn chưa trả lời câu hỏi"}, status=status.HTTP_400_BAD_REQUEST)
    
        #Score for each group
        score = {"stress": 0, "anxiety": 0, "depression": 0}

        # Mapping questions for 3 groups
        stress_questions = [1, 6, 8, 11, 12, 14, 18]
        anxiety_questions = [2, 4, 7, 9, 15, 19, 20]
        depression_questions = [3, 5, 10, 13, 16, 17, 21]

        for ans in answers:
            qid = ans['question_id']
            val = ans['answer_value']
            if qid in stress_questions:
                score['stress'] += val
            elif qid in anxiety_questions:
                score['anxiety'] += val
            elif qid in depression_questions:
                score['depression'] += val

        # --- Save the total record to dass21_tests ---
        test_data = {
            "user_id": user_id,
            "prediction_id": prediction_id,
            "stress_score": score['stress'],
            "anxiety_score": score['anxiety'],
            "depression_score": score['depression'],
            "created_at": datetime.utcnow(),
            "updated_at": datetime.utcnow()
        }

        try:
            test_ref = db.collection("dass21_tests").add(test_data)
            test_id = test_ref[1].id

            #Save each answer to dass21_answers
            batch = db.batch()
            answers_ref = db.collection("dass21_answers")

            for ans in answers:
                doc_ref = answers_ref.document()
                batch.set(doc_ref, {
                    "test_id": test_id,
                    "question_id": ans["question_id"],
                    "answer_value": ans["answer_value"],
                    "created_at": datetime.utcnow()
                })
            #Commit batch only once
            batch.commit()

            result_test = self.classify_dass21(score,prediction_id)

            return Response({
                "test_id": test_id,
                "score": score,
                "result_test": result_test,
            }, status=status.HTTP_201_CREATED)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
    def destroy(self, request, pk=None):
        try:
            predict_ai = PredictAIViewSet()

            prediction_deleted = predict_ai.destroy_prediction(pk)

            if not prediction_deleted:
                    return Response({"error": "Không thể xoá hoặc không tìm thấy prediction."},
                            status=status.HTTP_404_NOT_FOUND)
            
            test_docs = list(db.collection('dass21_tests')
                            .where("prediction_id", "==", pk)
                            .stream())

            if len(test_docs) == 0:
                return Response({"message": "Bài kiểm tra không tồn tại"}, status=status.HTTP_404_NOT_FOUND)

            total_answers = 0

            for test in test_docs:
                test.reference.update({
                    "is_deleted": True,
                    "updated_at": firestore.SERVER_TIMESTAMP
                })

                #get related questions
                ans_docs = list(db.collection('dass21_answers')
                                    .where("test_id", "==", test.id)
                                    .stream())

                total_answers += len(ans_docs)

                for ans in ans_docs:
                    ans.reference.update({
                        "is_deleted": True,
                        "updated_at": firestore.SERVER_TIMESTAMP
                    })
            return Response({"message": "Xoá thành công"}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


        


