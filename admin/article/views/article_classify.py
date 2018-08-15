import time
from django.shortcuts import render

from admin.article.form.ArticleForms import ArticleClassifyForms
from common.models import PArticleCategory as ArticleCategory
from admin.utils.response import *

'''
文章分类
'''

lists = []  # 无限级分类存储list的变量


# 分类列表
def article_category(request):
    if request.is_ajax():
        category = ArticleCategory.objects.values('category_id', 'category_name', 'parent_category_id').filter(
            is_delete=0)
        slist = list(category)
        categorylist = cate_tree(slist)
        rlist = list(categorylist)
        return load_data(request, len(rlist), rlist)
    else:
        return render(request, 'admin/article/article_category.html')


# 递归层级分类
def cate_tree(array, pid=0, level=1):
    global lists
    if level == 1:
        lists = []
    for v in array:
        if v['parent_category_id'] == pid:
            if level > 1:
                str = " | "
                for i in range(1, level):
                    str += "---- "
                v['category_name'] = str + v['category_name']
            lists.append(v)
            cate_tree(array, v['category_id'], level + 1)
    return lists


# 根据id查询该id所有子级的id
category_id_list = []


def querychildren(id):
    global category_id_list
    category = ArticleCategory.objects.values('category_id').filter(
        is_delete=0, parent_category_id=id)
    for value in category:
        category_id_list.append(value['category_id'])
        querychildren(value['category_id'])
    return category_id_list


# 添加/编辑分类


def add_category(request):
    try:
        category_id = int(request.GET['category_id']) if request.method == "GET" else int(request.POST['category_id'])
    except:
        return error(request, u'参数有误，category_id不能为空')
    else:
        model = ArticleCategory()
        if category_id > 0:
            model = ArticleCategory.objects.filter(category_id=category_id, is_delete=0).get()
            if model is None:
                return error(request, u'分类不存在,分类ID有误')
        else:
            model.category_id = -1
        if request.is_ajax():
            param = request.POST
            check_form = ArticleClassifyForms(param)
            ret = check_form.is_valid()
            if ret == False:
                return error(request, check_form.errors)
            if category_id > 0:
                global category_id_list
                category_id_list = []
                id_list = querychildren(category_id)
                id_list.append(category_id)
                judge = id_list.count(param['parent_category_id'])
                if judge > 0:
                    return error(request, u'参数有误，父级分类不能是自己或自己的子级')
                model.category_name = param['category_name']
                model.parent_category_id = param['parent_category_id']
                model.last_modified_time = time.strftime("%Y-%m-%d %H:%M:%S")
                result = model.save()
                if result is None:
                    return success(request, u'操作成功')
                else:
                    return error(request, u'操作失败')
            else:
                result = ArticleCategory.objects.create(
                    category_name=param['category_name'],
                    parent_category_id=param['parent_category_id'],
                    created_time=time.strftime("%Y-%m-%d %H:%M:%S"),
                    last_modified_time=time.strftime("%Y-%m-%d %H:%M:%S"),
                    is_delete=0,
                )
                if result is not None:
                    return success(request, u'操作成功')
                else:
                    return error(request, u'操作失败')
        else:
            parent_category_list = category_msg()
            return render(request, 'admin/article/add_article_category.html',
                          {'parent_category_list': parent_category_list, 'model_info': model})


# 获取分类信息
def category_msg():
    category = ArticleCategory.objects.values('category_id', 'category_name', 'parent_category_id').filter(
        is_delete=0)
    slist = list(category)
    categorylist = cate_tree(slist)
    return list(categorylist)


# 删除分类
def category_delete(request):
    category_id = int(request.POST['category_id'])
    if category_id <= 0:
        return error(request, u'分类参数ID有误')

    category_object = ArticleCategory.objects.filter(category_id=category_id, is_delete=0).get()
    if category_object is None:
        return error(request, u'分类不存在,分类ID有误')

    category_object.is_delete = 1

    result = category_object.save()
    if result is None:
        return success(request, u'删除成功')
    else:
        return error(request, u'删除失败')
