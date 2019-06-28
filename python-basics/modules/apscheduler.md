# apscheduler

apscheduler是python的定时任务框架， 可以将定时任务持久化

1. 三种出发模式
   1. cron 定时任务触发器
   2. interval 循环任务触发器
   3. date 一次性任务触发器

2. 使用
    ```Python
    from apscheduler.schedulers.blocking import BlockingScheduler
    import time 

    def print_time(x):
        time1 = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(time.time()))
        print(time1,"模式:{}".format(x))

    def clear_job(job_id):
        scheduler.remove_job(job_id)
        print("{}任务被删除了".format(job_id))

    def cron_job():
        sched = BlockingScheduler()
        sched.add_job(func=print_time, args=('定时任务', ), trigger='cron', hour='*/2', minute=1, id='cron_job')
        sched.add_job(func=print_time, args=('循环任务', ), trigger='interval', seconds=3, minute=1, id='interval_job')
        sched.add_job(func=clear_job, args=('cron_job', ), trigger='date', next_run_time='2019-06-28 18:09:00', id='date_job')
        sched.start()
    ```

3. 一些说明
   1. 定时任务设置hours
        ```
        * 表示每
        * /2 # 偶数
        x,y,z  # 组合
        ```
   2. 一次任务
        ```
        next_run_time = '2019-06-28 18:09:00'
        next_run_time = date(2019, 06, 28)
        next_run_time = datetime(2019, 06, 28, 1, 0, 2)
        # 未指定时间将立即执行
        ```
   3. 周期执行任务
        ```
        seconds = 2  # 表示每2s执行一次
        start_date='2018-12-11 09:30:00', end_date='2018-12-15 11:00:00'  # 也可以添加开始停止时间
        ```