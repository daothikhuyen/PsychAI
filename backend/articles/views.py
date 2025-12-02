import traceback
from rest_framework.response import Response
from rest_framework import viewsets, status
from firebase_admin import firestore
from backend.utils.firestore_utils import serialize_doc
from permission.authentication import FirebaseAuthentication
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action

db = firestore.client()

class ArticlesView(viewsets.GenericViewSet,viewsets.ViewSet):
    authentication_classes = [FirebaseAuthentication]
    permission_classes = [IsAuthenticated]   

    def list(self,request):
        user = request.user
        try:
            doc_ref = db.collection('articles').get()
            articles = [serialize_doc(doc) for doc in doc_ref]
            return Response({"result": articles}, status=status.HTTP_200_OK)
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def retrieve(self, request, pk=None):
        try:
            doc_ref = db.collection('articles').document(pk).get()
            if not doc_ref.exists:
                return Response({"error": "Dữ liệu không có"}, status=status.HTTP_400_BAD_REQUEST)
            
            return  Response({"result" : serialize_doc(doc_ref)}, status=status.HTTP_200_OK) 
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    @action(detail=True, methods=['get'])
    def list_by_topic(self, request, pk=None):
        try:
            
            doc_ref = db.collection('articles')
            col_ref = doc_ref.where('topic_id', '==', int(pk)).stream()
            articles = [serialize_doc(doc) for doc in col_ref]

            if articles: 
                return Response({"result": articles}, status=status.HTTP_200_OK)
            else:
                return Response({"error": "Bài viết không tồn tại"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            traceback.print_exc()
            return Response({"error": str(e)},status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    @action(detail=False, methods=['get'])
    def search(self, request):
        query_text = request.query_params.get('q', '').strip()
        if not query_text:
             return Response({"error": "Vui lòng nhập từ khóa tìm kiếm"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            title_ref = db.collection('articles')
            title_query = title_ref.where("title", ">=", query_text).where("title", "<=", query_text).stream()
            title_results = [doc.to_dict() for doc in title_query]

            tag_ref = db.collection('articles')
            tag_query = tag_ref.where("tags", "array_contains", query_text).stream()
            tag_results = [doc.to_dict() for doc in tag_query]

            results_dict = {a['id']: a for a in title_results + tag_results}
            results = list(results_dict.values()) 

            return Response({"results": results}, status=status.HTTP_200_OK)
        
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
    def count_like(self, article_id):
        count_query = db.collection('article_like') \
                    .where('article_id', '==', article_id) \
                    .stream()
        likes_count = sum(1 for _ in count_query)
        return likes_count

    def like(self, request):
        user = request.user
        data = request.data

        if not data:
            return Response({"error": "Dữ liệu không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)

        article_id = data.get('article_id')

        try:
            like_query = db.collection('article_like') \
                            .where('user_id', '==', user.uid) \
                            .where('article_id', '==', article_id) \
                            .limit(1) \
                            .stream()

            existing_like = None
            for doc in like_query:
                existing_like = doc
                break

            if existing_like is None:
                new_doc_ref = db.collection('article_like').document()
                new_doc_ref.set({
                    "user_id": user.uid,
                    "article_id": article_id,
                    "created_at": firestore.SERVER_TIMESTAMP
                })

                likes_count = self.count_like(article_id)

                result = Response({
                    "liked": True,
                    "likes_count": likes_count
                }, status=status.HTTP_200_OK)

            else:
                db.collection('article_like').document(existing_like.id).delete()

                likes_count = self.count_like(article_id)

                result = Response({
                    "liked": False,
                    "likes_count": likes_count
                }, status=status.HTTP_200_OK)

            return result

        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def save_hobby(self, request):
        user = request.user
        data = request.data

        if not data:
            return Response({"error": "Dữ liệu không hợp lệ"}, status=status.HTTP_400_BAD_REQUEST)

        article_id = data.get('article_id')

        try:
            doc_ref = db.collection('article_save').document()     
            doc_ref.set({
                "user_id" : user.uid,
                "article_id": article_id,
                "created_at": firestore.SERVER_TIMESTAMP
            })
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
