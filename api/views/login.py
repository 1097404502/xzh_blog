from django import forms
from django.contrib import auth
from app.models import UserInfo, Avatars
from django.views import View
from django.shortcuts import render
from django.http import JsonResponse
import random

#登录字段验证
class LoginForm(forms.Form):
    name=forms.CharField(error_messages={'required': '请输入用户名'})
    pwd=forms.CharField(error_messages={'required': '请输入密码'})
    code=forms.CharField(error_messages={'required': '请输入验证码'})

    # 重写init方法
    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)

    # 局部钩子
    def clean_code(self):
        code: str = self.cleaned_data.get('code')
        valid_code: str = self.request.session.get('valid_code')
        # print(code,valid_code)
        if code.upper() != valid_code.upper():
            self.add_error('code', '验证码输入错误')
        return self.cleaned_data

    # 全局钩子
    def clean(self):
        name = self.cleaned_data.get('name')
        pwd = self.cleaned_data.get('pwd')
        user = auth.authenticate(username=name, password=pwd)
        if not user:
            self.add_error('pwd','用户名或密码不正确')
            return self.cleaned_data

        # error_count = self.request.session.get('error_count', 0)
        # if error_count >= 3:
        #     self.add_error('name', '错误过多，请重新获取验证码')
        #     return None
        # if not user:
        #     # 为某一个字段添加一条错误信息
        #     self.add_error('pwd', '用户名或密码错误')
        #     error_count += 1
        #     self.request.session['error_count'] = error_count
        #     return self.cleaned_data

        # 把用户对象放到cleaned_data里面
        self.cleaned_data['user'] = user
        return self.cleaned_data

#注册字段验证
class RegisterForm(forms.Form):
    name=forms.CharField(error_messages={'required': '请输入用户名'})
    pwd=forms.CharField(error_messages={'required': '请输入密码'})
    re_pwd = forms.CharField(error_messages={'required': '请输入确认密码'})
    code=forms.CharField(error_messages={'required': '请输入验证码'})

    # 重写init方法
    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        super().__init__(*args, **kwargs)

    def clean(self):
        pwd=self.cleaned_data.get('pwd')
        re_pwd = self.cleaned_data.get('re_pwd')
        if pwd!=re_pwd:
            self.add_error('re_pwd','两次密码不一致')
        return self.cleaned_data

    def clean_name(self):
        name = self.cleaned_data.get('name')
        # print('验证用户名为'+name)
        userquery = UserInfo.objects.filter(username=name)
        if userquery:
            print('用户名出错')
            self.add_error('name', '用户名已注册')
        return self.cleaned_data

    # 局部钩子
    def clean_code(self):
        code: str = self.cleaned_data.get('code')
        valid_code: str = self.request.session.get('valid_code')
        # print(code,valid_code)
        if code.upper() != valid_code.upper():
            self.add_error('code', '验证码输入错误')
        return self.cleaned_data


#登录失败可复用代码
def clean_form(form):
    # 验证不通过
    err_dict: dict = form.errors
    # 拿到所有错误字段名字
    err_valid = list(err_dict.keys())[0]
    # 拿到第一个字段的第一个错误信息
    err_msg = err_dict[err_valid][0]
    # print(err_valid, err_msg)
    return err_valid, err_msg


#CBV
class LoginView(View):
    def get(self, request):
        return render(request, 'blog/login.html')

    def post(self,request):
        res = {
            'code': 425,
            'msg': "登录成功！",
            'self': None
        }
        data = request.data
        form = LoginForm(data, request=request)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        user = form.cleaned_data.get('user')
        # 登录操作
        auth.login(request, user)
        res['code'] = 0
        return JsonResponse(res)

class RegisterView(View):
    def get(self, request):
        return render(request, 'register.html')

    def post(self, request):
        res = {
            'code': 425,
            'msg': "注册成功！",
            'self': None
        }

        form = RegisterForm(request.data, request=request)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        # 注册成功的代码
        user = UserInfo.objects.create_user(username=request.data.get('name'),
                                            password=request.data.get('pwd'))

        # 随机选择头像
        avatar_list = [i.nid for i in Avatars.objects.all()]
        user.avatar_id = random.choice(avatar_list)
        user.save()

        # 注册之后直接登录
        auth.login(request, user)

        res['code'] = 0

        return JsonResponse(res)




