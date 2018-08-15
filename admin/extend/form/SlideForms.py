from django import forms

class SlideCategoryForms(forms.Form):
    category_name = forms.CharField(max_length=50, required=True,error_messages={'required': u'分类标题不能为空'})
    category_identify = forms.CharField(max_length=50, required=True,error_messages={'required': u'分类标识不能为空'})
    category_remark = forms.CharField(max_length=200, required=False)






# 轮播表单
class SlideForms(forms.Form):
    slide_title = forms.CharField(max_length=120, required=True, error_messages={'required': u'标题不能为空'})
    category_id = forms.IntegerField(required=True, error_messages={'required': u'请选择分类'})
    href_url = forms.CharField(required=True, error_messages={'required': u'链接不能为空'})
    content = forms.CharField(required=True, error_messages={'required': u'内容不能为空'})
    describe = forms.CharField(required=True, error_messages={'required': u'描述不能为空'})
    status = forms.IntegerField(required=False)
    picture_url = forms.CharField(required=False)