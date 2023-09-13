from django.db import models
from django.contrib.auth import get_user_model, get_user
from django.db import models


class Funcionarios(models.Model):
    nome = models.CharField()
    cpf = models.CharField(max_length=14, unique=True)
    data_nascimento = models.CharField()

    class Meta:
        db_table = 'funcionarios'


class ContatoFuncionario(models.Model):
    telefone = models.CharField()
    email = models.CharField()
    
    id_funcionario = models.ForeignKey(Funcionarios, on_delete=models.CASCADE, db_column="id_funcionario", related_name="contato_funcionario")

    class Meta:
        db_table = 'contato_funcionario'

class Clientes(models.Model):
    nome = models.CharField()
    data_nascimento = models.DateField()
    cpf = models.CharField(max_length=14, unique=True)
    email = models.CharField()
    telefone = models.CharField(null=True)
    senha = models.CharField()

    class Meta:
        db_table = 'clientes'