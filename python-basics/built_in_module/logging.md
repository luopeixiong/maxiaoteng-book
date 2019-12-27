# python logging 
logging可以发送到控制台, 文件, 网络

## 1. 等级
- a. logging.CRITICAL
- b. logging.ERROR
- c. logging.WARNING
- d. logging.INFO
- e. logging.DEBUG


## 2. 实践
1. 使用`__name__`作为logger的名称
    - 便于知道日志来自哪个模块
2. 异常捕捉时使用`traceback`记录
    ```
      logger.error('Failed to open file', exc_info=True)   
      logger.exception('Failed to open file')   
    ```
3. 不要在模块层次创建logger
    因为在模块层面获得的logger，在加载了配置文件后都将失效  
    而应该在使用时获得
    ```
        import logging
        
        def foo():
            logger = logging.getLogger(__name__)
            logger.info('Hi, foo')
        
        class Bar(object):
            def __init__(self, logger=None):
                self.logger = logger or logging.getLogger(__name__)
        
            def bar(self):
                self.logger.info('Hi, bar')
    ```

4. 使用json或YAML记录配置
    1. logging.json
        ```
            {
                "version": 1,
                "disable_existing_loggers": false,  # 如果为True,则模块层面获取的logger都失效
                "formatters": {
                    "simple": {
                        "format": "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
                    }
                },
            
                "handlers": {
                    "console": {
                        "class": "logging.StreamHandler",
                        "level": "DEBUG",
                        "formatter": "simple",
                        "stream": "ext://sys.stdout"
                    },
            
                    "info_file_handler": {
                        "class": "logging.handlers.RotatingFileHandler",
                        "level": "INFO",
                        "formatter": "simple",
                        "filename": "info.log",
                        "maxBytes": 10485760,
                        "backupCount": 20,
                        "encoding": "utf8"
                    },
            
                    "error_file_handler": {
                        "class": "logging.handlers.RotatingFileHandler",
                        "level": "ERROR",
                        "formatter": "simple",
                        "filename": "errors.log",
                        "maxBytes": 10485760,
                        "backupCount": 20,
                        "encoding": "utf8"
                    }
                },
            
                "loggers": {
                    "my_module": {
                        "level": "ERROR",
                        "handlers": ["console"],
                        "propagate": "no"
                    }
                },
            
                "root": {
                    "level": "INFO",
                    "handlers": ["console", "info_file_handler", "error_file_handler"]
                }
            }
        ```
    2. 读取json配置
        ```
            import json
            import logging.config
            
            def setup_logging(
                default_path='logging.json', 
                default_level=logging.INFO,
                env_key='LOG_CFG'
            ):
                """Setup logging configuration
            
                """
                path = default_path
                value = os.getenv(env_key, None)
                if value:
                    path = value
                if os.path.exists(path):
                    with open(path, 'rt') as f:
                        config = json.load(f)
                    logging.config.dictConfig(config)
                else:
                    logging.basicConfig(level=default_level)

        ```


## 2. 配置
1. 基础配置
    ```python
    import logging

    logFilename = os.path.join(os.path.dirname(os.path.abspath(__file__)), '../log/ele.log')

    log_dir = os.path.split(logFilename)[0]
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
    logging.basicConfig(
        level = logging.DEBUG,  # 定义输出到文件的log级别，
        format = '%(asctime)s  %(filename)s : %(levelname)s  %(message)s',  # 定义输出log的格式
        datefmt= '%Y-%m-%d %A %H:%M:%S',  # 时间
        filename = logFilename,  # log文件名
        filemode = 'w'
    )   
    ```
2. 日志是线程安全的，但是多进程会有问题，通常解决思路：
   1. 每个进程单独写一个文件
   2. 使用socketHandler，启一个线程或进程单独处理
   3. 多进程mulitprocessing中的Queue队列存储日志，单独一个进程处理

## 3. 遇到的bug
    1. [多进程+ 多线程 + logging遇到的问题](https://mozillazg.com/2016/09/python-threading-multiprocessing-logging-equal-deadlock.html)
        1. 主要问题是创建子进程时, 如果使用multiprocessing, 会fork父进程的所有的状态, 此时如果某个线程正在写日志, logging的锁将被fork到子进程中, 导致子进程logging锁无法释,产生死锁
        2. 解决办法: 使用subprocess, 或只使用多进程+logging

