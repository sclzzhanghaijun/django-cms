# encoding=utf-8
from django.db import models


class PMailRecord(models.Model):
    id = models.AutoField(primary_key=True, verbose_name=u'记录ID')
    email = models.CharField(max_length=1000, null=False, verbose_name=u'邮件地址')
    subject = models.CharField(max_length=200, null=False, verbose_name=u'邮件主题')
    content = models.CharField(max_length=5000, null=False, verbose_name=u'邮件内容')
    message = models.CharField(max_length=500, null=False, default='', verbose_name=u'结果内容')
    status = models.IntegerField(choices=((1, u'成功'), (1, u'失败')), verbose_name=u'发送状态')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'已删除')), verbose_name=u'是否被删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    class Meta:
        managed = False
        db_table = 'p_mail_record'
