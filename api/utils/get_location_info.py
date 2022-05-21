import requests
import re
from bs4 import BeautifulSoup

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.67 Safari/537.36"
}


def get_ip(request):
    # 判断是否使用代理
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        # 代理
        ip = x_forwarded_for.split(',')[0]
    else:
        # 获取真实ip
        ip = request.META.get('REMOTE_ADDR')
    return ip


def get_addr_ip(ip):
    if ip.startswith('10.') or ip.startswith('192') or ip.startswith('127'):
        return {'prov':'中国','city':'内网'}
    url = f'https://www.ip138.com/iplookup.asp?ip={ip}&action=2'
    res = requests.get(url=url, headers=headers).content.decode('gbk')
    print(res)
    result = re.findall(r'ip_result = (.*?);', res, re.S)[0]
    consequeue = eval(result)
    addr:dict = consequeue['ip_c_list'][0]
    addr.pop('begin')
    addr.pop('end')
    addr.pop('idc')
    addr.pop('net')
    area = addr.get('area')
    # print(addr)
    if not area:
        addr.pop('area')
    return addr



if __name__ == '__main__':
    get_addr_ip('171.42.143.203')
    get_addr_ip('106.13.185.190')
    get_addr_ip('171.120.159.122')
