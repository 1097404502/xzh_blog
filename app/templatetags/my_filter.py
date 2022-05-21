import datetime
import pendulum

from django import template
from app.models import Avatars, Cover

register = template.Library()


# 自定义过滤器
# 判断用户是否收藏了文章
@register.filter
def isUserCollect(article, request):
    if str(request.user) == 'AnonymousUser':
        return ''
    if article in request.user.collects.all():
        return 'show'
    return ''


# 判断是否有文章内容
@register.filter
def isArticleContent(article_list):
    if len(article_list):
        return 'search_content'
    else:
        return 'no_content'


# 时间格式化
@register.filter
def date_human(date: datetime.datetime):
    pendulum.set_locale('zh')
    tz = pendulum.now().tz
    time_difference = pendulum.parse(date.strftime('%Y-%m-%d %H:%M:%S'), tz=tz).diff_for_humans()
    return time_difference


# 计算使用头像的总和
@register.filter
def calculate_avatar(avatar: Avatars):
    count = avatar.moodcomment_set.count() + avatar.moods_set.count() + avatar.userinfo_set.count()
    if count:
        return 'hasAvatar'
    else:
        return 'no_avatar'


# 文章封面
@register.filter
def calculate_cover(cover: Cover):
    count = cover.articles_set.count()
    if count:
        return ''
    else:
        return 'no_cover'


@register.filter
def get_coll_nid(lis):
    return [i.nid for i in lis]

