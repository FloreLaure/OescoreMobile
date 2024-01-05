
from django.urls import path
from .views import create_user

urlpatterns = [
    # ... autres URLs de votre application ...
    path('api/create_user/', create_user, name='create_user'),
]