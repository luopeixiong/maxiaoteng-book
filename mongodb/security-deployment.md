# 安全设置
对于mongodb的安全部署, 可以参考一篇文章: [安全部署MongoDB最佳实践](http://www.mongoing.com/archives/631)

## 创建管理员用户

```
$ mongo  # 进入mongodb shell

> use admin # 进入admin 数据库

> db.createUser({user:"maxiaoteng",pwd:"******",roles:[{role:"root",db:"admin"}]})
  # admin是用户的身份验证数据库, 用户在当前数据库进行验证, 但也可以在其他数据库有角色

> exit

  Successfully added user: {
	"user" : "maxiaoteng",
	"roles" : [
		{
			"role" : "root",
			"db" : "admin"
		}
	]
  }

```

## 配置启动安全认证

```
sudo nano /etc/mongod.conf

# 更改默认端口为27010
port : 27010

# 生效认证
# 2.6 3.2 3.6 以上版本用法
security:
  authorization: enabled

# 重启生效
sudo service mongod restart
```
验证
```
mongo --port=27010  # 进入mongo shell

show dbs  

# 显示结果
2018-09-11T08:27:32.759+0000 E QUERY    [js] Error: listDatabases failed:{
	"ok" : 0,
	"errmsg" : "command listDatabases requires authentication",
	"code" : 13,
	"codeName" : "Unauthorized"
} :
# 说明登陆失败, 

db.auth("username","password")
# 返回1 说明登陆成功

**注意: 登陆认证某个数据库时, 要先`use db`, 然后再执行auth**
use admin
db.auth("username","password")

```



## 添加数据库用户

用户可以访问特定数据库

```
# mongo shell下
> use ifood
> db.createUser({user: "testdb1u1", pwd: "xyz123", roles: [{ role: "dbOwner", db: "testdb1" }]})

###显示:
Successfully added user: {
	"user" : "yunfutech",
	"roles" : [
		{
			"role" : "dbOwner",
			"db" : "ifood"
		}
	]
}

```

## pymongo连接
见pymongo
