# 编码问题

1. Python3有两种表示字符序列的类:bytes 和 str。 bytes的实例包含8个二进制位，str的实例包含Unicode字符。

2. 转换时必须使用encode和decode操作
3. 编写程序时，通常将编码和解码放在最外围函数，程序的核心代码应该使用Unicode字符类型，而且不要对字符编码做任何假设。
   1. 这样程序可以接受多种类型的文本编码，又保证输出的文本信息只采用一种编码形式
   2. (来自Effective Python)


## 1. 辅助函数
1. to_str
    ```
        def to_str(bytes_or_str):
            if isInstance(bytes_or_str, bytes):
                value = bytes_or_str.decode('utf-8')
            else:
                value = bytes_or_str
            return value
    ```
2. to_bytes
    ```
        def to_bytes(bytes_or_str):
            if isInstance(bytes_or_str, str):
                value = bytes_or_str.encode('utf-8')
            else:
                value = bytes_or_str
            return value
    ```

## 2. 默认编码
1. python3 默认utf-8 仅适用于转字符串, 文件open()根据系统确定默认的编码格式
2. python3的open函数添加了encoding，要求操作接受str实例，如果读写bytes，使用`rb`或`wb`

```
s1 = b'test'
s2 = s1.decode('utf-8')
type(s1) 
>> <class 'bytes'> <class 'str'>
```

## 3. html解析编码依据
```
<head>
    <meta charset="UTF-8">
</head>
```

## 4. 编码判断

1. 字符串
    ```
        import chardet
        body = b'...xxtestxx...'
        encode_info = chardet.detect(body)  # body是bytes类型
        encode_str = encode_info.get('encoding')
        print(encode_info, encode_str)
            >> {'encoding': 'ascii', 'confidence': 1.0, 'language': ''}
        item['body'] = body.decode(encode_str)  # 正确解码为str
    ```

2. 判断文件的编码
    ```
        import chardet
        
        # 获取文件编码类型
        def get_encoding(file):
            # 二进制方式读取，获取字节数据，检测类型
            with open(file, 'rb') as f:
                # 对于大文件,最好使用readline
                return chardet.detect(f.readline())['encoding']
    ```
