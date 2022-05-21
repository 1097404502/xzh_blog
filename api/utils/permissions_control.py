from django.shortcuts import redirect
from django.http import JsonResponse


# 视图函数权限验证
def is_super_fun(fun):
    def inner(*args, **kwargs):
        request = args[0]
        if not request.user.is_superuser:
            return redirect('/')
        res = fun(*args, **kwargs)
        return res
    return inner


# api权限验证
def is_super_method(fun):
    def inner(*args, **kwargs):
        request = args[1]
        if not request.user.is_superuser:
            res = {
                'code': -1,
                'msg': '权限验证失败',
            }
            return redirect('/')
        res = fun(*args, **kwargs)
        return res
    return inner
