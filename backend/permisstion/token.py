import firebase_admin
from firebase_admin import credentials, auth

class Token():
    def verify_token(token):
        try:
            decoded = auth.verify_id_token(token)
            uid = decoded['uid']
            email = decoded.get('email')
            return {"uid": uid, "email": email}
        except Exception as e:
            return {"error": str(e)}