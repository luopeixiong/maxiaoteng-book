# WEB服务器Nginx

## web服务器和应用服务器的区别
- web服务器负责处理HTTP协议
- web服务器用于处理静态页面的内容, 对于python产生的动态内容,通过WSGI接口交给应用服务器来处理
- 一般应用服务器都集成了web服务器

尽管集成了web服务器, 但大部分用来做调试, 出于性能和稳定性的考虑,并不能在生产环境中使用.

## 为什么选择Nginx
- 处理静态文件,索引文件效率非常高
- 高并发连接
- 低的内存损耗
- 强大的反响代理和负载均衡功能,平衡集群中各个服务器的负载压力


## 安装Nginx

二进制包安装
源码安装应用场景: 
- 对软件精简度有要求, 性能非常高的要求
- 源码安装自由度高
- 对软件打过补丁
- 源码安装提供了统一的安装方式,可以跨平台应用

```
sudo yum install nginx
sudo systemctl status nginx # 查看当前状态
sudo systemctl start nginx # 查看当前状态
sudo systemctl stop nginx # 查看当前状态
sudo systemctl enable nginx  # 设置开机自启动
```