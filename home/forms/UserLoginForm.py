# encoding=utf-8
from django import forms
from django.db.models import Q
from django.forms import ValidationError

from common.model.PUsers import PUsers


def check_username(value):
    admin_user = PUsers.objects.get(Q(username=value) | Q(email=value))
    if not admin_user:
        raise ValidationError(u'不存在此用户')
    else:
        if admin_user.is_active == 1:
            raise ValidationError(u'该用户已被禁用')


class UserLoginForm(forms.Form):
    username = forms.CharField(max_length=120, required=True, validators=[check_username],
                               error_messages={'required': u'用户名不能为空', 'max_length': u'用户名称长度不能超过120个字符'})
    password = forms.CharField(min_length=6, max_length=24, required=True,
                               error_messages={'required': u'密码不能为空', 'min_length': '密码长度不能少于6个字符',
                                               'max_length': u'密码长度不能超过24个字符'})
