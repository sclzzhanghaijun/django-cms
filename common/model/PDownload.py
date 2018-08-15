# encoding=utf-8
from django.db import models


class PDownload(models.Model):
    id = models.AutoField(primary_key=True, verbose_name=u'下载ID')
    user_id = models.IntegerField(null=False, verbose_name=u'下载用户')
    version = models.CharField(max_length=200, null=False, verbose_name=u'版本号')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')

    class Meta:
        managed = False
        db_table = 'p_download_record'
