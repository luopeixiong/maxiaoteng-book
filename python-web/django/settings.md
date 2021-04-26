# setting.py

- 设置语言

```python
blogproject/blogproject/settings.py
## 其它配置代码...
LANGUAGE_CODE = 'en-us'  # 'zh-hans'
TIME_ZONE = 'UTC'  # 'Asia/beijing'
## 其它配置代码...
```

- 设置模板路径

```python
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

- 选择数据库版本
- 查看默认设置

```python
# blogproject/settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

- 修改MySql数据库

```python
DEFAULT_CHARSET = 'utf8'
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'labelme',
        'USER': 'root',
        'PASSWORD': 'XXX',
        'HOST': '127.0.0.1',
        'PORT': '3306',
        'OPTIONS': {
            'sql_mode': 'traditional',
            # "init_command": "SET sql_mode='STRICT_TRANS_TABLES'",
            'charset': 'utf8'
        },
    }
}
```
