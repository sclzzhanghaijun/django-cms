# encoding=utf-8
from django import forms


class AdminGroupForms(forms.Form):
    group_name = forms.CharField(max_length=20, required=True,
                                 error_messages={'required': u'用户组名称不能为空', 'max_length': u'用户组名称长度不能超过20个汉子'})
    group_description = forms.CharField(max_length=100, required=True, error_messages={'required': u'用户组描述不能为空'})
    group_status = forms.ChoiceField(choices=[('on', u'正常'), ('off', u'禁用')], required=True,
                                     error_messages={'required': u'用户组状态不能为空', 'choices': u'选择的参数值有误'})
