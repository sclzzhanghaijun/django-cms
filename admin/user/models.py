from django.db import models
from django.contrib.auth.models import AbstractUser


# 这里生成的表名称就是当前模块名称User和Test使用下划线拼接而成的，user_test,如果要自己指定表名，那使用Meta的db_table属性
class Test(models.Model):
    # 默认情况没有设置id，那么会自动生成一个自增长ID，id = models.AutoField(primary_key=True)

    '''
    这是一个自增主键字段。
如果你想指定一个自定义主键字段，只要在某个字段上指定 primary_key=True 即可。如果 Django 看到你显式地设置了 Field.primary_key，就不会自动添加 id 列。
每个模型只能有一个字段指定primary_key=True（无论是显式声明还是自动添加）
    '''

    '''
    模型参考：http://python.usyiyi.cn/documents/django_182/topics/db/models.html#automatic-primary-key-fields
    字段类型参考：http://python.usyiyi.cn/documents/django_182/ref/models/fields.html#model-field-types
    
    '''
    test_id = models.AutoField(primary_key=True)  # 自增ID设置
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)

    class Meta:
        managed = False
        db_table = 'test'


class AdminUser(AbstractUser):
    nick_name = models.CharField(max_length=50, verbose_name=u'昵称')
    birthday = models.DateField(verbose_name=u'生日', null=True, blank=True)
    gender = models.CharField(max_length=10, choices=(("male", u'男'), ("female", u'女')), default='female')
    address = models.CharField(max_length=11, verbose_name=u'地址', null=True, blank=True)
    phone = models.CharField(max_length=11, verbose_name=u"手机号码", null=True, blank=True)
    is_delete = models.PositiveSmallIntegerField('是否删除', default=0, choices=((0, '未删除'), (1, '已删除')))

    class Meta:
        #managed = False
        db_table = "admin_users"
        verbose_name = u"用户信息"
        verbose_name_plural = verbose_name

    def __unicode__(self):
        return self.username
