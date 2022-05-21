import random

from django.shortcuts import redirect
from django.views import View
from django.http import HttpResponse, JsonResponse
from django import forms
from api.views.login import clean_form
from markdown import markdown
from pyquery import PyQuery
from app.models import Tags, Articles, Cover
from django.db.models import F
from api.utils.permissions_control import is_super_method


class AddArticleForm(forms.Form):
    title = forms.CharField(error_messages={'required': '请输入文章标题'})
    content = forms.CharField(error_messages={'required': '请输入文章内容'})
    abstract = forms.CharField(required=False)  # 不进行为空验证
    cover_id = forms.IntegerField(required=False)

    category = forms.IntegerField(required=False)
    pwd = forms.CharField(required=False)
    recommend = forms.BooleanField(required=False)
    status = forms.IntegerField(required=False)
    # word = forms.IntegerField(required=False)

    def clean(self):
        category = self.cleaned_data['category']
        if not category:
            self.cleaned_data.pop('category')

        pwd = self.cleaned_data['pwd']
        if not pwd:
            self.cleaned_data.pop('pwd')

    # 文章简介
    def clean_abstract(self):
        abstract = self.cleaned_data['abstract']
        if abstract:
            return abstract
        # 截取正文的前30个字符
        else:
            content = self.cleaned_data.get('content')
            if content:
                abstract = PyQuery(markdown(content)).text()[:90]
                return abstract

    #文章封面
    def clean_cover_id(self):
        cover_id = self.cleaned_data['cover_id']
        if cover_id:
            return cover_id
        else:
            # 随机选择一个封面图片
            cover_set = Cover.objects.all().values('nid')
            cover_id = random.choice(cover_set)['nid']
            return cover_id

    # def clean_word(self):
    #     return len(self.cleaned_data['content'])


# 给文章添加标签
def add_article_tags(tags, articleObj):
    '''
    对于数字标签要考虑是否是存在的标签
    如果不是数字标签 则将其的标签在数据库中创建一条
    :param tags:
    :param articleObj:
    :return:
    '''
    for tag in tags:
        if tag.isdigit():
            tag_query = Tags.objects.filter(nid=tag)
            # 对于标签是否存在检测
            if tag_query:
                articleObj.tag.add(tag)
        else:
            tag_obj = Tags.objects.create(title=tag)
            articleObj.tag.add(tag_obj.nid)






class ArticleView(View):
    # 添加文章
    @is_super_method
    def post(self, request):
        res = {
            'msg': '文章发布成功',
            'code': 412,
            "data": None,
        }
        data = request.data
        # print(data)
        data['status'] = 1
        form = AddArticleForm(data)
        if not form.is_valid():
            # 验证不通过
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        # 校验通过
        form.cleaned_data['author'] = 'xuzhuoheng'
        form.cleaned_data['source'] = '卓恒个人博客'
        articleObj = Articles.objects.create(**form.cleaned_data)
        tags = data.get('tags')
        # 添加标签
        add_article_tags(tags, articleObj)
        res['code'] = 0
        res['data'] = articleObj.nid
        return JsonResponse(res)

    # 编辑文章
    @is_super_method
    def put(self, request, nid):
        res = {
            'msg': '文章编辑成功',
            'code': 0,
            "data": None,
        }
        article_query = Articles.objects.filter(nid=nid)
        if not article_query:
            res['msg'] = '请求错误'
            return JsonResponse(res)
        data = request.data
        data['status'] = 1
        form = AddArticleForm(data)
        if not form.is_valid():
            # 验证通过
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        # 校验通过
        form.cleaned_data['author'] = 'xuzhuoheng'
        form.cleaned_data['source'] = 'zhuoheng个人博客'
        article_query.update(**form.cleaned_data)
        tags = data.get('tags')
        # 标签修改
        # 清空这篇文章所有的标签
        article_query.first().tag.clear()
        # 添加标签
        add_article_tags(tags, article_query.first())
        res['data'] = article_query.first().nid
        return JsonResponse(res)


# 文章点赞
class ArticleDiggView(View):
    def post(self, request, nid):
        res = {
            'msg': '文章点赞成功',
            'code': 412,
            'data': 0,
        }
        if not request.user.username:
            res['msg'] = '请登录'
            return JsonResponse(res)

        comment_query = Articles.objects.filter(nid=nid)
        comment_query.update(digg_count=F('digg_count') + 1)
        res['data'] = comment_query.first().digg_count
        res['code'] = 0
        return JsonResponse(res)

# 文章收藏
class ArticleCollectsView(View):
    def post(self, request, nid):
        '''
        一个用户只能收藏文章一次 同样的请求会取消收藏
        :param request:
        :param nid:
        :return:
        '''
        res = {
            'msg': '文章收藏成功',
            'code': 412,
            'data': 0,
            'isCollect': True,  # 判断是否收藏
        }
        if not request.user.username:
            res['msg'] = '请登录'
            return JsonResponse(res)
        # 判断用户是否收藏过文章
        flag = request.user.collects.filter(nid=nid)
        num = 1
        if flag:
            # 用户已经收藏了文章, 取消收藏
            res['msg'] = '文章取消收藏成功'
            res['isCollect'] = False
            request.user.collects.remove(nid)
            num = -1
            res['code'] = 0
        else:
            request.user.collects.add(nid)
        collect_query = Articles.objects.filter(nid=nid)
        collect_query.update(collects_count=F('collects_count') + num)
        res['data'] = collect_query.first().collects_count
        res['code'] = 0
        return JsonResponse(res)


# 查看加密文章
class ArticlePwdView(View):
    def post(self, request, nid):
        res = {
            'msg': '文章密码输入正确',
            'code': 0,
        }
        # 找到文章
        article_query = Articles.objects.filter(nid=nid)
        if not article_query:
            res['msg'] = '请求错误'
            res['code'] = -1
            return JsonResponse(res)
        article_obj = article_query.first()
        pwd = request.data.get('pwd')
        if article_obj.pwd != pwd:
            res['msg'] = '文章密码输入错误'
            res['code'] = -1
        request.session[f'article_pwd__{nid}'] = pwd
        return JsonResponse(res)


# 修改文章封面
class EditArticleCoverView(View):
    @is_super_method
    def post(self, request, nid):
        if not request.user.is_superuser:
            return JsonResponse({})
        cid = request.data.get('nid')  # 图片id
        Articles.objects.filter(nid=nid).update(cover_id=cid)
        return JsonResponse({})