# Celery

Distributed Task Queue

1. Choosing a Broker
    1. Redis
    2. Rebbit MQ
2. Installing Celery
    ```
    pip install celery
    ```
3. Application
    1. app线程安全
        ```python
        from celery import Celery
        app = Celery('tasks', broker='pyamqp://guest@localhost//')
        # redis, broker读取任务
        app = Celery('tasks', broker='redis://localhost')
        @app.task
        def add(x, y):
            return x + y
        ```
4. Keeping Results
    1. 为了追踪任务状态, celery需要存储和发送任务状态, backend可选( SQLAlchemy/Django ORM, MongoDB, Memcached, Redis, RPC (RabbitMQ/AMQP))
    ```python
    from celery import Celery
    app = Celery('tasks', backend='redis://localhost', broker='pyamqp://guest@localhost//')
    # redis, broker读取任务, backend
    app = Celery('tasks', backend='redis://localhost', broker='redis://localhost')
    @app.task
    def add(x, y):
        return x + y
    # 对于结果调用
    # delay调用, 返回异步结果
    result = add.delay(4, 4)
    result.id    # 任务id
    result.ready()
    result.get(timeout=1)
    # 异常处理, 如果有异常, 调用get也会返回异常
    result.get()    # 直接抛出异常
    result.get(propagate=False) # 只返回异常名, 不返回完整的调用栈
    result.traceback    # 查看完整的调用栈
    ```
5. Configuration
    1. 硬编码配置
        ```python
        app.conf.task_serializer = 'json'
        app.conf.update(
            task_serializer='json',
            accept_content=['json'],  # Ignore other content
            result_serializer='json',
            timezone='Europe/Oslo',
            enable_utc=True,
        )
        ```
    2. 配置文件
        ```
        app.config_from_object('celeryconfig')
        # celeryconfig.py
        broker_url = 'pyamqp://'
        result_backend = 'rpc://'
        task_serializer = 'json'
        result_serializer = 'json'
        accept_content = ['json']
        timezone = 'Europe/Oslo'
        enable_utc = True
        # python -m celeryconfig.py 检查配置文件准确
        # 特定队列的配置
        task_routes = {
            'tasks.add': 'low-priority',
            'tasks.add': {'rate_limit': '10/m'} # 每分钟处理10个任务
        }
        ```
6. 启动worker
    ```Shell
    celery -A tasks worker --loglevel=INFO
    ```
7. other