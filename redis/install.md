[**参考教程**:](https://medium.com/@andrewcbass/install-redis-v3-2-on-aws-ec2-instance-93259d40a3ce)


## 安装

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

## 配置Redis

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

## 使用服务方式运行redis
- 编辑配置脚本
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
- 重载systemctl
```
systemctl daemon-reload 
```
- 启动重启等操作
```
systemctl start/stop/restart/status redis
```
- redis.server修改后重启
```
systemctl enable redis.service
```


## 使用service来管理redis-server

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

## 打开系统配置文件, 修复redis内存低的问题
```
sudo nano /etc/sysctl.conf
      #confure redis background save issue 
      vm.overcommit_memory = 1
      systctl vm.overcommit_memory = 1
```

## 测试redis服务器是否启动正常
```
redis-cli ping
    # 响应为 PONG
```

## 客户端连接Redis
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


## 可视化RedisDesktopManager
使用ssh连接



