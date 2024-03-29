from rest_framework import generics
from .models import UploadImage
from .serializers import UploadImageSerializer

# Create your views here.
#GET POST UPDATE DELETE
class UploadImageGetCreate(generics.ListCreateAPIView):
    queryset = UploadImage.objects.all()
    serializer_class = UploadImageSerializer

class UploadImageUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = UploadImage.objects.all()
    serializer_class = UploadImageSerializer