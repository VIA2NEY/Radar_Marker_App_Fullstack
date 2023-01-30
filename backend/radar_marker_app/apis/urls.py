from django.urls import path

from.views import ListMarkeur,DetailMarkeur, login_user, user_list


urlpatterns = [
    path ('',ListMarkeur.as_view()),
    path('<int:pk>/', DetailMarkeur.as_view()),
    path('users/login/',login_user),
    path('users/inscrire/',user_list),
]