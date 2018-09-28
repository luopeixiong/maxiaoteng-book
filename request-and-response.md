# Request and Response

**cookie : scrapy 对cookie管理有很强的支持, 不需要可以去管理**


# Request

## 基本参数
- headers
- url(转义之后的，修改需用replace)
- method
- body (str，经过转义的)
- cookie
- callback
- meta 
 + 上一个请求 request.meta['item'] = item
 + 下一个响应中response.meta['item'] 便是item
- errback
 + 返回non-200时调用
 + 比如：def errback_httpbin(self, failure): … ，
 + failure.check(ErrorType),    
 > ErrorType有HttpError, DNSLookupError,TimeoutError, TCPTimeOutError…

- dont_filter(默认false, 过滤重复请求)

## 子类FormRequest（发送post请求, 可选）
- url
- formdata
iii. call_back
iv. …
v. FromRequest.from_response(response, formdata, call_back)
1) 可以用来模拟用户登录
2) 在login的方法中： return scrapy.FormRequest.from_response(
	response,
	formdata={'name'='xx', 'password'='xx'},
	callback=self.after_login
	)

## 注意事项
- get请求的querystring, 需要使用: ``` url + "?" + urllib.parse.urlencode(dict) ``` 来自动拼接


