# encoding=utf-8
from django.db import models


class PAdminGroupsUser(models.Model):
    group_id = models.PositiveIntegerField(null=False)
    admin_id = models.PositiveIntegerField(null=False)
    is_delete = models.PositiveIntegerField(default=0)
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'p_admin_groups_user'
