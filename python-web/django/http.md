## url

app中修改
- urls

```
# blog/urls.py
# url: 正则表达式匹配空字符, index: views的内容, name是index的别名
from django.conf.urls import url
urlpatterns = [
    url(r'^$', views.index, name='index'),
]
```
- views

```
# blog/views.py
from django.http import HttpResponse
# Create your views here.
def index(request):
    return HttpResponse("欢迎访问我的博客首页！")
```

注册到project中
```
from django.urls import path, include
urlpatterns = [
    path('admin/', admin.site.urls),
    # 此处的path, url添加后, 可以是二级目录
    path('', include('blog.urls')),
]
```