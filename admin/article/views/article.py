from django.shortcuts import render
from admin.article.form.ArticleForms import ArticleForms
from admin.article.views.article_classify import cate_tree
from common.models import PArticleCategory
from common.models import PArticle
import time
from django.db.models import Count
from django.template.defaultfilters import date
from admin.utils.response import *

# Create your views here.
'''
文章管理
'''


def article_lists(request):
    return render(request, 'admin/article/article_index.html', {'category': get_article_category()})


# 文章列表
def article_lists_data(request):
    page = int(request.GET['page'])
    limit = int(request.GET['limit'])
    article_title = request.GET['article_title']
    category_id = int(request.GET['category_id'])
    user_type = int(request.GET['user_type'])
    status = int(request.GET['status'])
    where = {
        'is_delete': 0
    }
    if article_title.strip() != '':
        where['article_title__contains'] = article_title
    if category_id != 0:
        where['category_id'] = category_id
    if user_type != 0:
        where['user_type'] = user_type
    if status != -1:
        where['status'] = status

    start_lines = (page - 1) * limit
    count = PArticle.objects.filter(**where).all().aggregate(count=Count('article_id'))
    data = PArticle.objects.filter(**where).values()[start_lines:(limit * start_lines) + limit]
    data = list(data)

    # 获取文章的类型
    category_ids = []
    for items in data:
        category_id = items['category_id']
        if category_ids.count(category_id):
            continue
        category_ids.append(items['category_id'])

    category = PArticleCategory.objects.filter(category_id__in=category_ids).values('category_id', 'category_name')

    new_category = {}
    for cat in category:
        value_list = list(cat.values())
        new_category[value_list[0]] = value_list[1]

    for items in data:
        category_id = items['category_id']
        items['category_name'] = new_category[category_id]
        items['created_time'] = date(items['created_time'], 'Y-m-d H:i:s')

        if items['status'] == 0:
            items['status'] = '草稿状态'
        elif items['status'] == 1:
            items['status'] = '上线状态'
        else:
            items['status'] = '下线状态'

        if items['user_type'] == 1:
            items['user_type'] = '管理员'
        else:
            items['user_type'] = '会员'

    return load_data(request, count['count'], data)


# 添加文章
def article_add(request):
    if request.method == 'POST':
        param = request.POST
        check_form = ArticleForms(param)
        ret = check_form.is_valid()
        if ret:
            data = check_form.cleaned_data
            data['created_time'] = time.strftime('%Y-%m-%d %H:%M:%S')
            data['last_modified_time'] = time.strftime('%Y-%m-%d %H:%M:%S')
            data['views'] = 0
            data['comment'] = 0
            data['topped'] = 0
            data['user_id'] = request.session.get('user_info')['id']
            data['user_type'] = 1
            data['is_delete'] = 0
            data['thumb'] = param['thumb']
            result = PArticle.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:
            return error(request, check_form.errors)

    else:
        return render(request, 'admin/article/article_add.html', {'category': get_article_category()})


# 编辑文章
def article_edit(request):
    if request.method == 'POST':
        param = request.POST
        check_form = ArticleForms(param)
        ret = check_form.is_valid()
        if ret:
            data = check_form.cleaned_data
            data['last_modified_time'] = time.strftime('%Y-%m-%d %H:%M:%S')
            result = PArticle.objects.filter(article_id=param['article_id']).update(**data)
            if result:
                return success(request, u'更新成功')
            else:
                return error(request, u'更新失败')
        else:
            return error(request, check_form.errors)
    else:
        article_id = request.GET['article_id']
        data = PArticle.objects.filter(article_id=article_id).get()
        return render(request, 'admin/article/article_edit.html', {'data': data, 'category': get_article_category()})


# 删除
def article_delete(request):
    article_id = request.GET['article_id']
    result = PArticle.objects.filter(article_id=article_id).update(is_delete=1)
    if result:
        return success(request, u'删除成功')
    else:
        return error(request, u'删除失败')


# 获取文章分类
def get_article_category():
    category = PArticleCategory.objects.filter(is_delete=0).values('category_id', 'category_name', 'parent_category_id')
    slist = list(category)
    return cate_tree(slist)
