# pycryptodome 模块

## 简介

[pycrypto to pycryptodome](https://blog.sqreen.com/stop-using-pycrypto-use-pycryptodome/)

## 安装
```
# 版本影响使用
sudo pip install pycryptodome==3.9.8
```

## 1. AES
1. demo
    ```python
    from Crypto.Cipher import AES
    import base64

    def decode_ecs_nio(res='', key='kcc$[41_fpqxxxxx'):
        # 如果key位数不够, 补齐
        while len(key) % 16 != 0:
            key += '\0'
        cipher = AES.new(key.encode(), AES.MODE_ECB)
        result = base64.b64decode(res)
        res_text = cipher.decrypt(result)
        return res_text
    ```