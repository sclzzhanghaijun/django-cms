from django.conf.urls import url
from home.view import home
from home.view import member
from home.view import article
from home.view import topic
from home.view import download

urlpatterns = [
    url('^index.html$', home.home_index, name='home.index'),
    url('^article_list$', home.article_list, name='home.article_list'),
    url('^article$', home.article, name='home.article'),
    url('^member$', member.index, name='home.member'),
    url('^contribute$', member.contribute, name='home.contribute'),
    url('^register_mail$', home.register_mail, name='home.register_mail'),
    url('^register$', home.register, name='home.register'),
    url('^user_login$', member.user_login, name='home.user_login'),
    url('^logout$', member.logout, name='home.logout'),
    url('^topic_list$', topic.topic_list, name='home.topic_list'),
    url('^topic_add$', topic.topic_add, name='home.topic_add'),
    url('^topic_detail$', topic.topic_detail, name='home.topic_detail'),
    url('^topic_comment_list$', topic.topic_comment_list, name='home.topic_comment_list'),
    url('^topic_comment_publish$', topic.topic_comment_publish, name='home.topic_comment_publish'),

    url('^user_article_list$', member.user_article_list, name='home.user_article_list'),
    url('^user_comment_list$', member.user_comment_list, name='home.user_comment_list'),
    url('^login_status_and_load_menu$', home.login_status_and_load_menu, name='home.login_status_and_load_menu'),
    url('^reset_password$', home.reset_password, name='home.reset_password'),
    url('^hotarticle$', article.hotarticle, name='home.hotarticle'),
    url('^edit_user_info$', member.edit_user_info, name='home.edit_user_info'),
    url('^download$', download.index, name='home.download_index'),
    url('^download_package$', download.download, name='home.download'),
    url('^add_article_comment$', article.add_article_comment, name='home.add_article_comment'),
    url('^article_comment$', article.article_comment, name='home.article_comment'),
]
