# urllib 

[AttributeError: module 'urllib' has no attribute 'parse'](https://stackoverflow.com/questions/41501638/attributeerror-module-urllib-has-no-attribute-parse)

1. 构造请求
    ```
    import urllib.parse
    # &后面的组合生成
    urllib.parse.urlencode(query_data, doseq=True)  # query_data是一个dict
    # 如果一个key中是list，doseq可以确保正确的编码

    # 如果需要构造cookie或其他内容，需要对单独的str编码
    urllib.parse.quote(str)
    # 默认将空格转码成%20， 如果需要转成`+`,使用下面的  
    urllib.parse.quote_plus(str)
    [+和%20的区别](https://stackoverflow.com/questions/2678551/when-to-encode-space-to-plus-or-20/2678602)
    ```

2. 解析请求
    ```
    urllib.parse.parse_qs('age=23&name=%E5%BC%A0%E4%B8%89')
    {'age': ['23'], 'name': ['张三']}

    urllib.parse.parse_qsl('age=23&name=%E5%BC%A0%E4%B8%89')
    [('age', '23'), ('name', '张三')]

    # 解析字符串
    urllib.parse.unquote(query)
    ```