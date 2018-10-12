# 虚拟机配置

## 安装系统
centos7

## 安装软件

- epel yum 扩展源
- python36 
- pip 
- virtualenv
- nano
- git

## 虚拟机和本机共享文件

- 虚拟机安装sshfs
```
sudo yum install sshfs
# 如果无法安装, 则需要扩展epel
sudo yum install epel-release
```

- windows安装win-sshfs
[安装说明](https://www.jianshu.com/p/d79901794e3d)

