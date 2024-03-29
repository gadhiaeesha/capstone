from django.urls import path
from .views import UploadImageGetCreate, UploadImageUpdateDelete

urlpatterns = [
    path('', UploadImageGetCreate.as_view()), #if path is empty or no id/int provided
    path('<int:pk>', UploadImageUpdateDelete.as_view()) #if an id/int or primary key is given
]