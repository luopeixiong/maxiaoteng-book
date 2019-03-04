# 迭代器 生成器 可迭代对象
Iteration Generator Iterable
1. Iteration 
Python中 string, list, dict, tuple, deque都是可迭代操作的
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
    2. 生成器就是把[] 换成 ()
        ```
        g = (x * x for x in range(10))
        >>> for n in g:
        ...     print(n)
        # 或者
        next(g)
        ```

3. Iterable
`collections.Iterable` 可迭代对象
    1. 生成器(generator)
    2. string, list, dict, tuple, deque...