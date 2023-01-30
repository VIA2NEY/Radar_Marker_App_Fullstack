from rest_framework import serializers
from markeurs import models


class MarkeurSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'latitude',
            'longitude',
            'description',
            'datecreation',
            'description'
        )
        model = models.Markeur

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        fields = (
            'id',
            'username',
            'password'
        )
        model = models.User