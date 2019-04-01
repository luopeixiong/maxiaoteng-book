# other

1. 为终端设置代理

    ```Shell
    set http_proxy=http://127.0.0.1:1080
    set https_proxy=http://127.0.0.1:1080
    ```

2. 查看ip

    ```Shell
    # 已被弃用
    ifconfig: command not found
    #等价于
    ip addr show
    ```

3. diff

    ```Shell
    # 比较文件
    diff file1 file2
    # 比较文件夹
    diff -urNa dir1 dir2
    ```

4. curl

    ```Shell
    curl -O http://mirror.bit.edu.cn/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz  # 用于下载文件，按服务器上的文件名保存
  
    curl -o filename url     # 文件下载后重命名为filename 
    ```

## 1. top命令
  
    ```Shell
        top

    ```
1. 查看内存占用等
    1. 使用 e/E 切换内存显示的单位


## 2. 查看端口命令
1. netstat
    ```
    netstat -tunlp  # 用于显示tcp, udp的端口和进程的相关情况
        -t (tcp) 仅显示tcp相关选项
        -u (udp)仅显示udp相关选项
        -n 拒绝显示别名，能显示数字的全部转化为数字
        -l 仅列出在Listen(监听)的服务状态
        -p 显示建立相关链接的程序名
    netstat -tunlp |grep 8000   # 查看8000端口的占用情况
    ```

2. lsof  是一个列出当前系统打开文件的工具
    ```
    lsof
    lsof -i:8080：查看8080端口占用
    lsof abc.txt：显示开启文件abc.txt的进程
    lsof -c abc：显示abc进程现在打开的文件
    lsof -c -p 1234：列出进程号为1234的进程所打开的文件
    lsof -g gid：显示归属gid的进程情况
    lsof +d /usr/local/：显示目录下被进程开启的文件
    lsof +D /usr/local/：同上，但是会搜索目录下的目录，时间较长
    lsof -d 4：显示使用fd为4的进程
    lsof -i -U：显示所有打开的端口和UNIX domain文件
    ```

## 3. kill命令
1. netstat查看到占用,使用kill杀掉进程
    ```
    kill -9 pid
    kill pid
    kill 
    ```

1. 给予root权限，文件夹的所有文件
    ```
        sudo chmod -R 777 ./dir/*
        sudo chown -R  maxiaoteng ./dir/*  # 修文件所有人
    ```

## 4. 快捷键
# 命令行技巧

1. 删除整行
    ctrl+u

2. 删除前一个单词
    ctrl+w

3. 不删除直接下一行重新输入
    ctrl+c


## 5. 运维命令

1. 一条命令杀进程

    ```
    ps -efww|grep -w 'process_test.py'|grep -v grep|cut -c 9-15|xargs kill -9

    ```
    - ps -ef    查看所有进程命令
    - grep -w   是强制PATTERN仅完全匹配字符
    - grep -v grep  列出的进程中去除含有grep的进程
    - cut -c 9-15   截取pid号
    - kill -9   强行杀掉制定进程(通过杀掉关联进程)