# encoding=utf-8
from django.db import models


class PFriendLink(models.Model):
    link_id = models.AutoField(primary_key=True, verbose_name=u'链接ID')
    link_name = models.CharField(max_length=50, null=False, unique=True, verbose_name=u'链接名称')
    link_url = models.CharField(max_length=200, null=False, verbose_name=u'链接地址')
    link_icon = models.CharField(max_length=200, null=False, verbose_name=u'图片链接')
    link_describe = models.CharField(max_length=200, null=False, verbose_name=u'链接描述')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'已删除')), verbose_name=u'是否被删除')
    status = models.IntegerField(default=0, choices=((0, u'显示'), (1, u'隐藏')), verbose_name=u'是否隐藏')
    open_mode = models.IntegerField(default=0, choices=((0, u'新标签打开'), (1, u'本窗口打开')), verbose_name=u'打开方式')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    class Meta:
        managed = False
        db_table = 'p_friend_link'