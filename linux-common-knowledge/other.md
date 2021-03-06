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
    curl -C 200 url     # 支持断点续传, 200为最小片段
    curl --interface ppp0(192.168.0.0) https://httpbin.org/ip   # 指定网络出口
    ```

5. wget

    ```Shell
    wget -c -b https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/2020.csv.gz
    -c 断点续传
    -b 后台运行
    # 添加代理
    -e "http_proxy=http://10.40.36.196:3389" https://github.com/yichengchen/clashX/releases/download/1.31.3/ClashX.dmg
    ```

6. scp

    ```Shell
    scp src_dir target_dir

    # eg:
    scp -l 1000 -r /root/2021.csv.gz xiaoteng@10.9.62.123:/home/xiaoteng/code/aspex_codes/src/utils/

    -r 迁移目录
    -l 限制带宽, Kbit/s
    ```

## 1. top命令
  
1. 查看内存占用等
    1. 使用 e/E 切换内存显示的单位

    ```Shell
        top

    ```

## 2. 查看端口命令

1. netstat

    ```shell
    netstat -tunlp  # 用于显示tcp, udp的端口和进程的相关情况
        -t (tcp) 仅显示tcp相关选项
        -u (udp)仅显示udp相关选项
        -n 拒绝显示别名，能显示数字的全部转化为数字
        -l 仅列出在Listen(监听)的服务状态
        -p 显示建立相关链接的程序名
    netstat -tunlp |grep 8000   # 查看8000端口的占用情况
    ```

2. lsof  是一个列出当前系统打开文件的工具

    ```shell
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

    ```shell
    kill -9 pid
    kill pid
    kill 
    ```

1. 给予root权限，文件夹的所有文件

    ```shell
    sudo chmod -R 777 ./dir/*
    sudo chown -R  maxiaoteng ./dir/*  # 修文件所有人
    ```

## 4. 快捷键

1. 删除整行
    ctrl+u

2. 删除前一个单词
    ctrl+w

3. 不删除直接下一行重新输入
    ctrl+c

## 5. 运维命令

1. 一条命令杀进程

    ```shell
    ps -efww|grep -w 'process_test.py'|grep -v grep|cut -c 9-15|xargs kill -9

    ```

    - ps -ef    查看所有进程命令
    - grep -w   是强制PATTERN仅完全匹配字符
    - grep -v grep  列出的进程中去除含有grep的进程
    - grep -A/-B/-C 20  过滤时会展示目标行前/后/前后 20条内容
    - grep -E '成功|失败'  使用正则匹配目标行
    - cut -c 9-15   截取pid号
    - kill -9   强行杀掉制定进程(通过杀掉关联进程)

## 6. 语言问题

nas是debian系统, 无法输入和显示中文

1. 添加语言支持

    ```bash
        apt install -y locale
        locales dpkg-reconfigure locales
        # 选择Zh开头的
        # 输入法不一定需要
    ```

2. 配置locale
    1. 默认locale: /etc/default/locale
    2. ~/.bashrc 优先级最高, 在这里设置

        ```bash
            export LANG="en_US.UTF-8"
            export LC_CTYP="en_US.UTF-8"
            export LC_NUMERIC="en_US.UTF-8"
            export LC_TIME="en_US.UTF-8"
            export LC_COLLATE="en_US.UTF-8"
            export LC_MONETARY="en_US.UTF-8"
            export LC_MESSAGES="en_US.UTF-8"
            export LC_PAPER="en_US.UTF-8"
            export LC_NAME="en_US.UTF-8"
            export LC_ADDRESS="en_US.UTF-8"
            export LC_TELEPHONE="en_US.UTF-8"
            export LC_MEASUREMENT="en_US.UTF-8"
            export LC_IDENTIFICATION="en_US.UTF-8"
            export LC_ALL=
        ```

3. 生效
    1. source ~/.bashrc

## 7. debian设置时区

```bash
# vim /etc/timezone
Asia/Shanghai

# ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
或者
# cp -a /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```
