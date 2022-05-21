from django.views import View
from django.contrib import auth
from django.http import JsonResponse
from api.views.login import clean_form
from django.shortcuts import redirect
from django import forms
from app.models import Avatars, Feedback
import time


class EditPasswordForm(forms.Form):
    oldpwd = forms.CharField(min_length=6, error_messages={'required': '请输入之前的密码', 'min_length': '密码最低为6位'})
    newpwd = forms.CharField(min_length=6, error_messages={'required': '请输入新的密码', 'min_length': '密码最低为6位'})
    repwd = forms.CharField(min_length=6, error_messages={'required': '重复新密码', 'min_length': '密码最低为6位'})

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)

    def clean(self):
        newpwd = self.cleaned_data.get('newpwd')
        repwd = self.cleaned_data.get('repwd')
        if newpwd != repwd:
            self.add_error('repwd', '两次密码不一致')
        return self.cleaned_data

    def clean_oldpwd(self):
        oldpwd = self.cleaned_data.get('oldpwd')
        user = auth.authenticate(username=self.request.user.username, password=oldpwd)
        if not user:
            self.add_error('oldpwd', '原密码错误')
        return oldpwd

#后台修改密码
class EditPasswordView(View):
    def post(self, request):
        res = {
            'msg': '密码修改成功',
            'code': 412,
            'self': None,
        }
        data = request.data
        form = EditPasswordForm(data, request=request)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)
        user = request.user
        user.set_password(data['newpwd'])
        user.save()
        auth.logout(request)  # 退出登录
        res['code'] = 0
        return JsonResponse(res)

#后台修改头像
class EditAvatarView(View):
    def put(self, request):
        res = {
            'msg': '头像修改成功',
            'code': 414,
            'data': None,
        }
        avatar_id = request.data.get('avatar_id')
        # 要判断用户的登录状态
        user = request.user
        sign_status = request.user.sign_status
        avatar = Avatars.objects.get(nid=avatar_id)
        if sign_status == 0:
            # 用户名密码注册
            user.avatar_id = avatar_id
        else:
            avatar_url = avatar.url.url
            user.avatar_url = avatar_url
        user.save()
        res['data'] = avatar.url.url
        res['code'] = 0
        return JsonResponse(res)


class EditUserInfoForm(forms.Form):
    email = forms.EmailField(error_messages={'required': '请输入邮箱', 'invalid': '请输入正确的邮箱'})
    pwd = forms.CharField(error_messages={'required': '请输入密码'})
    code = forms.CharField(error_messages={'required': '请输入验证码'})

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)

    def clean_email(self):
        email = self.cleaned_data.get('email')
        # 判断是否和self里面的邮箱相同
        if email == self.request.session.get('valid_email_obj')['email']:
            return email
        else:
            self.add_error('email', '邮箱二次校验错误')

    def clean_pwd(self):
        pwd = self.cleaned_data.get('pwd')
        user = auth.authenticate(username=self.request.user.username, password=pwd)
        if user:
            return pwd
        else:
            self.add_error('pwd', '密码错误')

    def clean_code(self):
        code = self.cleaned_data['code']
        if code == self.request.session.get('valid_email_obj')['code']:
            return code
        else:
            self.add_error('code', '验证码错误')

#后台完善信息
class EditUserInfoView(View):
    def put(self, request):
        res = {
            'code': 412,
            'msg': '信息绑定成功',
            'self': None,
        }
        # 校验时间
        valid_email_obj = request.session.get('valid_email_obj')
        if not valid_email_obj:
            res['msg'] = '请先获取验证码'
            return JsonResponse(res)
        else:
            time_stamp = valid_email_obj['time_stamp']
            now_stamp = time.time()
            if now_stamp - time_stamp > 300:  # 5分钟
                res['msg'] = '验证码失效'
                return JsonResponse(res)

            form = EditUserInfoForm(request.data, request=request)
            if not form.is_valid():
                res['self'], res['msg'] = clean_form(form)
                return JsonResponse(res)
            # 绑定信息
            user = request.user
            user.email = form.cleaned_data['email']
            user.save()
            res['code'] = 0
            return JsonResponse(res)


#后台取消收藏
class CancelCollectionView(View):
    def post(self, request):
        nid_list = request.POST.getlist('nid')
        request.user.collects.remove(*nid_list)
        return redirect('/backend')


class FeedBackForm(forms.Form):
    email = forms.EmailField(error_messages={'required': '请输入邮箱', 'invalid': '请输入正确的邮箱'})
    content = forms.CharField(error_messages={'required': '请输入内容'})


class FeedBackView(View):
    def post(self, request):
        res = {
            'msg': '反馈成功，请耐心等待',
            'code': 0,
            'self': None,
        }
        form = FeedBackForm(request.data)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        Feedback.objects.create(**form.cleaned_data)
        return JsonResponse(res)
