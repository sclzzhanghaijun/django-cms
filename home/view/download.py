# encoding=utf-8

from django.http import FileResponse
from django.conf import settings
import os
import json
from admin.utils.response import *
from home.common import login_required
from common.models import PDownload as p_download_model
from django.db.models import Count


def __version_list():
    download_dir = os.path.join(os.path.dirname(settings.BASE_DIR), "package/")
    version_path = os.path.join(download_dir, 'version.json')
    with open(version_path, 'r', encoding='utf-8') as file:
        version_list = file.read()

    if version_list:
        version_list = json.loads(version_list)

    return download_dir, version_list


@login_required
def index(request, **kwargs):
    _, version_list = __version_list()

    version_download_count = p_download_model.objects.values('version').annotate(Count('id'))
    version_download_count_list = {}
    for row in version_download_count:
        version_download_count_list[row.get('version')] = row.get('id__count')
    for row in version_list:
        row['download_count'] = version_download_count_list.get(row.get('version')) if version_download_count_list.get(
            row.get('version')) else 0

    return render(request, 'home/download.html', {'version_list': version_list[::-1]})


@login_required
def download(request, **kwargs):
    version = request.GET['version']
    if version == '':
        return error(request, u'请从下载界面进行下载')
    download_dir, version_list = __version_list()
    version_info = None
    for row in version_list:
        if row.get('version') == version:
            version_info = row

    if version_info is None:
        return error(request, u'版本不存在')

    package_name = version_info.get('package_name')
    package_path = os.path.join(download_dir, package_name)
    if os.path.exists(package_path) is False:
        return error(request, u'版本信息有误')

    p_download_model.objects.create(user_id=kwargs['user_id'], version=version)

    file = open(package_path, 'rb')
    response = FileResponse(file)
    response['Content-Type'] = 'application/octet-stream'
    response['Content-Disposition'] = 'attachment;filename="' + package_name + '"'
    return response
