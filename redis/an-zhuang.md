[**参考教程**:](https://medium.com/@andrewcbass/install-redis-v3-2-on-aws-ec2-instance-93259d40a3ce)


## 安装

```
$ sudo yum -y update 
$ sudo yum -y install gcc make  # 安装gcc make用来编译

# 下载文件
$ cd /usr/local/src 
$ sudo wget http://download.redis.io/releases/redis-4.0.11.tar.gz
$ sudo tar -xvzf redis-4.0.11.tar.gz 
$ sudo rm redis-4.0.11.tar.gz

# 重新编译redis
$ cd redis-4.0.11 
$ sudo make distclean 
$ sudo make

# 安装tcl和test
$ sudo yum install -y tcl 
$ sudo make test

# 设置软连接和配置文件
$ sudo mkdir -p /etc/redis /var/lib/redis /var/redis/6379
$ sudo cp src/redis-server src/redis-cli /usr/local/bin
$ sudo cp redis.conf /etc/redis/redis.conf

```

## 配置Redis
打开conf文件
```
$ sudo nano /etc/redis/redis.conf

    bind 127.0.0.1  # 绑定本地ip, 要想公网访问,注释掉
    requirepass xxx  # 添加链接密码, 在允许公网访问之前, 必须设置密码
    protected-mode  no  # 禁用保护模式, 这个是在无密码时禁止公网访问使用的                           
    daemonize yes  # 后台运行                             
    logfile "/var/log/redis_6379.log"             
    dir /var/redis/6379 
    
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

