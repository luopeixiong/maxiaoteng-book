# My Awesome Book


## 爬虫笔记待完善
- redis  组建消息队列, 作为分布式爬虫的一部分
- 打通scrapy_redis  
- 网页解析添加 xpath, lxml, scrapy_selector  
> xpath  
> lxml  
> scrapy_selector  
- 实现一次模拟登陆
- 使用docker快速部署爬虫? 
- 启动百度百科的爬虫, 实现过程结构化: 
- google爬虫也算


[] git 自动同步代码  


## gitbook的插件
book.json中不能有注释， 注释在这里
// 安装插件  
// 1. 折叠目录， 2. 分块显示 3. 自由移动目录侧 
```json
"plugins": ["toggle-chapters", "sectionx", "splitter"]
```

```python
# 安装插件
gitbook install
```
- 目录前面加序号
```json
"theme-default": {
        "showLevel": true
    },
```