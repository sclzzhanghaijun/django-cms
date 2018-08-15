# encoding=utf-8
from django.db import models
from django.urls import reverse


class PArticle(models.Model):
    STATUS_CHOICES = (
        (0, '草稿状态'),
        (1, '上线状态'),
        (2, '下线状态'),
    )  # 文章的状态
    article_id = models.AutoField(primary_key=True, serialize=False, verbose_name='文章ID')
    article_title = models.CharField('标题', max_length=300)
    article_content = models.TextField('正文')
    thumb = models.CharField('缩略图', max_length=200)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    # auto_now_add : 创建时间戳，不会被覆盖

    last_modified_time = models.DateTimeField('修改时间', auto_now=True)
    # auto_now: 自动将当前时间覆盖之前时间

    status = models.PositiveSmallIntegerField('文章状态', default=0, choices=STATUS_CHOICES)
    article_abstract = models.CharField('摘要', max_length=500, blank=True, null=True, help_text="可选项，若为空格则摘取正文钱54个字符")
    # 阅读量
    views = models.PositiveIntegerField('浏览量', default=0)
    # 评论数
    comment = models.PositiveIntegerField('评论数', default=0)
    # 是否置顶
    topped = models.BooleanField('置顶', default=False)
    # 目录分类
    # on_delete 当指向的表被删除时，将该项设为空
    category_id = models.PositiveIntegerField('分类id', default=0)
    user_id = models.PositiveIntegerField('用户id', default=0)
    user_type = models.PositiveSmallIntegerField('用户类型', default=1, choices=((1, '管理员'), (2, '会员')))
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))

    def __str__(self):
        return self.article_title

    class Meta:
        # Meta 包含一系列选项，这里的ordering表示排序, - 表示逆序
        # 即当从数据库中取出文章时，以文章最后修改时间逆向排序
        ordering = ['-last_modified_time']
        managed = False
        db_table = 'p_article'

    def get_absolute_url(self):
        return reverse('app:detail', kwargs={'article_id': self.pk})
