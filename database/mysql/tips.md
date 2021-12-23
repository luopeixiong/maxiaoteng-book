# Tips 技巧总结

不是会连接mysql，会增删改查语句就够了，因为就像所有的工具，MYSQL也有很多注意事项，需要明确注意，才能避免在运行一段时间后由于错误应用而损失

1. 增删改查SQL语句中的转义
2. utf8和utf8mb4
   1. 缘由: 处理小红书的数据，有的笔记中带有emoji表情，使用utf8保存会报错
   2. 解决办法: 修改数据库的编码为utf8mb4
   3. 注意数据库和表的字符集，在mysql和MariaDB中都要使用utf8mb4，而不是utf8，详见[mysql中永远不要使用utf8](https://www.techug.com/post/in-mysql-never-use-utf8-use-utf8mb4.html)
   4. 建表时要注意编码，连接数据库操作时也要指定编码，才能解决
        ```python
        conn = pymysql.connect(host=host, port=port,
                            user=user, password=password,
                            database=database, charset="utf8mb4"
                            )
        ```
3. 数据库同步策略
   1. 带时间戳的数据, 只有insert操作
      1. 按时间戳同步
   2. 不带时间戳的
      1. 全表update的, 全部同步
      2. 增量更新的, 按id查询后添加
