## 1. Redis命令参考
1. [官网提供的可搜索的命令](https://redis.io/commands)
2. [翻译中文文档](https://wizardforcel.gitbooks.io/redis-doc/)

# 1. Python连接Redis
[源代码](https://github.com/andymccurdy/redis-py)

## 1. redis连接
redis提供两个类Redis和StrictRedis, StrictRedis用来实现大部分官方的命令,并使用官方的语法和命令,Redis是StrictRedis的子类,用于向后兼容旧版本的redis-py.

redis连接实例是线程安全的,可以直接将redis设置为全局变量,直接使用.

**安装redis依赖**
```
sudo pip install redis
```

连接redis时,加上decode_response=True,写入的键值对中的value为str类型,不加这个参数写入的则为字节类型.

```
import redis
r = redis.StrictRedis(host='localhost', port=6379, password='xxx', decode_responses=True, db=0)   # host是redis主机，需要redis服务端和客户端都启动 redis默认端口是6379, 密码验证
r.set('name', 'junxi')  # key是"foo" value是"bar" 将键值对存入redis缓存
print(r['name'])
print(r.get('name'))  # 取出键name对应的值
print(type(r.get('name')))
```

## 2. 连接池

默认,每个Redis实例都会维护一个自己的连接池.可以直接建立一个连接池,实现多个Redis实例共享一个连接池
```
import redis    # 导入redis模块，通过python操作redis 也可以直接在redis主机的服务端操作缓存数据库

pool = redis.ConnectionPool(host='localhost', port=6379, password='xxx', decode_responses=True)   # host是redis主机，需要redis服务端和客户端都起着 redis默认端口是6379
r = redis.StrictRedis(connection_pool=pool)
r.set('gender', 'male')     # key是"gender" value是"male" 将键值对存入redis缓存
print(r.get('gender'))      # gender 取出键male对应的值
```


## 3. 创建Redis对象时，支持一些参数
1. host
2. port
3. password
4. db   # 选择存到第几个数据库
5. socket_timeout=None  # 超时时间  
6. connection_pool=None #  可以直接使用连接池 
7. charset='utf-8'  # redis入库默认utf-8，如果需要编码，结果第八项使用 
8. decode_responses=False   # 修改编码，这一项为True，(charset='GBK ', decode_responses=True)
9. errors='strict' 
10. unix_socket_path=None


# 2. redis 数据操作
参考教程：https://www.w3cschool.cn/redis_all_about/redis_all_about-jrvk26ug.html

## 1. redis key操作

1. 列出所有key
    ```
    1. r.keys()
    2. keys * # redis-cli
    ```
2. 判断某个key是否存在
    ```
    1. r.exists('key')
    2. exists key # redis-cli
    ```
3. 删除指定的key
    ```
    1. r.delete('key')
    2. del key1 key2 ... # redis-cli
    ```
4. 返回指定key的value类型
    ```
    1. r.type('key')
    2. type key # redis-cli (none不存在，string，list，set)
    ```
5. 随机取一个key
    ```
    1. r.randomkey()
    2. randomkey # redis-cli
    ```
6. 重命名一个key
    ```
    1. r.rename('key1', 'key2' ), r.renamenx('key1', 'key2')
    2. rename oldkey newkey | renamenx oldkey newkey  # redis-cli 区别，前面的如果newkey存在，则会被覆盖，后面的则会返回错误
    ```
7. key的超时设置
    ```
    1. r.rename('key1', 'key2' ), r.renamenx('key1', 'key2')
    2. redis-cli
        - expire key seconds    单位是秒。返回1成功，0表示key已经设置过过期时间或者不存在。如果想消除超时则使用persist key。如果希望采用绝对超时，则使用expireat命令。
        - ttl key   返回设置过过期时间的key的剩余过期秒数 -1表示没有设置过过期时间，对于不存在的key,返回-2。
        - pexpire key mseconds 设置生命周期。
        - pttl  key 以毫秒返回生命周期。
    ```


## 2. redis String 操作

1. 设值
    - set 单个值
    ```
    r.set(name, value, ex=None, px=None, nx=False, xx=False)
    Redis中设置值,默认为不存在则创建, 存在则修改
    # ex 过期时间(s)
    # px 过期时间(ms)
    # nx 如果为True, name不存在时set才操作(set只支持新增)
    # xx 如果设置为True, name存在时, set才操作(set只支持修改)
    ```
    - mset 批量添加
    ```
    # 支持两种方式
    mset(*args, **kwargs)
    r.mset(k1="v1", k2="v2")  # 这里k1 k2不能带引号,一次设置多个键值对
    r.mset({"k1:"v1", "k2":"v2"})  # 这里k1 k2不能带引号,一次设置多个键值对
    ```

2. 取值
    - get 获取单个值
    ```
    r.get('useful_proxy')
    ```

    - mget 批量获取
    ```
    # 同样支持两种
    mget(keys, *args)
    r.mget("k1", 'k2')
    r.mget(["k1", "k2"])
    ```

3. 读取后重设
    - getset(name, value)  # 设置新值,并获取旧值
    ```
    r.getset('food', 'barbecue')
    ```

4. 增减操作，如果value不是int，则错误
    ```
    r.incr('key')   # 加1 不存在默认为0  
    r.decr('key')   # 减1
    r.incrby('key', 5)   #   
    r.decrby('key', 4)   # 也可以加一个负数实现
    r.incrbyfloat('key', 5.1)   # 增减浮点数
    ```

5. 追加，截取和改写 字符串
    ```
    r.set("name", "strangename")
    r.append('name', 'afterfix')    # 追加：结果为strangenameafterfix
    r.getrange("name", 0, 3)  # 改写：结果为:stra
    r.substr('name', 2, 4)  # 截取，不修改值，结果为：ran
    ```

6. 获取字符串长度
    ```
    r.strlen('key')
    ```


## 3. redis list 操作

1. 添加列表
    ```
    r.lpush('list', '1')    # 左push 右pop 江湖规矩
    r.lpushx('list', '1')    # 如果存在才push
    r.linsert(name, where, refvalue, value)    # 特定位置插入（after，before）
    ```

2. 查看长度
    ```
    r.llen('list')   
    ```

3. 查看元素
    ```
    r.lindex('list', 0)  # 返回特定位置的元素
    ```

4. 查看一段列表
    ```
    r.lrange('list', 0, -1) # 返回一段列表，这个返回全部列表
    ```

5. 截取列表
    ```
    N = r.ltrim('list', '0','2')    # 截取一段列表，改写，返回删掉的元素个数
    ```

6. 删除元素
    ```
    r.lrem('list', count, value)    # 删除value的值，count为删除的个数，正数从左删除，负数从右删除
    r.lpop('list')  # 删除左侧第一个元素 
    r.rpop('list')  # 
    ```

7. 指定某个下标的值
    ```
    r.lset('list', 0, '5')  # 返回Ture
    ```
    
8. 阻塞队列
    ```
    blpop key1...keyN timeout   # 从左到右扫描返回对第一个非空list进行lpop操作并返回，比如blpop list1 list2 list3 0 ,如果list不存在list2,list3都是非空则对list2做lpop并返回从list2中删除的元素。如果所有的list都是空或不存在，则会阻塞timeout秒，timeout为0表示一直阻塞。当阻塞时，如果有client对key1...keyN中的任意key进行push操作，则第一在这个key上被阻塞的client会立即返回（返回键和值）。如果超时发生，则返回nil。有点像unix的select或者poll。
    ```

## 4. redis set 操作

1. 所有操作
    ```
    # 1. 添加元素
    r.sadd('set', '1s')    # 成功返回1， 已存在返回0，key不对应set则返回错误

    # 2. 移除元素
    r.srem('set', '1s')    # 成功返回1， 不存在返回0，key不对应set则返回错误

    # 3. 删除并返回元素
    r.spop('set')    # 不存在报错

    # 4. 随机取一个元素, 但不删除
    r.srandmember('set')    # 不存在报错

    # 5. 集合间移动元素
    r.smove('set1', 'set2', 'member') 

    # 6. 查看集合大小
    r.scard('set')

    # 7. 判断是否在集合中
    r.sismember('set', '2s')

    # 8. 求交集
    r.sinter('set', 'set2')
    r.sinterstore('new-set', 'set', 'set2') # 将交集保存在新的集合中
    
    # 9. 求并集
    r.sunion('set', 'set2')
    r.sunionstore('new-set', 'set', 'set2') # 将并保存在新的集合中

    # 10. 求差集
    r.sdiff('set', 'set2')
    r.sdiffstore('new-set', 'set', 'set2') # 将差集保存在新的集合中

    # 11. 查看所有元素
    r.smembers('new-set')
    ```

## 5. redis Sorted Set 操作

## 6. redis Hash(dict) 操作

1. 所有操作
    ```
    # 1. 设置hash值
    r.hset('hash', 'key1', 'value1')    # 成功返回1， field已存在则修改，key不对应hash则返回错误
    r.hsetnx('hash', 'key1', 'value1')    # nx 是no exist，如果field存在，返回0，不修改
    r.hmset('hash', 'key1', 'value1', 'key2', 'value2')    # 批量设置多个值
    
    # 2. 获取hash值
    r.hget('hash', 'key1')    # 
    r.hmget('hash', 'key1', 'key2')    # 批量获取多个值

    # 3. 递增某个域的值
    r.hincrby('hash', 'key1', 2)    # 不是int抛出错误

    # 4. 判断某个区域是否存在
    r.hexists('hash', 'key1')    # 

    # 5. 删除
    r.hdel('hash', 'key1') 

    # 6. 查看域的大小
    r.hlen('hash')

    # 7. 获取所有域名
    r.hkeys('hash')

    # 8. 获取所有域的值
    r.hvals('hash')
    
    # 9. 获取整个dict
    r.hgetall('hash')
    ```