from django.urls import path, include
from rest_framework import routers

from . import views as views

router = routers.DefaultRouter()

# Funcionário
router.register('funcionarios', views.FuncionarioViewSet)
router.register('contato-funcionario', views.ContatoFuncionarioViewSet)

# Clientes
router.register('clientes', views.ClientesViewSet)

# Servico
router.register('servico', views.ServicoViewSet)

# Agendamento
router.register('agendamento', views.AgendamentoViewSet)

# Produtos
router.register('produtos', views.ProdutosViewSet)

urlpatterns = [
    path('clientes/validar-senha/', views.ClientesViewSet.as_view({'post': 'validar_senha'}), name='validar_senha'),
    path('agendamento/servico-agendamento/', views.AgendamentoViewSet.as_view({'post': 'servico_agendamento'}), name='servico_agendamento'),
    path('', include(router.urls))  
]
