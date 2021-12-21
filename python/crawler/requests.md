# Requests

## 1. 请求参数
1. headers
2. proxies

3. get请求的参数dict
```
params = {}
res = requests.get(params=params)
```

4. cookies 参数,dict
```
cookies = {
    XX
    ...
}
res = requests.get(cookies=cookies)
```

5. post请求的data参数, dict
```
body = {}
res = requests.post(data=body)  #如果是json,则使用json.dumps()
```
    - 有个问题, 如果需要发送的body里面有中文, 则会被编码


## 2. cookies的使用
```
    cookies = response.cookies   # cookies类型: <class 'requests.cookies.RequestsCookieJar'>
    cookies = response.cookies.get_dict()   # cookies 返回, <class 'dict'>
    cookies['sig'] = tmp_cookies.get('sig') # 可以使用get拿取需要的cookie
    res = requests.post(url=post_url, data=data, cookies=cookies)   # 包含cookies访问
```

## 3. session的使用
```
    session = requests.Session()
    response = session.get('url')
    session_dict = session.json()  # 返回： {'cookies': {"abc": '123'}}
```

## 4. response
```
r = requests.get('url')
    1. r.text   # 返回的文本 
    2. r.json() # 返回的结果转成JSON格式
    3. r.status_code
    4. r.url
    5. r.request    # 请求对象 
    5. r.request.headers['User-Agent']  # 查看请求头
```