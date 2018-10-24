# 开始一个项目

## 准备目录
```
mkdir mysite
cd mysite
```

## 创建虚拟环境
```
virtualenv --no-site-packages venv
source venv/bin/activate
# 安装包
pip -r requirement.txt
```

## 创建django项目
```
django-admin startproject mysite
cd mysit
# 可以指定应用访问的web ip和端口
python36 manage.py runserver 0:8000 
```
开发服务器自动重载代码的修改, 但是文件的添加需要重启.

django提供了自动生成一个app的目录结构的功能.


## 创建一个app

```
python manage.py startapp polls
# 将会创建出一个目录
```
- app文件夹结构
```
blog\
    __init__.py
    admin.py
    apps.py
    migrations\
        __init__.py
    models.py
    tests.py
    views.py
```
- 配置文件中注册应用
