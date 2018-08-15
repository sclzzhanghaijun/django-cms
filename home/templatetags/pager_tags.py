from django import template
from django.utils.html import format_html

register = template.Library()

"""
all_item：总条数
current_page：当前页
page_size：一页的条数
"""
@register.simple_tag
def pager(all_item, current_page, page_size=10):
    all_page, div = divmod(all_item, page_size)

    if div > 0:
        all_page += 1

    pager_list = []

    if all_page <= 7:
        start = 1
        end = all_page
    else:
        if current_page <= 4:
            start = 1
            end = 6 + 1
        else:
            start = current_page - 3
            end = current_page + 3
            if current_page + 3 >= all_page:
                start = all_page - 6
                end = all_page

    # 把页面动态起来传入起始和结束
    for i in range(start, end):

        # 判断是否为当前页
        if i == current_page:
            temp = "<li class ='active'>" \
                   "<a class='pager' data-value='%d'>%d</a></li>" % (i, i)
        else:
            temp = "<li><a class='pager' data-value='%d'>%d</a></li>" % (i, i)

            # 把标签拼接然后返回给前端
        pager_list.append(temp)

    # 上一页
    if current_page > 1:
        pre_page = "<li><a class='pager' aria-label='Previous' data-value='%d'>" \
                   "<span aria-hidden='true'>" \
                   "<i class='icon icon-lt'>" \
                   "</i></span></a></li>"
    else:
        pre_page = "<li class='disabled'><a class='pager' aria-label='Previous'>" \
                   "<span aria-hidden='true'>" \
                   "<i class='icon icon-lt'>" \
                   "</i></span></a></li> "

    # 下一页
    if current_page >= all_page:
        next_page = "<li class='disabled'><a class='pager' aria-label='Previous'>" \
                    "<span aria-hidden='true'>" \
                    "<i class='icon icon-gt'>" \
                    "</i></span></a></li> "
    else:
        next_page = "<li><a class='pager' aria-label='Previous' data-value='%d'>" \
                    "<span aria-hidden='true'>" \
                    "<i class='icon icon-gt'>" \
                    "</i></span></a></li>" % (current_page + 1)

    # 第一页
    if current_page <= 1:
        first_page = "<li class='disabled'><a class='pager' aria-label='First'>" \
                     "<span aria-hidden='true'>" \
                     "<i class='icon icon-first'>" \
                     "</i></span></a></li> "
    else:
        first_page = "<li><a class='pager' aria-label='Previous' data-value='1'>" \
                     "<span aria-hidden='true'>" \
                     "<i class='icon icon-first'>" \
                     "</i></span></a></li>"

    # 最后一页
    if current_page >= all_page:
        last_page = "<li class='disabled'><a class='pager' aria-label='Previous'>" \
                    "<span aria-hidden='true'>" \
                    "<i class='icon icon-last'>" \
                    "</i></span></a></li> "
    else:
        last_page = "<li><a class='pager' aria-label='Previous' data-value='%d'>" \
                    "<span aria-hidden='true'>" \
                    "<i class='icon icon-last'>" \
                    "</i></span></a></li>" % all_page

    pager_list.insert(0, first_page)
    pager_list.insert(1, pre_page)
    pager_list.append(next_page)
    pager_list.append(last_page)

    return format_html(''.join(pager_list))
