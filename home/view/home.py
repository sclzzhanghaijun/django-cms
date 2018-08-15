from django.shortcuts import render

from admin.user.models import AdminUser
from common.model.PSlideCategory import PSlideCategory
from common.model.PSlideManage import PSlideManage
from common.model.PUsers import PUsers
from common.models import PArticle
from django.db.models import Count
from common.models import PArticleCategory
from common.models import PFriendLink
from django.template.defaultfilters import date
from admin.utils.response import *
from common.models import PUsers as p_user_model
from django.contrib.auth.hashers import make_password
from home.forms.RegisterForm import RegisterForm
from home.forms.RegisterEmailForm import RegisterEmailForm
from home.forms.ResetPwdEmailCheckForm import ResetPwdEmailCheckForm
from home.forms.ResetPwdEmailForm import ResetPwdEmailForm
from admin.utils.mail import mail
import random
from home.common import login_required


# Create your views here.
def home_index(request):
    # banner
    banner_list = PSlideManage.objects.filter(status=0, is_delete=0).values()

    # 文章列表
    where = {
        'is_delete': 0,
        'status': 1,
    }
    article_list_data = PArticle.objects.filter(**where).order_by('-created_time').values()[0:20]
    category_ids = []
    user_ids = []
    for item in article_list_data:
        category_ids.append(item.get('category_id'))
        if item.get('user_id') not in user_ids:
            user_ids.append(item.get('user_id'))

    categories = PSlideCategory.objects.filter(category_id__in=category_ids).values('category_id', 'category_name')
    users = PUsers.objects.filter(user_id__in=user_ids).values('nickname', 'user_id', 'avatar')
    for article_item in article_list_data:
        for category in categories:
            if article_item.get('category_id') == category.get('category_id'):
                article_item['category_name'] = category.get('category_name')
        for user_item in users:
            if user_item.get('user_id') == article_item.get('user_id'):
                article_item['user_nickname'] = user_item.get('nickname')
                article_item['user_avatar'] = user_item.get('avatar')

    # 友情链接
    where = {
        'is_delete': 0,
        'status': 0
    }
    friend_link = PFriendLink.objects.filter(**where).values('link_name', 'link_url', 'open_mode')

    # 用户文章
    user_article_where = {
        'status': 1,
        'is_delete': 0,
        'user_type': 2
    }
    user_article_list = PArticle.objects.filter(**user_article_where).order_by('-created_time').values()[0:10]
    user_ids = []
    for item in user_article_list:
        user_id = item['user_id']
        if user_ids.count(user_id):
            continue
        user_ids.append(item['user_id'])

    user = p_user_model.objects.filter(user_id__in=user_ids).values('user_id', 'nickname', 'avatar', )
    for value in user_article_list:
        for val in user:
            if val['user_id'] == value['user_id']:
                value['nickname'] = val['nickname']
                value['avatar'] = val['avatar']

    return render(request, 'home/index.html',
                  {'title': '首页', 'banner_list': banner_list, 'article_list': article_list_data,
                   'friend_link': friend_link, 'user_article_list': user_article_list})


