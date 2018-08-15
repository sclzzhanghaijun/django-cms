# encoding=utf-8
from django.db import models


class PSlideManage(models.Model):
    slide_id = models.AutoField(primary_key=True, verbose_name=u'管理ID')
    slide_title = models.CharField(max_length=50, null=False, unique=True, verbose_name=u'管理标题')
    href_url= models.CharField(max_length=200, null=False, verbose_name=u'跳转链接')

    picture_url = models.CharField(max_length=200, null=False, verbose_name=u'图片链接')

    describe = models.CharField(max_length=200, null=False, verbose_name=u'管理描述')
    content = models.CharField(max_length=200, null=False, verbose_name=u'管理内容')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'已删除')), verbose_name=u'是否被删除')
    status = models.IntegerField(default=0, choices=((0, u'显示'), (1, u'隐藏')), verbose_name=u'是否隐藏')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    category_id = models.PositiveIntegerField('分类id', default=0)

    class Meta:
        managed = False
        db_table = 'p_slide_manage'
