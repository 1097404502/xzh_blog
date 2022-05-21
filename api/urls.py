from django.contrib import admin
from django.urls import path,re_path
from api.views import login,article,comment,mood,user,file,apiEmail,history

urlpatterns = [
    path('login/',login.LoginView.as_view()),  #登录
    path('register/',login.RegisterView.as_view()),  #注册
    path('article/',article.ArticleView.as_view()),  #发布文章
    path('moods/',mood.MoodView.as_view()),  #发布心情

    re_path('article/(?P<nid>\d+)/',article.ArticleView.as_view()),  #修改文章
    re_path('article/comment/(?P<nid>\d+)/',comment.CommentView.as_view()),  #发布评论
    re_path('comment/digg/(?P<nid>\d+)/',comment.CommentDiggView.as_view()),  #评论点赞

    re_path('article/digg/(?P<nid>\d+)/', article.ArticleDiggView.as_view()),  # 文章点赞
    re_path('article/collect/(?P<nid>\d+)/', article.ArticleCollectsView.as_view()),  # 文章收藏

    re_path('moods/(?P<nid>\d+)/', mood.MoodView.as_view()),  # 删除心情
    re_path('mood_comment/(?P<nid>\d+)/',mood.MoodCommentView.as_view()), #发布心情评论

    path('history/', history.HistoryView.as_view()),  # 发布回忆记录
    path('history/<int:nid>', history.HistoryView.as_view()),# 编辑历史记录

    path('change_password/',user.EditPasswordView.as_view()),  #修改密码
    path('change_avatar/', user.EditAvatarView.as_view()),  # 修改头像
    path('upload/avatar/', file.AvatarUploadView.as_view()),  # 上传头像
    path('upload/cover/', file.CoverUploadView.as_view()),  # 上传封面
    re_path('upload/avatar/(?P<nid>\d+)/', file.AvatarUploadView.as_view()),  # 删除头像
    re_path('upload/cover/(?P<nid>\d+)/', file.CoverUploadView.as_view()),  # 删除封面
    path('paste_upload/', file.PasteUploadView.as_view()),  # 粘贴图片上传

    path('sendEmail/', apiEmail.ApiEmailView.as_view()),  # 发送邮件
    path('perfectInformation/', user.EditUserInfoView.as_view()),  # 完善信息

    path('cancelCollection/', user.CancelCollectionView.as_view()),  # 取消收藏


]