def article_list(request):
    # 页码
    try:
        pageindex = int(request.GET['page'])
    except:
        pageindex = 1
    try:
        type = int(request.GET['type'])
    except:
        type = 6
    # 每页数量

    pagesize = 10
    where = {
        'is_delete': 0,
        'status': 1,
        'category_id': type,
    }
    start_lines = (pageindex - 1) * pagesize
    count = PArticle.objects.filter(**where).all().aggregate(count=Count('article_id'))
    if count['count'] % pagesize == 0:
        allpage = count['count'] // pagesize
    else:
        allpage = count['count'] // pagesize + 1
    data = PArticle.objects.filter(**where).values()[start_lines:(start_lines + pagesize)]
    data = list(data)
    # 获取文章的类型
    category_ids = []
    user_ids = []
    user_ids_admin = []
    for items in data:
        category_id = items['category_id']
        user_id = items['user_id']
        if category_ids.count(category_id):
            continue
        category_ids.append(items['category_id'])
        if items['user_type'] == 2:
            if user_ids.count(user_id):
                continue
            user_ids.append(items['user_id'])
        elif items['user_type'] == 1:
            if user_ids_admin.count(user_id):
                continue
            user_ids_admin.append(items['user_id'])

    category = PArticleCategory.objects.filter(category_id__in=category_ids).values('category_id', 'category_name')
    admin_users = AdminUser.objects.filter(id__in=user_ids_admin).values('id', 'username')
    users = p_user_model.objects.filter(user_id__in=user_ids).values('user_id', 'username', 'avatar')
    user_ids_names = {}
    user_ids_admin_names = {}
    new_category = {}
    for value in users:
        value_list = list(value.values())
        user_ids_names[value_list[0]] = [value_list[1], value_list[2]]
    for value in admin_users:
        value_list = list(value.values())
        user_ids_admin_names[value_list[0]] = value_list[1]
    for cat in category:
        value_list = list(cat.values())
        new_category[value_list[0]] = value_list[1]
    for items in data:
        user_id = items['user_id']
        category_id = items['category_id']
        items['category_name'] = new_category[category_id]
        items['created_time'] = date(items['created_time'], 'Y-m-d H:i:s')
        if items['user_type'] == 2:
            if user_id in user_ids_names:
                items['user_id'] = user_ids_names[user_id][0]
                if user_ids_names[user_id][1] == "":
                    items['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
            else:
                continue
        elif items['user_type'] == 1:
            if user_id in user_ids_admin_names:
                items['user_id'] = user_ids_admin_names[user_id]
                items['avatar'] = "/static/home/sy-img/59_1502432173.jpg"
            else:
                continue
    return render(request, 'home/article_list.html',
                  {'title': '详情', 'article_lists': data, 'pageindex': pageindex, 'allpage': allpage, 'type': type})


# 文章详情界面
def article(request):
    try:
        article_id = int(request.GET['article_id'])
    except:
        return error(request, u'参数有误,文章不存在')
    where = {
        'is_delete': 0,
        'status': 1,
        'article_id': article_id,
    }
    model = PArticle.objects.filter(**where).values('status', 'article_id', 'article_title', 'article_content',
                                                    'created_time', 'status', 'views', 'comment', 'category_id',
                                                    'user_id', 'user_type', 'is_delete')
    if len(model) < 1:
        return error(request, u'参数有误,文章不存在')
    model = model[0]
    up = PArticle.objects.filter(**where).get()
    up.views = up.views + 1
    up.save()
    model['created_time'] = date(model['created_time'], 'Y-m-d H:i:s')
    category_id = model['category_id']
    user_id = model['user_id']
    category = PArticleCategory.objects.filter(category_id=category_id).values('category_id', 'category_name')[0]
    if model['user_type'] == 1:
        admin_users = AdminUser.objects.filter(id=user_id).values('id', 'username')[0]
        if len(admin_users) < 1:
            return error(request, u'参数有误,用户不存在')
        model['username'] = admin_users['username']
    elif model['user_type'] == 2:
        users = p_user_model.objects.filter(user_id=user_id).values('user_id', 'username')[0]
        if len(users) < 1:
            return error(request, u'参数有误,用户不存在')
        model['username'] = users['username']

    if len(category) < 1:
        return error(request, u'参数有误,文章分类不存在')
    model['category_id'] = category['category_name']
    # return success(request, '', '', model)
    return render(request, 'home/article.html', {'title': '详情', 'model': model})


'''
注册发送邮件
'''


def register_mail(request):
    if request.session.get('user_id'):
        return error(request, u'已登录,不能进行注册')
    if request.is_ajax():
        request.session.delete('register_code')
        param = request.POST
        check_form = RegisterEmailForm(param)
        if not check_form.is_valid():
            return error(request, check_form.errors)
        email = param['mail']

        code = str(random.randint(100000, 999999))
        result = mail().send_text_mail(u'邮箱用户注册验证码', u'尊敬的用户您好，感谢您使用本网站，注册的验证码为：' + code, email)
        if result is False:
            return error(request, u'邮件发送失败，请稍后再试')
        else:
            request.session['register_code'] = code
            return success(request, u'邮件发送成功，请前往邮箱获取验证码')
    else:
        return error(request, u'请求有误')


def register(request):
    if request.session.get('user_id'):
        return error(request, u'已登录,不能进行找回密码')
    if request.is_ajax():
        param = request.POST
        check_form = RegisterEmailForm(param)
        if not check_form.is_valid():
            return error(request, check_form.errors)
        check_form = RegisterForm(param)
        if check_form.is_valid():
            if param['code'] != request.session['register_code']:
                return error(request, u'验证码有误')
            email = param['mail']
            result = p_user_model.objects.create(username=email, password=make_password(param['password']),
                                                 nickname=u'pd-cms用户', email=email)
            if result.user_id:
                return success(request, u'注册成功')
            else:
                return error(request, u'注册失败')
        else:
            return error(request, check_form.errors)

    else:
        return error(request, u'请求有误')


def reset_password(request):
    if request.session.get('user_id'):
        return error(request, u'已登录,不能进行找回密码')
    if request.is_ajax():
        type = request.POST['type'] if request.POST.get('type') else request.GET['type']
        if type not in ['check_email', 'send_email', 'reset_password']:
            return error(request, u'处理类型错误')
        param = request.POST
        if type in ['check_email', 'send_email']:
            check_form = ResetPwdEmailCheckForm(param)
            if not check_form.is_valid():
                return error(request, check_form.errors)
            email = param['email']
            if type == 'check_email':
                return success(request, u'验证成功')
            else:
                code = str(random.randint(100000, 999999))
                # result = mail().send_text_mail(u'邮箱用户注册验证码', u'尊敬的用户您好，感谢您使用本网站，注册的验证码为：' + code, email)
                result = True
                if result is False:
                    return error(request, u'邮件发送失败，请稍后再试')
                else:
                    request.session['register_code'] = code
                    request.session['email'] = email
                    return success(request, u'发送邮箱验证码成功，请前往邮箱获取',
                                   {'code': code})
        elif type == 'reset_password':
            check_form = ResetPwdEmailForm(param)
            email = request.session['email']
            if not check_form.is_valid():
                return error(request, check_form.errors)
            if request.session['register_code'] != param['code']:
                return error(request, u'邮箱验证码输入错误')

            user_object = p_user_model.objects.get(email=email)
            user_object.password = make_password(param['password'], '123456')
            user_object.save()
            if user_object.user_id:
                return success(request, u'成功重置密码')
            else:
                return error(request, u'重置密码失败')
    else:
        return render(request, 'home/reset_password.html')


# 检查用户登录状态和菜单加载
def login_status_and_load_menu(request):
    # 获取登录状态
    status = True if request.session.get('user_id', False) else False
    username = request.session.get('username', '')
    avatar = request.session.get('avatar', '')
    # 菜单配置
    menu_list = []
    category = PArticleCategory.objects.values('category_id', 'category_name', 'parent_category_id').filter(
        is_delete=0)
    for value in category:
        if value['parent_category_id'] == 0:
            list_name = {
                'menu_name': value['category_name'],
                'link_url': '',
                'menu_item': [],
                'need_login': False
            }
            for cvalue in category:
                if cvalue['parent_category_id'] == value['category_id']:
                    item = {
                        'menu_name': cvalue['category_name'],
                        'link_url': '/article_list?type=' + str(cvalue['category_id'])
                    }
                    list_name['menu_item'].append(item)
            menu_list.append(list_name)

    another_menu = [
        {
            'menu_name': '话题',
            'link_url': '/topic_list',
            'menu_item': [],
            'need_login': False
        },
        {
            'menu_name': '个人中心',
            'link_url': '/member',
            'menu_item': [],
            'need_login': True
        },
        {
            'menu_name': '我要投稿',
            'link_url': '/contribute',
            'menu_item': [],
            'need_login': True
        },
        {
            'menu_name': '下载',
            'link_url': '/download',
            'menu_item': [],
            'need_login': True
        }
    ]
    for other in another_menu:
        menu_list.append(other)

    result = {
        'status': status,
        'username': username,
        'avatar': avatar,
        'menu_list': menu_list
    }
    return JsonResponse(result)
