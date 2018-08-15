from django.shortcuts import render
import time
from django.template.defaultfilters import date
from admin.extend.form.TopicForms import *
from common.models import PTopic as Topic
from common.models import PTopicComment as TopicComment
from admin.user.models import AdminUser
from common.models import PUsers
from django.db.models import Count
from admin.utils.response import *



# 话题列表
def topic_list(request):
    if request.is_ajax():
        page = int(request.GET['page'])
        limit = int(request.GET['limit'])
        topic_id = request.GET['topic_id']
        topic_title = request.GET['topic_title']
        user_type = int(request.GET['user_type'])
        where = {
            'is_delete': 0
        }

        if topic_id != '':
            where['topic_id'] = topic_id

        if topic_title.strip() != '':
            where['topic_title__contains'] = topic_title

        if user_type != 0:
            where['user_type'] = user_type

        start_lines = (page - 1) * limit


        count = Topic.objects.filter(**where).all().aggregate(count=Count('topic_id'))
        data = Topic.objects.filter(**where).values()[start_lines:(limit * start_lines) + limit]
        data = list(data)

        for items in data:
            comment_num = TopicComment.objects.filter(is_delete=0,topic_id=items['topic_id'],reply_comment_id=0).count()
            items['comment_num'] = comment_num
            if items['user_type'] == 1:
                items['user_type'] = '管理员'
            else:
                items['user_type'] = '会员'
        return load_data(request, count['count'], data)
    else:
        return render(request, 'admin/extend/topic_list.html')


# 添加话题
def topic_add(request):
    if request.is_ajax():
        check_form = TopicForms(request.POST)
        form_data = check_form.is_valid()
        if form_data:
            data = check_form.cleaned_data
            data['view_num'] = 0
            data['comment_num'] = 0
            data['user_id'] = 1
            data['user_type'] = 1
            data['is_delete'] = 0
            data['create_time'] = time.strftime("%Y-%m-%d %H:%M:%S")
            result = Topic.objects.create(**data)
            if result is not None:
                return success(request, u'添加成功')
            else:
                return error(request, u'添加失败')
        else:
            return error(request, check_form.errors)

    else:
        return render(request, 'admin/extend/topic_add.html')


# 编辑
def topic_edit(request):
    topic_id = request.GET['topic_id'] if request.method == 'GET' else request.POST['topic_id']
    data = Topic.objects.filter(topic_id=topic_id).get()
    if data is None:
        return error(request, u'更新失败')

    if request.is_ajax():
        check_form = TopicForms(request.POST)
        result = check_form.is_valid()
        if result:
            data = check_form.cleaned_data
            result = Topic.objects.filter(topic_id=topic_id).update(**data)
            if result:
                return success(request, u'更新成功')
            else:
                return error(request, u'更新失败')
        else:
            return error(request, check_form.errors)
    else:
        return render(request, 'admin/extend/topic_edit.html', {'data': data})


# 删除
def topic_delete(request):
    topic_id = int(request.POST['topic_id'])
    if topic_id <= 0:
        return error(request, u'ID有误')
    topic_object = Topic.objects.filter(topic_id=topic_id, is_delete=0).get()
    if topic_object is None:
        return error(request, u'不存在，话题ID有误')

    topic_object.is_delete = 1

    result = topic_object.save()
    if result is None:
        return success(request, u'删除话题成功')
    else:
        return error(request, u'删除话题失败')


# 评论管理列表
def topic_comment_list(request):
    topic_id = request.GET['topic_id'] if request.method == 'GET' else request.POST['topic_id']
    if request.is_ajax():
        page = int(request.GET['page'])
        limit = int(request.GET['limit'])
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

        topic_titles = Topic.objects.filter(topic_id__in=topic_ids).values('topic_id', 'topic_title')
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
        # print(data)
        for items in data:
            user_id = items['user_id']
            topic_id = items['topic_id']
            reply_comment_id = items['reply_comment_id']
            # print(reply_comment_id)

            if reply_comment_id != 0:
                topic_comment_object = TopicComment.objects.filter(topic_comment_id=reply_comment_id).values('topic_comment_id', 'comment_content','user_id','user_type').get()

                if topic_comment_object['user_type'] == 2:
                    topic_comment_object['username'] = PUsers.objects.filter(user_id=topic_comment_object['user_id']).values('username').get()['username']

                elif topic_comment_object['user_type'] == 1:
                    topic_comment_object['username'] = AdminUser.objects.filter(id=topic_comment_object['user_id']).values('username').get()['username']


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

        return load_data(request, count['count'] - num, rdata)
    else:
        return render(request, 'admin/extend/topic_comment_list.html', {'topic_id': topic_id})


# 评论删除
def topic_comment_delete(request):
    topic_comment_id = int(request.GET['topic_comment_id']) if request.method == 'GET' else int(
        request.POST['topic_comment_id'])
    print(topic_comment_id)
    if request.is_ajax():
        if topic_comment_id <= 0:
            return error(request, u'参数ID有误')
        comment_object = TopicComment.objects.filter(topic_comment_id=topic_comment_id, is_delete=0).get()
        if comment_object is None:
            return error(request, u'评论不存在,评论ID有误')
        comment_object.is_delete = 1
        result = comment_object.save()
        if result is None:
            return success(request, u'删除成功')
        else:
            return error(request, u'删除失败')
    else:
        return render(request, 'admin/extend/topic_comment_list.html')



# 评论回复
def topic_comment_reply(request):
    param = request.POST
    check_form = TopicCommentForms(param)
    return_data = check_form.is_valid()
    if return_data == False:
        return error(request, check_form.errors)
    if request.is_ajax():
        result = TopicComment.objects.create(
            topic_id=param['topic_id'],
            user_id=1,
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
    else:
        return render(request, 'admin/extend/topic_comment_list.html')
