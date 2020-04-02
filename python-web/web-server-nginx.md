# WEB服务器Nginx

## 1. 概述
1. web服务器和应用服务器的区别
   - web服务器负责处理HTTP协议
   - web服务器用于处理静态页面的内容, 对于python产生的动态内容,通过WSGI接口交给应用服务器来处理
   - 一般应用服务器都集成了web服务器

   尽管集成了web服务器, 但大部分用来做调试, 出于性能和稳定性的考虑,并不能在生产环境中使用.

2. 为什么选择Nginx
   - 处理静态文件,索引文件效率非常高
   - 高并发连接
   - 低的内存损耗
   - 强大的反响代理和负载均衡功能,平衡集群中各个服务器的负载压力


## 2. 使用
1. 安装
    ```
    sudo yum install nginx
    sudo systemctl status nginx # 查看当前状态
    sudo systemctl start nginx # 查看当前状态
    sudo systemctl stop nginx # 查看当前状态
    sudo systemctl enable nginx  # 设置开机自启动
    sudo systemctl restart nginx  # 重启nginx
    ```

2. 配置
    ```
    # 好的习惯是先检查配置文件,再重启服务器
    sudo nginx -t  # 验证Nginx配置是否正确

    # 修改配置文件后的重载
    sudo nginx -s reload
    ```

3. 配置文件
   1. 配置目录
       ```
       # 查找主配置文件, 里面包含日志文件路径和子配置文件路径
       # 优先配置方案参考https://serverfault.com/questions/527630/what-is-the-different-usages-for-sites-available-vs-the-conf-d-directory-for-ngi
       find / -name nginx.conf
       # 子路径配置文件
       /etc/nginx/conf.d/*.conf
       ```
   2. 配置文件demo
       ```
       # nginx.conf
       user root;
       worker_processes  1;
       error_log  /var/log/nginx/error.log warn;
       pid        /var/run/nginx.pid;
       events {
           worker_connections  1024;
       }
       http {
           include       /etc/nginx/mime.types;
           default_type  application/octet-stream;

           log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                           '$status $body_bytes_sent "$http_referer" '
                           '"$http_user_agent" "$http_x_forwarded_for"';

           access_log  /var/log/nginx/access.log  main;

           sendfile        on;
           #tcp_nopush     on;

           keepalive_timeout  65;

           #gzip  on;

           include /etc/nginx/conf.d/*.conf;
       }
       # 子配置文件
       server {
           charset utf-8;
           listen 80;
           server_name book.maxiaoteng.xyz;
           server_name book.maxiaoteng.tk;

           # 重定向
           rewrite  ^/(.*)$  https://maxiaoteng001.github.io/maxiaoteng-book/$1 permanent;

           # 代理
           location /static {
               alias /var/www/mxt_blogs_project/static; 
           }
           location / {
               proxy_pass http://localhost:4000;
           }
       }
       ```

3. 日志位置
    ```bash
    /var/log/nginx
    ```

## 3. 其他
1. 什么时候选择源码安装？二进制包安装和源码安装应用场景: 
    - 对软件精简度有要求, 性能非常高的要求
    - 源码安装自由度高
    - 对软件打过补丁
    - 源码安装提供了统一的安装方式,可以跨平台应用


2. 反向代理和正向代理  
    通常部署web应用的时候, 都会选择一个叫做WSGI的应用服务器,搭配Nginx来使用
    - 正向代理: 作为一个媒介将互联网获取的资源返回给相关联的客户端, 代理和客户端在一个局域网,对于服务端是透明的
    - 反向代理: 根据客户端的请求, 从后端的服务器上获取资源, 然后再将这些资源返回给客户端. 代理和服务器在一个局域网,对客户端是透明的.

3. 反向代理的作用
   - 提高动态语言的I/O处理能力
   - 加密和SSL加速
   - 安全
   - 负载均衡
   - 缓存静态内容
   - 支持压缩

4.  负载均衡算法
    1. round-robin  # 按请求顺序依次分配, 如果某台服务器自动宕机,自动剔除
    2. least_conn  # 请求发送到活跃连接最少的服务器上
    3. ip_hash  # 按ip的hash值分配
    4. hash


5. 通过Gunicorn启动Flask应用

6. nginx代理出现502 
    1. 检查日志发现
        ```
        # log文件显示
        15 connect() to 127.0.0.1:2018 failed (13: Permission denied) while connecting to upstream
        ```
    2. 解决办法: 
       - 关闭selinux
       ```
       sudo vim /etc/selinux/config
       # 将SELINUX=enforcing改为SELINUX=disabled
       重启即可
       ```
       - 临时解决: 
       ```
       setenforce 0
       ```