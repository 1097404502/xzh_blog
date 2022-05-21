from django import template
from app.utils.search import Search
from django.utils.safestring import mark_safe
from app.models import Tags, Avatars, Menu, Articles

register=template.Library()

#自定义过滤器
# @register.filter
# def add1(item):
#     return int(item)+1

@register.inclusion_tag('my_tag/headers.html')
def banner(menu_name,article=None):
    if article:
        # 说明是文章详情
        # 拿到文章的封面
        cover = article.cover.url.url
        img_list = [cover]
        menu_time = 0
        title = article.title
        return locals()
    menu_obj = Menu.objects.get(menu_title_en=menu_name)
    menu_time = menu_obj.menu_time  # 轮播时间
    title = menu_obj.title
    if menu_obj.menu_rotation:
        img_list = [
            i.url.url
            for i in menu_obj.menu_url.all()
        ]
    else:
        # 不轮播
        img_list = [menu_obj.menu_url.all().first().url.url]
        menu_time = 0

    return locals()


@register.simple_tag
def generate_order_html(request, key):
    order_list = []
    order = ''  # 用于设置选择排序方式
    if key == 'order':
        order = request.GET.get('order', '-create_date')
        order_list = [
            ('-create_date', '综合排序'),
            ('-change_date', '最新发布'),
            ('-collects_count', '最多收藏'),
            ('-digg_count', '最多点赞'),
            ('-comment_count', '最多评论'),
            ('-look_count', '最多浏览'),
        ]
    elif key == 'word':
        order = request.GET.getlist('word', '')
        order_list = [
            ('', '全部字数'),
            (['0', '100'], '100字以内'),
            (['100', '500'], '500字以内'),
            (['500', '1000'], '1000字以内'),
            (['1000', '3000'], '3000字以内'),
            (['3000', '5000'], '5000字以内'),
        ]
    elif key == 'tag':
        order = request.GET.get('tag', '')
        tag_list = Tags.objects.exclude(articles__isnull=True)
        order_list.append(('', '全部标签'))
        for tag in tag_list:
            order_list.append((tag.title, tag.title))

    query_params = request.GET.copy()
    order = Search(
        current_order=order,
        order_list=order_list,
        query_params=query_params,
        key=key
    )

    return mark_safe(order.order_html())


# 生成动态导航条
@register.simple_tag
def dynamic_nav(request):
    path = request.path_info
    path_dict = {
        '/': '首页',
        '/news/': '新闻',
        '/moods/': '心情',
        '/history/': '回忆录',
        '/about/': '关于',
        '/sites/': '网站导航',
    }
    nav_list = []
    for k, v in path_dict.items():
        if k == path:
            nav_list.append(f'<a href="{k}" class="active">{v}</a>')
        else:
            nav_list.append(f'<a href="{k}">{v}</a>')
    return mark_safe(''.join(nav_list))



#  生成广告
@register.simple_tag
def generate_advert(advert_list):
    html_list = []
    for i in advert_list:
        if i.img:
            # 上传的文件
            html_list.append(
                f'<div><a href="{i.href}" title="{i.title}" target="_blank"><img src="{i.img.url}"></a></div>')
        else:
            html_s: str = i.img_list
            html_new = html_s.replace('；', ';').replace('\r\n', '')
            img_list = html_new.split(';')
            for url in img_list:
                html_list.append(
                    f'<div><a href="{i.href}" title="{i.title}" target="_blank"><img src="{url}"></a></div>')
    return mark_safe(''.join(html_list))


@register.simple_tag
def generate_drawing(drawing: str):
    if not drawing:
        return ''
    drawing = drawing.replace('；', ';').replace('\n', ';')
    drawing_list = drawing.split(';')
    html_str = ''
    for i in drawing_list:
        html_str += f'<img src="{i}" alt="">'
    return mark_safe(html_str)


@register.simple_tag
def generate_content(content):
    if not content:
        return ''
    html_new = content.replace('；', ';').replace('\r\n', ';').replace('\n', ';')
    img_list = html_new.split(';')
    html_str = ''
    for i in img_list:
        html_str += f'<li>{i}</li>'
    return mark_safe(html_str)


# 计算某个分类的文章数
@register.simple_tag
def calculation_category_count(cid):
    article_query = Articles.objects.filter(category=cid)
    return article_query.count()