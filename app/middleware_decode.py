from django.utils.deprecation import MiddlewareMixin
import json
from api.utils.get_location_info import get_ip
from django.core.cache import cache

class Statistical(MiddlewareMixin):
    def process_request(self, request):
        ip=get_ip(request)
        online_ips = list(cache.get("online_ips", []))
        if online_ips:
            online_ips = list(cache.get_many(online_ips).keys())
        cache.set(ip, 0, 10) # 超市时间
        if ip not in online_ips:
            online_ips.append(ip)

        cache.set("online_ips", online_ips)
        request.online_list = online_ips



# 解析post请求的数据
class MD1(MiddlewareMixin):
    # 请求中间件
    def process_request(self, request):
        # 用来解析json格式的数据
        if request.method != 'GET' and request.META.get('CONTENT_TYPE') == 'application/json':
            # print('提取json数据放入到request.data中')
            data = json.loads(request.body, encoding='utf-8')
            request.data = data

    def process_response(self, request, response):
        return response