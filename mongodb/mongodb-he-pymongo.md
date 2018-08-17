
## 连接

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

## 查看数据库信息

**查看数据库的文档**
```
db.collection_names(include_system_collections=False)
```
---

## 集合

**获取集合**

```
def get_collection(self, name):
    collection = self.db[name]
    # collection = self.db.name
    # 获取集合时, 如果name == 'test'
    # 也可写成: collection = self.db.test
```

**删除集合**
```
name = 'test'
db.drop_collection(name)
或者

collection = db[name]
collection.drop()  # 成功返回true
```


## 统计
```
num = collection.count()   # 集合的count() 方法返回集合中文档的个数

```

---

## 插入文档

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

---

## 查询文档

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
result = collection.find(query).sort('name')  # 查询结果按照'name'的值排序
```

---

## 删除

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

query = {
    'age': {
        "$gt": 25,  # 大于25岁
    }
}

