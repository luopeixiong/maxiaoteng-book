## 搭建代理服务器（Proxy server）

### 使用Squid

系统为CentOS
```python
# yum 安装squid
sudo yum -y install squid
# 设置开机启动
sudo chkconfig --level 35 squid on  # 在35级别上自动运行squid服务
# 修改配置文件
sudo vi /etc/squid/squid.conf
    http_access allow !Safe_ports    #deny改成allow
    http_access allow CONNECT !SSL_ports  #deny改成allow
    http_access allow all  #deny改成allow
    http_port 27233  # 默认3128
# 启动Squid
sudo service squid start
```

### requests使用代理
```python
import requests
proxies = {
    "http": "http://53.53.171.25:27233",
    "https": "http://52.56.161.222:27233",
    }
url = 'http://ip.filefab.com/index.php'
res = requests.get(url, proxies=proxies)
```

### scrapy使用代理
- 在Request中添加
```python
# 初始化start_requests
def start_requests(self):
    proxies = {
        "http": "http://53.53.171.25:27233",
        "https": "http://52.56.161.222:27233",
    }
    url = 'http://ip.filefab.com/index.php'
    request = scrapy.Request(url, callback=self.parse)
    if url.startswith("http://"):
        request.meta['proxy']= proxies.get('http')          # http代理
    elif url.startswith("https://"):
        request.meta['proxy']= proxies.get('https')
    yield request
```

- 在中间件（Middleware）中添加
```python
# 在middlewares.py中增加一个类，取名：ProxyMiddleware即代理中间件
class ProxyMiddleware(object):
    def process_request(self, request, spider):
        proxies = {
            "http": "http://53.53.171.25:27233",
            "https": "http://52.56.161.222:27233",
        }
        if request.url.startswith("http://"):
            request.meta['proxy']= proxies.get('http')          # http代理
        elif request.url.startswith("https://"):
            request.meta['proxy']= proxies.get('https')
# 在setting.py中配置
DOWNLOADER_MIDDLEWARES = {
    'XX.middlewares.ProxyMiddleware': 543, # 数字是中间件的执行顺序
}
```
