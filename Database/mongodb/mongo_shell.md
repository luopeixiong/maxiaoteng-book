# Mongo Shell

1. 进入shell

    ```
    mongo  # 直接进入, 默认端口27017的数据库
    mongo --port=27010  # 指定端口的数据库
    mongo host:port/admin -u root -p password
    ```

2. 基本操作

- 查看版本
    ```
    db.version()
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

- 其他操作
    ```
    db.collection.find()
    db.collection.find().count
    ```

- 退出
    ```
    > exit
    bye
    ```

3. 数据导出导入
    ```
    # 导出csv
    mongoexport --host xx --port xx -u root -p xx --authenticationDatabase admin --db HotelRoomCounts --collection CtripRoomCounts --csv --out CtripRoomCounts.csv --fields 'hotelId,address,city,lat,lng,name,room_counts'

    # 导出其他文件
    mongoexport --host xx --port xx -u root -p xx --authenticationDatabase admin --db HotelRoomCounts --collection CtripRoomCounts -o co.dat

    # 导入
    mongoimport --host xx --port xx -u root -p xx --authenticationDatabase admin --db HotelRoomCounts --collection CtripRoomCounts --upsert file_name
    ```