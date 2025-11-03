import firebase_admin
from firebase_admin import credentials, firestore

# read file key
cred = credentials.Certificate('./firebase_key.json')

# check if not init then init
if not firebase_admin._apps:
    firebase_admin.initialize_app(cred)

# Create client Firestore
db = firestore.client()
