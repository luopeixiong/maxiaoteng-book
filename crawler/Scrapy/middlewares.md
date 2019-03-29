# 中间件 MiddleWare

## 1. HttpErrorMiddleware 处理200-300之外的返回码

https://juejin.im/post/5c10a1caf265da61380f1315 源码展示

1. 默认情况
   1. 200-300 调用callback，除此之外ignore
2. 指定要处理
   1. request.meta可以指定
        ```
            request.meta['handle_httpstatus_all'] = Ture
            # 或者
            request.meta['handle_httpstatus_list'] = [301, 302...]
        ```
   2. spiders里设置
        ```
            self.handle_httpstatus_list = [301, 302...]
        ```
   3. 在setting中配置
    ```python
        HTPERROR_ALLOWED_CODES = [403]  # 默认为[]
        # 或
        HTTPERROR_ALLOW_ALL = True  # 默认为False
    ```
3. 处理方式
   1. callback中能够处理
        - 200-300
        - 上述填写的其他handle-http-error
   2. errback处理
        - 上述之外的，因为有异常抛出