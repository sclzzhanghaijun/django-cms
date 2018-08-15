# encoding=utf-8
from django.db import models


class PSystemMenu(models.Model):
    menu_id = models.AutoField(primary_key=True, verbose_name=u'菜单ID')
    menu_name = models.CharField(max_length=50, null=False, verbose_name=u'菜单名')
    menu_description = models.CharField(max_length=1000, null=False, verbose_name=u'菜单描述')
    m_pid = models.IntegerField(null=False, verbose_name=u'父级菜单ID')
    menu_type = models.IntegerField(default=1, choices=((0, u"仅菜单"), (1, u'菜单及权限菜单'), (2, '仅权限菜单')),
                                    verbose_name=u'菜单类型')
    menu_status = models.IntegerField(choices=((0, u'正常状态'), (1, u'禁用状态')), verbose_name=u'菜单状态')
    menu_icon = models.CharField(max_length=20, default="", verbose_name=u'菜单图标')
    default_route = models.CharField(max_length=10, default='', null=False, verbose_name=u'默认路由ID')
    permission_route = models.CharField(max_length=1000, default='', null=False, verbose_name=u'权限路由ID,json字符串')
    sort = models.IntegerField(default=0, null=False, verbose_name=u'排序，升序排列')
    is_delete = models.IntegerField(default=0, choices=((0, u'正常'), (1, u'以删除')), verbose_name=u'是否被删除')
    create_time = models.DateTimeField(auto_now_add=True, verbose_name=u'添加时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name=u'修改时间')

    class Meta:
        managed = False
        db_table = 'p_system_menu'
