from django.views import View
from django.http import JsonResponse
from app.models import Avatars, Cover, UserInfo, History
from django import forms
from api.views.login import clean_form
from datetime import date, datetime


class HistoryForm(forms.Form):
    title = forms.CharField(error_messages={'required': '请输入事件标题'})
    content = forms.CharField(error_messages={'required': '请输入事件内容'})
    create_date = forms.CharField()
    drawing = forms.CharField(required=False)

    def clean_create_date(self):
        create_date = self.cleaned_data['create_date']
        if not create_date:
            create_date = date.today()
        else:
            create_date = datetime.strptime(create_date.split('T')[0], '%Y-%m-%d').date()
        return create_date


class HistoryView(View):
    def post(self, request, **kwargs):
        res = {
            'msg': '记录发布成功',
            'code': 0,
            'self': None
        }
        data = request.data
        form = HistoryForm(data)
        if not form.is_valid():
            res['self'], res['msg'] = clean_form(form)
            res['code'] = -1
            return JsonResponse(res)
        nid = kwargs.get('nid')
        if nid:
            # 编辑操作
            history_query = History.objects.filter(nid=nid)
            history_query.update(**form.cleaned_data)
            res['msg'] = '记录编辑成功'
        else:
            History.objects.create(**form.cleaned_data)
        return JsonResponse(res)

    def delete(self, request, nid):
        res = {
            'msg': '记录删除成功',
            'code': 0,
        }
        if not request.user.is_superuser:
            res['msg'] = '用户验证失败`'
            res['code'] = -1
            return JsonResponse(res)
        history_query = History.objects.filter(nid=nid)
        history_query.delete()
        return JsonResponse(res)
