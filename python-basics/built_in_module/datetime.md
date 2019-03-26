# datetime

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