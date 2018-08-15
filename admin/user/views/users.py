# encoding=utf-8
from django.shortcuts import render

from admin.user.forms.RegisterUserForms import RegisterUserForms
from common.models import PUsers
from django.contrib.auth.hashers import make_password
from admin.utils.response import *


def register_user(request):
    if request.method == 'POST':
        data = request.POST
        check_form = RegisterUserForms(data)
        if check_form.is_valid():
            username = data['username']
            user = PUsers()
            user.username = username
            user.nickname = data['nickname']
            user.password = make_password(data['password'])
            user.gender = data['gender']
            user.phone = data['phone']
            user.email = data['email']
            try:
                user.save()
                return success(request, '添加成功')
            except:
                return error(request, '添加失败')
        else:
            return error(request, check_form.errors)

    else:
        return render(request, 'admin/user/register_user.html')


def manager_user(request):
    return render(request, 'admin/user/manager_user.html')


def user_list_data(request):
    user_id = request.POST.get('user_id', '')
    username = request.POST.get('username', '')
    nickname = request.POST.get('nickname', '')
    phone = request.POST.get('phone', '')
    email = request.POST.get('email', '')
    page = int(request.POST.get('page', 1))
    limit = int(request.POST.get('limit', 20))
    start_row = (page - 1) * limit
    end_row = start_row + limit
    where = {
        'is_delete': 0
    }
    if user_id.strip() != '':
        where['user_id'] = user_id
    if username.strip() != '':
        where['username'] = username
    if nickname.strip() != '':
        where['nickname'] = nickname
    if phone.strip() != '':
        where['phone'] = phone
    if email.strip() != '':
        where['email'] = email
    total_row = PUsers.objects.filter(**where).count()
    user_list = PUsers.objects.filter(**where).order_by('-user_id').values('user_id', 'username', 'nickname', 'gender',
                                                                           'phone',
                                                                           'email', 'is_active')[start_row:end_row]
    return load_data(request, total_row, list(user_list))


def user_detail(request):
    user_id = request.GET['user_id']
    user = PUsers.objects.filter(user_id=user_id).get()
    return render(request, 'admin/user/user_detail.html', user.__dict__)


def user_reset_pwd(request):
    user_id = request.POST['user_id']
    user = PUsers.objects.filter(user_id=user_id).get()
    user.password = make_password('123456')
    user.save()
    return success(request, '密码重置成功')


def user_state_change(request):
    print(request.POST)
    user_id = request.POST["user_id"]
    is_active = request.POST['is_active']

    user = PUsers.objects.filter(user_id=user_id).get()
    user.is_active = is_active
    user.save()
    return success(request, '成功')


def user_delete(request):
    user_id = request.POST['user_id']
    rows = PUsers.objects.filter(user_id=user_id).update(is_delete=1)
    if rows == 1:
        return success(request, '删除成功')
    else:
        return error(request, '删除失败')
