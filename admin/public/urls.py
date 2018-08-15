# encoding=utf-8
from admin.route import custom_url
from admin.public.views import home

urlpatterns = [
    custom_url('index', home.index, name='admin_index', alias_name=u'后台首页'),
    custom_url('main', home.main, name='admin_main', alias_name=u'后台主页'),
    custom_url('info', home.info, name='admin_info', alias_name=u'帮助信息'),
]
