from django import forms
from django.core.exceptions import ValidationError
from common.models import PArticleCategory as ArticleCategory


def check_parent_id(value):
    if value < 0:
        raise ValidationError(u'请选择父级菜单')
    result = ArticleCategory.objects.filter(category_id=value, is_delete=0).count()
    if result is None:
        raise ValidationError(u'父级菜单参数有误')


'''
文章表单验证
'''


class ArticleForms(forms.Form):
    article_title = forms.CharField(max_length=300, required=True,
                                    error_messages={'required': u'文章标题不能为空', 'max_length': u'标题不能超过300个字符'})
    category_id = forms.IntegerField(required=True, error_messages={'required': u'请选择文章分类'})
    article_abstract = forms.CharField(max_length=500, required=True,
                                       error_messages={'required': u'文章摘要不能为空', 'max_length': u'摘要不能超过500个字符'})
    article_content = forms.CharField(required=True, error_messages={'required': u'文章内容不能为空'})
    status = forms.IntegerField()


'''文章分类表单验证'''


class ArticleClassifyForms(forms.Form):
    category_name = forms.CharField(required=True, error_messages={'required': u'分类名称不能为空'})
    parent_category_id = forms.IntegerField(required=True, validators=[check_parent_id],
                                            error_messages={'required': u'请选择上级分类'})


'''文章评论表单验证'''


class ArticleCommentForms(forms.Form):
    comment_content = forms.CharField(max_length=400, required=True, error_messages={'required': u'回复内容不能为空'})
