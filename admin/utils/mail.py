# encoding=utf-8
from django.core.mail import send_mail
from django.core.mail import EmailMultiAlternatives
from django.conf import settings
import configparser


class mail:
    def __init__(self):
        cf = configparser.ConfigParser()
        cf.read(settings.SITE_INI_PATH + 'config.ini', 'utf-8')
        try:
            mail_config = cf.items('mail_config')
            mail_config = dict(mail_config)
            if mail_config.get('mail_smtpsecure') is None or mail_config.get('mail_smtp') is None or mail_config.get(
                    'mail_smtpport') is None or mail_config.get('mail_loginname') is None or mail_config.get(
                'mail_password') is None or mail_config.get('mail_sender') is None or mail_config.get(
                'mail_address') is None:
                raise Exception(u"邮箱配置信息不完整")
            if mail_config.get('mail_smtpsecure') == 'tls':
                settings.EMAIL_USE_TLS = True
            else:
                settings.EMAIL_USE_SSL = True

            settings.EMAIL_HOST = mail_config.get('mail_smtp')
            settings.EMAIL_PORT = mail_config.get('mail_smtpport')
            settings.EMAIL_HOST_USER = mail_config.get('mail_loginname')
            settings.EMAIL_HOST_PASSWORD = mail_config.get('mail_password')
            settings.DEFAULT_FROM_EMAIL = mail_config.get('mail_sender') + " <" + mail_config.get('mail_address') + ">"
            settings.EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"
        except:
            raise Exception(u'邮箱配置信息不存在')

    def send_text_mail(self, subject, message, to_mails):
        while True:
            if type(to_mails) == str:
                to_mails = [to_mails]
            elif type(to_mails) == list:
                to_mails = to_mails
            else:
                result = False
                msg = '邮箱地址格式不正确'
                break
            try:
                result = send_mail(subject, message, settings.EMAIL_HOST_USER,
                                   to_mails, fail_silently=False)
            except Exception as e:
                result = False
                msg = e
                break
            if result:
                result = True
                msg = '发送成功'
                break
            else:
                result = False
                msg = '发送失败'
                break
        self.__record(subject, message, to_mails, result, msg)
        return result

    def send_html_mail(self, subject, html, to_mails):
        while True:
            if type(to_mails) == str:
                to_mails = [to_mails]
            elif type(to_mails) == list:
                to_mails = to_mails
            else:
                result = False
                msg = '邮箱地址格式不正确'
                break

            from_email = settings.EMAIL_HOST_USER
            try:
                msg = EmailMultiAlternatives(subject, html, from_email, to_mails)
                msg.content_subtype = "html"
                # 添加附件（可选）
                # msg.attach_file('./twz.pdf')
                # 发送
                result = msg.send()
            except Exception as e:
                result = False
                msg = e
                break
            if result:
                result = True
                msg = '发送成功'
                break
            else:
                result = False
                msg = '发送失败'
                break

        self.__record(subject, html, to_mails, result, msg)
        return result

    def __record(self, subject, html, to_mails, result, msg):
        from common.models import PMailRecord
        status = 1 if result is True else 2
        PMailRecord.objects.create(email='|'.join(to_mails), subject=subject, content=html, status=status)
