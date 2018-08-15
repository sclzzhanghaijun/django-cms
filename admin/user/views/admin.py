# encoding=utf-8
from django.http import JsonResponse
from django.shortcuts import render
from django.db.models import Count
from django.template.defaultfilters import date
from admin.user.models import AdminUser
from admin.utils.response import *
from common.model.PAdminGroups import PAdminGroups
from common.model.PAdminGroupsUser import PAdminGroupsUser
from django.db import transaction
from django.contrib.auth.hashers import make_password
from admin.user.forms.Admin import *


def admin_user(request):
    return render(request, 'admin/user/admin_user_list.html')


def admin_user_list(request):
    page = int(request.GET['page'])
    limit = int(request.GET['limit'])
    nick_name = request.GET['nick_name']
    phone = request.GET['phone']
    user_id = request.GET['id']
    gender = request.GET['gender']

    where = {
        'is_delete': 0
    }
    if nick_name.strip() != '':
        where['nick_name'] = nick_name
    if phone != '':
        where['phone'] = phone
    if user_id != '':
        where['id'] = user_id

    if gender != '':
        where['gender'] = gender

    start_row = (page - 1) * limit
    end_row = start_row + limit

    count = AdminUser.objects.filter(**where).all().aggregate(count=Count('id'))
    data = AdminUser.objects.filter(**where).order_by('-id').values()[start_row:end_row]
    data = list(data)
    for items in data:
        items['last_login'] = date(items['last_login'], 'Y-m-d H:i:s')
        if items['gender'] == 'female':
            items['gender'] = '女'
        else:
            items['gender'] = '男'

        if items['is_active'] == 1:
            items['is_active'] = '启用'
        else:
            items['is_active'] = '禁用'

        if items['is_superuser'] == 1:
            items['is_superuser'] = '是'
        else:
            items['is_superuser'] = '否'
    return load_data(request, count['count'], data)


def admin_user_detail(request):
    if request.method == "GET":
        user_id = int(request.GET['user_id'])
    else:
        user_id = int(request.POST['user_id'])
    if user_id <= 0:
        return error(request, u'用户ID有误')

    user_object = AdminUser.objects.filter(id=user_id, is_delete=0).get()

    if user_object is None:
        return error(request, u'用户不存在,用户ID有误')

    return render(request, 'admin/user/admin_user_detail.html', {'user_info': user_object})


def admin_user_edit(request):
    if request.method == "GET":
        user_id = int(request.GET['user_id'])
    else:
        user_id = int(request.POST['user_id'])
    if user_id <= 0:
        return error(request, u'用户ID有误')
    user_object = AdminUser.objects.filter(id=user_id, is_delete=0).get()
    if user_object is None:
        return error(request, u'用户不存在,用户ID有误')

    if request.is_ajax():
        data = request.POST
        check_form = AdminEditForms(data)
        if check_form.is_valid():
            admin = AdminUser.objects.get(id=data['user_id'])
            if data['user_id'] == 1:
                admin.first_name = data['first_name']
                admin.last_name = data['last_name']
                admin.email = data['email']
                admin.nick_name = data['nick_name']
                admin.gender = data['gender']
                admin.address = data['address']
                admin.phone = data['phone']
                admin.birthday = data['birthday']
            else:
                admin.first_name = data['first_name']
                admin.last_name = data['last_name']
                admin.email = data['email']
                admin.nick_name = data['nick_name']
                admin.gender = data['gender']
                admin.address = data['address']
                admin.phone = data['phone']
                admin.birthday = data['birthday']
                admin.is_staff = data['is_staff']
                admin.is_active = data['is_active']
                admin.is_superuser = data['is_superuser']

            result = admin.save()
            if result is None:
                return success(request, u'修改用户信息成功')
            else:
                return error(request, u'修改用户信息失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/user/admin_user_edit.html', {'user_info': user_object})


@transaction.atomic
def admin_user_add(request):
    where = {
        'is_delete': 0,
        'group_status': 0
    }
    groupList = PAdminGroups.objects.filter(**where).all()

    if request.method == "POST":

        sid = transaction.savepoint()

        is_success = True
        try:
            data = request.POST
            check_form = AdminForms(data)
            if check_form.is_valid():
                admin_id = AdminUser.objects.create(
                    password=make_password(data['password']),
                    is_superuser=data['is_superuser'],
                    username=data['username'],
                    first_name=data['first_name'],
                    last_name=data['last_name'],
                    email=data['email'],
                    is_staff=data['is_staff'],
                    is_active=data['is_active'],
                    nick_name=data['nick_name'],
                    gender=data['gender'],
                    address=data['address'],
                    phone=data['phone'],
                    birthday=data['birthday'],
                )
                result = PAdminGroupsUser.objects.create(group_id=data['group_id'], admin_id=admin_id.id)
                print(result)
                if result is None:
                    is_success = False
            else:
                return error(request, check_form.errors)
        except Exception as e:
            is_success = False

        if is_success == True:
            transaction.savepoint_commit(sid)
            return success(request, u'添加成功')
        else:
            transaction.savepoint_rollback(sid)
            return error(request, u'添加失败')
    else:
        return render(request, 'admin/user/admin_user_add.html', {'groupList': groupList})


def admin_user_delete(request):
    user_id = int(request.POST['user_id'])
    if user_id <= 0:
        return error(request, u'用户ID有误')
    user_object = AdminUser.objects.filter(id=user_id, is_delete=0).get()
    if user_object is None:
        return error(request, u'用户不存在,用户ID有误')
    user_object.is_delete = 1
    result = user_object.save()
    if result is None:
        return success(request, u'删除用户成功')
    else:
        return error(request, u'删除用户失败')


def admin_user_change_password(request):
    if request.method == "GET":
        user_id = int(request.GET['user_id'])
    else:
        user_id = int(request.POST['user_id'])
    if user_id <= 0:
        return error(request, u'用户ID有误')
    user_object = AdminUser.objects.filter(id=user_id).get()
    if user_object is None:
        return error(request, u'用户不存在,用户ID有误')
    if request.is_ajax():
        data = request.POST
        check_form = AdminChangePasswordForms(data)
        if check_form.is_valid():
            user = AdminUser.objects.get(id=data['user_id'])
            user.set_password(data['password'])
            result = user.save()
            if result is None:
                return success(request, u'修改密码成功')
            else:
                return error(request, u'修改密码失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/user/admin_user_change_password.html', {'user_info': user_object})
