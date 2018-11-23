## 处理http错误请求(handle-http-error)

爬虫时如果网站把ip封了，返回`response.status==403`，scrapy默认只处理200-300之间的请求

添加处理有两种方法：
1. 在Spider类下面添加handle_httpstatus_list
    ```python
    Class MySpider(CrawlSpider):
        handle_httpstatus_list = [403]
    ```
2. 在setting中增加HTTPERROR_ALLOWED_CODES
    ```python
    HTTPERROR_ALLOWED_CODES = [403]  # 默认为[]
    ```
3. 在setting中增加HTTPERROR_ALLOW_ALL
    ```python
    HTTPERROR_ALLOW_ALL = True  # 默认为False
    ```

设置完之后，就可以根据`response.status == 403`来确认网站封锁ip。