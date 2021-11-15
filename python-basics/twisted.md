# twisted

1. demo

    ```python
    import json
    import sys
    import time
    import datetime
    from twisted.internet import task
    from twisted.internet import reactor
    from twisted.internet.defer import inlineCallbacks
    from bo_lib.general.redis_helper import RedisHelper
    from bo_lib.general.slack_notifier import BONotifier
    from notice import feishu
    import logging


    logger = logging.getLogger(__name__)


    class TestTwisted():

        @inlineCallbacks
        def _task(self):
            a = time.time()
            for _ in range(10):
                print(datetime.datetime.now(), a)
                yield self.sleep(2)

        def run(self):
            logger.info('BotNotifier开始......')
            self.task = task.LoopingCall(self._task)
            self.task.start(5)
            reactor.run()
        
        def finish_run(self):
            logger.info('BotNotifier退出...')
            self.task.stop()
            reactor.stop()

        def sleep(self, delay):
            # Returns a deferred that calls do-nothing function
            # after `delay` seconds
            return task.deferLater(reactor, delay, lambda: None)


        @inlineCallbacks
        def repeat_forever(self, message):
            while True:
                print(message)
                yield self.sleep(1)


    if __name__ == "__main__":
        '''
        '''
        bn = TestTwisted()
        bn.run()

    ```

2. 一些说明
    - 因为使用了twisted, 要求运行在主线程, 所以需要使用多进程

        ```python
        t1 = Process(target=producter)
        t2 = Process(target=customer)
        t1.start()
        t2.start()
        t1.join()
        t2.join()
        ```

    - 任务阻塞参考task.deferLater
    - 如果上一个任务运行, 会持续, 不会开始下一个
