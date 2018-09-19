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

- 基本操作  
```
# 查看docker版本
docker --version

# 运行实例hello-world
# 自动下载image并运行, 展示一个基本工作流程
docker run hello-world  


# 查看本地有哪些镜像
docker image ls

# 查看本地有哪些容器
# 容器对应本地针对镜像运行起来的实例
docker container ls  # 只列出正在运行的
docker container ls --all  # 列出所有, 包括运行结束的

# 搜索docker镜像
docker search ubuntu

# 下载需要的docker镜像
docker pull ubuntu:rolling
# The centos:`latest tag` is always the most recent version currently available.
docker pull centos:latest

```