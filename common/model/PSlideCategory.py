# encoding=utf-8
from django.db import models


class PSlideCategory(models.Model):
    category_id = models.AutoField(primary_key=True, verbose_name=u'分类ID')
    category_name = models.CharField(max_length=50, null=False, unique=True, verbose_name=u'分类名称')
    category_identify = models.CharField(max_length=50, null=False, verbose_name=u'分类标识')
    category_remark = models.CharField(max_length=200, null=False, verbose_name=u'备注')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'已删除')), verbose_name=u'是否被删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    class Meta:
        managed = False
        db_table = 'p_slide_category'
