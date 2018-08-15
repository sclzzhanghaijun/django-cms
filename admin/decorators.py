# encoding=utf-8
from django.contrib.auth.views import redirect_to_login
from django.urls import reverse
from admin.utils import menupermission
from admin.utils.response import error, success


def go_login(request):
    return redirect_to_login(request.get_full_path(), login_url=reverse('admin_login'))


def require_admin_access(view_func):
    def decorated_view(request, *args, **kwargs):
        user = request.user
        if user.is_anonymous:
            return go_login(request)

        if not menupermission.check_path_permission(request, request.path_info):
            return error(request, '权限认证失败')

        return view_func(request, *args, **kwargs)

    return decorated_view
