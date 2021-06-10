# multiprocessing

用来执行python的函数，他启动的进程会重新加载父进程的代码。可以通过Queue、Array、Value等对象来通信。

## 用法

1. 普通用法

    ```Python
    from multiprocessing import Process

    def p_job(x):
        ...

    pros = []
    for i in range(5):
        p = Process(target=p_job, args=(i,))
        p.start()
        pros.append(p)
    # 先启动子进程，再join，父进程等待
    for pro in pros:
        pro.join()
    ```

2. 进程池 Pool

    ```Python
    from multiprocessing import Pool
    import os, time, random

    def long_time_task(name):
        print('Run task %s (%s)...' % (name, os.getpid()))
        start = time.time()
        time.sleep(random.random() * 3)
        end = time.time()
        print('Task %s runs %0.2f seconds.' % (name, (end - start)))

    if __name__=='__main__':
        print('Parent process %s.' % os.getpid())
        p = Pool(4)
        for i in range(5):
            p.apply_async(long_time_task, args=(i,))
        print('Waiting for all subprocesses done...')
        p.close()
        p.join()
        print('All subprocesses done.')
    ```
