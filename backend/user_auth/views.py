from rest_framework import viewsets, status
from rest_framework.decorators import action
from .serializers import UserSerializers
from rest_framework.response import Response
from firebase_admin import firestore, auth
from django.conf import settings
import requests
from rest_framework import viewsets, status
from rest_framework.decorators import action
from .serializers import UserSerializers
from rest_framework.response import Response
from firebase_admin import firestore, auth
from django.conf import settings
import requests

db = firestore.client()


class UserViewSet(viewsets.ViewSet):

    def check_user_exists(self, email):
        try:
            user = auth.get_user_by_email(email)
            return True
        except auth.UserNotFoundError:
            return False

    @action(detail=False, methods=['post'])
    def signup(self,request):
        serializer = UserSerializers(data = request.data)
        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST) 
        
        data = serializer.validated_data
        username = data['username']
        email = data['email']
        password = data['password']

        try:
            if self.check_user_exists(email):
                return Response({"message": "Account already exists"}, status=status.HTTP_400_BAD_REQUEST)

            user_record = auth.create_user(
                email = email,
                password = password,
                display_name = username
            )

            db.collection('users').document(user_record.uid).set({
                'uid': user_record.uid,
                'username': username,
                'email': email,
                'phone' : '',
                'avatar': '',
                'created_at': firestore.SERVER_TIMESTAMP,
                'update_at': firestore.SERVER_TIMESTAMP
            })

            return Response({"message": "Create User success"}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_400_BAD_REQUEST)

    def _firebase_signin(seft, email, password):

        url = f"https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key={settings.FIREBASE_API_KEY}"
        payload = {
            "email": email,
            "password": password,
            "returnSecureToken": True
        }
        r = requests.post(url, json=payload)
        data = r.json()

        if "error" in data:
            raise Exception(data["error"]["message"])
        
        id_token = data["idToken"]
        decoded_token = auth.verify_id_token(id_token)
        uid = decoded_token["uid"]
        user_record = auth.get_user(uid)

        return {
            "uid": user_record.uid,
            "email": user_record.email,
            "display_name": user_record.display_name,
            "phone_number": user_record.phone_number,
            "photo_url": user_record.photo_url
        }
    
    @action(detail= False, methods=['post'])    
    def signin(self, request):
        data = request.data
        email = data.get('email', None)
        password = data.get('password', None)

        if not email or not password:
            return Response({"message": "Email and password cannot be empty"}, status=status.HTTP_400_BAD_REQUEST)
        
        try:
            user_info = self._firebase_signin(email, password)
            return Response({"user": user_info}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({"message": str(e)}, status=status.HTTP_401_UNAUTHORIZED)
        
    @action(detail= False, methods=['post'])    
    def google_signin(self,request):
        id_token = request.data.get("id_token")
        if not id_token:
            return Response({"error": "id_token required"}, status=400)

        try:
            decoded_token = auth.verify_id_token(id_token)
            uid = decoded_token["uid"]

            user_record = auth.get_user(uid)
            user_info = {
                "uid": user_record.uid,
                "email": user_record.email,
                "display_name": user_record.display_name,
                "photo_url": user_record.photo_url,
            }

            return Response({"user": user_info})
        except Exception as e:
            return Response({"error": str(e)}, status=401)  
            return Response({"error": str(e)}, status=401)  
