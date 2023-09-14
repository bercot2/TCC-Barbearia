from django.contrib.auth.hashers import make_password, check_password
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from core.mixins import RepresentationMixin
from . import models


class ContatoFuncionarioSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = models.ContatoFuncionario
        fields = '__all__'

class FuncionariosSerializer(serializers.ModelSerializer):

    def to_representation(self, instance):
        data = super().to_representation(instance)
        contatos = models.ContatoFuncionario.objects.filter(id_funcionario=instance)
        
        contatos_data = ContatoFuncionarioSerializer(contatos, many=True).data

        for contato in contatos_data:
            contato.pop("id_funcionario")
        
        data['contatos'] = contatos_data

        return data
    
    class Meta:
        model = models.Funcionarios
        fields = '__all__'

        validators = [
            UniqueTogetherValidator(
                queryset=models.Funcionarios.objects.all(),
                fields=['cpf'],
                message="Já existe funcionário com este CPF cadastrado!"
            )
        ]


class ClientesSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        validated_data['senha'] = make_password(validated_data['senha'])
        return super(ClientesSerializer, self).create(validated_data)
    
    class Meta:
        model = models.Clientes
        fields = "__all__"
        validators = [
            UniqueTogetherValidator(
                queryset=models.Clientes.objects.all(),
                fields=['cpf', 'email'],
                message="Já existe funcionário com este CPF cadastrado!"
            )
        ]

class ServicoSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Servico
        fields = "__all__"


class AgendamentoSerializer(serializers.ModelSerializer):

    class Meta:
        model = models.Agendamentos
        fields = "__all__"