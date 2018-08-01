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

- python3   
目前yum能装的是python34, pip, 并且需要启用epel扩展仓库

```
sudo yum install python34
```

安装 requests, lxml, bs4, pip

```
```

