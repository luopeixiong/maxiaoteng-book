# time 模块

time归类在`Generic Operating System Services`中，是围绕着 Unix Timestamp 进行的，其所能表述的日期范围被限定在 1970 - 2038 之间。

1. time.time()
    ```
        # 返回float类型的时间
        now_time = time.time()
        print(now_time)   // →  1532328411.9794893
    ```

2. int(time.time())
    ```
        返回int的时间，通常做时间戳

        print(int(time.time())   // →  1532328411
    ```

3. time.localtime(time.time())
    ```
        返回一个对象time.structtime, 可以用 localtime.year 得到当前时间的年

        local_time = time.localtime(time.time())
        
        print(localtime)    // → time.structtime(tmyear=2018, tmmon=7, tmmday=23, tmhour=14, tmmin=46, tmsec=51, tmwday=0, tmyday=204, tm_isdst=0)
 
        print(type(localtime)  // → <class 'time.structtime'>
    ```

4. time.strftime(formate, value)
    ```
        格式化时间
        format = '%Y - %m - %d - %H - %M - %S'   // month和day要小写
        dt = time.strftime(format, value)    // →  2018 - 07 - 23 - 15 - 16 - 19
    ```

5. time.strptime()
    ```
        # 反格式化时间
        nowtime = time.strptime(strtime, format)
        // → 返回time.structtime类型的对象
        print(nowtime)  // → time.structtime(tmyear=2018, tmmon=7, tmmday=23, tmhour=15, tmmin=16, tmsec=19, tmwday=0, tmyday=204, tmisdst=-1)
    ```