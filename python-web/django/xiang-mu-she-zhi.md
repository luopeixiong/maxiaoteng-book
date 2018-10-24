## setting.py

- 设置语言
```
blogproject/blogproject/settings.py
## 其它配置代码...
LANGUAGE_CODE = 'en-us'  # 'zh-hans'
TIME_ZONE = 'UTC'  # 'Asia/beijing'
## 其它配置代码...
```

- 设置模板路径
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

