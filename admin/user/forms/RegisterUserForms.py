# encoding=utf-8
from django import forms
from django.forms import ValidationError

from common.model.PUsers import PUsers


def check_username(value):
    admin_user = PUsers.objects.filter(username=value).count()
    if admin_user > 0:
        raise ValidationError(u'已经存在相同的用户名')


def check_email(email):
    email = PUsers.objects.filter(email=email).count()
    if email > 0:
        raise ValidationError(u'已经存在相同的邮箱')


class RegisterUserForms(forms.Form):
    username = forms.CharField(max_length=20, required=True,
                               error_messages={'required': u'用户组名称不能为空', 'max_length': u'用户名称长度不能超过20个字符'})
    nickname = forms.CharField(max_length=20, required=True, validators=[check_username],
                               error_messages={'required': u'用户组名称不能为空', 'max_length': u'昵称长度不能超过20个字符'})
    email = forms.CharField(validators=[check_email])
