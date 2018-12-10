# Others

## list (append extend)
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

## 保存图片
```
    cat_img = response.content
    with open(image_path, 'wb') as f:
        f.write(cat_img)
        f.close()
```

## 包的导入
对于不再当前文件的python模块, 导入方法  

- 被导入包:  
文件夹下创建 __init__.py
- 导入包:
```
model_dir = os.path.join(os.path.split(os.path.abspath(__file__))[0], 'aa/bb/')
sys.path.append(model_dir)
from my_model import model_or_function 
```

## 生成随机数
- js常用的, 生成一个时间戳 + 随机数
```
    import time
    import random
    cert = int(time.time()*1000) + round(random.random(), 3)
    print('生成随机数: {}'.format(cert))
```

## 加密
```
    import hashlib
    hl = hashlib.md5()
    hl.update(url.encode(encoding='utf-8'))
    new = hl.hexdigest()
```