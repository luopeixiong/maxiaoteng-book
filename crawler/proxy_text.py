import requests

proxies = {"http": "http://111.198.154.116:8888"}

# res = requests.get('http://www.ip138.com/ips1388.asp', proxies=proxies)
res = requests.get('http://ip.filefab.com/index.php', proxies=proxies)
# res = requests.get('http://www.baidu.com/')
print(res.text)

class ProxyMiddleware(object):
    def process_request(self, request, spider):
        request.meta['proxy'] = 'http://111.111.111.11:8888'


        if request.url.startswith("http://"):
            request.meta['proxy']="http://180.96.27.12:88"          # http代理
        elif request.url.startswith("https://"):
            request.meta['proxy']="http://109.108.87.136:53281"