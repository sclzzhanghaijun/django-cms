# encoding=utf-8
import time
from django.db.models import Count
from django.template.defaultfilters import date
from django.shortcuts import render

from admin.article.form.ArticleForms import ArticleCommentForms
from common.models import PArticleComment as ArticleComment
from common.models import PArticle
from common.models import PUsers
from admin.user.models import AdminUser
from admin.utils.response import *

'''
评论列表
'''


def article_comment_list(request):
    artid = int(request.GET['art_id'])
    return render(request, 'admin/article/article_comment_list.html', {'art_id': artid})


'''
评论列表数据
'''


def article_comment_list_data(request):
    page = int(request.POST['page'])
    limit = int(request.POST['limit'])
    art_id = int(request.POST['art_id'])
    where = {
        'is_delete': 0,
        'article_id': art_id
    }
    start_lines = (page - 1) * limit
    count = ArticleComment.objects.filter(**where).all().aggregate(count=Count('article_id'))
    data = ArticleComment.objects.filter(**where).order_by('created_time').values()[
           start_lines:(limit * start_lines) + limit]
    data = list(data)
    # 获取文章的id和评论者的id
    article_ids = []
    user_ids = []
    user_ids_admin = []
    for items in data:
        article_id = items['article_id']
        user_id = items['user_id']
        if article_ids.count(article_id) < 1:
            article_ids.append(items['article_id'])
        if items['user_type'] == 2:
            if user_ids.count(user_id):
                continue
            user_ids.append(items['user_id'])
        elif items['user_type'] == 1:
            if user_ids_admin.count(user_id):
                continue
            user_ids_admin.append(items['user_id'])
    article_titles = PArticle.objects.filter(article_id__in=article_ids).values('article_id', 'article_title')
    admin_users = AdminUser.objects.filter(id__in=user_ids_admin).values('id', 'username')
    users = PUsers.objects.filter(user_id__in=user_ids).values('user_id', 'username')
    article_ids_titles = {}
    user_ids_names = {}
    user_ids_admin_names = {}
    for value in article_titles:
        value_list = list(value.values())
        article_ids_titles[value_list[0]] = value_list[1]
    for value in users:
        value_list = list(value.values())
        user_ids_names[value_list[0]] = value_list[1]
    for value in admin_users:
        value_list = list(value.values())
        user_ids_admin_names[value_list[0]] = value_list[1]
    rdata = []
    num = 0
    for items in data:
        if items['reply_comment_id'] == 0:
            user_id = items['user_id']
            article_id = items['article_id']
            if items['user_type'] == 2:
                if user_id in user_ids_names:
                    items['user_id'] = user_ids_names[user_id]
                else:
                    num = num + 1
                    continue
            elif items['user_type'] == 1:
                if user_id in user_ids_admin_names:
                    items['user_id'] = user_ids_admin_names[user_id]
                else:
                    num = num + 1
                    continue
            items['created_time'] = date(items['created_time'], 'Y-m-d H:i:s')
            items['article_id'] = article_ids_titles[article_id]
            rdata.append(items)
            for itemsc in data:
                if itemsc['reply_comment_id'] == items['article_comment_id']:
                    itemsc['comment_content'] = "  | - -  " + itemsc['comment_content']
                    user_id = itemsc['user_id']
                    article_id = itemsc['article_id']
                    if itemsc['user_type'] == 2:
                        if user_id in user_ids_names:
                            itemsc['user_id'] = user_ids_names[user_id]
                        else:
                            num = num + 1
                            continue
                    elif itemsc['user_type'] == 1:
                        if user_id in user_ids_admin_names:
                            itemsc['user_id'] = user_ids_admin_names[user_id]
                        else:
                            num = num + 1
                            continue
                    itemsc['created_time'] = date(itemsc['created_time'], 'Y-m-d H:i:s')
                    itemsc['article_id'] = article_ids_titles[article_id]
                    rdata.append(itemsc)
    return load_data(request, count['count'] - num, rdata)


'''删除评论'''


def article_comment_delete(request):
    article_comment_id = int(request.POST['article_comment_id'])
    if article_comment_id <= 0:
        return error(request, u'参数ID有误')

    model_object = ArticleComment.objects.filter(article_comment_id=article_comment_id, is_delete=0).get()
    if model_object is None:
        return error(request, u'评论不存在,评论ID有误')

    model_object.is_delete = 1

    result = model_object.save()
    if result is None:
        return success(request, u'删除成功')
    else:
        return error(request, u'删除失败')


'''回复评论'''


def add_comment(request):
    param = request.POST
    check_form = ArticleCommentForms(param)
    ret = check_form.is_valid()
    if ret == False:
        return error(request, check_form.errors)
    result = ArticleComment.objects.create(
        article_id=param['art_id'],
        user_id=2,
        user_type=1,
        comment_content=param['comment_content'],
        reply_comment_id=param['reply_comment_id'],
        created_time=time.strftime("%Y-%m-%d %H:%M:%S"),
        is_delete=0,
    )
    if result is not None:
        return success(request, u'回复成功')
    else:
        return error(request, u'回复失败')
