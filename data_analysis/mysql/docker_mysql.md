# docker mysql

1. 启动
    ```bash
    docker create -p 3306:3306 --name docker_mysql -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
    # 环境变量说明
    -v /my/custom:/etc/mysql/conf.d # conf.d 是配置文件, 位于custom, 注意只需要路径
    ```
2. 创建mysql dump
    ```bash
    docker exec some-mysql sh -c 'exec mysqldump --all-databases -uroot -p"$MYSQL_ROOT_PASSWORD"' > /some/path/on/your/host/all-databases.sql
    ```
3. 导入mysql dump
    ```bash
    docker exec -i some-mysql sh -c 'exec mysql -uroot -p"$MYSQL_ROOT_PASSWORD"' < /some/path/on/your/host/all-databases.sql
    ```
4. 