import os


if __name__ == '__main__':
    # 加载DJango项目的配置信息
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'blog.settings')

    # 导入Django，并启动Django项目
    import django
    from django.core.mail import send_mail
    from blog import settings

    django.setup()

    send_mail(
        '亲爱的狗伟，您的反馈被回复！',
        '回复的狗伟',
        settings.EMAIL_HOST_USER,
        ['1318521578@qq.com'],
        False)
