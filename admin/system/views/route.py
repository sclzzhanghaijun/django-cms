# encoding=utf-8
from django.shortcuts import render
from admin.route import get_route_cache
from common.models import PSystemRoute as system_route_model
from django.db import transaction
from admin.utils.response import *


def _route_compare():
    conf_route_list = get_route_cache()
    system_route_list = system_route_model.objects.filter(is_delete=0).values('route_name', 'route_alias_name')
    system_route_list_new = {}
    for row in system_route_list:
        system_route_list_new[row['route_name']] = row['route_alias_name']

    route_list = []
    for row in conf_route_list:
        name = row['name']
        if not system_route_list_new.get(name):
            msg = u'<span style="color:red;">系统中没有该路由，同步后将新增</span>'
            msg_type = 1
        else:
            system_route_list_new.pop(name)
            msg = u'<span>对比成功，无需操作</span>'
            msg_type = 2

        route_list.append(
            {'route_name': name, 'route_alias_name': row['alias_name'], 'msg': msg, 'msg_type': msg_type})

    for key in system_route_list_new:
        msg_type = 3
        route_list.append({'route_name': key, 'route_alias_name': system_route_list_new[key],
                           'msg': u'<span style="color:red;">路由配置中没有该信息，同步后将删除</span>', 'msg_type': msg_type})

    return route_list


def route(request):
    if request.is_ajax():
        route_list = _route_compare()
        return load_data(request, 1000, route_list)
    else:
        return render(request, 'admin/system/route_list.html')


@transaction.atomic
def merge_route(request):
    handle_type = request.POST['handle_type']
    if handle_type != 'add' and handle_type != 'merge':
        return error(request, u'操作类型错误')

    if handle_type == 'merge':
        password = request.POST['password']
        if password != 'qwe123456!':
            return error(request, u'合并口令错误')
    route_list = _route_compare()
    data_all = []
    del_name_list = []
    for row in route_list:
        if row['msg_type'] == 1:
            data_all.append(
                system_route_model(route_name=row['route_name'], route_alias_name=row['route_alias_name'], is_delete=0))
        elif row['msg_type'] == 3:
            del_name_list.append(row['route_name'])

    is_success = True
    sid = transaction.savepoint()
    try:
        while True:
            if len(del_name_list) > 0 and handle_type == 'merge':
                result = system_route_model.objects.filter(route_name__in=del_name_list).update(is_delete=1)
                if result is False:
                    is_success = False
                    break

            if len(data_all) > 0:
                result = system_route_model.objects.bulk_create(data_all)
                if result is False:
                    is_success = False
                    break
            break  # 这个一定不能省略
    except:
        is_success = False

    if is_success is True:
        transaction.savepoint_commit(sid)
        return success(request, u'合并数据成功')
    else:
        transaction.savepoint_rollback(sid)
        return error(request, u'合并数据失败')
