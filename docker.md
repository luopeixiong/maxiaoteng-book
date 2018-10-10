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

## 基本操作  

- 查看docker版本  
```
docker --version
```
  
- 运行实例hello-world  
```
# 自动下载image并运行, 展示一个基本工作流程  
docker run hello-world   
```

## 映像image  
- 查看本地有哪些镜像  
```
docker image ls
```

- 搜索docker镜像  
```
docker search ubuntu
```

- 下载需要的docker镜像  
```
docker pull ubuntu:rolling
# The centos: **latest** tag is always the most recent version currently available.
docker pull centos:latest
```

- 删除映像
```
docker rmi image_name  # 删除映像
docker rmi image_name -f # 强制删除映像
```

## 容器Container
容器对应本地针对镜像运行起来的实例

- 启动使用  
```
docker run -it centos  # 即可进入虚拟机
cat /etc/issue
uname 
uname -a
```

- 查看本地有哪些容器   
``` 
docker container ls  # 只列出正在运行的
docker container ls --all  # 列出所有, 包括运行结束的
docker ps  # 查看正在运行的容器
docker ps --all  # 查看所有的容器
```

- 查看容器日志
```
docker logs 858fd7c6a9d5(container_id)  # 查看容器的log
```

- 启动并登陆指定容器
```
docker start 858fd7c6a9d5(container_id)  # 启动一个容器
docker attach container_name/container_id  # 重新登陆指定容器
```

- 退出容器
```
exit  # 即可退出
或使用 ctrl + D
```

- 删除容器操作
```
docker rm container_id/container_name  # 删除容器
```


## 说明

windows10安装了docker,要求启用hyper-v来运行运行docker的虚拟机MobyLinuxVM, 所以需要重启

启用关闭Hyper-V的方法:
- 管理员身份打开PowerShell
- bcdedit  # 查看Hyper-V是否启用
- bcdedit /set hypervisorlaunchtype auto  # 设置为启动
