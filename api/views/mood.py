from django.views import View
from django.http import HttpResponse, JsonResponse
from api.views.login import clean_form
from django.db.models import F
from django import forms
from app.models import Avatars, Moods, MoodComment
from api.utils.get_location_info import get_ip, get_addr_ip


class AddMoodForm(forms.Form):
    name = forms.CharField(error_messages={'required': '请输入用户名'})
    content = forms.CharField(error_messages={'required': '请输入心情内容'})
    avatar_id = forms.IntegerField(required=False)  # 不进行为空校验
    drawing = forms.CharField(required=False)

    def clean_avatar_id(self):
        avatar_id = self.cleaned_data.get('avatar_id')
        if not avatar_id:
            avatar_id = 1
        return avatar_id


class MoodView(View):
    def post(self, request):
        res = {
            'msg': '心情发布成功',
            'code': 412,
            'self': None,
        }
        data = request.data
        form = AddMoodForm(data)
        if not form.is_valid():
            # 验证通过
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        ip = get_ip(request)
        addr = get_addr_ip(ip)
        form.cleaned_data['ip'] = ip
        form.cleaned_data['addr'] = addr

        Moods.objects.create(**form.cleaned_data)
        res['code'] = 0
        return JsonResponse(res)

    def delete(self, request, nid):
        res = {
            'msg': '心情删除成功',
            'code': 412
        }
        if not request.user.is_superuser:
            res['msg'] = '用户验证失败'
            return JsonResponse(res)
        mood_query = Moods.objects.filter(nid=nid)
        if not mood_query:
            res['msg'] = '该心情不存在'
            return JsonResponse(res)
        mood_query.delete()
        res['code'] = 0
        return JsonResponse(res)

    # 点赞
    def put(self, request, nid):
        res = {
            'msg': '心情点赞成功',
            'code': 412,

        }
        mood_query = Moods.objects.filter(nid=nid)
        mood_query.update(digg_count=F('digg_count')+1)
        res['data'] = mood_query.first().digg_count
        res['code'] = 0
        return JsonResponse(res)


class MoodCommentView(View):
    def post(self, request, nid):
        res = {
            'msg': '评论发布成功',
            'code': 412,
            'self': None,
        }
        data = request.data
        form = AddMoodForm(data)
        if not form.is_valid():
            # 验证通过
            res['self'], res['msg'] = clean_form(form)
            return JsonResponse(res)

        ip = get_ip(request)
        addr = get_addr_ip(ip)

        form.cleaned_data['ip'] = ip
        form.cleaned_data['addr'] = addr
        form.cleaned_data['mood_id'] = nid
        # 移除掉cleaned_data中的数据
        form.cleaned_data.pop('drawing')
        MoodComment.objects.create(**form.cleaned_data)
        Moods.objects.filter(nid=nid).update(comment_count=F('comment_count') + 1)
        res['code'] = 0
        return JsonResponse(res)

    def delete(self, request, nid):
        res = {
            'msg': '评论删除成功',
            'code': 412,
            'data':None,
        }
        if not request.user.is_superuser:
            res['msg'] = '用户验证失败'
            return JsonResponse(res)
        mood_id = request.data.get('mood_id')
        MoodComment.objects.filter(nid=nid).delete()
        mood_query = Moods.objects.filter(nid=mood_id)
        mood_query.update(comment_count=F('comment_count')-1)
        res['data'] = mood_query.first().comment_count
        res['code'] = 0
        return JsonResponse(res)

    # 点赞
    def put(self, request, nid):
        res = {
            'msg': '心情点赞成功',
            'code': 412,

        }
        comment_query = MoodComment.objects.filter(nid=nid)
        comment_query.update(digg_count=F('digg_count')+1)
        res['data'] = comment_query.first().digg_count
        res['code'] = 0
        return JsonResponse(res)
