# 随机User Agent

1. 运行爬虫时，通常使用随机而正确的请求头,`fake_useragent`这个第三方库可以用来快速实现
```
from fake_useragent import UserAgent
ua = UserAgent()
headers['User-Agent'] = ua.random
```

2. 访问移动网页时，需要加移动的浏览器头，android和ios
https://developers.whatismybrowser.com/useragents/explore网站提供了所有的user-agent

```
mobile_user_agents = [...]
def get_ua(is_mobile=False):
    return random.choice(mobile_user_agents) if is_mobile else ua.random
```