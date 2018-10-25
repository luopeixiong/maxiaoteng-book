## Templates -- Django模板系统
文件结构: project/templates/blog

## 配置
```
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        # 重点是这句
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

## 模板标签
- 模板变量
```
# django模板变量
{{ title }}
```

- 模板标签, 用来加载静态文件
```
{% load staticfiles %}
{% static '/blog/css/first.css' %}
> /static/blog/css/first.css  # 最终结果, static定义在setting中
```
- for 模板标签
```
{% for post in post_list %}
  <article class="post post-{{ post.pk }}">  # pk是primary key的缩写
    ...
  </article>
{% empty %}  # 如果post_list为空, 则执行下面的
  <div class="no-post">暂时还没有发布的文章！</div>
{% endfor %}
```

- extends 模板继承
```
# 继承语句
{% extends 'base.html' %}
# 继承版块
{% block main %}
{% endblock main %}
```

- safe标签
```
# djange出于安全的考虑, 任何html代码在Django模板中都会被转义, 直接显示代码内容. 为了解除转义, 在模板标签使用safe过滤器即可
{{ post.body|safe }}
```

- 代码高亮
```
# 1. 安装pygments  
pip install pygments
# 2. 引入css文件
重启
```

## 自定义模板标签

```
目录结构: ./blog/templatetags/blog_tags.py
from django import template
from ..models import Post, Category

register = template.Library()

@register.simple_tag
def get_recent_posts(num=5):
    return Post.objects.all().order_by('-created_time')[:num]

@register.simple_tag
def archives():
    # dates 返回一个列表, 列表元素为每一篇文章的创建时间
    return Post.objects.dates('created_time', 'month', order='DESC')
```
- 使用方法
```
# 目录: ./template/base.html
# 加载模板标签
{% load blog_tags %}
...
#使用, 直接使用其中的函数 返回结果使用as
{% get_recent_posts as recent_post_list %}
    <ul>
    {% for post in recent_post_list %}
        <li>
            <a href="{{ post.get_absolute_url }}">{{ post.title }}</a>
        </li>
    {% empty %}
        <p>暂无文章</p>
    {% endfor %}
</ul>
```

