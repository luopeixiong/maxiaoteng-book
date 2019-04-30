# 迭代器 生成器 可迭代对象
Iteration Generator Iterable

1. Iterator   
    - 可迭代对象有 `__iter__` 方法
    - 迭代器是在可迭代对象基础上, 加`__next__` 方法
    - Python中 string, list, dict, tuple, deque都是可迭代操作的, 但不是迭代器

2. Generator 
    1. 列表生成器
    set，list， dict都适用
        ```
            a = [1, 2, 3, 4, 5, 6]
            squares = [x ** 2 for x in a]
            even_squares = [x ** 2 for x in a if x % 2 == 0]

            # 矩阵
            matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
            flat = [x for x in row for row in matrix]
            >> flat = [1, 2, 3, 4, 5, 6, 7, 8, 9]
            squared = [[x ** 2 for x in row] for row in matrix]
            >> squared = [[1, 4, 9], [16, 25, 36], [49, 64, 81]]

            # 再复杂的结构，建议使用for循环
            
            # 列表推到每个值都要创建一个全新列表，占用大量内存
        ```
    2. 两种生成方法
        1. 生成器就是把[] 换成 ()
        ```
        g = (x * x for x in range(10))
        ```
        1. 实现yield函数
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
    2. 激活生成器
        1. next(g)
        2. generator.send(None)
    3. 生成器的四种状态
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
    4. 生成器的异常状态
        抛出: StopIteration


3. Iterable
`collections.Iterable` 可迭代对象
    1. 生成器(generator)
    2. string, list, dict, tuple, deque...