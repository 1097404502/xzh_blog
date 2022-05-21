from PIL import Image, ImageDraw, ImageFont
import string
import random
from io import BytesIO


str_all = string.digits+string.ascii_uppercase+string.ascii_lowercase


def random_color():
    return (random.randint(0, 255), random.randint(0, 255), random.randint(0, 255))


def random_verify_code(size=(200, 40), length=4, pointed_num=100, line_num=15):
    # 生成一个200*40的白色背景的图片
    width, height = size
    img = Image.new('RGB', (width, height), color=(255, 255, 255))
    # 新建一个和图片一样大小的画布
    draw = ImageDraw.Draw(img)

    # 生成字体对象
    font = ImageFont.truetype(font='/static/my/font/arial.ttf', size=32,)

    # 书写文字
    verify_code = ''
    for i in range(length):
        random_code = random.choice(str_all)
        verify_code += random_code
        draw.text((40*(i+1), 2), random_code, (0, 0, 0), font=font)

    # print(verify_code)
    # 随机画点
    for i in range(pointed_num):
        x = random.randint(0, width)
        y = random.randint(0, height)
        draw.point((x, y), random_color())

    # 随机画线
    for i in range(line_num):
        x1, y1 = random.randint(0, width), random.randint(0, height)
        x2, y2 = random.randint(0, width), random.randint(0, height)
        draw.line((x1, y1, x2, y2), fill=random_color())
    # 创建一个内存句柄
    f = BytesIO()
    # 将图片保存到内存当中
    img.save(f, 'PNG')
    # 读取内存句柄
    data = f.getvalue()
    return (data, verify_code)


if __name__ == '__main__':
    random_verify_code()