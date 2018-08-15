# encoding=utf-8
from django.contrib.auth import views
from django.contrib.auth import views as auth_views
from django.conf import settings
from django.shortcuts import render
from admin.public.forms.LoginForm import AuthenticationNewForm


def login(request):
    username = request.POST['username'] if request.POST.get('username') else ''
    return views.login(request, template_name='admin/admin_login.html', authentication_form=AuthenticationNewForm,
                       extra_context={'username': username})


def logout(request):
    response = auth_views.logout(request, next_page='admin_login')
    response.delete_cookie(settings.SESSION_COOKIE_NAME,
                           domain=settings.SESSION_COOKIE_DOMAIN,
                           path=settings.SESSION_COOKIE_PATH)

    request.session.modified = False

    return response


def redirect(request):
    param = request.GET
    return render(request, 'admin/redirect.html', {'param': param})
