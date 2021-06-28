# 代理服务器（Proxy server）
[TOC]

## 1. 使用Squid配置代理服务器

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

## 2. 爬虫使用代理

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
            proxyUser = "HUxxGD"
            proxyPass = "60xx35"
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

# 搭建4G代理
参考:
    1. [https://cuiqingcai.com/7540.html](https://cuiqingcai.com/7540.html)
    2. [https://blog.csdn.net/u012731379/article/details/78744757](https://blog.csdn.net/u012731379/article/details/78744757)
## 1. 工具:
1. 4G上网卡()
2. 宿主机linux
3. docker, centos7
## 2. docker配置, 单个docker容器实现一个网卡的代理
1. 启动demo
    ```shell
    # 启动容器
    docker run -it -d --name demo --privileged -p 3128:3128 -v /dev/bus/usb:/dev/bus/usb centos:7 bash
    # - v 映射宿主机usb到容器, 其实开了特权模式就不需要了
    # 进入容器
    docker exec -it demo bash
    ```
2. 配置
    ```shell
    ## docker
    # 删掉 -net 0.0.0.0 eth0 的路由, 不然拨号之后无法上网
    route del -net 0.0.0.0 eth0
    # 安装必要的服务
    apt install  net-tools wvdial squid vim
    # 不是必要的服务
    apt install iputils-ping

    # 配置 wvdial: vim /etc/wvdial.conf
        # 可以新加一组配置, [Dialer SG75-01]
        [Dialer SG75-01]
        Init1 = ATZ
        Init2 = ATQ V1 E1 S0=0 &C1 &D2 +FCLASS=0
        Init3 = ATE0V1
        Init4 = ATS0=0
        Init5 = AT+CGDCONT=1, "IP", "3GNET"
        # 这里 APN Init5中的 3GNET, 所以可以不填
        # APN = 3GNET
        Init6 = AT+CFUN=1
        Modem Type = Analog Modem
        # 波特率常见是 9600, 115200, 460800
        Baud = 115200
        New PPPD = yes
        # Modem 一般为一组 ttyUSB* 中的第一个
        Modem = /dev/ttyUSB0
        ISDN = 0
        Phone = *99#
        # 用户名, 密码可以不填
        Username = username
        Password = password
        Stupid Mode = 1
    # wvdial拨号, 可以配置多组
    wvdial SG75-01

    # 配置 squid
    # 代理访问授权
    echo "http_access allow all" > /etc/squid/squid.conf.tmp
    cat /etc/squid/squid.conf >> etc/squid/squid.conf
    mv /etc/squid/squid.conf.tmp /etc/squid/squid.conf
    # 关闭一些 header
    echo "via off" >> /etc/squid/squid.conf
    echo "forwarded_for delete" >> /etc/squid/squid.conf
    # 等同下面的方式
    echo "request_header_access Via deny all" >> /dev/squid/squid.conf
    echo "request_header_access X-Forwarded-For deny all" >> /dev/squid/squid.conf
    # 设置超时
    echo "request_timeout 2 minutes" >> /etc/squid/squid.conf
    echo "write_timeout 2 minutes" >> /etc/squid/squid.conf
    echo "read_timeout 2 minutes" >> /etc/squid/squid.conf
    # 关闭日志/缓存
    echo "access_log none" >> /dev/squid/squid.conf
    echo "cache_store_log none" >> /dev/squid/squid.conf
    echo "cache_log /dev/null" >> /dev/squid/squid.conf
    echo "logfile_rotate 0" >>  /dev/squid/squid.conf
    # 下面两个配置高版本不兼容, 低版本可以用
    echo "cache_dir no-store " >> /dev/squid/squid.conf
    echo "cache_mem 0MB" >> /dev/squid/squid.conf

    # 更改默认路由, 默认使用4G的网卡上网
    # 如果没有改默认路由的话，在不指定网卡的情况下，4G 网卡并不会被使用到，因为默认路由指向的是 Docker 自身的虚拟网卡，那个网卡通向你原本的内网环境。也就是说，IP 不会变
    route del -net 0.0.0.0 eth0
    route add -net 0.0.0.0 ppp0
    ```
3. 打包
    ```shell
    # 列出在运行的容器
    docker ps 
    # 把运行中的 docker 做的修改, 提交成一个镜像
    docker commit -m='wvdial_4G_centos' --author='xiaoteng' d5e87290836d xiaoteng/wvdial_4g:v1
    # 使用自定义提交的镜像运行容器
    docker run -it -d --name for_4g_1 -privileged xiaoteng/wvdial_4g:v1 bash
    # 如果需要在别的机器上运行, 可以直接导出镜像文件
    # 导出镜像
    docker export 82xxxxx > wvdial_4G_v1.image
    # 导入镜像文件
    docker import wvdial_4G_v1.image zhipeng/wvidal:v1
    # 或者保存镜像
    docker save 82xxxxx > wvdial_4G_v1.image
    docker load wvdial_4G_v1.image
    ```
4. 启动流程


## 3. 直接从python脚本实现随机选择网卡
1. 参考
    1. [https://stackoverflow.com/questions/12585317/requests-bind-to-an-ip](https://stackoverflow.com/questions/12585317/requests-bind-to-an-ip)
    2. [https://blog.csdn.net/u012731379/article/details/78711549](https://blog.csdn.net/u012731379/article/details/78711549)

