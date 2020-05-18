# 数据库 pymongo


## 1. 数据库操作
### 1. 连接

- **默认连接**  

```
dbconfig = {
    'host': MONGODB_SERVER,
    "port": MONGODB_PORT,
    'database': MONGODB_DATABASE,
}

class Mongodb(object):

    # 初始化
    def __init__(self, dbconfig):
        self.host = dbconfig.get('host')
        self.port = dbconfig.get('port')
        self.database = dbconfig.get('database')
        self._client = pymongo.MongoClient(self.host, self.port)
        self._db = self._client[self.database]


    # 退出
    def __exit__(self):
        self._client.close()
```

 - **用户名密码连接**
 
> 方法1  

```
client = pymongo.MongoClient(host, port)
db = client.mydb
db.authenticate(user, password)

```
> 方法2  

```
uri = "mongodb://{username}:{password}@{host}:{port}/{db_name}?authMechanism=MONGODB-CR".format(username=user_name,password=user_pwd,host=host,port=port,db_name=db_name)
mongo_client = pymongo.MongoClient(uri)
mongo_db = mongo_client[db_name]
mongo_coll = mongo_db[coll_name]
```
     
 - **密钥连接 **
 
 

### 2. 查看数据库信息

**查看数据库的文档**
```
db.collection_names(include_system_collections=False)
```

---

# 2. 集合操作

### 1. 获取集合

```
def get_collection(self, name):
    collection = self.db[name]
    # collection = self.db.name
    # 获取集合时, 如果name == 'test'
    # 也可写成: collection = self.db.test
```

### 2. 删除集合
```
name = 'test'
db.drop_collection(name)
// 或者 

collection = db[name]
collection.drop()  # 成功返回true
```

### 3. 统计
```
num = collection.count_documents()   # 集合的count() 方法返回集合中文档的个数

num = collection.find(query),count()  # 和上面的速度是一样快的

num = collection.update_many(...).modified_count()  # 查看更新操作修改了多少行

num = collection.deleted_many(...).deleted_count()  # 查看操作删除了多少行

num = collection.insert_many(...).inserted_count()  # 查看插入了多少行

```

--- 
## 3. 文档操作

### 1. 插入文档

1. **插入一条**
    ```
    item = {
        'name': 'xxx',
        'age': 22
    }

    insert_id = collection.insert_one(item).inserted_id  
    // 返回InsertOneResult实例, 就是item增加了inserted_id, 最终返回: ObjectId('...')
    ```

2. **批量插入**
    ```
    items = [
        {...}, 
        {...},
        ...
    ]
    result = collection.insert_many(items)
    // result 是一个InsertManyResult实例，支持迭代
    # 如果插入时数据库有唯一约束，可以添加ordered为无序，使用try except来忽略重复插入的异常，其他的就可以继续插入
    result = collection.insert_many(items, ordered=False)
    ```

3. **批量不重复插入**
    ```
    for r in rs:
        query = {
            "unique_colum": r.get('unique_colum'), 
        }
        update = {
            "$set": r,
        }
        rs = collection.find_one_and_update(query, update, upsert=True)
    ```

### 2. 修改
参考： https://blog.csdn.net/user_longling/article/details/52398667
    update共有四个参数：
      - query   # 条件
      - updata  # 更新内容
      - upsert  # 默认false，如果不存在要插入，则为true
      - multi   # 默认false，要修改所有符合条件的查询，则为true

1. 基本操作，
    updata是一个完整的值，将整个document修改

2. 不存在插入，存在则不操作 "$setOnInsert"
3. 修改某个key，有则修改，没有就新增 "$set"
    **修改符合条件的第一条**

    ```
    query = {
        "name": "xxx"
    }

    newvalue = {
        "$set": {
            "name": "sss"
        }
    }
    collection.update_one(query, newvalue)  # 修改单条
    result = collection.update_many(query, newvalue)  # 修改多条
    result.modified_count()   # 返回修改内容的数量
    ```
4. 删除某个键 "$unset"  
5. 增加计算   "$inc"
    ```
        newvalue = {
            "$inc": {
                "key" : 3,  # 或者-7
            }
        }
    ```
6. "$push"  # field的值必须是list
    ```
        updata = {
            "$push": {
                "field": "value",
            }
        }
    ```

7. "pushAll"    # 将list的每个值push进去，和push区别
    ```
        pushall接受list，将每个值放到目标数组中
        如果push一个list，list将作为整体加入到目标数组中
        原始：['aa', 'bb']
        push ['cc', 'dd']   # 结果 ['aa', 'bb'，['cc', 'dd']]
        pushall ['cc', 'dd']   # 结果 ['aa', 'bb'，'cc', 'dd']
    ```

     

### 3. 查询文档

1. **查询第一条**
    ```
    query = {
        'kk': 'vv',
        ...
    }
    collection.find_one(query)
    // 返回一个dict, 没有符合条件, 返回None
    ```

2. **查询多条**
    ```
    result = collection.find(query)
    #　**注意:** 此处返回result类型`<pymongo.cursor.Cursor object at 0x0000000002C6DBE0>`是可迭代对象,可以使用list(result)转换, 也可以使用for循环迭代

    num = result.count()   # Cursor有一个count方法, 返回查询结果的个数
    ```

