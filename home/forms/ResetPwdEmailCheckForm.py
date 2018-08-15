# encoding=utf-8
from django import forms
from django.forms import ValidationError
from common.models import PUsers as p_user_model


def check_mail_exists(value):
    email_is_exists = p_user_model.objects.filter(email=value).exists()
    if not email_is_exists:
        raise ValidationError(u'邮箱地址有误，请重新输入')


class ResetPwdEmailCheckForm(forms.Form):
    email = forms.EmailField(max_length=50, required=True, validators=[check_mail_exists],
                             error_messages={'required': u'注册邮箱不能为空', 'max_length': u'邮箱的过长，请检查输入',
                                             'invalid': u'请输入正确的邮箱'})
