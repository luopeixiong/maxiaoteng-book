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

# Python连接Redis