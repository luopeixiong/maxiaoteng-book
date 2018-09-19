
## 包管理和虚拟环境

- 包安装方法    
通过Python社区开发的pip, easy_install等工具   
使用系统本身自带的包管理器(yum, apt-get)      
通过源码安装     

- pip 安装
```
sudo yum install python-pip -yq
sudo pip install pip -U -q  # -q表示静默安装  
pip --version  # 查看版本
```
- virtualenv安装    
```
sudo pip install virtualenv  # 安装virtualenv
virtualenv venv  # 启动一个虚拟环境
source venv/bin/activate  # 生效一个虚拟环境
(venv)>which python
> /home.../bin/python
(venv)>deactivate  # 退出虚拟环境
```

- 使用pipenv管理一个项目


## 使用Docker

**概念**  
- LXC(Linux Containers)   
操作系统层面化的虚拟技术, 只运行1个内核, 一个虚拟化的可执行内核就是一个容器,可以绑定CPU和内存的使用, 分配特定比例的CPU的时间, IO时间, 容器技术的本质是对对计算机系统资源的隔离和控制 

- Docker 是一个虚拟环境的容器.

**Docker特点和应用场景**

1. 个人开发机和服务器不是同一个操作环境
2. 应用程序需要不同的应用环境
3. 耗费资源很小

**虚拟机 or 用容器技术**
1. 一个应用通常需要启动很多服务, 每个服务器需要一个容器, 开发麻烦
2. Docker桌面环境支持少

### 使用


## 使用vim

## 学习Emacs

## Pycharm安装和使用

## 使用IPython

## Web开发环境配置

