# encoding=utf-8
from django.shortcuts import render
from common.model.PAdminGroups import PAdminGroups as admin_groups_modes
from admin.user.forms.AdminGroupForms import AdminGroupForms
from common.models import PSystemRoute as system_route_model
from common.models import PSystemMenu as menu_model
from common.models import PAdminGroupsPermission as admin_groups_permission_model
from common.models import PAdminGroupsUser as admin_groups_user_model
import json
import operator
from django.forms.models import model_to_dict
from django.db import transaction
from admin.utils.response import *


def group_list(request):
    if request.is_ajax():
        page = int(request.POST.get('page', 1))
        limit = int(request.POST.get('limit', 20))
        start_row = (page - 1) * limit
        end_row = start_row + limit
        total_row = admin_groups_modes.objects.filter(is_delete=0).count()
        group_list = admin_groups_modes.objects.filter(is_delete=0).order_by('-group_id').values('group_id',
                                                                                                 'group_description',
                                                                                                 'group_name',
                                                                                                 'group_status',
                                                                                                 'create_time',
                                                                                                 'update_time')[
                     start_row:end_row]
        return load_data(request, total_row, list(group_list))
    else:
        return render(request, 'admin/user/admin_group_list.html')


def group_add(request):
    if request.method == 'POST':
        param = request.POST
        check_form = AdminGroupForms(param)
        if check_form.is_valid():
            group_status = 0
            if param['group_status'] == 'off':
                group_status = 1

            result = admin_groups_modes.objects.create(
                group_name=param['group_name'],
                group_description=param['group_name'],
                group_status=group_status,
            )
            if result is not None:
                return success(request, u'添加用户组成功')
            else:
                return error(request, u'添加用户组失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/user/admin_group_add.html')


def group_edit(request):
    group_id = int(request.GET['group_id']) if request.method == 'GET' else int(request.POST['group_id'])
    if group_id <= 0:
        return error(request, u'参数ID有误')

    group_object = admin_groups_modes.objects.filter(group_id=group_id, is_delete=0).get()
    if group_object is None:
        return error(request, u'用户组不存在,ID有误')

    if request.is_ajax():
        param = request.POST
        check_form = AdminGroupForms(param)
        if check_form.is_valid():
            group_status = 0
            if param['group_status'] == 'off':
                group_status = 1

            group_object.group_name = param['group_name']
            group_object.group_description = param['group_description']
            group_object.group_status = group_status
            group_object.save()
            if group_object.group_id:
                return success(request, u'修改用户组成功')
            else:
                return error(request, u'修改用户组失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/user/admin_group_edit.html', {'group_info': group_object})


def group_del(request):
    group_id = int(request.GET['group_id']) if request.method == 'GET' else int(request.POST['group_id'])
    if group_id <= 0:
        return error(request, u'参数ID有误')

    group_object = admin_groups_modes.objects.filter(group_id=group_id, is_delete=0).get()
    if group_object is None:
        return error(request, u'用户组不存在,ID有误')

    is_exists_user = admin_groups_user_model.objects.filter(group_id=group_id, is_delete=0).count()
    if is_exists_user > 0:
        return error(request, u'该用户组下还有后台管理人员绑定，请先取消绑定后在进行删除')

    group_object.is_delete = 1
    group_object.save()
    if group_object.group_id:
        return success(request, u'删除用户组成功')
    else:
        return error(request, u'删除用户组失败')


