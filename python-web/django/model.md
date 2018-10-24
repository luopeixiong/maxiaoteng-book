## 创建models.py来表示数据库关系
- 数据库关系

```
- ForeignKey  # 外键, 设置一对多, 例如: models.ForeignKey(User, on_delete=models.CASCADE)  # on_delete在1.10版本上不需要
- ManyToManyField  # 多对多关系,tags = models.ManyToManyField(Tag, blank=True)
```
- 数据库内容类型

```
- CharField  # 字符串
- TextField  # 很长的字符串
- DateTimeField  # 时间日期
- DateField  # 日期
```

- 内容参数

```
- max_length=100  
- blank=True # 默认False
```

- 例子
```
from django.db import models
class Post(models.Model):
    # 文章标题
    tille = models.CharField(max_length=70)
    body = models.TextField()
    modified_time = models.DateTimeField()
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    tags = models.ManyToManyField(Tag, blank=True)
```
- 内置Model
```    
# django.contrib.auth 是 Django 内置的应用，专门用于处理网站用户的注册、登录等流程，User 是 Django 为我们已经写好的用户模型。
from django.contrib.auth.models import User
```

