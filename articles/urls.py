from django.urls import path

from .views import index

urlpatterns = [
    path('<str:nom>/', index, name='index')
]
