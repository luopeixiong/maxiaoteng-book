# 随机浏览器头

运行爬虫时，通常使用随机而正确的请求头,`fake_useragent`这个第三方库可以用来快速实现
```
from fake_useragent import UserAgent
ua = UserAgent()
headers['User-Agent'] = ua.random
```
