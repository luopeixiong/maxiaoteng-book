# Proxy 代理

## 普通代理
1. requests使用代理
```
import requests
proxies = {
    'http': 'http://127.0.0.1:1080',
    'https': 'https://127.0.0.1:1080',
}
requests.get('http://example.com', proxies=proxies)
```

## 隧道代理

建立TCP连接