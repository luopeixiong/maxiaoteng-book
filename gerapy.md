## 安装

- 在aws上安装 系统amazon linux, python版本:python36
```
sudo python3 -m pip install gerapy 
```

- 出现错误
```
gcc -pthread -Wno-unused-result -Wsign-compare -DDYNAMIC_ANNOTATIONS_ENABLED=1 -DNDEBUG -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -D_GNU_SOURCE -fPIC -fwrapv -fPIC -I/usr/include/python3.6m -c src/twisted/test/raiser.c -o build/temp.linux-x86_64-3.6/src/twisted/test/raiser.o
    src/twisted/test/raiser.c:4:20: fatal error: Python.h: No such file or directory
     #include "Python.h"
                        ^
    compilation terminated.
**error: command 'gcc' failed with exit status 1**
```

- 解决方案:
```
sudo yum install python36-devel libxml2-devel libxslt-devel
sudo yum install gcc
**注意: 安装python-devel需要指定版本, 可解决问题**
```

- 验证成功
```
gerapy 
显示:
> Usage:
  gerapy init [--folder=<folder>]
  gerapy migrate
  gerapy createsuperuser
  gerapy runserver [<host:port>]
```

## 启动服务

1. 初始化
```
gerapy init
```
1. 执行完毕后, 本地生成gerapy文件夹, 进入后, 看到projects文件夹
```
cd gerapy
gerapy migrate  # 将会生成一个SQLite数据库, 同时建立数据库表
```
1. 启动服务, gerapy将会运行在6800端口
```
gerapy runserver
```

## 说明

gerapy其实是用来管理多个scrapyd的服务器, 所以没必要运行在多个服务器上, 
我可以运行在巴西1 或者本地都可以.


