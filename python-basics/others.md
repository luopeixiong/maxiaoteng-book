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
