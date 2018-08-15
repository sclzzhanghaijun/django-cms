# encoding=utf-8
from admin.route import custom_url
from admin.system.views import config, menu, route

urlpatterns = [
    custom_url('^menu$', menu.menu_list, name='menu_list', alias_name=u'菜单列表'),
    custom_url('^menu_add$', menu.menu_add, name='menu_add', alias_name=u'添加菜单'),
    custom_url('^menu_delete$', menu.menu_delete, name='menu_delete', alias_name=u'删除菜单'),
    custom_url('^menu_edit', menu.menu_edit, name='menu_edit', alias_name=u'修改菜单'),
    custom_url('^config$', config.set_config, name='set_config', alias_name=u'设置配置'),
    custom_url('^route$', route.route, name='route_set', alias_name=u'路由配置'),
    custom_url('^merge_route$', route.merge_route, name='merge_route', alias_name=u'路由合并'),
]
