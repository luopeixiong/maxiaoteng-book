# scrapy组件

![](/assets/2816666215-5a25a21f9f37d.png)

## spiders

### 基本用法
作为爬虫的开始  
- 开始:
```
scrapy genspider my_spider baidu.com
```
- 需要实现start_request方法 或存在 start_urls
- request和response中携带meta属性

### 模拟表单请求的FormRequest


### 异常请求的处理

---

## Items 
item用来结构化数据,所有的item都要实现scrapy.Item

- 每个Item为一个类

```python
class RestaurantItem(scrapy.Item):
    # define the fields for your item here like:
    id = scrapy.Field()
    name = scrapy.Field()
```

---
## item pipelines

pipeline用来处理Item对象, 需要实现的方法:
- process_item(self, item, spider)  **必须**
- __init__  **可选**
- from_crawler(cls, crawler)  **可选**
- open_spider(self, spider)  **可选**
- close_spider(self, spider)  **可选**

以官网的MongoPipeline为例:

```python

import pymongo

class MongoPipeline(object):

    collection_name = 'scrapy_items'

    def __init__(self, mongo_uri, mongo_db):
        self.mongo_uri = mongo_uri
        self.mongo_db = mongo_db

    @classmethod
    def from_crawler(cls, crawler):
        return cls(
            mongo_uri=crawler.settings.get('MONGO_URI'),
            mongo_db=crawler.settings.get('MONGO_DATABASE', 'items')
        )

    def open_spider(self, spider):
        self.client = pymongo.MongoClient(self.mongo_uri)
        self.db = self.client[self.mongo_db]

    def close_spider(self, spider):
        self.client.close()

    def process_item(self, item, spider):
        self.db[self.collection_name].insert_one(dict(item))
        return item

```
---
## download middlewares

