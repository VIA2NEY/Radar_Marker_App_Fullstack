from django.shortcuts import render

from rest_framework import generics
# Create your views here.

from markeurs import models
from .serializers import MarkeurSerializer


class ListMarkeur(generics.ListCreateAPIView): 
    queryset = models.Markeur.objects.all()
    serializer_class = MarkeurSerializer


class DetailMarkeur(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Markeur.objects.all()
    serializer_class = MarkeurSerializer