# Query Syntax

## 1. 六个查询关键词
1. SELECT
2. FROM
3. WHERE
4. GROUP
5. HAVING
6. ORDER

## 2. 数据类型(https://support.hostgator.com/articles/specialized-help/technical/phpmyadmin/mysql-variable-types)
1. text
   1. char(0-255 固定长度)
   2. varchar(0-255 可变长度)
   3. tinytext(最长255的字符串)
   4. TEXT	A string with a maximum length of 65535 characters.
   5. BLOB	A string with a maximum length of 65535 characters.
   6. MEDIUMTEXT	A string with a maximum length of 16777215 characters.
   7. MEDIUMBLOB	A string with a maximum length of 16777215 characters.
   8. LONGTEXT	A string with a maximum length of 4294967295 characters.
   9. LONGBLOB	A string with a maximum length of 4294967295 characters.
    >> BLOB stands for Binary Large OBject, and can be used to store non-text information that is encoded into text.

2. number
   1. TINYINT ( )	-128 to 127 normal	0 to 255 UNSIGNED
   2. SMALLINT( )	-32768 to 32767 normal	0 to 65535 UNSIGNED
   3. MEDIUMINT( )	-8388608 to 8388607 normal	0 to 16777215 UNSIGNED
   4. INT( )	-2147483648 to 2147483647 normal	0 to 4294967295 UNSIGNED
   5. BIGINT( )	-9223372036854775808 to 9223372036854775807 normal	0 to 18446744073709551615 UNSIGNED
   6. FLOAT	A small number with a floating decimal point.
   7. DOUBLE( , )	A large number with a floating decimal point.
   8. DECIMAL(M,D)	A DOUBLE stored as a string, allowing for a fixed decimal point. M表示整个长度，D表示小数点后的位数
3. datetime
   1. DATE	YYYY-MM-DD
   2. DATETIME	YYYY-MM-DD HH:MM:SS
   3. TIMESTAMP	YYYYMMDDHHMMSS
   4. TIME	HH:MM:SS
   5. YEAR	YYYY


## 3. 查看数据(look at the data)
1. 查看数据库
    ```
        USE db_name
        SHOW tables
    ```
2. 查看表
    ```

        SHOW columns FROM table_name
        SHOW columns FROM table_name FROM db_name
        SHOW columns FROM db_name.table_name

        DESCRIBE columns FROM table_name
        DESCRIBE columns FROM table_name FROM db_name
        DESCRIBE columns FROM db_name.table_name
    ```
3. KEY的类型
   1. empty 表示这列既不是索引，也不会作为多列索引的辅助索引
   2. PRI   表示该列是PRIMARY KEY，或者是多列PRIMARY KEY中的一列
   3. UNI   表示该列是唯一索引的首列
   4. MUL   表示该列是非唯一索引的首列


## 4.mysql shell

1. 查询执行任务
    show full processlist;
    select * from information_schema.innodb_trx\G


## 5. 查询
1. 截取字符串
    ```
    where substring(cs_name, 4) == 'kat';   # 从第4个开始
    where substring(cs_name, -4) == 'kat';   # 从倒数第4个开始
    where substring(cs_name, 4, 2) == 'kat';   # 从第4个开始，截取两个
    where right(str, length);   # 右截取
    where left(str, length);   # 左截取
    ```
2. 连接字符
    ```
    CONCATE(column1, column2, '--');   # 连接
    ```
3. 字符长度
    ```
    length(cs_name)
    ```
4. 正则
    ```
    where name like '%A%'
    ```
5. join
   1. inner join
   2. left join
   3. right join
   4. full join
6. limit
   1. limit 5   返回五条
   2. limit 10, 50  返回符合结果的11-60条数据
7. 排序
    1. @row_number变量
        ```sql
        set @row_number=0;
        insert into talabat.tmp_count 
        select null, cc.city_name, cc.area_name, cc.cnt, @row_number:=@row_number+1, 'hungerstation' from 
        (
        select aa.area_name, aa.city_name, bb.* from 
        hungerstation.areas aa
        left join 
        (select city_id, area_id, count(*) as cnt from hungerstation.restaurants_by_area group by city_id, area_id) bb
        on aa.area_id=bb.area_id and aa.city_id=bb.city_id
        ) cc
        order by cc.cnt desc;
        ```

