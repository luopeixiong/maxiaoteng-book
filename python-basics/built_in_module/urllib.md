# urllib 

1. 构造请求
    ```
    import urllib
    # &后面的组合生成
    urllib.parse.urlencode(query_data)  # query_data是一个dict

    # 如果需要构造cookie或其他内容，需要对单独的str编码
    urllib.parse.quote_plus(str)
    ```

2. 解析请求
    ```
    urllib.parse.parse_qs('age=23&name=%E5%BC%A0%E4%B8%89')
    {'age': ['23'], 'name': ['张三']}

    urllib.parse.parse_qsl('age=23&name=%E5%BC%A0%E4%B8%89')
    [('age', '23'), ('name', '张三')]
    ```