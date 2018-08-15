from django.conf.urls import url
from admin.utils.urlpatterns import decorate_urlpatterns
from admin.decorators import require_admin_access
from admin.public.views import public
from admin.route import write_route_cache
from admin.public import urls as public_urls
from admin.user import urls as user_urls
from admin.system import urls as system_urls
from admin.article import urls as article_urls
from admin.extend import urls as extend_urls

# 该部分是需要认证用户登录和权限的路由
urlpatterns = []
urlpatterns += public_urls.urlpatterns
urlpatterns += user_urls.urlpatterns
urlpatterns += system_urls.urlpatterns
urlpatterns += article_urls.urlpatterns
urlpatterns += extend_urls.urlpatterns

'''
以下部分不要进行修改
'''
write_route_cache(urlpatterns)
urlpatterns = decorate_urlpatterns(urlpatterns, require_admin_access)

# 该部分是不需要认证是否登录
urlpatterns += [
    url('login', public.login, name='admin_login'),
    url('logout', public.logout, name='admin_logout'),
    url('redirect', public.redirect, name='redirect'),
]
