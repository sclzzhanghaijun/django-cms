# encoding=utf-8
from django.db import models


class PAdminGroupsPermission(models.Model):
    permission_id = models.AutoField(primary_key=True)
    group_id = models.PositiveIntegerField(null=False)
    menu_id = models.PositiveIntegerField(null=False)
    route_permission = models.CharField(null=False, max_length=1000)
    is_delete = models.PositiveIntegerField(default=0)
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'p_admin_groups_permission'
