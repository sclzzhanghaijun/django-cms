# encoding=utf-8
from django.db import models


class PArticleComment(models.Model):
    article_comment_id = models.AutoField(primary_key=True, serialize=False, verbose_name='评论ID')
    article_id = models.PositiveIntegerField('文章ID', default=0)
    user_id = models.PositiveIntegerField('用户id', default=0)
    user_type = models.PositiveSmallIntegerField('用户类型', default=1, choices=((1, '管理员'), (2, '会员')))
    comment_content = models.TextField('评论内容')
    reply_comment_id = models.PositiveIntegerField('回复的评论的id', default=0)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))

    class Meta:
        managed = False
        db_table = 'p_article_comment'
