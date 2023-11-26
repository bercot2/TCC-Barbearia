from django.db import models
from django.db import models


class Funcionarios(models.Model):
    nome = models.CharField()
    cpf = models.CharField(max_length=14, unique=True)
    data_nascimento = models.CharField()
    dias_disponiveis = models.CharField()
    horarios_disponiveis = models.CharField()
    hora_inicio = models.TimeField()
    hora_final = models.TimeField()

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
    email = models.CharField(unique=True)
    telefone = models.CharField()
    senha = models.CharField(blank=True)

    class Meta:
        db_table = 'clientes'

class Servico(models.Model):
    descricao = models.CharField()
    valor = models.FloatField()
    e_ativo = models.BooleanField()
    tempo_servico = models.TimeField()

    class Meta:
        db_table = 'servico'

class Agendamentos(models.Model):

    data_hora_agendamento = models.DateTimeField()

    id_cliente = models.ForeignKey(Clientes, on_delete=models.CASCADE, db_column="id_cliente", related_name="cliente_agendamento")
    id_funcionario = models.ForeignKey(Funcionarios, on_delete=models.CASCADE, db_column="id_funcionario", related_name="funcionario_agendamento")
    id_servico = models.ForeignKey(Servico, on_delete=models.DO_NOTHING, db_column="id_servico", related_name="servicos_agendamento")

    class Meta:
        db_table = 'agendamentos'

class Produtos(models.Model):

    descricao = models.CharField()
    valor = models.FloatField()

    class Meta:
        db_table = 'produtos'
