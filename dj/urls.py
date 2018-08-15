"""dj URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf.urls import include
from admin import urls
from api import urls as apiurls
from django.conf import settings
from django.conf.urls.static import static
from home.view import home
from home import urls as home_url
from common.views import *
from django.conf.urls import handler404, handler500

urlpatterns = [
                  path('dj-admin/', admin.site.urls),
                  path('admin/', include(urls)),
                  path('api/ueditor/', include(apiurls)),
                  path('', home.home_index),
                  path('', include(home_url))
              ] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

handler404 = page_not_found
handler500 = page_error
