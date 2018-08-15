# encoding=utf-8
from django.shortcuts import render
from admin.system.forms.MenuForms import MenuForms
from common.models import PSystemMenu as menu_model
from common.models import PSystemRoute as p_system_route_model
import json
from admin.utils.response import *

'''
菜单列表
'''


def menu_list(request):
    menu_list_result = menu_model.objects.filter(is_delete=0).order_by('sort', 'm_pid', 'menu_id').all()

    menu_list_level = {}
    for row in menu_list_result:
        if menu_list_level.get(row.m_pid) is None:
            menu_list_level[row.m_pid] = []
            menu_list_level[row.m_pid].append(row)
        else:
            menu_list_level[row.m_pid].append(row)

    menu_list = []
    if menu_list_level:
        for row in menu_list_level[0]:
            menu_list.append(row)
            if menu_list_level.get(row.menu_id):
                for r in menu_list_level[row.menu_id]:
                    menu_list.append(r)

    return render(request, 'admin/system/menu_list.html', {'menu_list': menu_list})


"""
添加菜单
"""


def menu_add(request):
    pid = int(request.GET['pid']) if request.GET.get('pid') else -1

    # 获取父级菜单
    parent_menu_list = menu_model.objects.filter(is_delete=0, menu_type=1, menu_status=0).values('menu_id', 'menu_name')
    route_list = list(
        p_system_route_model.objects.filter(is_delete=0).values('route_id', 'route_name', 'route_alias_name'))
    if request.is_ajax():
        param = request.POST
        check_form = MenuForms(param)
        if check_form.is_valid():
            m_pid = param['m_pid']
            if param['m_pid'] == '-1':
                m_pid = 0
            menu_status = 0
            if param['menu_status'] is 'on':
                menu_status = 1
            menu_type = 1
            if param['m_pid'] == '-1' and param['default_route'] == '':
                default_route = ''
                permission_route = ''
            else:
                menu_type = 2
                default_route = param['default_route']
                permission_route = param['permission_route']

            result = menu_model.objects.create(
                m_pid=m_pid,
                menu_name=param['menu_name'],
                menu_type=menu_type,
                menu_description=param['menu_description'],
                menu_status=menu_status,
                menu_icon=param['menu_icon'],
                default_route=default_route,
                permission_route=permission_route,
                sort=param['sort'],
            )
            if result is not None:
                return success(request, u'添加菜单成功')
            else:
                return error(request, u'添加菜单失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/system/menu_add.html',
                      {'parent_menu_list': parent_menu_list, 'route_list': json.dumps(route_list), 'pid': pid})


"""
修改菜单
"""


def menu_edit(request):
    menu_id = int(request.GET['menu_id']) if request.method == "GET" else int(request.POST['menu_id'])
    if menu_id <= 0:
        return error(request, u'菜单参数ID有误')

    menu_object = menu_model.objects.filter(menu_id=menu_id, is_delete=0).get()
    if menu_object is None:
        return error(request, u'菜单不存在,菜单ID有误')

    route_list = list(
        p_system_route_model.objects.filter(is_delete=0).values('route_id', 'route_name', 'route_alias_name'))

    # 获取父级菜单
    parent_menu_list = menu_model.objects.filter(is_delete=0, menu_type=1, menu_status=0).values('menu_id', 'menu_name')
    if request.is_ajax():
        param = request.POST
        check_form = MenuForms(param)
        if check_form.is_valid():
            m_pid = param['m_pid']
            if param['m_pid'] == '-1':
                m_pid = 0

            if m_pid != menu_object.m_pid:
                is_sub_menu = menu_model.objects.filter(m_pid=menu_id, is_delete=0).count()
                if is_sub_menu > 0:
                    return error(request, u'该菜单下还有子菜单，请先将子菜单处理后在修改到其他菜单下去')

            menu_status = 0
            if param['menu_status'] == 'off':
                menu_status = 1

            menu_type = 1
            if param['m_pid'] == '-1' and param['default_route'] == '':
                default_route = ''
                permission_route = ''
            else:
                menu_type = 2
                default_route = param['default_route']
                permission_route = param['permission_route']

            menu_object.m_pid = m_pid
            menu_object.menu_name = param['menu_name']
            menu_object.menu_type = menu_type
            menu_object.menu_description = param['menu_description']
            menu_object.menu_status = menu_status
            menu_object.menu_icon = param['menu_icon']
            menu_object.default_route = default_route
            menu_object.permission_route = permission_route
            menu_object.sort = param['sort']
            result = menu_object.save()
            if result is None:
                return success(request, u'修改菜单成功')
            else:
                return error(request, u'修改菜单失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/system/menu_edit.html',
                      {'parent_menu_list': parent_menu_list, 'menu_info': menu_object,
                       'route_list': json.dumps(route_list)})


"""
删除菜单
"""


def menu_delete(request):
    menu_id = int(request.POST['menu_id'])
    if menu_id <= 0:
        return error(request, u'菜单参数ID有误')

    menu_object = menu_model.objects.filter(menu_id=menu_id, is_delete=0).get()
    if menu_object is None:
        return error(request, u'菜单不存在,菜单ID有误')

    is_sub_menu = menu_model.objects.filter(m_pid=menu_id, is_delete=0).count()
    if is_sub_menu > 0:
        return error(request, u'该菜单下还有子菜单，请先删除子菜单后在进行删除')
    menu_object.is_delete = 1

    result = menu_object.save()
    if result is None:
        return success(request, u'删除菜单成功')
    else:
        return error(request, u'删除菜单失败')
