from django.views import View
from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from django.db.models import F
from django import forms
from api.views.login import clean_form
from app.models import Comment, Articles
from api.utils.comment_find import find_root_comment
from app.utils.sub_comment import find_root_sub_comment


class CommentView(View):
    # 发布评论
    def post(self, request, nid):
        '''
        文章id 用户 评论内容 必填
        /api/article/2/comment
        :param request:
        :return:
        '''
        res = {
            'msg': '文章评论成功',
            'code': 412,
            'self': None
        }
        data = request.data
        if not request.user.username:
            res['msg'] = '请登录'
            return JsonResponse(res)

        content = data.get('content')
        if not content:
            res['msg'] = '请输入评论内容'
            res['self'] = 'content'
            return JsonResponse(res)
        pid = data.get('pid')
        # 文章评论量加1
        Articles.objects.filter(nid=nid).update(comment_count=F('comment_count') + 1)
        if pid:
            # 文章评论校验成功
            # 不是根评论
            comment_obj = Comment.objects.create(
                content=content,
                user=request.user,
                article_id=nid,
                parent_comment_id=pid,
            )
            # 根评论数+1
            # 找最终的根评论
            root_comment_obj = find_root_comment(comment_obj)
            root_comment_obj.comment_count += 1
            root_comment_obj.save()
        else:
            # 根评论
            Comment.objects.create(
                content=content,
                user=request.user,
                article_id=nid,
            )
        res['code'] = 0
        return JsonResponse(res)

    def delete(self, request, nid):
        # 自己发布的评论才能删除
        # 或者是超级管理员
        res = {
            'msg': '评论删除成功',
            'code': 412,
        }
        # 超级管理员
        login_user = request.user
        comment_query = Comment.objects.filter(nid=nid)
        # 评论人
        comment_user = comment_query.first().user

        aid = request.data.get('aid')
        # 子评论的最终根评论id
        pid = request.data.get('pid')
        if not (login_user == comment_user or login_user.is_superuser):
            res['msg'] = '用户验证失败'
            return JsonResponse(res)
            # 可以删除
        lis = []
        find_root_sub_comment(comment_query.first(), lis)

        Articles.objects.filter(nid=aid).update(comment_count=F('comment_count') - len(lis) - 1)

        if pid:
            # 删除子评论
            Comment.objects.filter(nid=pid).update(comment_count=F('comment_count') - len(lis) - 1)

        comment_query.delete()
        res['code'] = 0
        return JsonResponse(res)


class CommentDiggView(View):
    def post(self, request, nid):
        # nid 文章评论id
        res = {
            'msg': '文章评论点赞成功',
            'code': 412,
            'data': 0,
        }
        if not request.user.username:
            res['msg'] = '请登录'
            return JsonResponse(res)
        comment_query = Comment.objects.filter(nid=nid)
        comment_query.update(digg_count=F('digg_count') + 1)
        res['data'] = comment_query.first().digg_count
        res['code'] = 0
        return JsonResponse(res)
