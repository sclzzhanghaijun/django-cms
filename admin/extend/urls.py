# encoding=utf-8
from admin.route import custom_url
from admin.extend.views import slide
from admin.extend.views import friend_link
from admin.extend.views import topic

urlpatterns = [
    custom_url('^slide_category_list$', slide.category_list, name='slide_category_list', alias_name=u'轮播分类列表'),
    custom_url('^slide_add_category$', slide.add_category, name='slide_add_category', alias_name=u'添加轮播分类'),
    custom_url('^slide_delete_category$', slide.delete_category, name='slide_delete_category', alias_name=u'删除轮播分类'),
    custom_url('^slide_edit_category$', slide.edit_category, name='slide_edit_category', alias_name=u'编辑轮播分类'),

    custom_url('^slide_manage_list$', slide.slide_list, name='slide_manage_list', alias_name=u'轮播管理列表'),
    custom_url('^slide_manage_add$', slide.slide_manage_add, name='slide_manage_add', alias_name=u'轮播管理添加'),
    custom_url('^slide_manage_delete$', slide.slide_manage_delete, name='slide_manage_delete', alias_name=u'轮播管理删除'),
    custom_url('^slide_manage_edit$', slide.slide_manage_edit, name='slide_manage_edit', alias_name=u'轮播管理删除'),
    custom_url('^slide_manage_status$', slide.slide_manage_status, name='slide_manage_status', alias_name=u'轮播管理状态'),

    custom_url('^friend_link_list$', friend_link.friend_link_list, name='friend_link_list', alias_name=u'友情链接列表'),
    custom_url('^friend_link_add$', friend_link.friend_link_add, name='friend_link_add', alias_name=u'友情链接添加'),
    custom_url('^friend_link_delete$', friend_link.friend_link_delete, name='friend_link_delete', alias_name=u'友情链接删除'),
    custom_url('^friend_link_edit$', friend_link.friend_link_edit, name='friend_link_edit', alias_name=u'友情链接编辑'),
    custom_url('^friend_link_status$', friend_link.friend_link_status, name='friend_link_status', alias_name=u'友情链接状态'),


    custom_url('^topic_manage_list$', topic.topic_list, name='topic_manage_list', alias_name=u'话题列表'),
    custom_url('^topic_manage_add$', topic.topic_add, name='topic_manage_add', alias_name=u'话题添加'),
    custom_url('^topic_manage_delete$', topic.topic_delete, name='topic_manage_delete', alias_name=u'话题删除'),
    custom_url('^topic_manage_edit$', topic.topic_edit, name='topic_manage_edit', alias_name=u'话题编辑'),


    custom_url('^topic_comment_list$', topic.topic_comment_list, name='topic_comment_list', alias_name=u'评论列表'),
    custom_url('^topic_comment_delete$', topic.topic_comment_delete, name='topic_comment_delete', alias_name=u'评论删除'),
    custom_url('^topic_comment_reply$', topic.topic_comment_reply, name='topic_comment_reply', alias_name=u'评论回复'),

]
