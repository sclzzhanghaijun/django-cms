# encoding=utf-8
from django import forms
from django.core.exceptions import ValidationError
from common.models import PSystemMenu as Menu, PSystemRoute as Route
import re


def check_parent_id(value):
    if value is not -1 and value <= 0:
        raise ValidationError(u'请选择父级菜单')
    result = Menu.objects.filter(menu_id=value, m_pid=0, menu_status=0, is_delete=0).count()
    if result is None:
        raise ValidationError(u'父级菜单参数有误')


def check_default_route(value):
    if value.isdigit():
        result = Route.objects.filter(route_id=value, is_delete=0).count()
        if result is None:
            raise ValidationError(u'默认路由数据有误')
    else:
        raise ValidationError(u'默认路由必须是路由的ID')


def check_permission_route(value):
    if value is not '':
        value_list = list(set(value.split('|')))
        for i in value_list:
            if not i.isdigit():
                raise ValidationError(u'权限路由必须是路由ID使用|隔开')
        result = Route.objects.filter(route_id__in=value_list, is_delete=0).count()
        if result != len(value_list):
            raise ValidationError(u'权限路由数据有误，请重新选择')


def check_sort(value):
    if value < 0:
        raise ValidationError(u'菜单的顺序必须是大于等于0的整数')


class MenuForms(forms.Form):
    m_pid = forms.IntegerField(required=True, validators=[check_parent_id],
                               error_messages={'required': u'必须选择父级菜单'})
    menu_name = forms.CharField(max_length=20, required=True, error_messages={'required': u'菜单名称不能为空'})
    menu_description = forms.CharField(max_length=100, required=True, error_messages={'required': u'菜单描述不能为空'})
    menu_status = forms.ChoiceField(choices=[('on', u'开启'), ('off', u'关闭')], required=True,
                                    error_messages={'required': u'菜单状态不能为空', 'choices': u'选择的参数值有误'})
    default_route = forms.CharField(required=False, validators=[check_default_route])
    permission_route = forms.CharField(required=False, validators=[check_permission_route])
    sort = forms.IntegerField(required=True, validators=[check_sort],
                              error_messages={'required': u'请输入菜单的顺序'})
