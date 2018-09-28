# setting.py 配置

## 配置数据版本VERSION
```
date = datetime.datetime.now().strftime("%Y-%m-%d")

VERSION = date
```

## 配置item pipelines
```
# Configure item pipelines

ITEM_PIPELINES = {
   'mangoplate_scrapy.pipelines.MangoplateScrapyPipeline': 300,
}
```

## 关闭robots.txt遵循
```
# Obey robots.txt rules
ROBOTSTXT_OBEY = False
```

## 配置自动限速

下载延迟计算: 通过计算建立TCP连接到接收HTTP header之间的时间来测量的.

自动计算来确定合理的延迟和并发数, 注意: 
- 'CONCURRENT_REQUESTS_PER_DOMAIN' 计算出的并发不高于预设置的
- 'CONCURRENT_REQUESTS_PER_IP' 计算出的并发不高于预设置的
- 'DOWNLOAD_DELAY' 计算出的延迟不会低于预设置的

```
# Enable and configure the AutoThrottle extension (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/autothrottle.html
AUTOTHROTTLE_ENABLED = True  # 启用自动限速扩展
# The initial download delay
AUTOTHROTTLE_START_DELAY = 5  # 初始下载延迟
# The maximum download delay to be set in case of high latencies
AUTOTHROTTLE_MAX_DELAY = 60 # 高延迟情况下最大的下载延迟
# The average number of requests Scrapy should be sending in parallel to each remote server
AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0  # 开启时的并发
# Enable showing throttling stats for every response received:
AUTOTHROTTLE_DEBUG = False  # debug模式, true将会展示每个接收到的response, 可以查看限速参数是如何调整的.
```

## log配置
```
cur_dir = os.path.dirname(os.path.realpath(__file__))
logFilename = os.path.join(cur_dir, '../../crawlerOutput/{}/log/roundmenu.log'.format(VERSION))
logging.basicConfig(
  level=logging.ERROR,  # 定义输出到文件的log级别，
  format='%(asctime)s  %(filename)s : %(levelname)s  %(message)s',  # 定义输出log的格式
  datefmt='%Y-%m-%d %A %H:%M:%S',  # 时间
  filename=logFilename,  # log文件名
  filemode='a')

FEED_EXPORT_ENCODING = 'UTF-8'
```
