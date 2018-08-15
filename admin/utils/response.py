# encoding=utf-8
from django.shortcuts import reverse, render
from django.http import JsonResponse, HttpResponseRedirect
from urllib.parse import urlencode
from django.forms.utils import ErrorDict


def _msg_type(msg):
    if type(msg) == ErrorDict:
        for i in msg:
            for j in msg[i]:
                return j
    else:
        return msg


def load_data(request, count, data):
    result = {
        'code': 0,
        'count': count,
        'data': data
    }
    if request.is_ajax():
        return JsonResponse(result)
    else:
        return result


def success(request, msg='', url=None, data='', wait=3, header=None):
    code = 1
    msg = _msg_type(msg)
    if msg.isdigit():
        code = msg
        msg = ''

    if url is None and request.META['HTTP_REFERER']:
        url = request.META['HTTP_REFERER']
    else:
        url = url

    result = {'code': code, 'msg': msg, 'data': data, 'url': url, 'wait': wait}
    if request.is_ajax():
        return JsonResponse(result)
    else:
        # return HttpResponseRedirect(reverse('redirect') + "?" + urlencode(result))
        return render(request, 'admin/redirect.html', {'param': result})


def error(request, msg='', url=None, data='', wait=3, header=None):
    code = 0
    msg = _msg_type(msg)
    if msg.isdigit():
        code = msg
        msg = ''

    if url is None and request.META['HTTP_REFERER']:
        url = request.META['HTTP_REFERER']
    else:
        url = url

    result = {'code': code, 'msg': msg, 'data': data, 'url': url, 'wait': wait}
    if request.is_ajax():
        return JsonResponse(result)
    else:
        # return HttpResponseRedirect(reverse('redirect') + "?" + urlencode(result))
        return render(request, 'admin/redirect.html', {'param': result})
