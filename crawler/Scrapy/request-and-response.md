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
	2. 如果是get方法,get请求的querystring, 需要使用: ``` url + "?" + urllib.parse.urlencode(dict) ``` 来自动拼接,不能在此处传入。
5. cookies	# 默认生效,接受dict 
    ```
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
6. callback
7. meta 
 + 上一个请求 request.meta['item'] = item
 + 下一个响应中response.meta['item'] 便是item
8. errback
 + 返回non-200时调用
 + 比如：def errback_httpbin(self, failure): … ，
 + failure.check(ErrorType),    
 > ErrorType有HttpError, DNSLookupError,TimeoutError, TCPTimeOutError…

9. dont_filter(默认false, 过滤重复请求)

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
