# Crawler optimization 爬虫优化

1. 并发爬虫
    1. 多线程 
    2. 多进程 
    3. concurrent.futures 
    4. asyncio

2. 使用连接池(urllib3)
    - 实现了连接池和支持数据的压缩
    - 为什么要使用连接池呢？
        保持链接可以节省网络链接的时间和资源
3. 开启gzip
4. 使用消息队列
5. 布隆过滤器(Bloom Filter) 
    - scrapy使用了
    - [参考链接](https://llimllib.github.io/bloomfilter-tutorial/)
    - [结合redis的去重](https://blog.csdn.net/bone_ace/article/details/53107018)
6. 熟悉抓取相关框架的参数 
7. 批量存到数据库 
8. 设置请求超时时间 