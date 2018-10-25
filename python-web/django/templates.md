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
