import firebase_admin
from rest_framework import viewsets, status
from firebase_admin import credentials, auth
from rest_framework.response import Response

class Token():
    def verify_token(token, request):
                  # Lấy token từ FE
        id_token = request.headers.get("Authorization")
        if not id_token:
            return Response({"error": "Thiếu token"}, status=401)

        # Kiểm tra token và lấy UID
        try:
            decoded = auth.verify_id_token(id_token)
            user_id = decoded["uid"]
        except:
            return Response({"error": "Bạn chưa đăng nhập"}, status=status.HTTP_401_UNAUTHORIZED)