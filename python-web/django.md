# Django 开始

安装: 
```
sudo pip install Django
sudo python -m pip install Django
```

## 坑

导入模块, 必须
```
from xx.xx import ss
```

## 开发流程
- 搭建开发环境
- 创建Django工程, 基础设置(数据库版本, 模板路径, 语言等), 创建超级用户
- 建立应用app, 并注册到setting
- 创建数据库模型models, 迁移数据库
- 设计app需要的urls, 添加到工程的urls中
- 设计url对应的视图函数views

