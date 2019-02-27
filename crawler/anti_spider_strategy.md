# 反爬虫策略 Anti-spider strategy

1. 通过header
    1. User-Agent, Cookie, Referer
2. 访问行为(比如高并发)
3. JavaScript动态计算
4. 验证码
5. 蜜罐(设置一些普通用户访问不到的内容)
6. 识别到爬虫，返回假数据