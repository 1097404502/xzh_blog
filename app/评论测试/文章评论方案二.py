import os


if __name__ == '__main__':
    # 加载DJango项目的配置信息
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'fengfengzhidao.settings')

    # 导入Django，并启动Django项目
    import django
    django.setup()

    from app.models import Articles, Comment

    #  方案二:
    '''
    思想：根据根评论去递归查找它下面的所有子评论, 放入到根评论的空间中
    
    '''
    def find_root_subcomment(root_comment, sub_comment_list):
        for sub_comment in root_comment.comment_set.all():
            # 找根评论的子评论
            sub_comment_list.append(sub_comment)
            find_root_subcomment(sub_comment, sub_comment_list)

    # 找到某个文章的评论
    comment_query = Comment.objects.filter(article_id=1)
    # 把评论存储起来
    comment_list = []
    for comment in comment_query:
        # 如果它的父亲是none 就说明是根评论
        if not comment.parent_comment:
            # 递归查找这个根评论下面的所有子评论
            lis = []
            find_root_subcomment(comment, lis)
            comment.sub_comment = lis
            comment_list.append(comment)

    for comment in comment_list:
        for sub_comment in comment.sub_comment:
            print(comment, sub_comment)