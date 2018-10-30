## Scrapy-Redis

## 设置
```
   ## 以下是redis配置
   
   # 启用Redis调度存储请求队列
   SCHEDULER = "scrapy_redis.scheduler.Scheduler"
   
   # 确保所有的爬虫通过Redis去重
   DUPEFILTER_CLASS = 'scrapy_redis.dupefilter.RFPDupeFilter'
   
   # 请求序列化器
   SCHEDULER_SERIALIZER = "scrapy_redis.picklecompat"
   
   # 不清空Redis队列, 可以暂停/恢复爬虫
   SCHEDULER_PERSIST = True
   
   #使用优先级调度请求队列 （默认使用）
   SCHEDULER_QUEUE_CLASS = 'scrapy_redis.queue.PriorityQueue'
   #可选用的其它队列
   #SCHEDULER_QUEUE_CLASS = 'scrapy_redis.queue.FifoQueue'
   #SCHEDULER_QUEUE_CLASS = 'scrapy_redis.queue.LifoQueue'
   
   # 设置最大等待时间来避免爬虫关闭, 只有在队列是SpiderQueue和SpiderStack是才有效
   SCHEDULER_IDLE_BEFORE_CLOSE = 10
   
   # 在redis中存储爬取的item, 以便于后续处理
   ITEM_PIPELINES = {
      'scrapy_redis.pipelines.RedisPipeline': 300,
   }
   
   # item序列化并保存这些item在此redis 键中
   REDIS_ITEMS_KEY = '%(spider)s:items'
   
   # item序列化默认使用ScrapyJSONEncoder. 你可以使用其他
   REDIS_ITEMS_SERIALIZER = 'json.dumps'
   
   # 指定redis的主机和端口
   REDIS_HOST = 'localhost'
   REDIS_PORT = 6379
   
   # 指定完整的redis连接参数,比如: 超时等
   #REDIS_PARAMS  = {}
   # Use custom redis client class.
   #REDIS_PARAMS['redis_cls'] = 'myproject.RedisClient'
   
   # 如果为true, 将使用redis的spop操作,你必须使用sadd命令来增加urls到redis队列. 
   # 如果你想在start urls的列表避免重复, 并且顺序不重要是可以使用
   REDIS_START_URLS_AS_SET = False
   
   # 默认redis urls的键用于RedisSpider和RedisCrawlSpider
   REDIS_START_URLS_KEY = '%(name)s:start_urls'
   
   # 为redis使用其他编码, 默认utf-8
   # REDIS_ENCODING = 'latin1'
```

## spider部分
- spider继承RedisSpider类
```
from scrapy_redis.spiders import RedisCrawlSpider  # 可以自定义地址过滤, 暂不考虑
from scrapy_redis.spiders import RedisSpider
```
- start_urls
```
# start_urls 来自redis, 位置由redis_key决定, 一般为 spider_name:start_urls
redis_key = 'douban_spider_redis:start_urls'
```

- pipelines
```
# item默认输出到redis一份, 位置: spider_name:items
# 可以改写process_item方法来将item输出成多个格式, 也可以爬完之后再从redis获取
```

