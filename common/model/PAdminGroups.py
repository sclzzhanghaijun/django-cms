# encoding=utf-8
from django.db import models


class PAdminGroups(models.Model):
    group_id = models.AutoField(primary_key=True)
    group_name = models.CharField(max_length=255)
    group_status = models.PositiveIntegerField(default=0)
    group_description = models.CharField(max_length=1000)
    is_delete = models.PositiveIntegerField(default=0)
    create_time = models.DateTimeField(auto_now_add=True)
    update_time = models.DateTimeField(auto_now=True)

    class Meta:
        managed = False
        db_table = 'p_admin_groups'
