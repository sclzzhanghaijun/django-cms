# encoding=utf-8
from admin.route import custom_url
from admin.article.views import article
from admin.article.views import article_classify
from admin.article.views import article_comment

urlpatterns = [
    custom_url('^article_list$', article.article_lists, name='article_list', alias_name=u'文章管理'),
    custom_url('^article_add$', article.article_add, name='article_add', alias_name=u'添加文章'),
    custom_url('^article_edit$', article.article_edit, name='article_edit', alias_name=u'编辑文章'),
    custom_url('^article_delete$', article.article_delete, name='article_delete', alias_name=u'删除文章'),
    custom_url('^article_lists_data$', article.article_lists_data, name='article_lists_data', alias_name=u'文章列表'),

    custom_url('^article_category$', article_classify.article_category, name='article_category', alias_name=u'文章分类'),
    custom_url('^add_category$', article_classify.add_category, name='add_category', alias_name=u'添加分类'),
    custom_url('^category_delete$', article_classify.category_delete, name='category_delete', alias_name=u'删除分类'),

    custom_url('^article_comment_list$', article_comment.article_comment_list, name='article_comment_list',
               alias_name=u'评论列表'),
    custom_url('^article_comment_list_data$', article_comment.article_comment_list_data,
               name='article_comment_list_data', alias_name=u'评论列表数据'),
    custom_url('^article_comment_delete$', article_comment.article_comment_delete, name='article_comment_delete',
               alias_name=u'删除评论'),
    custom_url('^add_comment$', article_comment.add_comment, name='add_comment',
               alias_name=u'回复评论'),
]
