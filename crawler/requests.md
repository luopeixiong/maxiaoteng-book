# Requests

- get请求的参数dict
```
params = {}
res = requests.get(params=params)
```

- cookies 参数,dict
```
cookies = {
    XX
    ...
}
res = requests.get(cookies=cookies)
```

- post请求的data参数, dict
```
body = {}
res = requests.post(data=body)  #如果是json,则使用json.dumps()
```


## cookies的使用
```
    cookies = response.cookies   # cookies类型: <class 'requests.cookies.RequestsCookieJar'>
    cookies = response.cookies.get_dict()   # cookies 返回, <class 'dict'>
    cookies['sig'] = tmp_cookies.get('sig') # 可以使用get拿取需要的cookie
    res = requests.post(url=post_url, data=data, cookies=cookies)   # 包含cookies访问
```