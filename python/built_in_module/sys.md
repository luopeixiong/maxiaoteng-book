# sys

1. sys.path.append('')
2. 中断python进程
    1. sys.exit(0)
        1. 会引发一个异常, SystemExit, 如果异常不被捕获,, 解释器将会退出
        2. 0为正常退出, (1-127为异常)
        3. 优先使用
    2. os._exit()
        1. 直接终止解释器运行
    3. quit()
        1. raist SystemExit
        2. demo

            ```python

            def test_quit():
                try:
                    quit()
                except:
                    pass
                except Exception as e:
                    print(e)
                except SystemExit:
                    pass
            ```
