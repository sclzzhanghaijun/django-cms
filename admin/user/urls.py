# encoding=utf-8
from admin.route import custom_url
from admin.user.views import users, admin, admin_group

urlpatterns = [
    custom_url('^user$', admin.admin_user, name='user_list', alias_name=u'用户列表'),
    custom_url('^admin_user_edit$', admin.admin_user_edit, name='admin_user_edit', alias_name=u'编辑后台用户'),
    custom_url('^admin_user_add$', admin.admin_user_add, name='admin_user_add', alias_name=u'添加后台用户'),
    custom_url('^admin_user_delete$', admin.admin_user_delete, name='admin_user_delete', alias_name=u'删除后台用户'),
    custom_url('^admin_user_change_password$', admin.admin_user_change_password, name='admin_user_change_password',
               alias_name=u'修改后台用户密码'),
    custom_url('^admin_user_list$', admin.admin_user_list, name='admin_user_list',
               alias_name=u'获取用户列表'),

    custom_url('^admin_user_detail$', admin.admin_user_detail, name='admin_user_detail', alias_name=u'查看后台用户'),
    custom_url('^admin_group_list$', admin_group.group_list, name='admin_group_list', alias_name=u'管理员组列表'),
    custom_url('^admin_group_add$', admin_group.group_add, name='admin_group_add', alias_name=u'管理员组添加'),
    custom_url('^admin_group_edit$', admin_group.group_edit, name='admin_group_edit', alias_name=u'管理员组修改'),
    custom_url('^admin_group_del$', admin_group.group_del, name='admin_group_del', alias_name=u'管理员组删除'),
    custom_url('^admin_group_permission$', admin_group.group_permission, name='admin_group_permission',
               alias_name=u'管理员组权限'),
    custom_url('^manager_user$', users.manager_user, name='manager_user', alias_name=u'管理用户'),
    custom_url('^user_list_data$', users.user_list_data, name='user_list_data', alias_name=u'用户列表'),
    custom_url('^user_detail$', users.user_detail, name='user_detail', alias_name=u'用户详情'),
    custom_url('^register_user$', users.register_user, name='register_user', alias_name=u'添加用户'),
    custom_url('^user_reset_pwd$', users.user_reset_pwd, name='user_reset_pwd', alias_name=u'重置用户密码'),
    custom_url('^user_state_change$', users.user_state_change, name='user_state_change', alias_name=u'设置用户状态'),
    custom_url('^user_delete$', users.user_delete, name='user_delete', alias_name=u'删除用户')
]
