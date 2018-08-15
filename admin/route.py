# encoding=utf-8
from django.conf import settings
from django.conf.urls import url
import json


def custom_url(regex, view, kwargs=None, name=None, alias_name=None):
    url_ob = url(regex, view, kwargs, name)
    url_ob.alias_name = alias_name
    return url_ob


def write_route_cache(urlpatterns):
    route_name_list = []
    for pattern in urlpatterns:
        route_name_list.append({'name': pattern.name, 'alias_name': pattern.alias_name})

    with open(settings.SITE_CACHE_PATH + 'route.json', 'w') as fp:
        fp.write(json.dumps(route_name_list))


def get_route_cache():
    with open(settings.SITE_CACHE_PATH + 'route.json', 'r') as fp:
        cache = fp.read()
    return json.loads(cache)
