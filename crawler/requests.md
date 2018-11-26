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
