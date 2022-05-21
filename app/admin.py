from django.contrib import admin
from app.models import *  #导入所有的表
from django.utils.safestring import mark_safe
from django.core.mail import send_mail
from threading import Thread


# Register your models here.

class ArticleAdmin(admin.ModelAdmin):
    def get_cover(self):
        if self.cover:
            return mark_safe(f'<img src="{self.cover.url.url}" style="height:50px;">')
        return

    def get_tags(self):
        tag_list = ','.join([i.title for i in self.tag.all()])
        return tag_list

    def get_title(self):
        return mark_safe(f'<a href="/article/{self.nid}" target="_blank">{self.title}</a>')

    def get_edit_delete_btn(self):
        return mark_safe(f"""
        <a href="/backend/edit_article/{self.nid}" target="_blank">编辑</a>
        <a href="/admin/app/articles/{self.nid}/delete/">删除</a>
        """)

    get_cover.short_description = '文章封面'
    get_tags.short_description = '文章标签'
    get_title.short_description = '文章'
    get_edit_delete_btn.short_description = '操作'

    list_display = [get_title,
                    get_cover,
                    get_tags,
                    'category',
                    'look_count',
                    'digg_count',
                    'comment_count',
                    'collects_count',
                    'word',
                    'change_date',
                    get_edit_delete_btn,
                    ]

    def action_count_word(self, request, queryset):
        for obj in queryset:
            obj.word = len(obj.content)
            obj.save()

    action_count_word.short_description = '获取文章字数'
    action_count_word.type = 'success'
    actions = [action_count_word]

# 广告
class AdvertAdmin(admin.ModelAdmin):
    def get_href(self):
        return mark_safe(f"""<a href="{self.href}" target="_blank">跳转链接</a>""")

    def get_img_list(self):
        # 解析分号 ; ；
        # 解析换行 \n
        html_s: str = self.img_list
        html_new = html_s.replace('；', ';').replace('\r\n', '')
        img_list = html_new.split(';')
        html_str = ''
        for i in img_list:
            html_str += f'<img src="{i}" style="height:50px;">'
        return mark_safe(html_str)

    def get_img(self):
        if self.img:
            return mark_safe(f"""
            <img src="{self.img.url}" style="height:50px;">
            """)

    list_display = ['title', get_img, 'is_show', 'author', get_img_list, get_href]

    get_href.short_description = '跳转链接'
    get_img_list.short_description = '图片列表'
    get_img.short_description = '用户上传'

    # 为自定义名字指定颜色
    get_href.style = 'color:#409eff;'
    get_img_list.style = 'color:#409eff;'
    get_img.style = 'color:blue;'


# 站点背景
class MenuAdmin(admin.ModelAdmin):

    add_form_template = 'simple_admin/add_form.html'
    change_form_template = 'simple_admin/add_form.html'

    def get_menu_url(self: Menu):
        lis = [f"<img src='{i.url.url}' style='height:60px;margin-right:5px;'>" for i in self.menu_url.all()]
        return mark_safe(''.join(lis))

    list_display = ['menu_title',
                    'menu_title_en',
                    'title',
                    'abstract',
                    'rotation',
                    'abstract_time',
                    'menu_rotation',
                    'menu_time',
                    get_menu_url,
                    ]

    get_menu_url.short_description = '图片组'


#站点背景图
class MenuImgAdmin(admin.ModelAdmin):
    def getImg(self):
        if self.url:
            return mark_safe(f"""
            <img src="{self.url.url}" style="height:50px;">
            """)

    list_display = ['url', getImg]
    getImg.short_description = '背景图'


#网站标签
# class NavsAdmin(admin.ModelAdmin):
#
#     list_display = ['title', ]



# class FeedbackAdmin(admin.ModelAdmin):
#     list_display = ['email', 'content', 'status', 'processing_content']
#     readonly_fields = ['email', 'content', 'status']
#
#     def has_add_permission(self, request):
#         return False
#
#     def save_model(self, request, obj, form, change):
#         # change true等于编辑  false 等于添加
#         if not change:
#             return
#         # 编辑
#         email = obj.email
#         content = obj.content
#         obj.status = True
#         processing_content = form.data.get('processing_content')
#         # 发送邮箱 设置超时时间
#         Thread(target=send_mail, args=(f'【君安小窝】你反馈的信息:{content}-被回复了',
#                                        processing_content,
#                                        settings.EMAIL_HOST_USER,
#                                        [email, ],
#                                        False)).start()
#         return super(FeedbackAdmin, self).save_model(request, obj, form, change)


admin.site.register(Articles, ArticleAdmin)
admin.site.register(Tags)
admin.site.register(History)
admin.site.register(Cover)
admin.site.register(Comment)
admin.site.register(Avatars)
admin.site.register(UserInfo)
admin.site.register(Advert, AdvertAdmin)
admin.site.register(Moods)
admin.site.register(Menu, MenuAdmin)
admin.site.register(MenuImg, MenuImgAdmin)