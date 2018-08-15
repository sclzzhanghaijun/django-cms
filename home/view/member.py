import time

from django.contrib.auth.hashers import check_password
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.db.models import Q

from admin.article.form.ArticleForms import ArticleForms
from admin.article.views.article_classify import cate_tree
from admin.utils.response import *
from common.model.PUsers import PUsers
from common.models import PArticle
from common.models import PArticleCategory
from common.models import PArticleComment
from home.common import *
from home.forms.UserLoginForm import UserLoginForm

'''
个人中心
'''


def user_login(request):
    if request.method == 'POST':

        check_form = UserLoginForm(request.POST)

        if not check_form.is_valid():
            return error(request, check_form.errors)

        username = request.POST['username']
        pwd = request.POST['password']
        where = {
            'is_delete': 0,
            'is_active': 0
        }
        user = PUsers.objects.get(Q(username=username) | Q(email=username), **where)
        if not check_password(pwd, user.password):
            return error(request, u'用户名或密码错误')

        request.session['user_id'] = user.user_id  # 在Django 中一句话搞定
        request.session['nickname'] = user.nickname  # 在Django 中一句话搞定
        request.session['username'] = user.username
        request.session['avatar'] = user.avatar

        return success(request, "登录成功")
    else:
        return error(request, u'请使用post方式提交')


def logout(request):
    if request.method == 'POST':
        request.session['user_id'] = ''
        request.session['nickname'] = ''
        request.session['username'] = ''
        request.session['avatar'] = ''
        ref = request.META['HTTP_REFERER']
        ref_arr = ref.split('/')
        name = ref_arr.pop()
        if name == 'member' or name == 'contribute':
            ref = '/index.html'
        return success(request, '注销成功', ref)
    return error(request, '注销失败')


@login_required
def index(request, **kwargs):
    user_id = kwargs['user_id']
    page = int(request.GET.get('page', '1'))
    user_info = PUsers.objects.filter(user_id=user_id).get()
    type = request.GET.get('type', 'info')
    obj = {
        'request': request,
        'page': page,
        'user_id': user_id
    }

    if type == 'info':
        return render(request, 'home/member.html', {'user_info': user_info, 'type': 'info'})
    elif type == 'article':
        data = user_article_list(**obj)
        return render(request, 'home/member.html',
                      {'user_info': user_info, 'type': 'article', 'page': data[0], 'list': data[1]})
    else:
        data = user_comment_list(**obj)

        return render(request, 'home/member.html',
                      {'user_info': user_info, 'type': 'comment', 'page': data[0], 'list': data[1]})


def user_comment_list(**kwargs):
    user_id = kwargs['user_id']
    where = {
        'is_delete': 0,
        'user_id': user_id
    }

    page = int(kwargs['page'])
    limit = 20
    start_row = (page - 1) * limit
    end_row = start_row + limit

    comment_all = PArticleComment.objects.filter(**where).all()
    comment_list = PArticleComment.objects.filter(**where).order_by('-article_comment_id').values()[start_row:end_row]
    comment_list = list(comment_list)
    paginator = Paginator(comment_all, 20)  # Show 25 contacts per page

    article_ids = []
    for item in comment_list:
        article_id = item['article_id']
        if article_ids.count(article_id):
            continue
        article_ids.append(item['article_id'])

    article = PArticle.objects.filter(article_id__in=article_ids).values('article_id', 'article_title')
    for value in comment_list:
        for val in article:
            if val['article_id'] == value['article_id']:
                value['article_from'] = val['article_title']

    try:
        comment_page = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        comment_page = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        comment_page = paginator.page(paginator.num_pages)
    return (comment_page, comment_list)


def user_article_list(**kwargs):
    user_id = kwargs['user_id']

    where = {
        'is_delete': 0,
        'user_id': user_id
    }
    page = int(kwargs['page'])
    limit = 10
    start_row = (page - 1) * limit
    end_row = start_row + limit

    article_all = PArticle.objects.filter(**where).all()
    article_list = PArticle.objects.filter(**where).order_by('-article_id').values()[start_row:end_row]
    article_list = list(article_list)
    paginator = Paginator(article_all, 10)  # Show 25 contacts per page

    try:
        article_page = paginator.page(page)
    except PageNotAnInteger:
        # If page is not an integer, deliver first page.
        article_page = paginator.page(1)
    except EmptyPage:
        # If page is out of range (e.g. 9999), deliver last page of results.
        article_page = paginator.page(paginator.num_pages)
    return (article_page, article_list)


@login_required
def edit_user_info(request, **kwargs):
    user_id = request.session['user_id']
    nickname = request.POST.get('nickname', '')
    phone = request.POST.get('phone', '')
    gender = request.POST.get('gender', '')
    imgURL = request.POST.get('imgURL', '')
    PUsers.objects.filter(user_id__contains=user_id).update(nickname=nickname, phone=phone, gender=gender,
                                                            avatar=imgURL)
    return success(request, msg='成功')


# 文章发布
@login_required
def contribute(request, **kwargs):
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
            data['user_id'] = request.session['user_id']
            data['user_type'] = 2
            data['is_delete'] = 0
            data['thumb'] = param['thumb']
            data['status'] = 0
            result = PArticle.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:
            return error(request, check_form.errors)
    else:
        category = PArticleCategory.objects.filter(is_delete=0).values('category_id', 'category_name',
                                                                       'parent_category_id')
        slist = list(category)
        category_list = cate_tree(slist)
        return render(request, 'home/contribute.html', {
            'title': '我要投稿',
            'category': category_list
        })
