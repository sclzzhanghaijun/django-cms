# encoding=utf-8
from django.db import models


class PTopic(models.Model):
    topic_id = models.AutoField(primary_key=True, verbose_name=u'话题ID')
    user_id = models.PositiveIntegerField(default=0, verbose_name=u'用户ID')
    topic_title = models.CharField(max_length=50, null=False, verbose_name=u'话题标题')
    content = models.TextField(null=False, verbose_name=u'话题内容')
    view_num = models.PositiveIntegerField(default=0, null=False, verbose_name=u'浏览量')
    comment_num = models.PositiveIntegerField(default=0, null=False, verbose_name=u'评论数')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'已删除')), verbose_name=u'是否被删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')
    user_type = models.PositiveSmallIntegerField(default=1, choices=((1, '管理员'), (2, '会员')), verbose_name='用户类型', )

    class Meta:
        managed = False
        db_table = 'p_topic'
