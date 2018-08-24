# 部署爬虫

部署爬虫的两种方案:
- 开源方案 Scrapyd
- Scrapy的付费方案: Scrapy Cloud

## Scrapyd 的使用

__服务器部署__

- 安装
```
sudo pip install scrapyd
```

- 启动服务器
```
scrapyd
# 或者
systemctl enable scrapyd
```
>并将scrapyd加入到supervisor来确保始终启用
```

```

- web端访问
> 访问 http://localhost:6800/

- scrapyd配置
> 配置文件位于 ```/etc/scrapyd/scrapyd.conf```
