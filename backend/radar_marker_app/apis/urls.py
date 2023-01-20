from django.urls import path

from.views import ListMarkeur,DetailMarkeur


urlpatterns = [
    path ('',ListMarkeur.as_view()),
    path('<int:pk>/', DetailMarkeur.as_view())
]