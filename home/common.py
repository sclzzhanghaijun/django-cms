from admin.utils.response import *


def login_required(func):
    def weaper(request):
        user_id = request.session.get('user_id', '')
        if user_id == '':
            return error(request, u'还未登录', reverse('home.index'))
        else:
            return func(request, **dict(request.session))

    return weaper


'''
视图函数初始化装饰器
'''


def view_init(*bargs, **bkwargs):
    print(bargs)
    print(bkwargs)

    def wrapper(func):
        def _wrapper(request):
            args = ()
            kwargs = {}
            return func(request, *args, **kwargs)

        return _wrapper

    return wrapper
