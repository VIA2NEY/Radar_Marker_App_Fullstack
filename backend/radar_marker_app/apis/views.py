from django.shortcuts import render

from rest_framework import generics
# Create your views here.

from markeurs import models
from .serializers import MarkeurSerializer,UserSerializer

from django.contrib.auth import authenticate,login
from django.views.decorators.csrf import csrf_exempt
from django.http.response import JsonResponse
from rest_framework import status


class ListMarkeur(generics.ListCreateAPIView): 
    queryset = models.Markeur.objects.all()
    serializer_class = MarkeurSerializer


class DetailMarkeur(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Markeur.objects.all()
    serializer_class = MarkeurSerializer

@csrf_exempt
def login_user(request) :
    if request.method == 'POST' :
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(username=username, password=password)
        if user :
            login(request, user)
            return JsonResponse({'message': 'Connexion reussi'}, status= status.HTTP_200_OK)
        return JsonResponse({'message': 'Identifiant ou mot de passe incorrect'}, status= status.HTTP_401_UNAUTHORIZED)

@csrf_exempt
def  user_list(request) :
    if request.method == 'GET' :
        user = models.User.objects.all()

        userSerializer = UserSerializer(user, many=True)
        return JsonResponse(userSerializer.data, safe=False)
    
    elif request.method == 'POST' :
        userSerializer = UserSerializer(data=request.POST)

        if userSerializer.is_valid() :
            userSerializer.save()

            return JsonResponse(user.data, status=status.HTTP_201_CREATED )
        return JsonResponse(userSerializer.errors, status=status.HTTP_400_BAD_REQUEST)