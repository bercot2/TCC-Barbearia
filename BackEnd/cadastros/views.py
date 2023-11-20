import traceback

from datetime import datetime
from django.contrib.auth.hashers import check_password
from django.db.models import Q
from rest_framework import status
from rest_framework import viewsets
from rest_framework.viewsets import ModelViewSet
from rest_framework.decorators import api_view, action
from rest_framework.response import Response
from rest_framework.mixins import CreateModelMixin, UpdateModelMixin
from . import models, serializers


class FuncionarioViewSet(viewsets.ModelViewSet):
    queryset = models.Funcionarios.objects.all()
    serializer_class = serializers.FuncionariosSerializer


class ContatoFuncionarioViewSet(viewsets.GenericViewSet, CreateModelMixin, UpdateModelMixin):
    queryset = models.ContatoFuncionario.objects.all()
    serializer_class = serializers.ContatoFuncionarioSerializer


class ClientesViewSet(viewsets.ModelViewSet):
    queryset = models.Clientes.objects.all()
    serializer_class = serializers.ClientesSerializer
    filterset_fields = ['id','email', 'cpf']
    
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
                    return Response({'mensagem': True}, status=status.HTTP_200_OK)
                else:
                    return Response({'mensagem': 'Senha incorreta.'}, status=status.HTTP_401_UNAUTHORIZED)
        else:
            return Response({'mensagem': 'Usuário não encontrado!'}, status=status.HTTP_400_BAD_REQUEST)
        
        
class ServicoViewSet(viewsets.ModelViewSet):
    queryset = models.Servico.objects.all().order_by('descricao')
    serializer_class = serializers.ServicoSerializer
    filterset_fields = ['id', 'e_ativo']


class AgendamentoViewSet(viewsets.ModelViewSet):
    queryset = models.Agendamentos.objects.all()
    serializer_class = serializers.AgendamentoSerializer
    filterset_fields = ['id', 'id_cliente']

class ProdutosViewSet(viewsets.ModelViewSet):
    queryset = models.Produtos.objects.all()
    serializer_class = serializers.ProdutosSerializer
