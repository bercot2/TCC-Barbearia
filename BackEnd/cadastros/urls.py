from django.urls import path, include
from rest_framework import routers

from . import views as views

router = routers.DefaultRouter()

# Funcionário
router.register('funcionarios', views.FuncionarioViewSet)
router.register('contatoFuncionario', views.ContatoFuncionarioViewSet)

# Clientes
router.register('clientes', views.ClientesViewSet)
# router.register('clientes/validar-senha/', views.ClientesViewSet.as_view({'post': 'validar_senha'}), name='validar_senha')

urlpatterns = [
    path('clientes/validar-senha/', views.ClientesViewSet.as_view({'post': 'validar_senha'}), name='validar_senha'),
    path('', include(router.urls))  
]