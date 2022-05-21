from urllib.parse import urlencode


class Search:
    def __init__(self, key, current_order, order_list, query_params):
        self.key = key
        self.order_list = order_list
        self.query_params = {}
        self.current_order = current_order
        for i in query_params:
            self.query_params[i] = query_params.getlist(i)

    def order_html(self):
        order_list = []
        for li in self.order_list:
            self.query_params[self.key] = li[0]
            if li[0] == self.current_order:
                order_list.append(f'<li class="active"><a href="?{self.query_encode}">{li[1]}</a></li>')
            else:
                order_list.append(f'<li><a href="?{self.query_encode}">{li[1]}</a></li>')
        return ''.join(order_list)

    @property
    def query_encode(self):
        return urlencode(self.query_params, doseq=True)
