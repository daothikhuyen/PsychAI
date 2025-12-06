from rest_framework.authentication import BaseAuthentication
from rest_framework import permissions
from firebase_admin import auth as firebase_auth
from rest_framework import exceptions


class FirebaseAuthentication(BaseAuthentication, permissions.BasePermission):
    def authenticate(self, request):
        id_token = request.headers.get('Authorization')
        if not id_token:
            return None

        if id_token.startswith("Bearer "):
            id_token = id_token.split(" ")[1]

        try:
            decoded_token = firebase_auth.verify_id_token(id_token)
            uid = decoded_token['uid']
        except Exception:
            raise exceptions.AuthenticationFailed("Invalid Firebase ID token")

        user_record = firebase_auth.get_user(uid)
        return (user_record, None)  

