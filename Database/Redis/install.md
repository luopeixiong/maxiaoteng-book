
## 1. Redis简介
1. Redis是一个基于内存的键值对存储系统，常用作数据库、缓存和消息代理 。它支持字符串、字典、列表、集合、有序集合、位图（Bitmaps）、地理位置等多种数据结构，所以常常被称为**数据结构服务器**。Redis支持事务、分片、主从复制，**支持RDB**（将内存中的数据保存在文件中）和AOF（类似于MySQL的binlog）两种持久化方式，还支持订阅分发、Lua 脚本、集群等特性。

2. 相对于Memcached的优势
    1. Web应用中常需要将一些重要数据持久化到硬盘，避免宕机等原因导致数据丢失。Redis会周期性把更新的数据写入磁盘或者追加到命令日志中，并且在此基础上实现了主从同步。而Memcached在进程关闭之后数据就会丢失
    2. 一些业务为了简化工作，需要使用列表、集合这样只有Redis才支持的数据结构。相对于Memcahced，Redis有更多的应用场景
    3. Redis提供了丰富的命令

3. Redis应用场景
    1. 取Top N 操作
    2. 实时统计
    3. 计数器
    4. 显示最新的项目列表
    5. 秒杀活动

## 2. 安装
1. ubuntu安装可以使用`apt install redis-server`一键安装

2. 以下方法用于在aws ec2 上安装
[**参考教程**:](https://medium.com/@andrewcbass/install-redis-v3-2-on-aws-ec2-instance-93259d40a3ce)

```
$ sudo yum -y update 
$ sudo yum -y install gcc make  # 安装gcc make用来编译

# 下载文件
cd /usr/local/src 
sudo wget http://download.redis.io/releases/redis-4.0.11.tar.gz
sudo tar -xvzf redis-4.0.11.tar.gz 
cd redis-stable
make test  # 可选
# 编译安装
make  

# 安装到环境变量
sudo make install
# 等价于: 
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/

# 安装tcl
sudo yum install -y tcl 
```

## 3. 配置Redis

初始配置文件位于解压目录 `.../redis-stable/redis.conf`
```
cd ./redis-stable/redis.conf  
sudo nano redis.conf

    bind 127.0.0.1  # 绑定本地ip, 要想公网访问,注释掉
    requirepass xxx  # 添加链接密码, 在允许公网访问之前, 必须设置密码
    protected-mode  no  # 禁用保护模式, 这个是在无密码时禁止公网访问使用的                           
    daemonize yes  # 后台运行                             
    logfile "/var/log/redis_6379.log"             
    pidfile  /var/run/redis.pid 
    dir /var/redis/6379
```
移动配置文件:
```
cp redis.conf /etc
```

## 4. 使用服务方式运行redis
1. 编辑配置脚本
```
vim /etc/systemd/system/redis.service
# 注意执行命令和配置文件的路径

    [unit]
    Description=The redis-server Process Manager
    After=syslog.target network.target remote-fs.target nss-lookup.target
    
    [Service]
    Type=forking
    PIDFile=/var/run/redis.pid
    ExecStart=/usr/local/bin/redis-server /etc/redis.conf
    ExecReload=/bin/kill -s HUP $MAINPID
    ExecStop=/bin/kill -s QUIT $MAINPID
    PrivateTmp=true
    
    [Install]
    WantedBy=multi-user.target
```
2. 重载systemctl
```
systemctl daemon-reload 
```
3. 启动重启等操作
```
systemctl start/stop/restart/status redis
```
4. redis.server修改后重启
```
systemctl enable redis.service
```


## 5. 使用service来管理redis-server

1. 下载init脚本
```
sudo wget https://raw.githubusercontent.com/saxenap/install-redis-amazon-linux-centos/master/redis-server
sudo mv redis-server /etc/init.d
sudo chmod 755 /etc/init.d/redis-server
```
**/etc/init/ 和 /etc/init.d 两个文件里的脚本, 是可以使用service mmm start 来启动某项服务的**

2.  修改redis_server的配置文件
```
sudo nano /etc/init.d/redis-server
    # 编辑文件以匹配配置文件
    REDIS_CONF_FILE =“/etc/redis/6379.conf”
```

3. 设置redis服务器自启动
```
sudo chkconfig --add redis-server 
sudo chkconfig --level 345 redis-server on 
sudo service redis-server start
```

## 6. 打开系统配置文件, 修复redis内存低的问题
```
sudo nano /etc/sysctl.conf
      #confure redis background save issue 
      vm.overcommit_memory = 1
      systctl vm.overcommit_memory = 1
```

## 7. 测试redis服务器是否启动正常
```
redis-cli ping
    # 响应为 PONG
```

## 8. 客户端连接Redis
1. redis-cli  # 启动redis客户端
2. 连接到本地redis 服务器
```
redis 127.0.0.1:6379>  # 连接到本地的redis服务器 
```
3. 连接到远程redis服务器
redis-cli -h host -p port -a password
```
$redis-cli -h 127.0.0.1 -p 6379 -a "mypass"
redis 127.0.0.1:6379>
redis 127.0.0.1:6379> PING

PONG
```


## 9. 可视化RedisDesktopManager
使用ssh连接



