# Python连接Redis

## redis连接
redis提供两个类Redis和StrictRedis, StrictRedis用来实现大部分官方的命令,并使用官方的语法和命令,Redis是StrictRedis的字类,用于向后兼容旧版本的redis-py.

redis连接实例是线程安全的,可以直接将redis设置为全局变量,直接使用.

**安装redis**
```
sudo pip install redis
```

连接redis时,加上decode_response=True,写入的键值对中的value为str类型,不加这个参数写入的则为字节类型.

```
import redis
r = redis.Redis(host='localhost', port=6379, password='xxx', decode_responses=True)   # host是redis主机，需要redis服务端和客户端都启动 redis默认端口是6379, 密码验证
r.set('name', 'junxi')  # key是"foo" value是"bar" 将键值对存入redis缓存
print(r['name'])
print(r.get('name'))  # 取出键name对应的值
print(type(r.get('name')))
```

## 连接池

默认,每个Redis实例都会维护一个自己的连接池.可以直接建立一个连接池,实现多个Redis实例共享一个连接池
```
import redis    # 导入redis模块，通过python操作redis 也可以直接在redis主机的服务端操作缓存数据库

pool = redis.ConnectionPool(host='localhost', port=6379, password='xxx', decode_responses=True)   # host是redis主机，需要redis服务端和客户端都起着 redis默认端口是6379
r = redis.Redis(connection_pool=pool)
r.set('gender', 'male')     # key是"gender" value是"male" 将键值对存入redis缓存
print(r.get('gender'))      # gender 取出键male对应的值
```

## redis基本命令String

- set 基本操作
```
set(name, value, ex=None, px=None, nx=False, xx=False)
Redis中设置值,默认为不存在则创建, 存在则修改
# ex 过期时间(s)
# px 过期时间(ms)
# nx 如果为True,name不存在时set才操作(set只支持新增)
# xx 如果设置为True,name存在时, set才操作(set只支持修改)
```

- 批量操作
mset
```
mset(*args, **kwargs)
r.mset(k1="v1", k2="v2")  # 这里k1 k2不能带引号,一次设置多个键值对
```

mget
```
mget(keys, *args)
r.mget("k1", 'k2')
r.mget(["k1", "k2"])

```

- getset(name, value)  # 设置新值,并获取旧值
```
r.getset('food', 'barbecue')
```

- getrange(key, start, end)  # 获取子序列
```
r.set("name", "strangename")
r.getrange("name", 0, 3)  # 结果为:stra
```


## redis基本命令Hash

- hset/hget 添加
```
r.hset("hash1", "k1", "v1")
r.hgetnx("hash1", "k2", "v2")  # 只新建
r.hkeys("hash1")  # 取出hash1中所有的keys
r.hget("hash1", "k1") # 去除单个value
```

- hmset/hmget  批量操作

......