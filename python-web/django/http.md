## url

子路径
```
# blog/urls.py
# url: 正则表达式匹配空字符, index: views的内容, name是index的别名
from django.conf.urls import url
urlpatterns = [
    url(r'^$', views.index, name='index'),
]
```
```
# blog/views.py
from django.http import HttpResponse
# Create your views here.
def index(request):
    return HttpResponse("欢迎访问我的博客首页！")
```