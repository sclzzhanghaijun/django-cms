from django import forms


# 轮播表单
class FriendLinkForms(forms.Form):
    link_name = forms.CharField(max_length=120, required=True, error_messages={'required': u'链接名称不能为空'})
    link_url = forms.CharField(required=True, error_messages={'required': u'链接地址不能为空'})
    link_describe = forms.CharField(required=True, error_messages={'required': u'描述不能为空'})
    open_mode = forms.IntegerField(required=True)
    status = forms.IntegerField(required=False)
    link_icon = forms.CharField(required=False)