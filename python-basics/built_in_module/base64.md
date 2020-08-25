# base64

base64 是一种用 64 个字符来表示任意二进制数据的方法

1. demo
```Python
import base64

def get_base64_code(file_path):
    with open(file_path, 'rb') as f:  # 以二进制读取图片
        data = f.read()
        encodestr = base64.b64encode(data) # 得到 byte 编码的数据
        return encodestr

def base64_decode(base64_code, file_path):
    with open(file_path, 'wb') as f:  # 以二进制读取图片
        f.write(base64.b64decode(base64_code))
```