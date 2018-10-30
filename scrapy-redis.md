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

## 可以指定redis数据库到其他位置
[参考位置:https://blog.csdn.net/Bone_ACE/article/details/54139500](https://blog.csdn.net/Bone_ACE/article/details/54139500)
原理: 重写scrapy_redis的调度器: scheduler.py下的from_settings()方法调用

在settings.py同级目录下新建一个文件schedulerOverwrite.py，填入下面的代码。然后在settings.py设置SCHEDULER=schedulerOverwrite.SchedulerSon，之后在settings.py中设置REDIS_DB=XXX即可指定db。
```
import redis
from scrapy_redis.scheduler import Scheduler
from scrapy.utils.misc import load_object
# default values
SCHEDULER_PERSIST = False
QUEUE_KEY = '%(spider)s:requests'
QUEUE_CLASS = 'scrapy_redis.queue.SpiderPriorityQueue'
DUPEFILTER_KEY = '%(spider)s:dupefilter'
IDLE_BEFORE_CLOSE = 0
 
REDIS_URL = None
REDIS_HOST = 'localhost'
REDIS_PORT = 6379
REDIS_DB = 0
 
 
def from_settings(settings):
    url = settings.get('REDIS_URL', REDIS_URL)
    host = settings.get('REDIS_HOST', REDIS_HOST)
    port = settings.get('REDIS_PORT', REDIS_PORT)
    db = settings.get('REDIS_DB', REDIS_DB)

    # REDIS_URL takes precedence over host/port specification.
    if url:
        return redis.from_url(url)
    else:
        return redis.Redis(host=host, port=port, db=db)
 
 
class SchedulerSon(Scheduler):
    @classmethod
    def from_settings(cls, settings):
        persist = settings.get('SCHEDULER_PERSIST', SCHEDULER_PERSIST)
        queue_key = settings.get('SCHEDULER_QUEUE_KEY', QUEUE_KEY)
        queue_cls = load_object(settings.get('SCHEDULER_QUEUE_CLASS', QUEUE_CLASS))
        dupefilter_key = settings.get('DUPEFILTER_KEY', DUPEFILTER_KEY)
        idle_before_close = settings.get('SCHEDULER_IDLE_BEFORE_CLOSE', IDLE_BEFORE_CLOSE)
        server = from_settings(settings)
        return cls(server, persist, queue_key, queue_cls, dupefilter_key, idle_before_close)
```
