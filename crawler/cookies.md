# Cookies
[TOC]

## 1. set cookie
1. [requests](./requests.md##1)
2. [scrapy](./Scrapy/request-and-response.md##1)
   1. scrapy 自动管理cookie, 无需过多干预


## 2. get cookie
1. [requests](./requests.md##1)
2. [scrapy](./Scrapy/request-and-response.md##1)

## 3. get set_cookie
    ```
    import requests
    from http.cookies import SimpleCookie
    res = requests.get('https://www.xiaohongshu.com/')
    cookie = SimpleCookie(res.headers.get('Set-Cookie'))
    for i in cookie.values():
        i.key
        i.value
    
    # scrpay
    cookies = response.headers.getlist('Set-Cookie')
    for cookie in cookies:
        cookie = cookie.decode('utf-8')
        cookie_dict = SimpleCookie(cookie)
        for i in cookie.values():
            i.key
            i.value
    ```