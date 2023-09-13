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
