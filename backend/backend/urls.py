from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/auth/', include('user_auth.urls')),
    path('api/predict/', include('predict.urls')),
    path('api/test/', include('psych_test.urls')),
]
