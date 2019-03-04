# 面试知识点

1. 常用库
- requests
- hashlib
- demjson | json
- bs4
- lxml
- selenium


2. Python堆和栈

3. Python的垃圾回收机制
    参考： https://www.jianshu.com/p/1e375fb40506
    1. Python采用Garbage collection垃圾收集机制，以`引用计数`为主,`标记-清除`和`分代收集`两种机制为辅
    2. 对于`引用计数`机制,每个对象都是一个`PyObject`结构体,包含ob_refcnt作为引用计数,当ob_refcnt为0时,将被GC回收.
        - √简单
        - √实时性, 平摊内存回收的时间
        - X维护引用计数占用资源
        - X循环引用会导致永久占用

4. [进程、线程和协程](/python-basics/process_thread_coroutine.md)

5. 小的知识点：
    1. Float类型高精度转低精度
    ```
    # 字符串化：
    d = ({:0.2f}).format(f)
    # round内置函数
    round(d, 2) 
    ```

6. HTTP的三次握手

7. 