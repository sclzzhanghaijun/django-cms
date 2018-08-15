from django import forms
from django.forms import ValidationError
from admin.user.models import AdminUser
import re

def check_username(value):
    where = {
        'username':value
    }
    admin_user = AdminUser.objects.filter(**where).values()
    if admin_user:
        raise ValidationError(u'已经存在相同的用户名')


class AdminForms(forms.Form):
    nick_name = forms.CharField(max_length=12, required=True,
                                 error_messages={'required': u'用户昵称不能为空', 'max_length': u'用户昵称长度不能超过12个字符'})
    username = forms.CharField(max_length=20, required=True,validators=[check_username],
                                error_messages={'required': u'用户名不能为空', 'max_length': u'用户名长度不能超过20个字符'})
    password = forms.CharField(max_length=20, required=True,
                                error_messages={'required': u'用户密码不能为空', 'max_length': u'用户密码长度不能超过20个字符'})
    address = forms.CharField(max_length=100, required=False,
                               error_messages={'max_length': u'用户名长度不能超过100个字符'})
    birthday = forms.CharField(required=True,error_messages={'required': u'请填写日期'})


class AdminEditForms(forms.Form):
    nick_name = forms.CharField(max_length=12, required=True,
                                 error_messages={'required': u'用户昵称不能为空', 'max_length': u'用户昵称长度不能超过12个字符'})
    address = forms.CharField(max_length=100, required=False,
                               error_messages={'max_length': u'用户名长度不能超过100个字符'})
    birthday = forms.CharField(required=True,error_messages={'required': u'请填写日期'})

class AdminChangePasswordForms(forms.Form):
    password = forms.CharField(max_length=20, required=True,
                               error_messages={'required': u'用户密码不能为空', 'max_length': u'用户密码长度不能超过20个字符'})