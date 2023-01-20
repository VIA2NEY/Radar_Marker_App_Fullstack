from django.db import models


# Create your models here.
class Markeur(models.Model):

    latitude = models.FloatField()
    longitude = models.FloatField()
    description = models.CharField(max_length=50)
    # photo = models.ImageField()
    datecreation = models.DateTimeField(auto_now=True)
    description = models.TextField()

    # def __str__(self):
    #     return self.latitude


# class Todo(models.Model):
#     title = models.CharField(max_length=200)
#     description = models.TextField()

#     def __str__(self):
#         return self.title


# class Todo(models.Model):
#     title = models.CharField(max_length=200)
#     description = models.TextField()

#     def __str__(self):
#         return self.title