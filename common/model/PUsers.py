# encoding=utf-8
from django.db import models


class PUsers(models.Model):
    user_id = models.AutoField(primary_key=True, serialize=False, verbose_name='用户ID')
    avatar = models.CharField(max_length=128, unique=False, verbose_name=u'用户头像')
    username = models.CharField(max_length=120, unique=True, verbose_name=u'用户名')
    password = models.CharField(max_length=128, verbose_name=u'密码')
    nickname = models.CharField(max_length=20, verbose_name=u'昵称')
    gender = models.CharField(max_length=10, choices=(("male", u'男'), ("female", u'女')), default='female')
    phone = models.CharField(max_length=11, unique=True, verbose_name=u"手机号码", null=True, blank=True)
    email = models.CharField(max_length=128, unique=True, verbose_name=u'邮箱')
    last_login = models.DateTimeField(blank=True, auto_now=True, null=True, verbose_name=u'最后登录时间')
    login_ip = models.CharField(max_length=50, null=True, verbose_name=u'最后登录IP', default='0.0.0.0')
    create_at = models.DateTimeField(auto_now_add=True, verbose_name=u'创建时间')
    is_active = models.PositiveSmallIntegerField('是否禁用', default=0, choices=((0, '启用'), (1, '禁用')))
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))

    class Meta:
        managed = False
        db_table = 'p_users'
        verbose_name = u"用户信息"
        verbose_name_plural = verbose_name
