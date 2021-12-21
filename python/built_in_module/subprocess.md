# Subprocess

> subprocess的目的就是启动一个新的进程并且与之通信。
> subprocess模块中只定义了一个类: Popen。可以使用Popen来创建进程，并与进程进行复杂的交互。它的构造函数如下：
> The subprocess option:用来执行其他的可执行程序的，即执行外部命令。 他是os.fork() 和 os.execve() 的封装。 他启动的进程不会把父进程的模块加载一遍。使用subprocess的通信机制比较少，通过管道或者信号机制.
> The multiprocessing option:用来执行python的函数，他启动的进程会重新加载父进程的代码。可以通过Queue、Array、Value等对象来通信。

- 并发与并行
    并发: 交错使用cpu实行任务，本质还是顺序执行
    并行: 多核CPU同时执行，效率翻倍

## 用subprocess模块管理子进程

1. Python启动的多个子进程是可以并行运行的。子进程将会独立于父进程而运行，这里的父进程指的Python解释器。

    ```Python
    import subprocess
    proc = subprocess.Popen(['echo', 'Hello subprocess'], stdout=subprocess.PIPE)
    out, err = proc.communicate()
    print(out.decode('utf-8'))
    ```

2. Python 子进程从父进程中解耦，父进程可以运行跟多条平行的子进程

    ```Python
    import subprocess

    def run_some():
        proc = subprocess.Popen(['cmd'],
                    stdout=subprocess.PIPE,
                    stdout=subprocess.PIPE)
        return proc

    procs = []
    for _ in range(10):
        proc = run_some(x)
        procs.append(proc)

    for proc in procs:
        proc.communicate()  # 通过comunicate，等待这些子进程完成I/O工作并终结

    # 如果不希望交互操作,使用shell执行
    subpros = []
    for _ in range(10):
        subpro = subprocess.Popen(['cmd'], shell=True)
        subpors.append(subpro)
    for subpro in subpors:
        subpro.wait()
    ```

3. Python向子进程输送数据

    ```Python
    import os
    def run_openssl(data):
        env = os.environ.copy()
        env['password'] = b'\xe24U'
        proc = subprocess.Popen(
            ['openssl', 'enc', '-des3', '-pass', 'env:password'],
            env=env,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE
        )
        proc.stdin.write(data)
        proc.stdin.flush() # 确保子进程获得输入
        return proc

    procs = []
    for _ in range(3):
        data = os.urandom(10)
        proc = run_openssl(data)
        procs.append(proc)
        other_proc = run_other(proc.stdout) # 将前一个进程的输出为输入
        other_procs.append(other_proc)

    for proc in procs:
        out, error = proc.communicate()  # 通过comunicate，等待这些子进程完成I/O工作并终结
        print(out)
    ```

4. Python子进程超时设置

    ```Python
    for proc in procs:
        try:
            proc.communicate(timeout=0.1)  # 如果子进程在0.1s内没有结束，将抛出异常，可以强行终止
        except subprocess.TimeoutExpired:
            proc.terminate()
            proc.wait()
    ```

## Popen详解

1. 初始化

    ```python
        subprocess.Popen(args, bufsize=0, executable=None, stdin=None, stdout=None, stderr=None, preexec_fn=None, close_fds=False, shell=False, cwd=None, env=None, universal_newlines=False, startupinfo=None, creationflags=0)
        # 参数args可以是字符串或者序列类型（如：list，元组），用于指定进程的可执行文件及其参数。如果是序列类型，第一个元素通常是可执行文件的路径。我们也可以显式的使用executeable参数来指定可执行文件的路径。
    ```

2. 参数
    1. 参数stdin, stdout, stderr分别表示程序的标准输入、输出、错误句柄。他们可以是PIPE，文件描述符或文件对象，也可以设置为None，表示从父进程继承。

    2. 如果参数shell设为true，程序将通过shell来执行。

    3. 参数env是字典类型，用于指定子进程的环境变量。如果env = None，子进程的环境变量将从父进程中继承。

    4. subprocess.PIPE
        > 在创建Popen对象时，subprocess.PIPE可以初始化stdin, stdout或stderr参数。表示与子进程通信的标准流。

    5. subprocess.STDOUT
        > 创建Popen对象时，用于初始化stderr参数，表示将错误通过标准输出流输出。

3. Popen的方法
    1. Popen.poll()
        用于检查子进程是否已经结束。设置并返回returncode属性。

    2. Popen.wait()
        等待子进程结束。设置并返回returncode属性。

    3. Popen.communicate(input=None)
        与子进程进行交互。向stdin发送数据，或从stdout和stderr中读取数据。可选参数input指定发送到子进程的参数。Communicate()返回一个元组：(stdoutdata, stderrdata)。注意：如果希望通过进程的stdin向其发送数据，在创建Popen对象的时候，参数stdin必须被设置为PIPE。同样，如果希望从stdout和stderr获取数据，必须将stdout和stderr设置为PIPE。

    4. Popen.send_signal(signal)
        向子进程发送信号。

    5. Popen.terminate()
        停止(stop)子进程。在windows平台下，该方法将调用Windows API TerminateProcess（）来结束子进程。

    6. Popen.kill()
        杀死子进程。

    7. Popen.stdin，Popen.stdout ，Popen.stderr ，
        官方文档上这么说：
        > stdin, stdout and stderr specify the executed programs’ standard input, standard output and standard error file handles, respectively. Valid values are PIPE, an existing file descriptor (a positive integer), an existing file object, and None.
    8. Popen.pid
        获取子进程的进程ID。

    9. Popen.returncode
        获取进程的返回值。如果进程还没有结束，返回None。

