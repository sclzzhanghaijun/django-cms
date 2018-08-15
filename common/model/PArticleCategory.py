# encoding=utf-8
from django.db import models


class PArticleCategory(models.Model):
    category_id = models.AutoField(primary_key=True, serialize=False, verbose_name='分类ID')
    category_name = models.CharField('类名', max_length=20)
    parent_category_id = models.PositiveIntegerField('父级分类id', default=0)
    created_time = models.DateTimeField('创建时间', auto_now_add=True)
    last_modified_time = models.DateTimeField('修改时间', auto_now=True)
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))

    class Meta:
        managed = False
        db_table = 'p_article_category'

    def __str__(self):
        return self.category_name
