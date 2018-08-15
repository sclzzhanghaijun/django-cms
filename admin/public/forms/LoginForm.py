# encoding=utf-8
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth import authenticate
from django.forms import ValidationError


class AuthenticationNewForm(AuthenticationForm):

    def clean(self):
        username = self.cleaned_data.get('username')
        password = self.cleaned_data.get('password')
        if username is not None and password:
            self.user_cache = authenticate(self.request, username=username, password=password)
            if self.user_cache is None:
                raise ValidationError(
                    u'用户名或密码错误,请重新输入',
                    code='invalid_login',
                    params={'username': self.username_field.verbose_name},
                )
            elif self.user_cache.is_delete == 1:
                raise ValidationError(
                    u'该用户不存在，不能进行登录',
                    code='invalid_login',
                    params={'username': self.username_field.verbose_name},
                )
            else:
                self.confirm_login_allowed(self.user_cache)

        return self.cleaned_data
