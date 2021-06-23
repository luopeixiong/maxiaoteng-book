# string 模块

提供字符串和数字组合

1. 用法

    ```python
    >>> import string
    >>> string
    <module 'string' from '/Library/Frameworks/Python.framework/Versions/3.6/lib/python3.6/string.py'>
    >>> string.digits
    '0123456789'
    >>> string.hexdigits
    '0123456789abcdefABCDEF'
    >>> string.octdigits
    '01234567'
    >>> string.punctuation
    '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~'
    >>> string.ascii_lowercase
    'abcdefghijklmnopqrstuvwxyz'
    >>> string.ascii_uppercase
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    >>> string.ascii_letters
    'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
    ```

2. 关系

    ```python
    printable = digits + ascii_letters + punctuation + whitespace
    hexdigits = digits + 'abcdef' + 'ABCDEF'
    whitespace = ' \t\n\r\v\f'
    ```

3. 随机字符串

    ```python
    ''.join([random.choice(string.digits+string.ascii_lowercase) for _ in range(20)])
    ```
