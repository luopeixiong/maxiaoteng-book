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
$ sudo cp redis.conf /etc/redis/6379.conf

```

## 配置Redis
打开conf文件
```
$ sudo nano /etc/redis/6379.conf

    bind 127.0.0.1  # 绑定本地ip                           
    daemonize yes  # 后台运行                             
    logfile "/var/log/redis_6379.log"             
    dir /var/redis/6379 
```


