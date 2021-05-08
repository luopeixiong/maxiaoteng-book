# Tips

## 1. 字符串

1. format %

    ```shell
        >>> print('percent: {:.2%}'.format(42/50))
        percent: 84.00%
        >>> print('percent: {:.2f}%'.format(42/50*100))
        percent: 84.00%
    ```

## 2. list (append extend)

    ```shell
        mxt = ['a', 'b', 'c']
        mm = ['d', 'e']

        mxt.append('d')
        > mxt = ['a', 'b', 'c', 'd']

        mxt.append(mm)
        > mxt = ['a', 'b', 'c', ['d', 'e']]

        mxt.extend(mm)
        > mxt = ['a', 'b', 'c', 'd', 'e']
    ```

## 3. 保存图片

```python
    cat_img = response.content
    with open(image_path, 'wb') as f:
        f.write(cat_img)
        f.close()
```

## 4. 包的导入

对于不再当前文件的python模块, 导入方法  

- 被导入包:  
文件夹下创建 __init__.py
- 导入包:

    ```python
    model_dir = os.path.join(os.path.split(os.path.abspath(__file__))[0], 'aa/bb/')
    sys.path.append(model_dir)
    from my_model import model_or_function 
    ```

## 5. 生成随机数

- js常用的, 生成一个时间戳 + 随机数

    ```python
        import time
        import random
        cert = int(time.time()*1000) + round(random.random(), 3)
        print('生成随机数: {}'.format(cert))
    ```

## 6. 加密

```python
    import hashlib
    hl = hashlib.md5()
    hl.update(url.encode(encoding='utf-8'))
    new = hl.hexdigest()
```

## 7. del

由于python都是引用，而python有GC机制，所以，del语句作用在变量上，而不是数据对象上。

```python
    a = 1
    b = a
    c = a
    del a
    del b
    print(c)    # c == 1
    # 对于list
    li=[1,2,3,4,5]  #列表本身不包含数据1,2,3,4,5，而是包含变量：li[0] li[1] li[2] li[3] li[4]
    first=li[0]     #拷贝列表，也不会有数据对象的复制，而是创建新的变量引用
    del li[0]
    print(li)      #输出[2, 3, 4, 5]
    print(first)   #输出 1
```

## 8. Python执行Shell命令

1. os
    返回外部程序的运行结果

    ```shell
        import os
        os.system('ls')
    ```

2. popen()
    返回一个类文件对象，调用read()或readline()可以输出内容

    ```shell
        import os
        output = os.popen('ps -u root')
        print(output)
    ```

3. commands

    ```shell
        import commands
        commands.getstatusoutput('ls')
        commands.getoutput('ls')
    ```

4. subprocess
    subprocess比os.system更灵活

    ```shell
        import subprocess
        subprocess.call('pwd', shell=True)
    ```

## 9. enumerate 代替range

```shell
    # 为了同时获取索引和列表的值
    for i in range(len(my_list)):
        print(i, my_list[i])
    
    # 使用enumerate, i其实就是计数
    for i, item in enumerate(my_list):
        print(i, item)

    # 也可以指定i的开始值
    # i将从1开始
    for i, item in enumerate(my_list， 1):
        print(i, item)
```

## 10. zip平行遍历多个迭代器

```shell
    # python3 zip相当于生成器，逐次产生元组
    for name, count in zip(list_name, list_count):
        print(name, count)
    # 如果迭代器长度不一致，要使用itertool.zip_longest
```
