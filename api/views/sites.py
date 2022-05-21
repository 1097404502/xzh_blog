import time
from django.views import View
from django.http import JsonResponse
from app.models import Site, Navs, NavTags
from django import forms
from api.views.login import clean_form
from datetime import date, datetime
from django.db.models import F


class NavTagsView(View):
    def post(self, request, **kwargs):
        res = {
            'msg': '标签添加成功',
            'code': 0,
            'self': None
        }
        if not request.user.is_superuser:
            res['msg'] = '用户验证失败`'
            res['code'] = -1
            return JsonResponse(res)
        title = request.data.get('title')
        if not title:
            res['msg'] = '请输入标签名'
            res['code'] = -1
            return JsonResponse(res)
        # 分辨出是添加标签还是编辑标签 添加标签没有nid 编辑标签存在nid
        nid = kwargs.get('nid')
        if not nid:
            # 添加标签
            # 忽略大小写
            tag_query = NavTags.objects.filter(title__iexact=title)
            if tag_query:
                res['msg'] = '标签已经存在'
                res['code'] = -1
            else:
                NavTags.objects.create(title=title)
            return JsonResponse(res)
        else:
            # 编辑标签
            tag = NavTags.objects.filter(nid=nid)
            tag.update(title=title)
            res['msg'] = '标签编辑成功'
            return JsonResponse(res)

    def delete(self, request, nid):
        res = {
            'msg': '标签删除成功',
            'code': 0,
            'self': None
        }
        if not request.user.is_superuser:
            res['msg'] = '用户验证失败`'
            res['code'] = -1
            return JsonResponse(res)
        tag_query = NavTags.objects.filter(nid=nid)
        if tag_query:
            tag_query.delete()
        else:
            res['msg'] = '预料之外的标签删除'
            res['code'] = -1
        return JsonResponse(res)


class NavForm(forms.Form):
    title = forms.CharField(min_length=4, error_messages={'required': '请输入网站标题', 'min_length': '网站标题小于4个字符'})
    abstract = forms.CharField(min_length=10, max_length=128,
                               error_messages={'required': '请输入网站简介', 'min_length': '网站简介小于10个字符',
                                               'max_length': '网站简介太长，最大为128个字符'})
    href = forms.URLField(error_messages={'required': '请输入网站链接'})
    icon_href = forms.URLField(error_messages={'required': '请输入网站图标'})
    status = forms.IntegerField(required=False)

    def __init__(self, *args, **kwargs):
        self.request = kwargs.pop('request', None)
        self.add_or_edit = kwargs.pop('add_or_edit', True)
        super().__init__(*args, **kwargs)

    def clean_title(self):
        title = self.cleaned_data.get('title')
        nav_query = Navs.objects.filter(title=title)
        if self.add_or_edit:
            # 添加网站 需要验证
            if nav_query:
                self.add_error('title', '该网站标题已存在')
        return title

    def clean_status(self):
        if self.request.user.is_superuser:
            # 超级管理员
            status = 1
        else:
            status = 0
        return status


class NavView(View):
    def get(self, request):
        data = []
        if request.user.is_authenticated:
            nav_coll_list = request.user.navs.all()
        else:
            nav_coll_list = []
        order = request.GET.get('order')
        title = request.GET.get('title')
        if title == '我的收藏' and request.user.is_authenticated:
            nav_list = request.user.navs.all().order_by(f"-{order}")
        else:
            nav_list = Navs.objects.filter(tag__title=title, status=1).order_by(f"-{order}")
        for nav in nav_list:
            data.append({
                'nid': nav.nid,
                'title': nav.title,
                'abstract': nav.abstract,
                'href': nav.href,
                'icon_href': nav.icon_href,
                'create_date': nav.create_date.strftime('%Y-%m-%d'),
                'collects_count': nav.collects_count,
                'digg_count': nav.digg_count,
                'tags': [{
                    'nid': tag.nid,
                    'title': tag.title
                } for tag in nav.tag.all()],
                'isColl': 'show' if nav in nav_coll_list else ' ',
            })
        return JsonResponse(data, safe=False)

    def post(self, request):
        res = {
            'msg': '网站添加成功',
            'code': 0,
            'self': None
        }
        data = request.data
        form = NavForm(data, request=request)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        # 添加
        nav_obj = Navs.objects.create(**form.cleaned_data)
        # 添加标签
        tag = data.get('tag')
        if tag:
            nav_obj.tag.add(*tag)
        if not request.user.is_superuser:
            res['msg'] = '感谢添加， 管理员正在审核'
        return JsonResponse(res)

    def put(self, request, nid):
        res = {
            'msg': '网站编辑成功',
            'code': 0,
            'self': None
        }
        if not request.user.is_superuser:
            # 超级管理员
            res['msg'] = '用户验证失败'
            res['code'] = -1
            return JsonResponse(res)
        data = request.data
        form = NavForm(data, request=request, add_or_edit=False)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        # 编辑
        nav_query = Navs.objects.filter(nid=nid)
        nav_query.update(**form.cleaned_data)
        tag = data.get('tag')
        obj: Navs = nav_query.first()
        # 先清空 在添加
        obj.tag.clear()
        if tag:
            obj.tag.add(*tag)
        return JsonResponse(res)

    def delete(self, request, nid):
        res = {
            'msg': '网站删除成功',
            'code': 0,
        }
        if not request.user.is_superuser:
            # 超级管理员
            res['msg'] = '用户验证失败'
            res['code'] = -1
            return JsonResponse(res)
        nav_query = Navs.objects.filter(nid=nid)
        nav_query.delete()
        return JsonResponse(res)


# 用于动态获取网站的tag
class NavTagView(View):
    def get(self, request):
        tag_all = NavTags.objects.all()
        # 拿到存在数据的网站tag
        tag_list = tag_all.exclude(navs__isnull=True)
        # 将所有的网站tag的nid和title提取出来
        data = []
        for tag in tag_list:
            data.append({
                'nid': tag.nid,
                'title': tag.title
            })
        return JsonResponse(data, safe=False)


class NavDiggView(View):
    def post(self, request, nid):
        res = {
            'msg': '点赞+1',
            'code': 0,
            'self': None
        }
        beforeTime = request.session.get(f'site_{nid}', 0)
        now = str(int(time.time()))
        if now - beforeTime < 5:
            res['msg'] = '点赞频率过快'
            res['code'] = -1
            return JsonResponse(res)
        request.session[f'site_{nid}'] = now
        Navs.objects.filter(nid=nid).update(digg_count=F('digg_count') + 1)
        return JsonResponse(res)


class NavCollectsView(View):
    def post(self, request, nid):
        '''
        一个用户只能收藏网站一次 同样的请求会取消收藏
        :param request:
        :param nid:
        :return:
        '''
        res = {
            'msg': '网站收藏成功',
            'code': 0,
            'data': 0,
            'isCollect': True,  # 判断是否收藏
        }
        if not request.user.username:
            res['msg'] = '请登录'
            res['code'] = -1
            return JsonResponse(res)
        # 判断用户是否收藏过网站
        flag = request.user.navs.filter(nid=nid)
        num = 1
        if flag:
            # 用户已经收藏了网站, 取消收藏
            res['msg'] = '网站取消收藏成功'
            res['isCollect'] = False
            request.user.navs.remove(nid)
            num = -1
        else:
            request.user.navs.add(nid)
        nav_query = Navs.objects.filter(nid=nid)
        nav_query.update(collects_count=F('collects_count') + num)
        res['data'] = num
        return JsonResponse(res)
