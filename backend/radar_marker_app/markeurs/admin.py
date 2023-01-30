from django.contrib import admin

# Register your models here.
from .models import Markeur,User

admin.site.register(Markeur)
admin.site.register(User)