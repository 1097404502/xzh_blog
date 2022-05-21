import time

from django.views import View
from django.http import JsonResponse
from django import forms
from api.views.login import clean_form
from django.core.mail import send_mail
from django.core.handlers.wsgi import WSGIRequest
from blog_test import settings
import random
from threading import Thread
from app.models import UserInfo


class EmailForm(forms.Form):
    email = forms.EmailField(error_messages={'required': '请输入邮箱', 'invalid': '请输入正确的邮箱'})

    def clean_email(self):
        email = self.cleaned_data['email']
        user = UserInfo.objects.filter(email=email)
        if user:
            self.add_error('email', '该邮箱已注册')
        return email


class ApiEmailView(View):
    def post(self, request: WSGIRequest):
        res = {
            'code': 413,
            'msg': '验证码获取成功',
            'self': None,
        }
        form = EmailForm(request.data)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        # 去session里面读取
        valid_email_obj = request.session.get('valid_email_obj')
        if valid_email_obj:
            time_stamp = valid_email_obj['time_stamp']
            # 判断现在的时间戳
            now_stamp = time.time()
            if now_stamp - time_stamp < 60:
                res['msg'] = '请求过于频繁'
                return JsonResponse(res)
        # 生成验证码
        valid_email_code = ''.join(random.sample('0123456789', 6))
        request.session['valid_email_obj'] = {
            'code': valid_email_code,
            'time_stamp': time.time(),
            'email': form.cleaned_data['email'],
        }
        # 发送邮箱 设置超时时间
        Thread(target=send_mail, args=('【卓恒小窝】完善信息',
                                       f'【卓恒小窝】您正在绑定邮箱，使用的验证码是{valid_email_code},验证码有效期为5分钟',
                                       settings.EMAIL_HOST_USER,
                                       [form.cleaned_data.get('email')],
                                       False)).start()
        res['code'] = 0
        return JsonResponse(res)
