## 数据库 pymongo

### 连接

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

### 查看数据库信息

**查看数据库的文档**
```
db.collection_names(include_system_collections=False)
```

---


## 集合操作

### 获取集合

```
def get_collection(self, name):
    collection = self.db[name]
    # collection = self.db.name
    # 获取集合时, 如果name == 'test'
    # 也可写成: collection = self.db.test
```

### 删除集合
```
name = 'test'
db.drop_collection(name)
// 或者 

collection = db[name]
collection.drop()  # 成功返回true
```

### 统计
```
num = collection.count_documents()   # 集合的count() 方法返回集合中文档的个数

```

--- 
## 文档操作

### 1. 插入文档

**插入一条**
```
item = {
    'name': 'xxx',
    'age': 22
}

insert_id = collection.insert_one(item).inserted_id  
// 返回InsertOneResult实例, 就是item增加了inserted_id, 最终返回: ObjectId('...')
```

**批量插入**
```
items = [
    {...}, 
    {...},
    ...
]
result = collection.insert_many(items)
// result 是一个InsertManyResult实例
```

**批量不重复插入**
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

### 3. 查询文档

**查询第一条**
```
query = {
    'kk': 'vv',
    ...
}
collection.find_one(query)
// 返回一个dict, 没有符合条件, 返回None
```

**查询多条**
```
result = collection.find(query)
// result 是一个可迭代的Cursor对象, 可用for遍历

num = result.count()   # Cursor有一个count方法, 返回查询结果的个数
```

**范围查询**

```
query = {
    "date": {
        "$lt": d,   # 表示查询 d日期之后的文档
    }
}
result = collection.find(query)  # 查询结果
result.sort('name')  # 升序排序
result.sort('name', -1)  # 降序排序

```

### 4. 删除

**删除一条**
```
query = {"name": "maxiaoteng"}
collection.delete_one(query)  # 删除符合条件的第一条
```

**删除多条**
```
query = {
    "name": {
        "$regex": "^F"  # 使用正则表达式:name中以F开头的
    }
}
x = collection.delete_many(query)
count = x.deleted_count  # 返回删除文档的个数
```

**删除所有**  
query = {}  # 即可

---

## 索引

添加索引可以加快速度
```
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
        "$regex": "^f",   # 以f开头的
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
- 