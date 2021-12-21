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
2. AES/CBC/PKCS5Padding加密, CBC加密需要一个十六位的key(密钥)和一个十六位iv(偏移量)
    1. Java实现
        ```Java
        # 可以发现加密类型, 需要数据块/密码/偏移量/数据字符集 参考nio
        # Cipher instance = Cipher.getInstance("AES/CBC/PKCS5Padding");
        public static final String a(String str, String str2, String str3) {
            Intrinsics.b(str2, "key");
            Intrinsics.b(str3, "ivValue");
            try {
                byte[] bytes = str2.getBytes(b);
                Intrinsics.a((Object) bytes, "(this as java.lang.String).getBytes(charset)");
                SecretKeySpec secretKeySpec = new SecretKeySpec(bytes, "AES");
                Cipher instance = Cipher.getInstance("AES/CBC/PKCS5Padding");
                byte[] bytes2 = str3.getBytes(b);
                Intrinsics.a((Object) bytes2, "(this as java.lang.String).getBytes(charset)");
                instance.init(2, secretKeySpec, new IvParameterSpec(bytes2));
                byte[] decode = Base64.decode(str, 0);
                Intrinsics.a((Object) decode, "Base64.decode(str,Base64.DEFAULT)");
                byte[] doFinal = instance.doFinal(decode);
                Intrinsics.a((Object) doFinal, "cipherByte");
                return new String(doFinal, b);
            } catch (Exception e) {
                return "";
            }
        }
        ```
    2. Python
        ```python
        import base64
        from Crypto.Cipher import AES
        from Crypto import Random
        
        def encrypt(data, key, iv):
            pad = lambda s: s + (bs - len(s) % bs) * chr(bs - len(s) % bs)
            cipher = AES.new(key, AES.MODE_CBC, iv)
            data = cipher.encrypt(pad(data))
            data = iv + data
            return (data)
        
        def decrypt(data, key, iv):
            bs = AES.block_size
            if len(data) <= bs:
                return (data)
            unpad = lambda s : s[0:-ord(s[-1])]
            cipher = AES.new(data, AES.MODE_CBC, iv)
            data  = unpad(cipher.decrypt(data))
            return data
        
        if __name__ == '__main__':
            data = 'd437814d9185a290af20514d9341b710'
            password = '78f40f2c57eee727a4be179049cecf89' #16,24,32位长的密码
            encrypt_data = encrypt(data, password)
            encrypt_data = base64.b64encode(encrypt_data)
            print ('encrypt_data:', encrypt_data)
        
        
            encrypt_data = base64.b64decode(encrypt_data)
            decrypt_data = decrypt(encrypt_data, password)
            print ('decrypt_data:', decrypt_data)

        ```