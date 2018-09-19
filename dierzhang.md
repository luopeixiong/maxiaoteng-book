# 使用Vagrant
使用virtualbox的api操作虚拟机  

## 说明

**Box**  
就是一个箱子, 实际就是一个zip包, 里面包含了vagrant的配置信息, 虚拟机镜像文件以及构建环境等.


**特点**  
1. 快速完成部署
2. 支持多种虚拟机系统
3. 内置配置管理支持
**缺点**  
1. 维护更新不及时
2. 积累issue太多,解决不及时

解决办法: 查找稳定版本的副本, 或者配置自己的副本并保持更新


## 安装并开始

1. 软件安装
官网下载, 正常安装即可  
安装目录: `C:\Program Files (x86)\vagrant`
  
2. 安装vagrant box
在官网上搜索合适的box, 我选择了官方的[centos/7](https://app.vagrantup.com/centos/boxes/7)  
cd到要创建虚拟机的位置(我的位于: ~/vagrant/centos7)  
命令行下: ```vagrant init centos/7  # 下载vagrant配置文件```  
启动: ```vagrant up  # 将会下载镜像, 配置文件```

设置vagrant启动时,虚拟机的类型: 
```
vagrant up --provide hyperv  # 默认virtualbox
```
   

## 冲突

1. hyper-v是windows自带的虚拟化技术，hypver-v管理器是它的控制程序，可以对hyper-v进行设置和操作。你可以把hyper-v和hyper-v管理器理解成windows自带的virtualbox

2. docker确实是在MobyLinuxVM的hyper-v虚拟机中运行的
所以docker需要开启hyperv
3. 

## [虚拟机的一个解释](https://superuser.com/questions/1208850/why-vitualbox-or-vmware-can-not-run-with-hyper-v-enabled-windows-10)
hypervisor虚拟层

VirtualBox and VMware Workstation (or VMware Player) 被称为虚拟管理程序2级. Hyper-V or VMware ESXi 是虚拟管理程序1级. 虚拟二级是运行在一个OS中的应用, 而虚拟1级就是这个系统. 

当windows10开启了hyperv, 就变成了一台虚拟机.
那么为什么VirtualBox和VMware不能运行在Hyper-V虚拟机里面呢,因为作为一个VM，Intel VT-X指令不再从你的虚拟机中访问，只有主机才能拥有它.





