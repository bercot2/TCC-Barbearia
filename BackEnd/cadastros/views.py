import traceback

from datetime import datetime
from django.contrib.auth.hashers import check_password
from django.db.models import Q
from rest_framework import status
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


class ClientesViewSet(viewsets.ModelViewSet):
    queryset = models.Clientes.objects.all()
    serializer_class = serializers.ClientesSerializer
    
    @action(detail=False, methods=['post'])
    def validar_senha(self, request):
        cpf = request.data.get('cpf', None)
        email = request.data.get('email', None)
        senha = request.data.get('senha', None)
        
        cliente = self.get_queryset().filter(cpf=cpf).values() if cpf else self.get_queryset().filter(email=email).values()
        
        if cliente:
            senha_criptografada = cliente[0]["senha"]

            if senha and senha_criptografada:
                senha_correta = check_password(senha, senha_criptografada)

                if senha_correta:
                    return Response({'mensagem': 'A senha é correta.'}, status=status.HTTP_200_OK)
                else:
                    return Response({'mensagem': 'A senha é incorreta.'}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            return Response({'mensagem': 'Usuário não encontrado!'}, status=status.HTTP_400_BAD_REQUEST)