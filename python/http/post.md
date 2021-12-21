# POST

HTTP协议中的post请求，由状态行、请求头(headers)和消息主体(entity-body)组成  
post的消息主体（entity-body）的说明
消息主体(entity-body)是在HTTP协议中规定，以ASCII码传输，但协议没有规定使用何种编码，所以POST请求包含了Content-Type(编码说明)和entity-body(消息主体)两部分


Content-Type样式： 

- x-www-form-urlencoded
    ```
    # headers样式
    # 消息主体发送浏览器form表单，消息主体进行url编码
    headers = {
        'Content-Type':'application/x-www-form-urlencoded'
    }
    # url编码后的样式
    title=test&sub%5B%5D=1&sub%5B%5D=2&sub%5B%5D=3
    ```
  - requests样式
    ```Python
    import requests
    payload = {}  # 一个字典，requests在发送时会自动编码
    res = requests.post(url=url, data=payload)
    ```
  - requests发送list
    ```Python
    payload = (('key1', 'value1'), ('key1', 'value2'))
    r = requests.post('http://httpbin.org/post', data=payload)
    >"form": {
    >    "key1": [
    >      "value1",
    >      "value2"
    >    ]
    >  },
    ```

- application/json
    ```
    # headers样式
    # 消息主题是序列化后的JSON字符串
    headers = {
        'Content-Type':'application/json'
    }
    ```
    - requests样式
        ```Python
        import requests
        payload = {}  # 一个字典，requests在发送时会自动编码
        r = requests.post(url, data=json.dumps(payload))        
        ```

- multipart/form-data


- text/xml