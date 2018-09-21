# 开始一个项目

## 准备目录
```
mkdir mysite
cd mysite
```

## 创建虚拟环境
```
virtualenv venv
source venv/bin/activate
```

## 创建django项目
```
django-admin startproject mysite

cd mysit

# 可以指定应用访问的web和端口
python36 manage.py runserver 0:8000 


```
开发服务器自动重载代码的修改, 但是文件的添加需要重启.

django提供了自动生成一个app的目录结构的功能.