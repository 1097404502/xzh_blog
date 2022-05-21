from app.models import Articles, Comment


def find_root_sub_comment(root_comment, sub_comment_list):
    for sub_comment in root_comment.comment_set.all():
        sub_comment_list.append(sub_comment)
        find_root_sub_comment(sub_comment , sub_comment_list)


def sub_comment_list(nid):
    # 找到某个文章的评论
    comment_query = Comment.objects.filter(article_id=nid).order_by('-create_time')
    comment_list=[]
    for comment in comment_query:
        # 如果它的父亲是none 就说明是根评论
        if not comment.parent_comment:
            lis=[]
            find_root_sub_comment(comment,lis)
            comment.sub_comment = lis
            comment_list.append(comment)
            continue

    return comment_list

