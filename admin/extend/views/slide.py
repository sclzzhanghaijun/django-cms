from django.shortcuts import render


from admin.extend.form.SlideForms import *

from common.models import PSlideCategory as SlideCategory
from common.models import PSlideManage as SlideManage
import time
from admin.utils.response import *


# 获取分类列表
def category_list(request):
    if request.is_ajax():

        page = int(request.POST.get('page', 1))
        limit = int(request.POST.get('limit', 20))
        start_row = (page - 1) * limit
        end_row = start_row + limit

        count = SlideCategory.objects.filter(is_delete=0).count()
        category = SlideCategory.objects.filter(is_delete=0).values('category_id', 'category_name', 'category_identify',
                                                                    'category_remark')[start_row:end_row]
        slist = list(category)
        return load_data(request, count, slist)
    else:
        return render(request, 'admin/extend/slide_category_list.html')


# 添加分类
def add_category(request):
    if request.is_ajax():

        check_form = SlideCategoryForms(request.POST)
        result = check_form.is_valid()

        if result:
            data = check_form.cleaned_data
            data['is_delete'] = 0


            result = SlideCategory.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:

            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/slide_category_add.html')


# 删除分类
def delete_category(request):
    category_id = int(request.POST['category_id'])
    if category_id <= 0:
        return error(request, u'ID有误')
    category_object = SlideCategory.objects.filter(category_id=category_id, is_delete=0).get()
    if category_object is None:
        return error(request, u'不存在，分类ID有误')

    count = SlideManage.objects.filter(category_id = category_id).values().count()
    if count > 0:
        return error(request, u'删除分类失败,请先删除该分类下的轮播')


    category_object.is_delete = 1

    result = category_object.save()
    if result is None:
        return success(request, u'删除分类成功')
    else:
        return error(request, u'删除分类失败')

# 编辑
def edit_category(request):
    category_id = int(request.GET['category_id']) if request.method == "GET" else int(request.POST['category_id'])

    if category_id <= 0:
        return error(request, u'分类参数ID有误')
    category_object = SlideCategory.objects.filter(category_id=category_id, is_delete=0).get()
    if category_object is None:
        return error(request, u'分类不存在,分类ID有误')
    if request.is_ajax():

        check_form = SlideCategoryForms(request.POST)
        result = check_form.is_valid()
        if result:
            data = check_form.cleaned_data
            result = SlideCategory.objects.filter(category_id=category_id).update(**data)
            if result:
                return success(request, u'修改分类成功')
            else:
                return error(request, u'修改分类失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/slide_category_edit.html', {'category_object': category_object})


# 轮播管理
def slide_list(request):
    if request.is_ajax():
        page = int(request.GET['page'])
        limit = int(request.GET['limit'])
        category_id = int(request.GET['category_id'])
        status = request.GET['status']
        slide_id = request.GET['slide_id']
        slide_title = request.GET['slide_title']

        where = {
            'is_delete': 0
        }

        if slide_id != '':
            where['slide_id'] = slide_id

        if category_id != 0:
            where['category_id'] = category_id

        if status != '':
            where['status'] = status

        if slide_title.strip() != '':
            where['slide_title'] = slide_title

        start_row = (page - 1) * limit
        end_row = start_row + limit

        data = SlideManage.objects.filter(**where).values()[start_row:end_row]
        count = SlideManage.objects.filter(**where).values().count()

        data = list(data)

        category_ids = []
        for items in data:
            category_id = items['category_id']
            if category_ids.count(category_id):
                continue
            category_ids.append(items['category_id'])

        category = SlideCategory.objects.filter(category_id__in=category_ids).values('category_id', 'category_name')

        new_category = {}
        for cat in category:
            value_list = list(cat.values())
            new_category[value_list[0]] = value_list[1]

        for items in data:
            category_id = items['category_id']
            items['category_name'] = new_category[category_id]

        return load_data(request, count, data)
    else:
        return render(request, 'admin/extend/slide_manage_list.html', {'category_list': slide_category_name_list})


# 添加轮播
def slide_manage_add(request):
    if request.is_ajax():
        check_form = SlideForms(request.POST)
        result = check_form.is_valid()

        if result:
            data = check_form.cleaned_data
            data['is_delete'] = 0
            data['status'] = 0

            result = SlideManage.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:

                return error(request, u'添加失败')
        else:

            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/slide_manage_add.html', {'category_list': slide_category_name_list})


# 删除
def slide_manage_delete(request):
    slide_id = int(request.POST['slide_id'])
    result = SlideManage.objects.filter(slide_id=slide_id).update(is_delete=1)
    if result:
        return success(request, u'删除成功')
    else:
        return error(request, u'删除失败')


# 编辑
def slide_manage_edit(request):
    slide_id = request.GET['slide_id'] if request.method == 'GET' else request.POST['slide_id']
    data = SlideManage.objects.filter(slide_id=slide_id).get()
    if data is None:
        return error(request, u'更新失败')

    if request.is_ajax():
        check_form = SlideForms(request.POST)
        result = check_form.is_valid()
        if result:
            data = check_form.cleaned_data
            result = SlideManage.objects.filter(slide_id=slide_id).update(**data)
            if result:
                return success(request, u'更新成功')
            else:
                return error(request, u'更新失败')
        else:
            return error(request, check_form.errors)
    else:

        return render(request, 'admin/extend/slide_manage_edit.html',
                      {'data': data, 'category_list': slide_category_name_list()})


# 显示隐藏
def slide_manage_status(request):
    slide_id = int(request.POST['slide_id'])
    status = int(request.POST['status'])
    if status == 1:
        status = 0
    else:
        status = 1
    result = SlideManage.objects.filter(slide_id=slide_id).update(status=status)
    if result:
        return success(request, u'操作成功')
    else:
        return error(request, u'操作失败')


# 获取分类名字
def slide_category_name_list():
    category = SlideCategory.objects.values('category_id', 'category_name').filter(is_delete=0)
    slist = list(category)
    return list(slist)
