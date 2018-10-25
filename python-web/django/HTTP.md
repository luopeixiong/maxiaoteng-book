## url

### app中修改
- 添加urls

```
# blog/urls.py
# url: 正则表达式匹配空字符, index: views的内容, name是index的别名
from django.conf.urls import url
urlpatterns = [
    url(r'^$', views.index, name='index'),
]
```
- 添加views

```
# blog/views.py
from django.http import HttpResponse
# render根据返回的内容构造httpResponse
from django.shortcuts import render  
# Create your views here.
def index(request):
    return HttpResponse("欢迎访问我的博客首页！")
```

### 注册到project中
```
from django.urls import path, include
urlpatterns = [
    path('admin/', admin.site.urls),
    # 此处的path, url添加后, 可以和后面的urls组合
    path('', include('blog.urls')),
]
```

## 编辑视图函数
```
from django.urls import get_object_or_404
# 返回数据库的对象, 不存在返回404
- ...
    post = get_object_or_404(Post, pk=pk)
  ... 
```
