## 创建models.py来表示数据库关系
- 数据库关系

```
- 一对多
- 多对多
- 
```
- 数据库内容类型

```
- CharField  # 字符串
- TextField  # 很长的字符串
- DateTimeField  # 时间日期
- DateField  # 日期
- ForeignKey
- ManyToManyField
```

- 内容参数

```
- max_length=100  
- blank=True # 默认False
- Model类名  # models.ForeignKey(User)
```

- 例子
```
from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Category(models.Model):
    name = models.CharField(max_length=100)
    
class Tag(models.Model):
    name = models.CharField(max_length=100)

class Post(models.Model):
    # 文章标题
    tille = models.CharField(max_length=70)
    
    # 文章正文 textField存储更多的内容
    body = models.TextField()

    # 创建时间和最新修改时间
    created_time = models.DateTimeField()
    modified_time = models.DateTimeField()

    # 文章摘要, 指定blank=True可以为空
    excerpt = models.CharField(max_length=200, blank=True)

    # 标签和分类, 标签可以为空, 
    category = models.ForeignKey(Category)
    tags = models.ManyToManyField(Tag, blank=True)

    # User表是django自带的,
    # django.contrib.auth 是 Django 内置的应用，专门用于处理网站用户的注册、登录等流程，User 是 Django 为我们已经写好的用户模型。
    # 一个文章只有一个作者, 一个作者有多篇文章, 所以是一对多
    author = models.ForeignKey(User)
```