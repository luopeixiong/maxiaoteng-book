# Tips

## 1. 字符串
1. format %
    ```
        >>> print('percent: {:.2%}'.format(42/50))
        percent: 84.00%
        >>> print('percent: {:.2f}%'.format(42/50*100))
        percent: 84.00%
    ```

## 2. list (append extend)
    ```
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
    ```
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
```
model_dir = os.path.join(os.path.split(os.path.abspath(__file__))[0], 'aa/bb/')
sys.path.append(model_dir)
from my_model import model_or_function 
```

## 5. 生成随机数
- js常用的, 生成一个时间戳 + 随机数
```
    import time
    import random
    cert = int(time.time()*1000) + round(random.random(), 3)
    print('生成随机数: {}'.format(cert))
```

## 6. 加密
```
    import hashlib
    hl = hashlib.md5()
    hl.update(url.encode(encoding='utf-8'))
    new = hl.hexdigest()
```