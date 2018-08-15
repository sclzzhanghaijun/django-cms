from django.shortcuts import render
from django.urls import reverse
from common.model.PTopic import PTopic
from common.model.PUsers import PUsers
from admin.user.models import AdminUser

from common.models import PTopicComment as TopicComment
from home.Pager import Pager
import time
from django.template.defaultfilters import date
from django.db.models import Count
from admin.utils.response import *
from home.forms.TopicForms import *



from home.common import login_required

def topic_list(request):
    current_page = int(request.GET.get('page', '1'))

    page_size = 20
    start = (current_page - 1) * page_size
    end = current_page * page_size

    count = PTopic.objects.filter(is_delete=0).count()
    topic_list_data = PTopic.objects.filter(is_delete=0).values()[start: end]


    for topic in topic_list_data:

        if topic['user_type'] == 1:
            userinfo = AdminUser.objects.filter(id=topic['user_id']).values()
            # print(userinfo)
        elif topic['user_type'] == 2:
            userinfo = PUsers.objects.filter(user_id=topic['user_id']).values('avatar').get()
            print(userinfo['avatar'])
            # print(userinfo)
            topic['avatar'] = userinfo['avatar']
            # topic['author_name'] = userinfo.nickname




    print(topic_list_data)
    page_obj = Pager(current_page, base_url=reverse('home.topic_list'), page_size=page_size)

    pager_str = page_obj.page_str(count)

    return render(request, 'home/topic_list.html',
                  {'title': '话题', 'data': topic_list_data, 'pager_str': pager_str})

@login_required
def topic_add(request,**kwargs):
    user_id = kwargs['user_id']
    if request.is_ajax():
        check_form = TopicForms(request.POST)
        form_data = check_form.is_valid()
        if form_data:
            data = check_form.cleaned_data
            data['view_num'] = 0
            data['comment_num'] = 0
            data['user_id'] = user_id
            data['user_type'] = 2
            data['is_delete'] = 0
            data['create_time'] = time.strftime("%Y-%m-%d %H:%M:%S")
            result = PTopic.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:
            return error(request, check_form.errors)

    else:
        return render(request, 'home/topic_add.html')



def topic_detail(request):
    topic_id = int(request.GET['topic_id'])
    where = {
        'topic_id': topic_id,
        'is_delete': 0
    }

    topic_detail_data = PTopic.objects.filter(**where).values().get()
    if topic_detail_data['user_type'] == 2:

        result = PUsers.objects.filter(user_id=topic_detail_data['user_id']).values('username').get()
        topic_detail_data['username'] = result['username']
    elif topic_detail_data['user_type'] == 1:
        result = AdminUser.objects.filter(id=topic_detail_data['user_id']).values('username').get()
        topic_detail_data['username'] = result['username']



    return render(request, 'home/topic_detail.html',
                  {'title': '话题详情', 'data': topic_detail_data})


def topic_comment_list(request):
    if request.is_ajax():
        topic_id = request.GET['topic_id'] if request.method == 'GET' else request.POST['topic_id']

        page = 1
        limit = 20
        where = {
            'is_delete': 0,
            'topic_id': topic_id
        }
        start_lines = (page - 1) * limit
        count = TopicComment.objects.filter(**where).all().aggregate(count=Count('topic_id'))
        data = TopicComment.objects.filter(**where).order_by('-created_time').values()[
               start_lines:(limit * start_lines) + limit]
        data = list(data)


        # 获取id和评论者
        topic_ids = []
        user_ids = []
        user_ids_admin = []

        for items in data:
            topic_ids.append(items['topic_id'])
            if items['user_type'] == 2:
                user_ids.append(items['user_id'])
            elif items['user_type'] == 1:
                user_ids_admin.append(items['user_id'])

        topic_titles = PTopic.objects.filter(topic_id__in=topic_ids).values('topic_id', 'topic_title')
        admin_users = AdminUser.objects.filter(id__in=user_ids_admin).values('id', 'username')
        users = PUsers.objects.filter(user_id__in=user_ids).values('user_id', 'username')

        topic_ids_titles = {}
        user_ids_names = {}
        user_ids_admin_names = {}

        for value in topic_titles:
            value_list = list(value.values())
            topic_ids_titles[value_list[0]] = value_list[1]

        for value in users:
            value_list = list(value.values())
            user_ids_names[value_list[0]] = value_list[1]

        for value in admin_users:
            value_list = list(value.values())
            user_ids_admin_names[value_list[0]] = value_list[1]


        rdata = []
        num = 0

        for items in data:
            user_id = items['user_id']
            topic_id = items['topic_id']
            reply_comment_id = items['reply_comment_id']
            # print(reply_comment_id)

            if reply_comment_id != 0:
                topic_comment_object = TopicComment.objects.filter(topic_comment_id=reply_comment_id).values(
                    'topic_comment_id', 'comment_content', 'user_id', 'user_type').get()

                if topic_comment_object['user_type'] == 2:
                    topic_comment_object['username'] = \
                    PUsers.objects.filter(user_id=topic_comment_object['user_id']).values('username').get()['username']

                elif topic_comment_object['user_type'] == 1:
                    topic_comment_object['username'] = \
                    AdminUser.objects.filter(id=topic_comment_object['user_id']).values('username').get()['username']

                items['reply_comment_info'] = topic_comment_object

            else:
                items['reply_comment_info'] = []

            if items['user_type'] == 2:
                if user_id in user_ids_names:
                    items['username'] = user_ids_names[user_id]
                else:
                    num = num + 1
                    continue
            elif items['user_type'] == 1:
                if user_id in user_ids_admin_names:
                    items['username'] = user_ids_admin_names[user_id]
                else:
                    num = num + 1
                    continue
            items['created_time'] = date(items['created_time'], 'Y-m-d H:i:s')
            items['topic_title'] = topic_ids_titles[topic_id]
            rdata.append(items)

        # return render(request, 'home/topic_detail.html', {'data': rdata})
        return load_data(request, count, rdata)
    else:
        return render(request, 'home/topic_detail.html')





@login_required
def topic_comment_publish(request,**kwargs):
    user_id = kwargs['user_id']
    param = request.POST
    check_form = TopicCommentForms(param)
    return_data = check_form.is_valid()
    if return_data == False:
        return error(request, check_form.errors)
    if request.is_ajax():
        result = TopicComment.objects.create(
            topic_id=param['topic_id'],
            user_id=user_id,
            user_type=2,
            comment_content=param['comment_content'],
            reply_comment_id=param['reply_comment_id'],
            created_time=time.strftime("%Y-%m-%d %H:%M:%S"),
            is_delete=0,
        )

        if result is not None:
           return success(request, u'回复成功')
        else:
           return error(request, u'回复失败')
    else:
        return render(request, 'home/topic_detail.html')



