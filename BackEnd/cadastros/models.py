from django.db import models
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
    email = models.CharField(unique=True)
    telefone = models.CharField()
    senha = models.CharField(blank=True)

    class Meta:
        db_table = 'clientes'

class Servico(models.Model):
    descricao = models.CharField()
    valor = models.FloatField()
    e_ativo = models.BooleanField()

    class Meta:
        db_table = 'servico'

class Agendamentos(models.Model):

    data_hora_agendamento = models.DateField()

    id_cliente = models.ForeignKey(Clientes, on_delete=models.CASCADE, db_column="id_cliente", related_name="cliente_agendamento")
    id_funcionario = models.ForeignKey(Funcionarios, on_delete=models.CASCADE, db_column="id_funcionario", related_name="funcionario_agendamento")

    class Meta:
        db_table = 'agendamentos'

class ServicosAgendamento(models.Model):

    id_agendamento = models.ForeignKey(Agendamentos, on_delete=models.CASCADE, db_column="id_agendamento", related_name="servicos_agendamento_agendamento")
    id_servico = models.ForeignKey(Servico, on_delete=models.DO_NOTHING, db_column="id_servico", related_name="servicos_agendamento_servico")

    class Meta:
        db_table = 'servicos_agendamento'