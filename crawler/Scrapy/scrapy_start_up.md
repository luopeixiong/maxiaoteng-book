# 开始一个scrapy

```
scrapy startproject my_scrapy

cd my_scrapy

scrapy genspider -t basic first_spider xx.com

scrapy list

scrapy crawl first_spider  
```

## scrapy
```
scrapy
#等价于
/usr/bin/python36 /usr/local/bin/scrapy
# 所以可以使用这种方法来指定python版本
```


## spider传入参数
```
scrapy crawl spider1 -a params
```

## 1. 定时任务解决

1. apscheduler定时任务
    ```
    # -*- coding: utf-8 -*-
    from multiprocessing import Process
    import traceback
    from apscheduler.schedulers.blocking import BlockingScheduler
    import sys
    sys.path.append('..')
    from utils.scrapy_tools import start_up_spider

    def crawl_scrapy_job_basic_info():
        pros = []
        for i in range(6):
            p = Process(target=start_up_spider, name='worker {}'.format(i+1), args=('as_scrapy_job_categories',))
            pros.append(p)
            p.start()

        for pro in pros:
            pro.join()


    def cron_job():
        sched = BlockingScheduler()
        sched.add_job(func=crawl_as_scrapy_job_company, trigger='cron', hour='07', minute=1, day='11,26', id='crawl_as_scrapy_job_company')
        sched.start()


    if __name__ == '__main__':
        cron_job()
    ```

2. 日志配置
    ```
    # -*- coding: utf-8 -*-
    from scrapy import cmdline
    import os
    import datetime
    import logging


    def start_up_spider(spider_name):
        root_logger = logging.getLogger()
        log_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../../logs')
        if not os.path.exists(log_dir):
            os.makedirs(log_dir)
        datetime_str = datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d_%H:%M:%S')
        log_path = os.path.join(log_dir, '{}_{}.log'.format(spider_name, datetime_str))
        file_handler = logging.handlers.TimedRotatingFileHandler(
                        filename=log_path,
                        when='midnight',
                        backupCount=20,
                        encoding="utf8",
                    )   
        formater = logging.Formatter("%(asctime)s %(processName)-10s %(filename)-15s %(lineno)-3s %(levelname)-8s %(message)s")
        file_handler.setFormatter(formater)
        file_handler.setLevel(logging.DEBUG)
        root_logger.addHandler(file_handler)
        s = "scrapy crawl {} --logfile={}/{}_{}.log ".format(spider_name, log_dir, spider_name, datetime_str)
        cmdline.execute(s.split())
    ```