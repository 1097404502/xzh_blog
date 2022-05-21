import os


if __name__ == '__main__':
    # 加载DJango项目的配置信息
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'fengfengzhidao.settings')

    # 导入Django，并启动Django项目
    import django
    django.setup()

    from app.models import Articles, Comment

    #  方案一:
    '''
    {
    父评论1_nid：{
    sub_comment:{},
    },
    父评论2_nid：{
    sub_comment:{},
    },
    }
    '''
    def find_root_comment(comment:Comment):
        # 找comment的最终根评论
        if comment.parent_comment:
            # 不是根评论
            return find_root_comment(comment.parent_comment)
        else:
            # 是根评论
            return comment

    comment_dict = {

    }
    # 找到某个文章的评论
    comment_query = Comment.objects.filter(article_id=1)
    for comment in comment_query:
        # 如果它的父亲是none 就说明是根评论
        if not comment.parent_comment:
            # 把根评论放入字典
            comment_dict[comment.nid] = comment
            # 给根评论添加自定义属性，将所有的子评论放进去
            comment.sub_comment = []

    for comment in comment_query:
        # 一定是某个父评论的子评论
        for sub_comment in comment.comment_set.all():
            # 遍历该评论下面的所有子评论
            # 找这个子评论的最终根评论
            # find_root_comment:找这个子评论的最终根评论 返回根评论
            root_comment = find_root_comment(sub_comment)
            # 把子评论添加进属于自己的根评论里面
            comment_dict[root_comment.nid].sub_comment.append(sub_comment)

    for k, v in comment_dict.items():
        print(v, '根评论')
        for comment in v.sub_comment:
            print('         ',comment, '子评论')


    print(comment_dict)
