
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




## 获取集合

```
def get_collection(self, name):
    collection = self.db[name]
    # collection = self.db.name
    # 获取集合时, 如果name == 'test'
    # 也可写成: collection = self.db.test
```

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
```

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


