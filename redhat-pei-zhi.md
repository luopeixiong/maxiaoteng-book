# aws 服务器配置
## 环境
**Red Hat Enterprise Linux (RHEL) 7**


## 1. yum说明
Yum（全称为 Yellow dog Updater, Modified）是一个在Fedora和RedHat以及CentOS中的Shell前端软件包管理器。基于RPM包管理，能够从指定的服务器自动下载RPM包并且安装，可以自动处理依赖性关系，并且一次安装所有依赖的软件包，无须繁琐地一次次下载、安装

- 安装并启用EPEL rpm软件包
ELEP: Extra Packages for Enterprise Linux的简称，是为企业级Linux提供的一组高质量的额外软件包
```
sudo yum install –y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```

- 安装软件包
```
sudo yum install -y python36  # -y为自动应答
```

- 升级软件包
```
sudo yum check-update  # 检查更新
sudo yum update  # 升级所有
sudo yum update tomcat  # 升级特定软件包
```

- 查看已安装软件
```
yum list installed
```

- 查看软件包的描述信息
```
yum info tomcat
```

- 卸载软件包
```
sudo yum remove tomcat
```

## 2. 基本软件

### - 先查看可安装包, 比如:
```
sudo yum list| grep python3
```

## 安装python36 和 pip
```
sudo yum install python36
# 虽然3.4之后默认包含pip, 但我的版本太纯净没有pip
python36 -m pip --version
> /usr/bin/python36: No module named pip
# 安装pip
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python3.6 get-pip.py

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
$ sudo pip install pip -U -q  # 静默安装, 升级
$ pip --version
$ sudo python3 -m pip install requests lxml bs4  //要想使用这种, 需要安装

```
  第二种方法:
```
// 如果想安装setuptools, 使用以下方法:
$ sudo yum install python36-setuptools
$ sudo easy_install-3.6 pip
$ sudo pip3 install requests lxml bs4
```