3. **范围查询**
参考： https://blog.csdn.net/yangguangxiadeshu/article/details/45096007
    ```
    query = {
        "date": {
            # 范围查询
            "$gt": d,   # 大于
            "$lt": d,   # 小于
            "$gte": d,   # 大于等于
            "$lte": d,   # 小于等于
            "$ne": d,   # 不等于
        },
        "value1": {  
            # 并列查询
            "$lt": 20,   # 小于
            "$gte": 3,   # 大于等于
        },
        "value2": {  
            # in or not in
            "$in": [2, 3], 
            "$nin": [2, 3],   
        },
        "value3": {  
            # 取模运算
            "$mod": [10, 1],   # 等价于 value3 % 10 == 1
        },
        "value4": {  
            # list大小
            "$size": 5,   # value4这个list的大小，官网不建议查找size的范围，如果想要找size<5, 建议创建一个字段来保存元素的数量
        },
        "value5": {  
            # 是否存在
            "$exists": true,   # 存在
            "$exists": false,   # 不存在
        },
        "value6": {  
            # 类型判断
            "$type": 2,   # string, 基于bson来判断，
            "$type": 16,   # int
            "$gte": 3,   # 大于等于
        },
        "value7": {  
            # 元素匹配,针对list类型
            "$elemMath":{
                a : 1, 
                b : {
                    "$gt": 2
                }
            }
        },
        "value8.name": {  
            # 嵌入对象查询,直接使用.即可
            "name_target",
        }
    }
    result = collection.find(query)  # 查询结果
    result.sort('name')  # 升序排序
    result.sort('name', -1)  # 降序排序
    ```
4. **随机查询**
    ```
    query = [{
        '$sample': {
            "size": 2,
        },
    }]
    rs = list(collection.aggregate(pipeline=query))
    ```
5. **过滤显示**

    ```
    filter = {
        'id': 0,  # 0表示不显示, 1表示显示, 0和1只能存在一种
        'url': 0,
    }
    result = collection.find({}, filter)
    ```

### 4. 删除

1. **删除一条**
    ```
    query = {"name": "maxiaoteng"}
    collection.delete_one(query)  # 删除符合条件的第一条
    ```

2. **删除多条**
    ```
    query = {
        "name": {
            "$regex": "^F"  # 使用正则表达式:name中以F开头的
        }
    }
    x = collection.delete_many(query)
    count = x.deleted_count  # 返回删除文档的个数
    ```

3. **删除所有**  
    query = {}  # 即可

---

## 4. 创建索引

添加索引可以加快查询速度

   - 使用mongoShell操作，使用`3.0`之后版本
    ```
        # 创建索引，1表示升序，-1表示降序
        # option
        # 1. 创建索引
        db.COLLECTION_NAME.createIndex({"name":1})

        # 2. 组合索引
        db.COLLECTION_NAME.createIndex({"name":1, "age": -1})

        # 3. 后台创建索引
        db.COLLECTION_NAME.createIndex({"name":1, "age": -1}, {"background": 1})

        # 4. 查看索引
        db.COLLECTION_NAME.getIndexes()
        db.COLLECTION_NAME.getIndexkeys()

        # 5. 删除索引,根据name
        db.COLLECTION_NAME.dropIndex("name_1")
        db.COLLECTION_NAME.dropIndex("name_1_age_1")
        db.COLLECTION_NAME.dropIndexes()    # 删除所有索引

        # 6. 创建唯一索引
        db.COLLECTION_NAME.createIndex({"name":1, "age": -1}, {unique: true})

        # 7. 修改索引
        db.COLLECTION_NAME.reIndex({"name":1, "age": -1})
        # 将数据插入带有唯一约束的表中，在insert_many中设置ordered=false

        # pymongo创建
        result = collection.create_index([('user_id', pymongo.ASCENDING)], unique=True)
        // user_id的值为递增, 且唯一, 之后再插入, 则抛出错误
    ```
---
## 同步操作

find_one_and_update
find_one_and_replace
find_one_and_delete

---

## mongodb中的正则表达式

```
query = {
    'name': {
        "$regex": "^f", # 以f开头的
        "$regex": "f",  # 包含f的
    }

}
```
---

## mongodb中的范围查询
```
query = {
    'age': {
        "$gt": 25,  # 大于25岁
    }
}
```
---
## 心得
请使用最新的, 且规范的方法来操作. 比如: 
- 统计使用collection.find().count(), 
- 增删改查使用xx_one 和 xx_many, 模糊的update, insert等已经被弃用. 
- 查询并更新使用find_one_and_update(), delete, replace... 还可以根据参数, 选择返回的是修改前还是修改后的内容
- 避免重复插入的方法: 一个一个插入, 每次插入时使用find_one_and_update(query, update, upsert=True).(即不存在则插入, 存在则更新)


## 值的比较
比较

|  | MongoDB | pymongo |
| -- | -- | -- |
| 1 | true | True |
| 2 | false | False |
| 3 | null/不存在 | None |