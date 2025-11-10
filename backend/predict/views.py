from rest_framework import viewsets, status
from rest_framework.decorators import action
from .serializers import PredictSerializers
from rest_framework.response import Response
from firebase_admin import firestore
import numpy as np
import cv2
import traceback
import mediapipe as mp
import tensorflow as tf
from collections import Counter
from datetime import datetime
from google.cloud.firestore_v1.base_query import FieldFilter

db = firestore.client()

# Load model
emotion_model = tf.keras.models.load_model('predict/ml/fer2013_cnn_improved.h5')
gender_model = tf.keras.models.load_model('predict/ml/gender_model.h5')

emotion_labels = ['Angry', 'Disgust', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral']
gender_labels = ['Male', 'Female']

mp_face_detection = mp.solutions.face_detection

def _serialize_doc(doc):
    data = doc.to_dict() or {}
    out = {"id": doc.id}
    for k, v in data.items():
        if hasattr(v, "ToDatetime"):
            try:
                out[k] = v.ToDatetime().isoformat()
            except Exception:
                out[k] = str(v)
        elif isinstance(v, datetime):
            out[k] = v.isoformat()
        else:
            out[k] = v
    return out

class PredictAIViewSet(viewsets.GenericViewSet,viewsets.ViewSet):

    def save_prediction(self, email, user_id, gender, emotions, final_emotion):
        try:
            predict_info = {
                "user_id": user_id,
                "email": email,
                "gender": gender,
                "emotions": emotions,
                "final_emotion": final_emotion,
                "created_at": datetime.utcnow(),
                "update_at":  datetime.utcnow(),
            }

            write_time, doc_ref = db.collection("predictions").add(predict_info)
            return {
                    "id": doc_ref.id,
                    "user_id": user_id,
                    "email": email,
                    "gender": gender,
                    "emotions": emotions,
                    "final_emotion": final_emotion,
                }
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)   
         
    @action(detail=False, methods=['post'])
    def face_analysis(self,request):
        serializer = PredictSerializers(data = request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST) 

        data = serializer.validated_data
        email = data['email']
        user_id = data['user_id']
        images = data['images']

        emotions = []
        genders = []
        face_inputs = []
        for img in images:
            image_bytes = np.frombuffer(img.read(), np.uint8)
            frame = cv2.imdecode(image_bytes, cv2.IMREAD_COLOR)
            if frame is None:
                return Response({'error': 'Invalid image'}, status=status.HTTP_400_BAD_REQUEST) 

            with mp_face_detection.FaceDetection(model_selection=0, min_detection_confidence=0.5) as face_detection:
                rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                face_results = face_detection.process(rgb_frame)

                if not face_results.detections:
                    emotions.append('no_face')
                    genders.append('unknown')
                    continue

                detection = face_results.detections[0]
                bboxC = detection.location_data.relative_bounding_box
                ih, iw, _ = frame.shape
                x1 = int(bboxC.xmin * iw)
                y1 = int(bboxC.ymin * ih)
                w = int(bboxC.width * iw)
                h = int(bboxC.height * ih)
                x1, y1, x2, y2 = max(0, x1), max(0, y1), min(iw, x1 + w), min(ih, y1 + h)

                face_crop = frame[y1:y2, x1:x2]
                if face_crop.shape[0] < 10 or face_crop.shape[1] < 10:
                    return  Response({'error': 'Face too small'}, status=status.HTTP_400_BAD_REQUEST) 

                face_gray = cv2.cvtColor(face_crop, cv2.COLOR_BGR2GRAY)
                face_resized = cv2.resize(face_gray, (48, 48))
                face_input = face_resized.astype("float32") / 255.0
                face_input = np.expand_dims(face_input, axis=(0, -1))
                face_inputs.append(face_input)

        if not face_inputs:
            return Response({'error': 'No faces detected'}, status=status.HTTP_400_BAD_REQUEST)  

        face_inputs = np.vstack(face_inputs)  # (N,48,48,1)
        gender_preds = gender_model.predict(face_inputs, verbose=0)
        emotion_preds = emotion_model.predict(face_inputs, verbose=0)

        genders = [gender_labels[np.argmax(g)] for g in gender_preds]
        emotions = [emotion_labels[np.argmax(e)] for e in emotion_preds]      

        first_gender = genders[0]
        if any(g != first_gender for g in genders):
            return Response({
            'error': 'All images must be of the same person — inconsistent gender detected!',
            'detected_genders': genders
        }, status=status.HTTP_400_BAD_REQUEST)

        final_emotion = Counter(emotions).most_common(1)[0][0]
        result_predict = self.save_prediction(email, user_id, first_gender, emotions, final_emotion)

        return Response(result_predict, status=status.HTTP_200_OK) 
    
    def retrieve(self, request, pk=None):
        try:
            doc_ref = db.collection('predictions').document(pk).get()
            if not doc_ref.exists:
                return Response({"error": "Document not found"}, status=404)
            
            return  Response(_serialize_doc(doc_ref), status=status.HTTP_200_OK) 
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    
    def list(self, request):
        user_id = request.data.get('user_id')

        if not user_id:
            return Response({"error": "Data cannot be left blank"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            col_ref = db.collection('predictions')
            if user_id:
                docs = col_ref.where(filter=FieldFilter("user_id", "==", user_id)).stream()
            else:
                docs = col_ref.stream()

            results = []
            for doc in docs:
                results.append(_serialize_doc(doc))

            return Response({"count": len(results), "results": results}, status=status.HTTP_200_OK)

        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def destroy(self, request, pk=None):
        if not pk:
            return Response({"error": "Document id not provided"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            doc_ref = db.collection('predictions').document(pk)
            doc = doc_ref.get()
            if not doc.exists:
                return Response({"error": "The predicted result does not exist."}, status=status.HTTP_404_NOT_FOUND)
            
            doc_ref.delete()
            return Response({"Delete Successfully"}, status=status.HTTP_200_OK)
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)


