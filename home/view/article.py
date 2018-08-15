# encoding=utf-8
from admin.article.form.ArticleForms import ArticleCommentForms
from common.models import PArticle
from common.models import PArticleComment as ArticleComment
from admin.utils.response import *
import time
from common.models import PArticleComment
from admin.user.models import AdminUser
from common.models import PUsers as p_user_model
from django.template.defaultfilters import date


# 获取热门文章

def hotarticle(request):
    where = {
        'is_delete': 0,
        'status': 1,
    }
    data_views = PArticle.objects.filter(**where).order_by('-views').values('article_id', 'article_title', 'thumb')[0:5]
    lists = list(data_views)
    data_commnet = PArticle.objects.filter(**where).order_by('-comment').values('article_id', 'article_title', 'thumb')[
                   0:5]

    lists = lists + list(data_commnet)
    rlist = []
    for id in lists:
        if id not in rlist:
            rlist.append(id)
    rlist = rlist[0:5]
    return JsonResponse(rlist, safe=False)


# 文章评论
def add_article_comment(request):
    param = request.POST
    check_form = ArticleCommentForms(param)
    ret = check_form.is_valid()
    if ret == False:
        return error(request, check_form.errors)
    result = ArticleComment.objects.create(
        article_id=param['art_id'],
        user_id=request.session.get('user_id'),
        user_type=2,
        comment_content=param['comment_content'],
        reply_comment_id=param['reply_comment_id'],
        created_time=time.strftime("%Y-%m-%d %H:%M:%S"),
        is_delete=0,
    )
    if result is not None:
        return success(request, u'评论成功')
    else:
        return error(request, u'评论失败')


# 文章评论展示
def article_comment(request):
    param = request.POST
    article_id = param['art_id']
    where = {
        'is_delete': 0,
        'article_id': article_id,
    }
    data_views = PArticleComment.objects.filter(**where).order_by('created_time').values()
    user_ids = []
    user_ids_admin = []
    for items in data_views:
        user_id = items['user_id']
        if items['user_type'] == 2:
            if user_ids.count(user_id):
                continue
            user_ids.append(items['user_id'])
        elif items['user_type'] == 1:
            if user_ids_admin.count(user_id):
                continue
            user_ids_admin.append(items['user_id'])
    admin_users = AdminUser.objects.filter(id__in=user_ids_admin).values('id', 'username')
    users = p_user_model.objects.filter(user_id__in=user_ids).values('user_id', 'username', 'avatar')
    user_ids_names = {}
    user_ids_admin_names = {}
    for value in users:
        value_list = list(value.values())
        user_ids_names[value_list[0]] = [value_list[1], value_list[2]]
    for value in admin_users:
        value_list = list(value.values())
        user_ids_admin_names[value_list[0]] = value_list[1]
    dic = {}
    dicr = {}
    listr = []
    for value in data_views:
        if value['reply_comment_id'] == 0:
            user_id = value['user_id']
            value['created_time'] = date(value['created_time'], 'Y-m-d H:i:s')
            if value['user_type'] == 2:
                if user_id in user_ids_names:
                    value['user_id'] = user_ids_names[user_id][0]
                    if user_ids_names[user_id][1] == "":
                        value['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
                else:
                    continue
            elif value['user_type'] == 1:
                if user_id in user_ids_admin_names:
                    value['user_id'] = user_ids_admin_names[user_id]
                    value['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
                else:
                    continue
            listr.append(value)
            listc = []
            for valuec in data_views:
                if valuec['reply_comment_id'] == value['article_comment_id']:
                    user_id = valuec['user_id']
                    valuec['created_time'] = date(valuec['created_time'], 'Y-m-d H:i:s')
                    if valuec['user_type'] == 2:
                        if user_id in user_ids_names:
                            valuec['user_id'] = user_ids_names[user_id][0]
                            if user_ids_names[user_id][1] == "":
                                valuec['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
                        else:
                            continue
                    elif valuec['user_type'] == 1:
                        if user_id in user_ids_admin_names:
                            valuec['user_id'] = user_ids_admin_names[user_id]
                            valuec['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
                        else:
                            continue
                    listc.append(valuec)
            dic[value['article_comment_id']] = listc
    dicr[0] = listr
    dicr[1] = dic
    return JsonResponse(dicr, safe=False)
