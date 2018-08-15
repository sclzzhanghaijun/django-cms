# encoding=utf-8
from django.shortcuts import render
from admin.system.forms.SetConfigForms import SetConfigForms
from django.conf import settings
import configparser
from admin.utils.response import *


def set_config(request):
    if request.is_ajax():
        check_form = SetConfigForms(request.POST)
        if check_form.is_valid():
            cf = configparser.ConfigParser()
            # 网站基本信息配置
            cf.add_section('site_config')
            cf.set('site_config', 'site_title', request.POST['site_title'])
            cf.set('site_config', 'site_description', request.POST['site_description'])
            cf.set('site_config', 'site_status', request.POST['site_status'])

            # 邮箱配置
            cf.add_section('mail_config')
            cf.set('mail_config', 'mail_sender', request.POST['mail_sender'])
            cf.set('mail_config', 'mail_address', request.POST['mail_address'])
            cf.set('mail_config', 'mail_smtp', request.POST['mail_smtp'])
            cf.set('mail_config', 'mail_smtpsecure', request.POST['mail_smtpsecure'])
            cf.set('mail_config', 'mail_smtpport', request.POST['mail_smtpport'])
            cf.set('mail_config', 'mail_loginname', request.POST['mail_loginname'])
            cf.set('mail_config', 'mail_password', request.POST['mail_password'])

            with open(settings.SITE_INI_PATH + 'config.ini', 'w', encoding='utf-8') as fw:
                cf.write(fw)
            return success(request, u'保存成功')
        else:
            return error(request, check_form.errors)
    else:
        cf = configparser.ConfigParser()
        cf.read(settings.SITE_INI_PATH + 'config.ini', 'utf-8')
        site_config = []
        sections = cf.sections()
        if 'site_config' in sections:
            site_config += cf.items('site_config')

        if 'mail_config' in sections:
            site_config += cf.items('mail_config')
        # from admin.utils.mail import mail
        # m = mail()
        # result = m.send_html_mail(u'用户注册邮件', u'<div><a href="http://www.baidu.com">点击这里</a>点击这里完成注册激活</div>',
        #                           '429353924@qq.com')
        # print(result)
        return render(request, 'admin/system/set_config.html', {'site_config': dict(site_config)})
