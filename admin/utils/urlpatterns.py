# encoding=utf-8
from functools import update_wrapper


def decorate_urlpatterns(urlpatterns, decorator):
    for pattern in urlpatterns:
        if hasattr(pattern, 'url_patterns'):
            decorate_urlpatterns(pattern.url_patterns, decorator)

        if getattr(pattern, 'callback', None):
            pattern.callback = update_wrapper(decorator(pattern.callback), pattern.callback)

    return urlpatterns
