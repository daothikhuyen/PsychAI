from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from firebase_admin import firestore
import json

db = firestore.client()

@csrf_exempt
def register(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            username = data.get("username")
            email = data.get("email")
            password = data.get("password")

            if not username or not email or not password:
                return JsonResponse({"error": "Thiếu dữ liệu"}, status=400)

            # Kiểm tra trùng username/email
            users_ref = db.collection("users")
            existing = users_ref.where("email", "==", email).get()
            if existing:
                return JsonResponse({"error": "Email đã tồn tại"}, status=400)

            # Lưu vào Firestore
            user_data = {
                "username": username,
                "email": email,
                "password": password,  # ⚠️ demo, thực tế nên mã hóa!
            }
            users_ref.add(user_data)

            return JsonResponse({"message": "Đăng ký thành công", "user": user_data}, status=201)

        except Exception as e:
            return JsonResponse({"error": str(e)}, status=500)

    return JsonResponse({"error": "Chỉ hỗ trợ phương thức POST"}, status=405)
