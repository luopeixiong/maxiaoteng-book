# Scrapy优化

## 增大并发数

```
# Configure maximum concurrent requests performed by Scrapy (default: 16)
CONCURRENT_REQUESTS = 32
```

## 降低日志级别

```
LOG_LEVEL = 'INFO'
```

## 增大线程池

```
REACTOR_THREADPOOL_MAXSIZE = 20
```

## 禁用cookie
```
# Disable cookies (enabled by default)
COOKIES_ENABLED = True
```

## 自动调整负载


```
# Enable and configure the AutoThrottle extension (disabled by default)
# See https://doc.scrapy.org/en/latest/topics/autothrottle.html
AUTOTHROTTLE_ENABLED = True
# The initial download delay
AUTOTHROTTLE_START_DELAY = 5
# The maximum download delay to be set in case of high latencies
AUTOTHROTTLE_MAX_DELAY = 60
# The average number of requests Scrapy should be sending in parallel to
# each remote server
AUTOTHROTTLE_TARGET_CONCURRENCY = 1.0
# Enable showing throttling stats for every response received:
AUTOTHROTTLE_DEBUG = False
```