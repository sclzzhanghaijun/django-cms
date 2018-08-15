from django import forms


class TopicForms(forms.Form):
    topic_title = forms.CharField(max_length=120, required=True, error_messages={'required': u'话题标题不能为空'})
    content = forms.CharField(required=True, error_messages={'required': u'话题内容不能为空'})

class TopicCommentForms(forms.Form):
    comment_content = forms.CharField(max_length=1000, required=True, error_messages={'required': u'回复内容不能为空'})