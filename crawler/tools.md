# 工具篇

## 1. 抓包工具
1. Chrome 开发者工具(推荐)
2. Tamper Chrome(可以拦截请求，修改后继续请求)
3. Tamper Data(Firefox上的，和2类似)
4. Fiddler(chrome开发者工具无法实现的功能再用)

## 2. HTTP请求库
1. requests(可以代替python原生的请求库)
2. httpie(命令行库)
3. curl
4. aiohttp(支持异步io的库)
5. hyper(支持http2的库)

## 3. 页面解析
1. lxml(推荐lxml和xpath结合使用)
2. BeautifulSoup(bs4)(推荐配合lxml使用)
3. pyquery(不推荐)
4. html5lib(不常用)


## 4. 动态网站加载
1. chromedrier + Chrome + selenium (使用无界面模式降低资源占用)
2. Phantomjs(已被无界面的Chrome替代)

## 5. 爬虫代理
防止被ban的技巧
    1. 并发逐步增加，参考scrapy，大致了解对方网站对并发的限制情况
    2. 使用代理ip
