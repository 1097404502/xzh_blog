from qiniu import Auth, put_file, put_data

import time
from django.conf import settings

# 秘钥
# access_key = 'wd751QltFVSAdwogn9Nvpr7BoEuMGewxNUu7sf9v'
# secret_key = 'MbqdgJ0r38ogmB3UVSoomV7YIZKW5ipjafKf2gYF'
access_key = settings.QINIU_ACCESS_KEY
secret_key = settings.QINIU_SECRET_KEY
# 要上传的空间
bucket_name = 'zhuohengblog'
# 构建鉴权对象
q = Auth(access_key, secret_key)


def upload_file(path, key=None, prefix='blog/'):
    '''

    :param path:图片的路径
    :param key:图片上传之后的名字
    :param prefix:前缀
    :return:
    '''
    # 上传后保存的文件名
    if not key:
        key = prefix + key + '.' + path.split('.')[-1]
    else:
        key = prefix + key + '.' + path.split('.')[-1]
    # 生成上传Token 可以指定过期时间等
    token = q.upload_token(bucket_name, key, 2)
    put_file(token, key, path, version='v2')
    return 'http://rc6m7e397.hn-bkt.clouddn.com/' + key


def upload_data(file_data, key=None, suffix='.png', prefix='blog/'):
    '''

    :param file_data: 图片的字节数据
    :param key:图片上传后的名字
    :param suffix:
    :param prefix:
    :return:
    '''
    if not key:
        key = prefix + str(int(time.time())) + suffix
    else:
        key = prefix + key + suffix
    # 生成上传token，可以指定过期时间等
    token = q.upload_token(bucket_name, key, 2)
    put_data(token, key, file_data)
    return 'http://rc6m7e397.hn-bkt.clouddn.com/' + key


if __name__ == '__main__':
    with open('../../static/upload/1.png', 'rb') as f:
        data = f.read()
        file_name = upload_data(data)
        print(file_name)
