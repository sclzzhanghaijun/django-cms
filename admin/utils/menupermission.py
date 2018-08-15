# encoding=utf-8
from django.urls import *


def check_path_permission(request, path_info):
    if hasattr(request, 'urlconf'):
        urlconf = request.urlconf
        set_urlconf(urlconf)
        resolver = get_resolver(urlconf)
    else:
        resolver = get_resolver()
    for i in resolver.url_patterns:
        print(i)
    try:
        resolver_match = resolver.resolve(path_info)
        print(resolver)
        url_name = resolver_match.url_name
        print('====>', url_name)
        if url_name not in ['admin_index', 'admin_main']:
            print(u'需要进行验证')
            user_info = request.session.get('user_info')
            group_id = user_info.get('group_id')
            if group_id == 1:
                is_valid = True
            elif url_name not in request.session.get('user_info').get('cache_route_list'):
                print(u'没有权限访问')
                is_valid = False
            else:
                is_valid = True
        else:
            is_valid = True
    except:
        is_valid = False

    return is_valid
