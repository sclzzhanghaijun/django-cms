# encoding=utf-8
from django import forms


class RegisterForm(forms.Form):
    password = forms.CharField(required=True, min_length=6, max_length=20,
                               error_messages={'required': u'登录密码不能为空', 'min_length': u'密码不能小于6个字符',
                                               'max_length': u'密码不能超过20个字符'})
    code = forms.CharField(required=True, max_length=6, min_length=6,
                           error_messages={'required': u'请输入邮箱注册码', 'max_length': u'注册码必须是6位数字',
                                           'min_length': u'注册码必须是6位数字'})
