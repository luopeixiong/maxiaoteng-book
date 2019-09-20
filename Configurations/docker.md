# Docker

## 基本概念

- LXC(Linux Containers)    
操作系统层面化的虚拟技术, 只运行1个内核, 一个虚拟化的可执行内核就是一个容器,可以绑定CPU和内存的使用, 分配特定比例的CPU的时间, IO时间, 容器技术的本质是对对计算机系统资源的隔离和控制

- Docker 是一个虚拟环境的容器.

- Docker特点和应用场景
个人开发机和服务器不是同一个操作环境
应用程序需要不同的应用环境
耗费资源很小

**虚拟机 or 用容器技术**  
1. 一个应用通常需要启动很多服务, 每个服务器需要一个容器, 开发麻烦 
2. Docker桌面环境支持少
> 所以开发使用vagrant虚拟机, 部署使用docker  

## 安装和开始

- 安装软件
官网安装, 目录: `C:\Program Files\Docker`

- 文件目录  
docker pull下载后的文件位置: `C:\Users\Public\Documents\Hyper-V\Virtual Hard Disks`
>**说明: ** windows上的docker本质上还是借助与windows平台的hyper-v创建一个linux虚拟机，你执行的所有命令都是在这个虚拟机里执行的，所有pull到本地的image都会在虚拟机的Virtual hard disks目录的文件中，这个文件就是虚拟硬盘文件（有点类似与vmware的原理）。
因此你打开hyper-v管理器，可以找到docker创建的虚拟机，点击左侧的虚拟机名称，然后再点击右边的移动选项，按照向导将虚拟机移动到其他目录即可。
另外还可以在菜单栏点击:操作->Hyper-v设置，来调整你所有虚拟机的虚拟硬盘文件的默认存储位置

- centos 安装docker
```
# 使用仓库安装
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce
# 使用脚本安装
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# 查看启动
sudo systemctl start docker  # 启动docker
```

