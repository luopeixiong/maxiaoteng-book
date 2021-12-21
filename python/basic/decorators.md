# Decorators 装饰器
主要还是利用了Python能够接收和返回函数的功能

## 1. 闭包
1. 实例
    ```
        def zoo(acount):
            def _inner():
                print(acount)

            return _inner
    ```    

## 2. 装饰器
1. 实例
    ```
        ## 定义一个装饰器, 将原来函数的参数输出一下, 就用到了所有情况
        def demo(func):
            def _warpper(*args, **kwargs):
                print('我是装饰器demo的功能')
                print('输出的args和kwargs来自被装饰函数, args:{},kwargs: {} '.format(args, kwargs))
                func(*args, **kwargs)

            return _warpper

        # 使用
        @demo
        def func(*args, **kwargs):
            print('来自原始函数', args, kwargs)

        # 测试
        func(2, 3, 5, name='mm', **{"age": 8})
        >>  我是装饰器demo的功能
            输出的args和kwargs来自被装饰函数, args:(2, 3, 5),kwargs: {'name': 'mm', 'age': 8}
            来自原始函数 (2, 3, 5) {'name': 'mm', 'age': 8}
    ```