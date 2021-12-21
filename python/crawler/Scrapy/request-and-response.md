# Request and Response
[中文文档](https://scrapy-chs.readthedocs.io/zh_CN/latest/topics/request-response.html)

**cookie : scrapy 对cookie管理有很强的支持, 可以不需要去管理**


# Request

## 1. 基本参数
1. headers
2. url(转义之后的，修改需用replace)
3. method
4. body (str，经过转义的)
	1. 当method为post时使用
        ```python
        import urllib
        import json
        post_data = {}
        # 'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        post_data = urllib.parse.urlencode(post_data, doseq=True)
        # "Content-Type": "application/json",
        post_data = json.dumps(post_data)
        yield scrapy.Request(post_url,
                    method='post',
                    body=post_data,
                    headers=self.headers,
                    callback=self.parse,
                    dont_filter=True,
                    errback=self.errback_httpbin
                )
        ```
	2. 如果是get方法,get请求的querystring, 需要使用: ``` url + "?" + urllib.parse.urlencode(dict) ``` 来自动拼接,不能在此处传入。
5. cookies	# 默认生效,接受dict 
    1. 普通添加cookie
        ```python
        cookies = {
            'PREF': "TM={}277:L={}".format(last_time, keyword_urlencode),
            'RQ': "q=&l={}&ts={}114".format(keyword_urlencode, before_time),
        }
        request = scrapy.Request(url=url, 
                        headers=self.headers,
                        cookies=cookies,
                        callback=self.parse, 
                        errback=self.errback_httpbin,
                        dont_filter=True,
                        meta=data)
        ```
    2. dont_merge_cookies   此时cookies参数就不再适用, cookie中间件也不再处理set-cookie
        ```python
        custom_settings = {
            'COOKIES_ENABLED': True,
        }
        meta = {}
        meta['dont_merge_cookies'] = True
        self.headers['Cookie'] = "; ".join([str(x)+"="+str(y) for x,y in cookies.items()])
        return scrapy.Request(meta.get('url'), 
            headers=self.headers, 
            callback=self.parse, 
            errback=self.errback_httpbin,
            meta=meta, 
            dont_filter=True)

        ```
6. callback
7. meta 
 + 上一个请求 request.meta['item'] = item
 + 下一个响应中response.meta['item'] 便是item
8. errback
 + 返回non-200时调用
 + 比如：def errback_httpbin(self, failure): … ，
 + failure.check(ErrorType),    
 + ErrorType有HttpError, DNSLookupError,TimeoutError, TCPTimeOutError…

9. dont_filter(默认false, 过滤重复请求, 如果要处理302,301, 就需要设置成True)

## 2. 子类FormRequest（发送post请求, 可选）
- url
- formdata(此处传入dict即可)
iii. call_back
iv. …
v. FromRequest.from_response(response, formdata, call_back)
1) 可以用来模拟用户登录
2) 在login的方法中： return scrapy.FormRequest.from_response(
	response,
	formdata={'name'='xx', 'password'='xx'},
	callback=self.after_login
	)

## 3. dont_filter机制


## 4. errback的处理
scrapy默认情况下, 只有status在200-300之间时才会调用callback, 其他都由errback调用  
可以定义要进入callback的其他返回码[setting.md的处理HTTP错误](scrapy-setting.md), 
1. 调用方法
    ```
    # 通常有三种情况会调用到errback
    import scrapy

    from scrapy.spidermiddlewares.httperror import HttpError
    from twisted.internet.error import DNSLookupError
    from twisted.internet.error import TimeoutError, TCPTimedOutError

    ...

    def errback_httpbin(self, failure):
        # log all failures
        self.logger.error(repr(failure))
        # in case you want to do something special for some errors,
        # you may need the failure's type:

        if failure.check(HttpError):
            # these exceptions come from HttpError spider middleware
            # you can get the non-200 response
            response = failure.value.response
            self.logger.error('HttpError on %s', response.url)

        elif failure.check(DNSLookupError):
            # this is the original request
            request = failure.request
            self.logger.error('DNSLookupError on %s', request.url)

        elif failure.check(TimeoutError, TCPTimedOutError):
            request = failure.request
            self.logger.error('TimeoutError on %s', request.url)
    ```
2. 几种处理
   1. 重试
        ```
        # 通常都是在meta中保存请求的参数，可以放回redis或直接重构请求
        meta = failure.request.meta.copy()
        ```
   2. 对于HttpError的请求
        ```
        # 可以取回status, url, headers(用来获取重定向的url)等
        response = failure.value.response
        url = response.url
        status = response.status
        headers = response.headers
        # 如果返回302或301
        location = headers.get('Location').decode('utf-8')
        ```

# Response

## 1. 基本属性
1. url(string)
2. headers(dict)
3. status(integer)
4. body(bytes), 
5. text   # body.decode('utf-8') = text  utf-8可以是其他类型, <meta charset="UTF-8">
6. meta(dict)
7. flags(list)
8. request  
  产生这个response的request对象，重定向后的request是原始的，所以`response.url == response.request.url` 不总是成立
