# Http 协议
## HyperText Transfer Protocol
超文本传输协议

## 基本概念

- **URL**: Uniform Resource Locator 统一资源标识符
> 协议类型:[//服务器地址[:端口号]][/资源层级UNIX文件路径]文件名[?查询][#片段ID]
> eg:https://www.douban.com/note/5264875/?type=like#sep
> 端口默认: http 80 https 443
> |#用作锚点, 定位页面的特定位置

- **https**: 超文本传输安全协议(HyperText Transfer Protocol Secure) 
> 防止电信运营商的劫持
> 安全
> 用户体验


## 请求方法

- GET  从制定的资源请求数据
- POST  向指定的资源提交要被处理的数据   
- PUT  替换(更新)资源
- DELETE  删除指定资源
- HEAD  获得报文首部
- OPTIONS  返回服务器支持的HTTP方法  




## 状态码

- 1xx  (信息性状态码)接收的请求正在处理  

- 2XX  
200 OK 成功  
204 No Content 代表服务器已经对请求成功处理, 但是没有返回内容  
206 Partial Content 表示客户端进行了范围请求  

- 3XX  
301 Moved Permanently 永久性重定向  
302 Found 临时性重定向  
304 Not Modified  使用本地资源(比如缓存)

- 4XX
400 Bad Request 请求的内容有问题  
401 Unauthorized 未验证的请求  
403 Forbidden 请求资源的访问被服务器拒绝  
404 Not Found 服务器上无法找到请求的资源  

- 5XX  
500 Internal Server Error 服务器端在执行请求时发生了错误  
502 Bad Gateway nginx或者网关后面没有上游服务器能相应请求  
503  Service Unavailable 服务器暂时处于超负荷或正在进行停机维护  
504  Gateway Timeout 对nginx或者网关请求超时了  


## 请求头

- **通用头部字段**  
Cache 控制缓存的行为  
Connection 逐条首部,连接的管理  
Date 创建报文的日期  
Pragma 报文指令  
Trailer 报文末端的首部一览  
Upgrade 升级为其他协议
Via 代理服务器的相关信息  
Warning  错误通知

- **常用字段Cache-Control**  
减少网络延迟和提升性能
```
# 禁止缓存  
Cache-Control: no-store
Cache-Control: no-store, no-cache, must-revalidate
# 强制确认缓存
Cache-Control: no-cache
# 私有缓存和公共缓存
Cache-Control: private
Cache-Control: public
# 缓存过期机制
Cache-Control: max-age=31536000  # 表示资源能够被缓存的最大时间(s)
# 缓存验证确认
Cache-Control: must-revalidate
```

- **常用字段Connection**  
可以保持连接, 减少关闭网络连接的开销
```
Connection: keep-alive
Connection: close
```

- **常用字段Via**  
可以保持连接, 减少关闭网络连接的开销
```
Connection: keep-alive
Connection: close
```









## Cookie/Session

## 身份验证

## Ajax  

## 代理

## HTTP/2






 
 
 
 
 
 
 
 
 
 
 
 
 
 