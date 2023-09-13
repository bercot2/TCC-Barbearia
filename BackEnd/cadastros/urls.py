from django.urls import path, include
from rest_framework import routers

from . import views as views

router = routers.DefaultRouter()

router.register('funcionarios', views.FuncionarioViewSet)
router.register('contatoFuncionario', views.ContatoFuncionarioViewSet)

urlpatterns = [
    path('', include(router.urls))  
]