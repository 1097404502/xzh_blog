from django.db.models import F,Q
from django.shortcuts import render,HttpResponse,redirect
from django.http import JsonResponse
from django import forms
from django.contrib import auth
from django.views import View

from api.utils.permissions_control import is_super_fun
from app.models import *
from django.core.exceptions import NON_FIELD_ERRORS,ValidationError
from app.utils.verification import random_verify_code
from app.utils.sub_comment import sub_comment_list
from app.utils.pagination import Pagination


# Create your views here.
def index(request):
    article_list = Articles.objects.filter(status=1).order_by('-change_date')
    qianduan_list = article_list.filter(category=1)[:6]
    houduan_list = article_list.filter(category=2)[:6]

    query_params = request.GET.copy()

    pager = Pagination(
        current_page=request.GET.get('page'),
        all_count=article_list.count(),
        base_url=request.path_info,
        query_params=query_params,
        per_page=7,
        pager_page_count=7,
    )
    article_list = article_list[pager.start:pager.end]
    advert_list = Advert.objects.filter(is_show=True)
    cover_list = Cover.objects.all()
    #网站在线人数
    online_count= len(request.online_list)
    advert_list = Advert.objects.filter(is_show=True)

    # 获取所有的tag
    tags = Tags.objects.exclude(articles__isnull=True)

    return render(request,'index.html', locals())


def search(request):
    search_key = request.GET.get('key', '')
    order = request.GET.get('order', '-create_date')
    word = request.GET.getlist('word')
    # print(word)
    tag = request.GET.get('tag', '')
    article_list = Articles.objects.filter(title__contains=search_key)
    # article_list = Articles.objects.filter(Q(title__contains=search_key) | Q(tag__title__contains=tag))
    query_params = request.GET.copy()
    #字数搜索
    if len(word) == 2:
        article_list = article_list.filter(word__range=word)
    #标签搜索
    if tag:
        article_list = article_list.filter(tag__title=tag)

    if order:
        try:
            article_list = article_list.order_by(order)
        except Exception:
            order = '-change_date'
    else:
        order = '-change_date'
    page = Pagination(
        current_page=request.GET.get('page'),
        all_count=article_list.count(),
        base_url=request.path_info,
        query_params=query_params,
        per_page=15,
        pager_page_count=7
    )
    article_list = article_list[page.start:page.end]
    return render(request,'search.html',locals())

def article(request,nid):
    article_query=Articles.objects.filter(nid=nid)

    #文章浏览量+1
    article_query.update(look_count=F('look_count')+1)

    if not article_query:
        return redirect('/')
    article = article_query.first()

    comment_list = sub_comment_list(nid)

    return render(request,'article.html',locals())


def news(request):
    return render(request,'news.html')


def moods(request):
    # 查询所有的头像
    avatar_list = Avatars.objects.all()
    # 搜索
    key = request.GET.get('key', '')
    mood_list = Moods.objects.filter(content__contains=key).order_by('-create_date')
    query_params = request.GET.copy()
    page = Pagination(
        current_page=int(request.GET.get('page', '1')),
        all_count=mood_list.count(),
        base_url=request.path_info,
        query_params=query_params,
        per_page=5,
        pager_page_count=7
    )
    mood_list = mood_list[page.start:page.end]
    return render(request,'moods.html',locals())


# 回忆录
def history(request):
    history_list = History.objects.all().order_by('-create_date')
    return render(request, 'history.html', locals())


# 网站页面
# def site(request):
#     # 取所有的标签
#     tag_all = NavTags.objects.all()
#     tag_list = tag_all.exclude(navs__isnull=True)
#     return render(request, 'blog01/site.html', locals())


# 网站关于页面
def about(request):
    return render(request, 'blog01/about.html', locals())

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
        print(user)
        if not user:
            self.add_error('pwd','用户名或密码不正确')
            return self.cleaned_data

        error_count = self.request.session.get('error_count', 0)
        if error_count >= 3:
            self.add_error('name', '错误过多，请重新获取验证码')
            return None
        if not user:
            # 为某一个字段添加一条错误信息
            self.add_error('pwd', '用户名或密码错误')
            error_count += 1
            self.request.session['error_count'] = error_count
            return self.cleaned_data

        # 把用户对象放到cleaned_data里面
        self.cleaned_data['user'] = user
        return self.cleaned_data

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


def login(request):
    if request.method=="POST":
        res={
            'code':425,
            'msg':"登录成功！",
            'self':None
        }
        data=request.data
        form=LoginForm(data,request=request)
        if not form.is_valid():
            res['self'],res['msg']=clean_form(form)
            return JsonResponse(res)

        user=form.cleaned_data.get('user')
        #登录操作
        auth.login(request,user)
        res['code']=0
        return JsonResponse(res)
    return render(request,"login.html")

def register(request):
    if request.method=="POST":
        res={
            'code':425,
            'msg':"注册成功！",
            'self':None
        }

        form=RegisterForm(request.data,request=request)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        #注册成功的代码
        user = UserInfo.objects.create_user(username=request.data.get('name'),
                                     password=request.data.get('pwd'))
        #注册之后直接登录
        auth.login(request,user)

        res['code']=0

        return JsonResponse(res)
    return render(request,'register.html')

def logout(request):
    auth.logout(request)
    return redirect('/')

def verify_code(request):
    data,valid_code= random_verify_code()
    request.session['valid_code']=valid_code
    return HttpResponse(data)


def backend(request):
    if not request.user.username:
        # 没有登录
        return redirect('/')
    user = request.user
    collect_query = user.collects.all()
    return render(request, 'backend/backend.html',locals())

def add_article(request):
    #拿到所有分类，标签
    tag_list=Tags.objects.all()
    #拿到所以文章封面
    cover_list=Cover.objects.all()
    #拿到分类
    category_list = Articles.category_choice

    c_l = []
    for cover in cover_list:
        c_l.append({
            "url":cover.url.url,
            "nid":cover.nid
        })

    return render(request,'backend/add_article.html',locals())

def change_avatar(request):
    avatar_url = request.user.avatar.url.url
    avatar_list = Avatars.objects.all()
    for i in avatar_list:
        if i.url.url == avatar_url:
            avatar_id = i.nid
    return render(request,'backend/change_avatar.html',locals())

# 头像列表
@is_super_fun
def avatar_list(request):
    avatar_all = Avatars.objects.all()
    return render(request, 'backend/avatar_list.html', locals())


# 文章封面
@is_super_fun
def cover_list(request):
    cover_query = Cover.objects.all()
    return render(request, 'backend/cover_list.html', locals())

def change_password(request):
    return render(request,'backend/change_password.html',locals())

def edit_article(request,nid):
    article_obj = Articles.objects.get(nid=nid)
    # 拿到分类
    category_list = Articles.category_choice
    tags = [str(tag.nid) for tag in article_obj.tag.all()]

    #拿到所有分类，标签
    tag_list=Tags.objects.all()

    #拿到所以文章封面
    cover_list=Cover.objects.all()
    return render(request,'backend/edit_article.html',locals())

def admin_home(request):
    return render(request,'admin_home.html')