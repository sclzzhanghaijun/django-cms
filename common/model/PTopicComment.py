# encoding=utf-8
from django.db import models


class PTopicComment(models.Model):
    topic_comment_id = models.AutoField(primary_key=True, serialize=False, verbose_name='评论ID')
    topic_id = models.PositiveIntegerField('话题ID', default=0)
    user_id = models.PositiveIntegerField('用户id', default=0)
    comment_content = models.TextField('评论内容')
    reply_comment_id = models.PositiveIntegerField('回复的评论的id', default=0)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))
    user_type = models.PositiveSmallIntegerField('用户类型', default=1, choices=((1, '管理员'), (2, '会员')))

    class Meta:
        # managed = False
        db_table = 'p_topic_comment'
