# Process Status -- ps进程查看

ps显示进程快照，使用top动态的显示进程信息

## 1. 

1. linux上进程有五种状态
   - 运行(正在运行或在运行队列中等待)
   - 中断(休眠中, 受阻, 在等待某个条件的形成或接受到信号)
   - 不可中断(收到信号不唤醒和不可运行, 进程必须等待直到有中断发生)
   - 僵死(进程已终止, 但进程描述符存在, 直到父进程调用wait4()系统调用后释放)
   - 停止(进程收到SIGSTOP, SIGTSTP, SIGTTIN, SIGTTOU信号后停止运行运行)

2. ps工具表示进程的五种状态
   - D 不可中断 uninterruptible sleep (usually IO)
   - R 运行 runnable (on run queue)
   - S 中断 sleeping
   - T 停止 traced or stopped
   - Z 僵死 a defunct (”zombie”) process

3. 命令参数

   - a 显示所有进程
   - -a 显示同一终端下的所有程序
   - -A 显示所有进程
   - c 显示进程的真实名称
   - -N 反向选择
   - -e 等于“-A”
   - e 显示环境变量
   - f 显示程序间的关系
   - -H 显示树状结构
   - r 显示当前终端的进程
   - T 显示当前终端的所有程序
   - u 指定用户的所有进程
   - -au 显示较详细的资讯
   - -aux 显示所有包含其他使用者的行程
   - -C<命令> 列出指定命令的状况
   - –lines<行数> 每页显示的行数
   - –width<字符数> 每页显示的字符数
   - –help 显示帮助信息
   - –version 显示版本显示

4. 输出列的含义
   - F 代表这个程序的旗标 (flag)， 4 代表使用者为 super user
   - S 代表这个程序的状态 (STAT)，关于各 STAT 的意义将在内文介绍
   - UID 程序被该 UID 所拥有
   - PID 进程的ID
   - PPID 则是其上级父程序的ID
   - C CPU 使用的资源百分比
   - PRI 这个是 Priority (优先执行序) 的缩写，详细后面介绍
   - NI 这个是 Nice 值，在下一小节我们会持续介绍
   - ADDR 这个是 kernel function，指出该程序在内存的那个部分。如果是个 running的程序，一般就是 “-“
   - SZ 使用掉的内存大小
   - WCHAN 目前这个程序是否正在运作当中，若为 - 表示正在运作
   - TTY 登入者的终端机位置
   - TIME 使用掉的 CPU 时间。
   - CMD 所下达的指令为何

5. 常用
    ```
        # 显示所有进程
        ps -A
        # 显示指定用户
        ps -u root

        # 显示所有进程，连同命令行
        ps -ef

        # ps grep 组合
        ps -ef|grep ssh

        # 列出所有正在内存中的程序
        ps aux
    ```