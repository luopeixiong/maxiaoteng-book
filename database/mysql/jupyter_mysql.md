# Jupyter Mysql

1. 加载mysql库
    ```
        # 加载sql库
        %load_ext sql

        # 建立连接
        %sql mysql://user:pw@mysqlserver/db_name

        # 选择查询的数据库
        %sql USE db

        # 每一次操作都要如下开头
        %sql ...
    ```