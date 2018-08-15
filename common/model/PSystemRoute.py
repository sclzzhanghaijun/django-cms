# encoding=utf-8
from django.db import models


class PSystemRoute(models.Model):
    route_id = models.AutoField(primary_key=True, verbose_name=u'路由ID')
    route_name = models.CharField(max_length=50, null=False, unique=True, verbose_name=u'路由名')
    route_alias_name = models.CharField(max_length=50, null=False, verbose_name=u'路由别名')
    is_delete = models.IntegerField(choices=((0, u'正常'), (1, u'以删除')), default=0, verbose_name=u'是否被删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    class Meta:
        managed = False
        db_table = 'p_system_route'
