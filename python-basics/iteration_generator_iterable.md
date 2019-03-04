# 迭代器 生成器 可迭代对象
Iteration Generator Iterable

1. Iterator   
    - 可迭代对象有 `__iter__` 方法
    - 迭代器是在可迭代对象基础上, 加`__next__` 方法
    - Python中 string, list, dict, tuple, deque都是可迭代操作的, 但不是迭代器

2. Generator 
    1. 列表生成器
        ```
        # 一般操作
         [x * x for x in range(1, 11)]
         >> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
        # 双层循环
         [m + n for m in 'ABC' for n in 'XYZ']
        ```
        直接生成一个list会占用内存,所以有了生成器
    2. 两种生成方法
        1. 生成器就是把[] 换成 ()
        ```
        g = (x * x for x in range(10))
        ```
        2. 实现yield函数
            ```
            # 实现了yield的函数
            def mygen(n):
                now = 0
                while now < n:
                    yield now
                    now += 1

            if __name__ == '__main__':
                gen = mygen(10)
                print(isinstance(gen, Generator))  # True
            ```
    3. 激活生成器
        1. next(g)
        2. generator.send(None)
    4. 生成器的四种状态
        ```
        GEN_CREATED # 等待开始执行
        GEN_RUNNING # 解释器正在执行（只有在多线程应用中才能看到这个状态）
        GEN_SUSPENDED # 在yield表达式处暂停
        GEN_CLOSED # 执行结束

        from inspect import getgeneratorstate

        def mygen(n):
            now = 0
            while now < n:
                yield now
                now += 1

        if __name__ == '__main__':
            gen = mygen(2)
            print(getgeneratorstate(gen))  # GEN_CREATED

            print(next(gen))
            print(getgeneratorstate(gen))  # GEN_SUSPENDED

            print(next(gen))
            gen.close()  # 手动关闭/结束生成器
            print(getgeneratorstate(gen))   # GEN_CLOSED

        ```
    5. 生成器的异常状态
        抛出: StopIteration


3. Iterable
`collections.Iterable` 可迭代对象
    1. 生成器(generator)
    2. string, list, dict, tuple, deque...