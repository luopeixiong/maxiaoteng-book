# 1. 搭建代理服务器（Proxy server）

## 使用Squid

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


## 2. 使用代理

1. requests使用代理
    ```
    import requests
    proxies = {
        "http": "http://53.53.171.25:27233",
        "https": "http://52.56.161.222:27233",
        }
    url = 'http://ip.filefab.com/index.php'
    res = requests.get(url, proxies=proxies)
    ```

2. scrapy使用代理
    1. 第一种，在spier的Request中添加
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

    2. 第二种，scrapy代理使用中间件((参考dianping的配置)
        1. 在中间件中创建proxy，下面展示了接入阿布云代理的方法
        ```
        # 在middlewares.py中增加一个类，取名：ProxyMiddleware即代理中间件
            # 添加阿布云代理
            import base64
            # 代理服务器
            proxyServer = "http://http-dyn.abuyun.com:9020"
            # 代理隧道验证信息
            proxyUser = "HU80498W9ZK49KGD"
            proxyPass = "60DBD202DC5E8F35"
            # for Python2
            # proxyAuth = "Basic " + base64.b64encode(proxyUser + ":" + proxyPass)
            # for Python3
            proxyAuth = "Basic " + base64.urlsafe_b64encode(bytes((proxyUser + ":" + proxyPass), "ascii")).decode("utf8")
            class ProxyMiddleware(object):
                def process_request(self, request, spider):
                    request.meta["proxy"] = proxyServer
                    request.headers["Proxy-Authorization"] = proxyAuth
        ```
        2. settings.py中生效配置的中间件即可
        ```
            DOWNLOADER_MIDDLEWARES = {
                'dianping.middlewares.UAMiddleware': 545,
            }
        ```

