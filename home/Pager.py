class Pager(object):
    def __init__(self, current_page, page_size=10, base_url='', **params):
        self.current_page = int(current_page)
        self.page_size = int(page_size)
        self.params = params
        self.url = self.base_url_create(base_url)

    # 把方法伪造成属性(1)
    @property
    def start(self):
        return (self.current_page - 1) * self.page_size

    @property
    def end(self):
        return self.current_page * self.page_size

    def page_str(self, all_item):
        if all_item <= 0:
            return '<label>没有数据哦~</label>'
        all_page, div = divmod(all_item, self.page_size)
        if div > 0:
            all_page += 1

        pager_list = []

        if all_page <= 7:
            start = 1
            end = all_page
        else:
            if self.current_page <= 4:
                start = 1
                end = 6 + 1
            else:
                start = self.current_page - 3
                end = self.current_page + 3
                if self.current_page + 3 >= all_page:
                    start = all_page - 6
                    end = all_page

        # 把页面动态起来传入起始和结束
        for i in range(start, end + 1):

            # 判断是否为当前页
            if i == self.current_page:
                temp = "<li class ='active'><a href = '%s'>%d</a></li>" % (self.getHref(i), i)
            else:
                temp = "<li><a href = '%s'>%d</a></li>" % (self.getHref(i), i)

                # 把标签拼接然后返回给前端
            pager_list.append(temp)

        # 上一页
        if self.current_page > 1:
            pre_page = "<li><a href = '%s' aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                       "icon-lt'></i></span></a></li>" % (self.getHref(self.current_page - 1))
        else:
            pre_page = "<li class='disabled'><a aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                       "icon-lt'></i></span></a></li> "

        # 下一页
        if self.current_page >= all_page:
            next_page = "<li class='disabled'><a aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                        "icon-gt'></i></span></a></li> "
        else:
            next_page = "<li><a href = '%s' aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                        "icon-gt'></i></span></a></li>" % (self.getHref(self.current_page + 1))

        # 第一页
        if self.current_page <= 1:
            first_page = "<li class='disabled'><a aria-label='First'><span aria-hidden='true'><i class='icon " \
                         "icon-first'></i></span></a></li> "
        else:
            first_page = "<li><a href = '%s' aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                         "icon-first'></i></span></a></li>" % (self.getHref(1))

        # 最后一页
        if self.current_page >= all_page:
            last_page = "<li class='disabled'><a aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                        "icon-last'></i></span></a></li> "
        else:
            last_page = "<li><a href = '%s' aria-label='Previous'><span aria-hidden='true'><i class='icon " \
                        "icon-last'></i></span></a></li>" % (self.getHref(all_page))

        pager_list.insert(0, first_page)
        pager_list.insert(1, pre_page)
        pager_list.append(next_page)
        pager_list.append(last_page)

        return ''.join(pager_list)

    def getHref(self, page):
        if self.url == '':
            return ''
        if '?' in self.url:
            return '%s&page=%d' % (self.url, page)
        else:
            return '%s?page=%d' % (self.url, page)

    def base_url_create(self, base_url):
        if base_url == '':
            return ''
        first = True
        url = base_url
        for key in self.params.keys():
            if first:
                first = False
                url += '?' + key + '=' + self.params.get(key)
            else:
                url += '&' + key + '=' + self.params.get(key)
        return url
