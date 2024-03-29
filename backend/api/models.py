from django.db import models

# Create your models here.
class UploadImage(models.Model):
    title = models.TextField()
    image = models.ImageField(upload_to='images/')
    # midiFile = models.TextField()

    def __str__(self):
        return self.title