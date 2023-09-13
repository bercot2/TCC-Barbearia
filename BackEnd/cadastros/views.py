import traceback

from datetime import datetime
from django.db.models import Q
from rest_framework import viewsets
from rest_framework.viewsets import ModelViewSet
from rest_framework.decorators import api_view, action
from rest_framework.response import Response
from rest_framework.mixins import CreateModelMixin
from . import models, serializers


class FuncionarioViewSet(viewsets.ModelViewSet):
    queryset = models.Funcionarios.objects.all()
    serializer_class = serializers.FuncionariosSerializer


class ContatoFuncionarioViewSet(viewsets.GenericViewSet, CreateModelMixin):
    queryset = models.ContatoFuncionario.objects.all()
    serializer_class = serializers.ContatoFuncionarioSerializer
