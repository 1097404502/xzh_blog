from django.contrib.auth import get_user_model
from django.contrib.auth.backends import ModelBackend
from django.db.models import Q


User = get_user_model()


class CustomBackend(ModelBackend):
    # 重写authenticate方法
    def authenticate(self, request, username=None, password=None, **kwargs):
        print('调用重写的authenticate方法')
        user = User.objects.filter(Q(username=username)|Q(email=username)).first()
        if user:
            if user.check_password(password):
                return user
        return None