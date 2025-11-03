from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import numpy as np
import cv2
import mediapipe as mp
from datetime import datetime
from firebase_admin import firestore
from django.core.files.uploadedfile import InMemoryUploadedFile
import tensorflow as tf
import io


# Load model
emotion_model = tf.keras.models.load_model('predict/ml/fer2013_cnn_improved.h5')
gender_model = tf.keras.models.load_model('predict/ml/gender_model.h5')

emotion_labels = ['Angry', 'Disgust', 'Fear', 'Happy', 'Sad', 'Surprise', 'Neutral']
gender_labels = ['Male', 'Female']

mp_face_detection = mp.solutions.face_detection

@csrf_exempt
def predict(request):
    if request.method != 'POST':
        return JsonResponse({'error': 'POST required'}, status=405)

    if 'image' not in request.FILES:
        return JsonResponse({'error': 'No image uploaded'}, status=400)

    file = request.FILES['image']
    if isinstance(file, InMemoryUploadedFile):
        image_bytes = np.frombuffer(file.read(), np.uint8)
    else:
        return JsonResponse({'error': 'Invalid file'}, status=400)

    frame = cv2.imdecode(image_bytes, cv2.IMREAD_COLOR)
    if frame is None:
        return JsonResponse({'error': 'Invalid image'}, status=400)

    with mp_face_detection.FaceDetection(model_selection=0, min_detection_confidence=0.5) as face_detection:
        rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = face_detection.process(rgb_frame)

        if not results.detections:
            return JsonResponse({'error': 'No face detected'}, status=200)

        detection = results.detections[0]
        bboxC = detection.location_data.relative_bounding_box
        ih, iw, _ = frame.shape
        x1 = int(bboxC.xmin * iw)
        y1 = int(bboxC.ymin * ih)
        w = int(bboxC.width * iw)
        h = int(bboxC.height * ih)
        x1, y1, x2, y2 = max(0, x1), max(0, y1), min(iw, x1 + w), min(ih, y1 + h)

        face_crop = frame[y1:y2, x1:x2]
        if face_crop.shape[0] < 10 or face_crop.shape[1] < 10:
            return JsonResponse({'error': 'Face too small'}, status=200)

        face_gray = cv2.cvtColor(face_crop, cv2.COLOR_BGR2GRAY)
        face_resized = cv2.resize(face_gray, (48, 48))
        face_input = face_resized.astype("float32") / 255.0
        face_input = np.expand_dims(face_input, axis=(0, -1))

        gender_pred = gender_model.predict(face_input, verbose=0)[0]
        gender = gender_labels[np.argmax(gender_pred)]

        emotion_pred = emotion_model.predict(face_input, verbose=0)[0]
        emotion = emotion_labels[np.argmax(emotion_pred)]

        return JsonResponse({'gender': gender, 'emotion': emotion})

