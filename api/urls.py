from django.urls import path
from api.views import ueditor

urlpatterns = [
    path('index', ueditor.get_ueditor_controller, name='uploadfile')
]
