# aws Redhat 配置
##  基本软件
1. python3   
目前yum能装的是python34, 并且需要启用epel扩展仓库
```
    sudo yum install epel-release
    sudo yum install python34
```
安装 requests, lxml, bs4, pip