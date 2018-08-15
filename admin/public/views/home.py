# encoding=utf-8
from django.shortcuts import render
from django.conf import settings
import django
import platform
from admin.user.models import AdminUser
from common.models import PSystemMenu as system_menu_model
from common.models import PSystemRoute as system_route_model
from common.models import PAdminGroupsUser as admin_groups_user_model
from common.models import PAdminGroupsPermission as admin_groups_permission_model
from django.urls import reverse
import json
from common.models import PUsers as p_users_model
from common.models import PArticle as p_article_model
from common.models import PTopic as p_topic_model
from common.models import PDownload as p_download_model
import time


def index(request):
    # 获取所有路由
    route_list_object = system_route_model.objects.filter(is_delete=0).values('route_id',
                                                                              'route_name')
    route_list = {}
    route_name_list = {}
    for row in route_list_object:
        try:
            route_url = reverse(row['route_name'])
        except:
            continue
        route_list[row['route_id']] = route_url
        route_name_list[row['route_id']] = row['route_name']

    if request.session.get('user_info_1') is None:
        user_info = AdminUser.objects.get(username=request.user)
        group_object = admin_groups_user_model.objects.get(admin_id=user_info.id)
        if group_object is None:
            pass
        group_id = group_object.group_id
        group_permission = admin_groups_permission_model.objects.filter(group_id=group_object.group_id,
                                                                        is_delete=0).values(
            'route_permission', 'menu_id')
        if group_permission is None:
            pass
        cache_route_list = []
        cache_menu_route_list = {}
        for row in group_permission:
            route_permission = row['route_permission'].split('|')
            for i in route_permission:
                cache_route_list.append(route_name_list.get(int(i)))
            cache_menu_route_list[row['menu_id']] = route_permission
        request.session['user_info'] = {'id': user_info.id, 'user_name': user_info.username,
                                        'nick_name': user_info.nick_name, 'cache_route_list': cache_route_list,
                                        'group_id': group_id,
                                        'cache_menu_route_list': cache_menu_route_list}

    else:
        user_info = request.session.get('user_info')
        group_id = user_info.get('group_id')
        cache_menu_route_list = user_info.get('cache_menu_route_list')

    # 获取所有菜单
    menu_list_object = system_menu_model.objects.filter(is_delete=0, menu_status=0).order_by('sort', 'm_pid').all()
    menu_list = {}
    for row in menu_list_object:
        if (row.default_route != '' and group_id == 1) or (group_id != 1 and
                                                           row.default_route != '' and cache_menu_route_list.get(
                    int(row.menu_id))):
            route_url = route_list.get(int(row.default_route))
        else:
            route_url = '#'

        if row.m_pid == 0 and route_url:
            if menu_list.get(row.menu_id) is None:
                children = []
            else:
                children = menu_list[row.menu_id]['children']
            menu_list[row.menu_id] = {'id': row.menu_id, 'href': route_url, 'title': row.menu_name,
                                      'icon': row.menu_icon, 'pid': row.m_pid,
                                      'children': children}

        else:
            if group_id == 1 or (group_id != 1 and cache_menu_route_list.get(int(row.menu_id))):
                if menu_list.get(row.m_pid) is None:
                    menu_list[row.m_pid] = {'id': 0, 'href': '', 'title': 0,
                                            'icon': '', 'pid': 0,
                                            'children': []}
                menu_list[row.m_pid]['children'].append({'id': row.menu_id, 'href': route_url, 'title': row.menu_name,
                                                         'icon': row.menu_icon, 'pid': row.m_pid})

    # 将子菜单为0的菜单去掉
    for row in list(menu_list.keys()):
        if menu_list[row]['href'] == '#' and len(menu_list[row]['children']) == 0:
            menu_list.pop(int(row))

    return render(request, 'admin/public/index.html',
                  {'user_info': user_info, 'menu_list': json.dumps(list(menu_list.values()))})


def main(request):
    config = {
        'host': '127.0.0.1',
        'document_root': settings.BASE_DIR,
        'server_os': platform.system(),
        'server_port': request.META['SERVER_PORT'],
        'server_ip': request.META['REMOTE_ADDR'],
        #'server_soft': request.META['SERVER_SOFTWARE'],
        'python_version': platform.python_version(),
        'django_version': django.get_version(),
    }
    return render(request, 'admin/public/main.html', {'config': config})


def info(request):
    # 获取用户总数
    user_count = p_users_model.objects.count()
    # 今日注册用户
    today_register_user_count = p_users_model.objects.filter(
        create_at__gte=time.strftime('%Y-%m-%d 00:00:00', time.localtime(time.time()))).count()

    # 文章总数
    article_count = p_article_model.objects.count()

    # 投稿数量
    user_article_count = p_article_model.objects.filter(user_type=2).count()

    # 话题数量
    topic_count = p_topic_model.objects.count()

    # 下载量
    download_count = p_download_model.objects.count()
    return render(request, 'admin/public/info.html', {
        'user_count': user_count,
        'today_register_user_count': today_register_user_count,
        'article_count': article_count,
        'user_article_count': user_article_count,
        'topic_count': topic_count,
        'download_count': download_count
    })