@transaction.atomic
def group_permission(request):
    group_id = int(request.GET['group_id']) if request.method == 'GET' else int(request.POST['group_id'])
    if group_id <= 0:
        return error(request, u'参数ID有误')

    group_object = admin_groups_modes.objects.filter(group_id=group_id, is_delete=0).get()
    if group_object is None:
        return error(request, u'用户组不存在,ID有误')
    # 获取所有路由
    route_list_object = system_route_model.objects.filter(is_delete=0).values('route_id', 'route_name',
                                                                              'route_alias_name')
    route_list = {}
    for row in route_list_object:
        route_list[row['route_id']] = row['route_alias_name']

    menu_list_result = menu_model.objects.filter(is_delete=0).order_by('m_pid').all()

    menu_list_level = {}
    for row in menu_list_result:
        row = model_to_dict(row)
        if row.get('default_route') != '':
            row['default_route_name'] = route_list.get(int(row['default_route']))

        if row.get('permission_route') != '':
            permission_route_name = {}
            permission_route_list = row.get('permission_route').split('|')
            for i in permission_route_list:
                permission_route_name[i] = route_list.get(int(i))
            row['permission_route_list'] = permission_route_list
            row['permission_route_name_list'] = permission_route_name.items()
        if menu_list_level.get(row['m_pid']) is None:
            menu_list_level[row['m_pid']] = []
            menu_list_level[row['m_pid']].append(row)
        else:
            menu_list_level[row['m_pid']].append(row)
    menu_list = []
    if menu_list_level:
        for row in menu_list_level[0]:
            menu_list.append(row)
            if menu_list_level.get(row['menu_id']):
                for r in menu_list_level[row['menu_id']]:
                    menu_list.append(r)

    permission_menu_list = admin_groups_permission_model.objects.filter(group_id=group_id, is_delete=0).values(
        'permission_id', 'route_permission', 'menu_id')

    group_menu_list = {}
    menu_route_list = {}
    for row in permission_menu_list:
        menu_route_list[row['menu_id']] = row['route_permission'].split('|')
        group_menu_list[row['menu_id']] = row['permission_id']

    if request.is_ajax():
        route_param = {}
        param = request.POST
        for i in param:
            if 'route' in i:
                _, menu_id = i.split('_')
                route_param[int(menu_id)] = param.getlist(i)
        if len(route_param) <= 0:
            return error(request, u'请选择菜单权限路由')

        # 验证数据的正确
        for menu_info in menu_list:
            route_param_info = route_param.get((menu_info['menu_id']))
            if route_param_info:
                default_route = menu_info['default_route']
                permission_route_list = menu_info['permission_route_list']
                if default_route not in route_param_info:
                    return JsonResponse({'code': -1, 'msg': u'菜单权限必须包含默认路由'})
                else:
                    route_intersection = list(set(route_param_info).intersection(set(permission_route_list)))
                    if operator.eq(set(route_intersection), set(route_param_info)) is False:
                        return JsonResponse({'code': -1, 'msg': u'菜单权限参数有误'})

        add_all = []  # 增加所有
        update_all = []  # 修改所有
        for i in route_param:
            route_permission = '|'.join(route_param.get(i))
            if group_menu_list.get(i):
                update_all.append({'permission_id': group_menu_list.get(i), 'group_id': group_id, 'menu_id': i,
                                   'route_permission': route_permission})
                group_menu_list.pop(i)
            else:
                add_all.append(admin_groups_permission_model(group_id=group_id, menu_id=i,
                                                             route_permission=route_permission))
        del_all = list(group_menu_list.values())
        is_success = True
        sid = transaction.savepoint()
        try:
            while True:
                if len(del_all) > 0:
                    result = admin_groups_permission_model.objects.filter(permission_id__in=del_all).update(
                        is_delete=1)
                    if result is False:
                        is_success = False
                        break

                if len(add_all) > 0:
                    result = admin_groups_permission_model.objects.bulk_create(add_all)
                    if result is False:
                        is_success = False
                        break

                if len(update_all) > 0:
                    for row in update_all:
                        result = admin_groups_permission_model.objects.filter(permission_id=row['permission_id'],
                                                                              group_id=row['group_id'],
                                                                              menu_id=row['menu_id']).update(
                            route_permission=row['route_permission'])
                        if result == 0:
                            is_success = False
                            break
                break  # 这个一定不能省略
        except:
            is_success = False

        if is_success is True:
            transaction.savepoint_commit(sid)
            return success(request, u'权限编辑成功')
        else:
            transaction.savepoint_rollback(sid)
            return error(request, u'权限编辑失败')

    else:
        return render(request, 'admin/user/admin_group_permission.html',
                      {'menu_list': menu_list, 'route_list': route_list, 'group_info': group_object,
                       'menu_route_list': json.dumps(menu_route_list)})
