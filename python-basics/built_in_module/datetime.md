# datetime time

> datetime比time高级了不少，可以理解为datetime基于time进行了封装，提供了更多实用的函数。在datetime 模块中包含了几个类，具体关系如下:

- 对象
    - timedelta     # 主要用于计算时间跨度
    - tzinfo        # 时区相关
    - time          # 只关注时间
    - date          # 只关注日期
    - datetime  # 同时有时间和日期

1. datetime
    1. 属性
        - datetime.year
        - datetime.month
        - datetime.day
        - datetime.hour
        - datetime.minute
        - datetime.second
        - datetime.microsecond
        - datetime.tzinfo
        - datetime.date()   # 返回date对象
        - datetime.time()   # 返回time对象
        - datetime.replace(name=value)   # 替换各个属性，因为是只读，只有这样才能修改
        - datetime.timetuple()  # 返回time.struct_time对象
        - datetime.strftime(format) # 按照format进行格式化
        - datetime.strptime(date_string, format) # 按照format解析时间
        - datetime.datetime.fromtimestamp(str_timestamp) # 转换时间戳为datetime
    2. 实例的方法
       1. datetime.today()  # 当前时间，localtime
       2. datetime.now([tz])    # 当前默认时间 localtime,datetime.datetime实例
       3. datetime.utcnow() # 当前UTC时间
2. datedelta
    ```
        In [1]: import datetime
        In [2]: time_now = datetime.datetime.now()
        In [3]: time_now
        Out[3]: datetime.datetime(2014, 10, 27, 21, 46, 16, 657523)

        In [4]: delta1 = datetime.timedelta(hours=25)
        In [5]: print(time_now + delta1)
        2014-10-28 22:46:16.657523

        In [6]: print(time_now - delta1)
        2014-10-26 20:46:16.657523
    ```
3. 时区
    1. 起因是在日本服务器运行, 写入时间差一小时
        ```
            import datetime
            # utc now
            utc_now = datetime.datetime.utcnow()
            now = datetime.datetime.utcnow()
            # +8:00 时间
            now = utc_now.astimezone(datetime.timezone(datetime.timedelta(hours=8)))
        ```
4. 其他
    1. 上周五的算法
        '''
            weeks = {
                'MONDAY': 0,
                'TUESDAY': 1,
                'WEDNESDAY': 2,
                'THURSDAY': 3,
                'FRIDAY': 4,
                'SATURDAY': 5,
                'SUNDAY': 6,
            }
            datetime.date.today() - datetime.timedelta(days=time.localtime().tm_wday - 4 + 7) 
        '''
    2. strptime的其他:
        - %Y	年	2016
        - %m	月	12
        - %d	日(在月中)	25
        - %a	周（英文简写）	Mon
        - %A	周（英文全写）	Monday
        - %b	月（英文简写）	Dec
        - %B	月（英文全写）	December
        - %H	时(24)	18
        - %p	AM或者PM	PM
        - %I	时(12)	6
        - %M	分	28
        - %S	秒	32
        - %f	微秒	4321
        - %c: 日期时间的字符串表示。（如： 04/07/10 10:43:39）
        - %j: 日在年中的天数 [001,366]（是当年的第几天）
        - %U: 周在当年的周数当年的第几周），星期天作为周的第一天
        - %w: 今天在这周的天数，范围为[0, 6]，6表示星期天
        - %W: 周在当年的周数（是当年的第几周），星期一作为周的第一天
        - %x: 日期字符串（如：04/07/10）
        - %X: 时间字符串（如：10:43:39）
        - %y: 2个数字表示的年份
        - %z: 与utc时间的间隔 （如果是本地时间，返回空字符串）
        - %Z: 时区名称（如果是本地时间，返回空字符串）
        - 链接：https://www.jianshu.com/p/937d6415c96f


## time

1. 生成时间
    ```
    import time
    time.time()  
    int(time.time())  # 10位整数
    ```

2. datetime转time
    ```
    import datetime
    now = datetime.datetime.now()
    now.timestamp()
    ```