# aws 服务器配置
## 环境
**Red Hat Enterprise Linux (RHEL) 7**


## 1. 安装并启用EPEL rpm软件包
ELEP: Extra Packages for Enterprise Linux的简称，是为企业级Linux提供的一组高质量的额外软件包
```
sudo yum install –y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```


## 2. 基本软件

### - 先查看可安装包, 比如:
```
sudo yum list| grep python3
```

### - python34   
发现可以安装的最新版本是python36, 但是没有python36-pip, 不便于管理, 安装python34

```
$ sudo yum install python34
$ type -a python34    //type 命令查看命令的路径
python34 is /usr/bin/python34
$ sudo ln /usr/bin/python34 /usr/bin/python3    //建立软连接, 更便于访问
$ type -a python3
python3 is /usr/bin/python3

```

### - 安装 pip, requests, lxml, bs4

```
$ sudo yum install python34-pip
$ sudo python3 -m pip install requests lxml bs4  //要想使用这种, 需要安装

```
  第二种方法:
```
// 如果想安装setuptools, 使用以下方法:
$ sudo yum install python36-setuptools
$ sudo easy_install-3.6 pip
$ sudo pip3 install requests lxml bs4
```

