# aws 服务器配置
## 环境
**Red Hat Enterprise Linux (RHEL) 7**


## 1. 安装并启用EPEL rpm软件包
ELEP: Extra Packages for Enterprise Linux的简称，是为企业级Linux提供的一组高质量的额外软件包
```
sudo yum install –y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```


## 2. 基本软件
- 先查看可安装包, 比如:
```
sudo yum list| grep python3
```

- python36   
发现可以安装的最新版本是python36, 使用python3 启动

```
$ sudo yum install python36
$ type -a python36    //type 命令查看命令的路径
python36 is /usr/bin/python36
$ sudo ln /usr/bin/python36 /usr/bin/python3    //建立软连接, 更便于访问
$ type -a python3
python3 is /usr/bin/python3

```

安装 requests, lxml, bs4, pip

```
$ yum install python36-setuptools
$ easy_install-3.6 pip
$ sudo python3 -m pip install requests lxml bs4 
$ sudo pip3 install requests lxml bs4
```