- RHEL 安装
踩坑参考(https://stackoverflow.com/questions/45415524/installing-docker-ce-in-redhat/47903707#47903707)

    - 安装
    ```
    sudo yum install -y docker
    ```
    - 错误 (报错: `No package docker available.` 或 `Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable) Requires: container-selinux >= 2.9`)
        - 对于RHEL 7.x以上的系统, docker在 `rhel-7-server-extras-rpms`仓库中, 可以使用如下命令生效:
            `subscription-manager repos --enable=rhel-7-server-extras-rpms`
        - 如果系统(如: aws上的RHEL)没有任何subscription, 可以使用centos的扩充yum源, 方法如下: 
            ```
            sudo vim /etc/yum.repos.d/centos.repo
            
            [CentOS-extras]
            name=CentOS-7-Extras
            mirrorlist=http://mirrorlist.centos.org/?release=7&arch=$basearch&repo=extras&infra=$infra
            #baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch/
            gpgcheck=0
            gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
            ```
    

## 基本操作  
参考[docker命令详解](https://segmentfault.com/a/1190000008876540#articleHeader21)  
[全面教程](https://jiajially.gitbooks.io/dockerguide/content/index.html)

1. 查看docker版本  
    ```
    docker --version
    ```
2. image 查看本地有哪些镜像  
    ```
    docker image ls
    ```
3. search 搜索docker镜像  
    ```
    docker search ubuntu
    ```
4. pull 下载需要的docker镜像  
    ```
    docker pull ubuntu:rolling
    # The centos: **latest** tag is always the most recent version currently available.
    docker pull centos:latest
    ```
5. rmi 删除映像
    ```
    docker rmi image_name  # 删除映像
    docker rmi image_name -f # 强制删除映像
    ```
6. ps/container 查看本地有哪些容器   
    ``` 
    docker container ls  # 只列出正在运行的
    docker container ls --all  # 列出所有, 包括运行结束的
    docker ps  # 查看正在运行的容器
    docker ps --all  # 查看所有的容器
    ```
7. create 创建容器
    ```
    docker create <选项><镜像名称,id><命令><参数>
    --attach="stdin"  # 将标准输入、标准输出、标准错误链接到容器
    --add-host=hello:192.168.0.233  # 向容器的/etc/hosts添加主机名与IP地址
    --link mysql-server:mysql   # 进行容器连接，格式为<容器名称>:<别名>
    --name # 设置容器名称
    --net="bridge" # 设置容器的网络模式（选项可以是：bridge,none,container,host）
    -P、--publish-all=false # 将连接到主机的容器的所有端口暴露在外
    -p、--publish=[]    # 将连接到主机的容器的特定端口暴露在外。一般主要用于暴露web服务器的端口
    -v、--volume=[] # 设置数据卷。设置要与主机共享目录，不将文件保存到容器，而直接保存到主机。在主机目录后添加 :ro、:rw进行读写设置，默认为:rw
    -w、--workdir=""    # 设置容器内部要运行进程的目录
    ```
8. run 启动容器
    ```
    # 参数同create
    docker run <选项><镜像名称，id><命令><参数>
    -d、--detach    # Detach模式，一般为守护进程模式，容器以后台方式运行
    --rm=false  #若容器内的进程终止，则自动删除容器，此选项不能与-d选项一起使用
    --sig-proxy=true    # 将所有信号传递给进程（非TTY模式时也一样），但不传递SIGCHLD、SIGKILL、SIGSTOP信号
    ```
9. start/attach/restart 启动并登陆指定容器
    ```
    docker start 858fd7c6a9d5(container_id)  # 启动一个容器
    docker attach container_name/container_id  # 重新登陆指定容器
    ```
10. pause/unpause 暂停/启动容器
11. exit 退出容器
    ```
    exit  # 即可退出并关闭
    或使用 ctrl + D
    # 退出并后台运行:
    ctrl + P + Q
    或: Ctrl + P , Ctrl + D
    ```
12. logs 查看容器日志
    ```
    docker logs 858fd7c6a9d5(container_id)  # 查看容器的log
    -f # 持续输出
    --tail=7    # 指定数量
    -t  # 显示时间戳 
    ```
13. port 查看容器开放的端口
    ```
    docker port 858fd7c6a9d5(container_id)
    ```
14. cp 容器和外界文件传输
    ```
    sudo docker cp contain_id:/root/DTP/output.xlsx ~/new_dir/
    ```
15. top 查看容器进程信息
    ```
    docker top 858fd7c6a9d5(container_id) aux  # 查看容器的进程
    ```
16. exec 从外部运行内部的命令
    ```
    docker exec -it 858fd7c6a9d5(container_id) /bin/bash  # 连接容器
    ps ax
    ```
17. export 容器持久化
    ```
    # 不保存历史的导入导出
    docker export contain_id > ./new_contain.tar
    ```
18. save 
    ```
    # 保存历史的导入导出
    docker save contain_id > ./new_contain.tar
    ```

19. import 容器的导入
    ```
    docker import dtp_container.tar dtp  # 容器的名称将是dtp
    ```

20. commit 容器制作镜像
    ```
    # 根据容器的改变生成一个新的镜像
    docker commit contain_id ./new_image.tar
    ```

21. rm 删除容器操作
    ```
    docker rm container_id/container_name  # 删除容器
    ```
22. rmi 删除镜像
    ```
    docker rmi image_name  # 删除镜像
    ```

23. info 显示当前系统信息、docker容器、镜像个数、设置等信息。
    ```
    docker info
    ```

24. 使用特权运行docker[https://blog.51cto.com/lizhenliang/1975466](https://blog.51cto.com/lizhenliang/1975466)
    ```
    docker run -d -name centos7 --privileged=true centos:7 /usr/sbin/init    
    ```

## 说明

windows10安装了docker,要求启用hyper-v来运行运行docker的虚拟机MobyLinuxVM, 所以需要重启

启用关闭Hyper-V的方法:
- 管理员身份打开PowerShell
- bcdedit  # 查看Hyper-V是否启用
- bcdedit /set hypervisorlaunchtype auto  # 设置为启动


## 用户管理
Docker守候进程绑定的是一个unix  socket，而不是TCP端口。这个套接字默认的属主是root，其他是用户可以使用sudo命令来访问这个套接字文件。因为这个原因，docker服务进程都是以root帐号的身份运行的。

为了避免每次运行docker命令的时候都需要输入sudo，可以创建一个docker用户组，并把相应的用户添加到这个分组里面。当docker进程启动的时候，会设置该套接字可以被docker这个分组的用户读写。这样只要是在docker这个组里面的用户就可以直接执行docker命令了。

- 查看docker相关的分组
```
sudo cat /etc/group | grep docker
```

- 创建分组, 添加用户
```
sudo groupadd -g 999 docker   # 999是分组id, 可不指定
# 添加用户
sudo usermod -aG dockerroot ec2-user
sudo usermod -aG docker ec2-user
```

- 确认创建成功
```
cat /etc/group
```

- 重启
```
sudo systemctl restart docker
```

- 确认能否直接运行
```
docker info
# 如果提示权限不足
sudo chmod a+rw /var/run/docker.sock
```