4. 简单的用法
    1. 执行

        ```python
        p=subprocess.Popen("dir", shell=True)  
        p.wait() 
        # shell参数根据你要执行的命令的情况来决定，上面是dir命令，就一定要shell=True了，p.wait()可以得到命令的返回值。
        # 如果上面写成a=p.wait()，a就是returncode。那么输出a的话，有可能就是0【表示执行成功】。
        ```

    2. 进程通讯
        1. 如果想得到进程的输出，管道是个很方便的方法，这样：

            ```python
            p=subprocess.Popen('ls',shell=True,stdout=subprocess.PIPE)
            stdoutput,erroutput = p.communicate('/home/zoer')
            print stdoutput[0]
            print erroutput
            # 上面的例子通过communicate给stdin发送数据，然后使用一个tuple接收命令的执行结果。

            # 上面，标准输出和标准错误输出是分开的，也可以合并起来，只需要将stderr参数设置为subprocess.STDOUT就可以了，这样子：
            p=subprocess.Popen("dir", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)  
            (stdoutput,erroutput) = p.communicate()  
            p.communicate会一直等到进程退出，并将标准输出和标准错误输出返回，这样就可以得到子进程的输出了。

            # 如果你想一行行处理子进程的输出，也没有问题：
            p=subprocess.Popen("dir", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)  
            while True:  
                buff = p.stdout.readline()  
                if buff == '' and p.poll() != None:  
                    break 
            ```

    3. 死锁

        ```python
        # 但是如果你使用了管道，而又不去处理管道的输出，那么小心点，如果子进程输出数据过多，死锁就会发生了，比如下面的用法：
        p=subprocess.Popen("longprint", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)  
        p.wait()  
        longprint是一个假想的有大量输出的进程，那么在我的xp, Python2.5的环境下，当输出达到4096时，死锁就发生了。当然，如果我们用p.stdout.readline或者p.communicate去清理输出，那么无论输出多少，死锁都是不会发生的。或者我们不使用管道，比如不做重定向，或者重定向到文件，也都是可以避免死锁的。
        ```

    4. 管道连接
        subprocess还可以连接起来多个命令来执行。
        在shell中我们知道，想要连接多个命令可以使用管道。
        在subprocess中，可以使用上一个命令执行的输出结果作为下一次执行的输入。例子如下：

        ```python
        p1=subprocess.Popen('cat ff',shell=True,stdout=subprocess.PIPE)
        p2=subprocess.Popen('tail -2',shell=True,stdin=p1.stdout,stdout=subprocess.PIPE)
        print p2.stdout
        print p2.stdout.read()
        # 例子中，p2使用了第一次执行命令的结果p1的stdout作为输入数据，然后执行tail命令。
        ```

        下面是一个更大的例子。用来ping一系列的ip地址，并输出是否这些地址的主机是alive的。代码参考了python unix linux 系统管理指南。

        ```python
            #!/usr/bin/env python  
            
            from threading import Thread  
            import subprocess  
            from Queue import Queue  
            
            num_threads=3 
            ips=['127.0.0.1','116.56.148.187']  
            q=Queue()  
            def pingme(i,queue):  
                while True:  
                    ip=queue.get()  
                    print 'Thread %s pinging %s' %(i,ip)  
                    ret=subprocess.call('ping -c 1 %s' % ip,shell=True,stdout=open('/dev/null','w'),stderr=subprocess.STDOUT)  
                    if ret==0:  
                        print '%s is alive!' %ip  
                    elif ret==1:  
                        print '%s is down...'%ip  
                    queue.task_done()  
            
            #start num_threads threads  
            for i in range(num_threads):  
                t=Thread(target=pingme,args=(i,q))  
                t.setDaemon(True)  
                t.start()  
            
            for ip in ips:  
                q.put(ip)  
            print 'main thread waiting...' 
            q.join();print 'Done' 
            在上面代码中使用subprocess的主要好处是，使用多个线程来执行ping命令会节省大量时间。

            假设说我们用一个线程来处理，那么每个 ping都要等待前一个结束之后再ping其他地址。那么如果有100个地址，一共需要的时间=100*平均时间。
        ```

        如果使用多个线程，那么最长执行时间的线程就是整个程序运行的总时间。【时间比单个线程节省多了】

## 这里要注意一下Queue模块的学习

pingme函数的执行是这样的：  
启动的线程会去执行pingme函数。  
pingme函数会检测队列中是否有元素。如果有的话，则取出并执行ping命令。  
这个队列是多个线程共享的。所以这里我们不使用列表。【假设在这里我们使用列表，那么需要我们自己来进行同步控制。Queue本身已经通过信号量做了同步控制，节省了我们自己做同步控制的工作=。=】

代码中q的join函数是阻塞当前线程。下面是e文注释
>
> Queue.join()
>
>　Blocks until all items in the queue have been gotten and processed(task_done()).
> 学习Processing模块的时候，遇到了进程的join函数。进程的join函数意思说，等待进程运行结束。与这里的Queue的join有异曲同工之妙啊。processing模块学习的文章在这里。
