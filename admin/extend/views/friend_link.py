from django.shortcuts import render

from admin.extend.form.FriendLinkForms import *

from common.models import PFriendLink as FriendLink

from admin.utils.response import *


# 轮播管理
def friend_link_list(request):
    if request.is_ajax():
        page = int(request.GET['page'])
        limit = int(request.GET['limit'])
        status = request.GET['status']
        link_id = request.GET['link_id']
        link_name = request.GET['link_name']
        open_mode = request.GET['open_mode']
        where = {
            'is_delete': 0
        }

        if link_id != '':
            where['link_id'] = link_id

        if status !='':
            where['status'] = status

        if link_name.strip() != '':
            where['link_name'] = link_name

        if open_mode != '':
            where['open_mode'] = open_mode

        start_row = (page - 1) * limit
        end_row = start_row + limit

        data = FriendLink.objects.filter(**where).values()[start_row:end_row]
        count = FriendLink.objects.filter(**where).values().count()
        data = list(data)

        return load_data(request, count, data)
    else:
        return render(request, 'admin/extend/friend_link_list.html')



# 添加链接
def friend_link_add(request):
    if request.is_ajax():
        check_form = FriendLinkForms(request.POST)
        result = check_form.is_valid()

        if result:
            data = check_form.cleaned_data
            data['is_delete'] = 0
            data['status'] = 0

            result = FriendLink.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:

            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/friend_link_add.html')


# 删除
def friend_link_delete(request):
    link_id = int(request.POST['link_id'])
    result = FriendLink.objects.filter(link_id=link_id).update(is_delete=1)
    if result:
        return success(request, u'删除成功')
    else:
        return error(request, u'删除失败')


# 编辑
def friend_link_edit(request):
    link_id = request.GET['link_id'] if request.method == 'GET' else request.POST['link_id']
    data = FriendLink.objects.filter(link_id=link_id).get()
    if data is None:
        return error(request, u'更新失败')

    if request.is_ajax():
        check_form = FriendLinkForms(request.POST)
        result = check_form.is_valid()
        if result:
            data = check_form.cleaned_data
            result = FriendLink.objects.filter(link_id=link_id).update(**data)
            if result:
                return success(request, u'更新成功')
            else:
                return error(request, u'更新失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/friend_link_edit.html',
                      {'data': data})


# 显示隐藏
def friend_link_status(request):
    link_id = int(request.POST['link_id'])
    status = int(request.POST['status'])
    if status == 1:
        status = 0
    else:
        status = 1
    result = FriendLink.objects.filter(link_id=link_id).update(status=status)
    if result:
        return success(request, u'操作成功')
    else:
        return error(request, u'操作失败')



