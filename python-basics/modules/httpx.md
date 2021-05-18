# httpx

1. demo

    ```python
    import httpx
    import brotli
    headers = {
        # httpx自动添加字段
        # ":method": "GET",
        # ":authority": "teslamotorsclub.com",
        # ":scheme": "https",
        # ":path": "/tmc/online/?type=member",
        "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36",
    }
    with httpx.Client(headers=headers, http2=True, verify=False) as client:
        r = client.get(url, headers=headers)
        if r.status_code == 200:
            if r.headers['Content-Encoding'] == 'br':
                res_text = brotli.decompress(r.content)
            else:
                res_text = r.text()
    ```

2. 说明
    1. httpx自动添加headers中http20所需要的字段
    2. tesla的response使用brotli压缩, 需要特殊处理
