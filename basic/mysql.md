# windows7 安装mysql

启动: 服务中找到mysql, 点击启动即可

- char  
- varchar
    >> char(n)和varchar(n)的n表示字符的个数, 不表示字节数, 
    >> char不管实际值都会占用n个空间, 而varchar占用实际字符+1<=n, 
    >> 超过n的上限就会被截断, char上限255字节, varchar上限65535字节,text上限65535
- text
    >> char存储时会截断尾部空格, varchar和text不会

    - varchar
        - > 255 tinytext
        - > 500 text
        - > 20000  mediumtext
- blob


## pymysql查询

```
# 建立数据库, 数据来自三江源在阿里云的服务器
    connect = pymysql.connect(
        host='39.107.95.132',
        db='sanjiangyuan',
        user='root',
        passwd='jAqFum_sMusIE6E8',
        charset='utf8',
        use_unicode=True
    )
    # 如果不使用Dict, 返回的是list, 每个元素都是元祖
    cursor = connect.cursor(cursor=pymysql.cursors.DictCursor)
    try:
        cursor.execute(
            "select * from yunfu_crawler_news where created_at >= '{}'".format(yesterday)
        )
        data = cursor.fetchall()
        connect.commit()
        return data
    except Exception as e:
        print(str(e))
        logging.info(str(e))
    finally:
        connect.close()
```