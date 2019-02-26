## 爬虫涉及方面

1. 熟悉网页抓取原理和技术
2. 设计爬虫策略和防屏蔽规则
3. 提升网页抓取的效率和质量
4. 分布式抓取架构设计和维护
5. 数据清洗和入库
6. 大数据处理（hadoop、Spark、Hive、HBase、Kaflka）
7. 抓取协议设计与开发

# 工具篇

## 1. 抓包工具
1. Web抓包工具
    1. Chrome 开发者工具(推荐)
    2. Tamper Chrome(可以拦截请求，修改后继续请求)
    3. Tamper Data(Firefox上的，和2类似)
    4. Fiddler(chrome开发者工具无法实现的功能再用)
2. 移动应用抓包
    1. Charles抓包分析http和https请求(推荐)
    2. Fiddler抓包(优先使用上一个)
    3. Mitmproxy(使用python编写，是命令行程序)

## 2. HTTP请求库
1. [requests(可以代替python原生的请求库)](/crawler/requests.md)
2. httpie(命令行库)
3. curl
4. aiohttp(支持异步io的库)
5. hyper(支持http2的库)

## 3. 页面解析
1. [lxml(推荐lxml和xpath结合使用)](/crawler/xpath.md)
2. [BeautifulSoup(bs4)(推荐配合lxml使用)](/crawler/beautifulsoup.md)
3. pyquery(不推荐)
4. html5lib(不常用)


## 4. 动态网站加载
1. [chromedrier + Chrome + selenium (使用无界面模式降低资源占用)](/crawler/selenium.md)
2. Phantomjs(已被无界面的Chrome替代)

## 5. 爬虫代理
防止被ban的技巧  
    1. [并发逐步增加，参考scrapy，大致了解对方网站对并发的限制情况](/crawler/Scrapy/scrapy_optimization.md)
    2. [使用代理ip](/crawler/proxy_server.md)
