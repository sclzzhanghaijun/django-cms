# encoding=utf-8
from django import forms


class SetConfigForms(forms.Form):
    site_title = forms.CharField(max_length=20, required=True, error_messages={'required': u'站点名称不能为空'})
    site_description = forms.CharField(max_length=100, required=True, error_messages={'required': u'站点描述不能为空'})
    site_status = forms.ChoiceField(choices=[('on', u'开启'), ('off', u'关闭')], required=True,
                                    error_messages={'required': u'站点状态不能为空', 'choices': u'选择的参数值有误'})
