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
301 Moved Permanently 永久性重定向, 配合`Location`使用
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

HTTP是无状态协议, 需要设置机制记录用户状态, 用来:
> 登录状态记录, 限制登陆后显示页面  

- Cookie
通过在请求和相应报文中写入Cookie信息来控制客户端的状态    
服务端给客户端发送的报文有`Set-Cookie`项  
客户端解析`Set-Cookie`, 下次请求时, 就在请求报文中添加`Cookie`发送给服务器, 服务器就可以判断

- Session
由于Cookie明文请求, 容易被伪造, 信息太多是影响请求效率 等原因, 引入session机制.  
session保存在服务器端, 加密后将加密id作为Cookie返回给客户端

## 身份验证
适用场景:
- 移动设备API调用
- 第三方网站使用本网站进行身份认证, 且不希望直接注册本网站账号

主流方案:
- 基本认证(Basic access authentication)  
认证步骤:  
> 1. 客户端请求一个需要身份验证的页面   
> 2. 如果输入错误, 返回401应答   
> 3. 用户输入用户名和密码后, 请求增加认证消息头, 服务器认证通过后, 返回正常页面  
- 摘要式的认证(Digest access authentication)  
> 在提交之前, 对密码进行一个加密函数

- OAuth
允许用户让第三方应用访问该用户在某一网站上存储的私密资源, 而无需将用户名和密码提供给第三方应用

- JWT(JSON Web Token)
头部

## 代理

## HTTP/2
优化了性能, 兼容htpp1的语义

1. 多路复用
2. 二进制协议
3. 表头压缩
4. 服务端推送






 
 
 
 
 
 
 
 
 
 
 
 
 
 