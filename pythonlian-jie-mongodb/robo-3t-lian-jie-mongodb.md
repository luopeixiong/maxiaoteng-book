## 安全设置

1. 创建管理员用户

```
$ mongo  # 进入mongodb shell

> use admin # 进入admin 数据库

> db.createUser(
     {
       user:"maxiaoteng",
       pwd:"******",
       roles:[{role:"root",db:"admin"}]
     }
  )
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

2. 添加数据库用户


