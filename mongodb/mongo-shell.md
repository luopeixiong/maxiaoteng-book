# Mongo Shell

## 进入shell

```
mongo  # 直接进入, 默认端口27017的数据库

mongo --port=27010  # 指定端口的数据库

```


## 基本操作

- 查看版本
```
db.bersion()
```

- 登陆
```
use db_name  # 登陆admin, use admin
db.auth("username","password")
```

- 查看操作命令
```
db.help()
```

- 查看数据库列表
```
show dbs
```

- 切换或创建数据库
```
use db_name
```

- 显示所有用户
```
show users
```

- 显示当前数据库的集合
```
show collections
```

- 显示集合操作命令
```
db.yourCollection.help()
# 比如
db.readme.help()

```

- 显示当前所用的数据库
```
> db
```

- 其他操作...

## 退出

```
> exit
bye
```
