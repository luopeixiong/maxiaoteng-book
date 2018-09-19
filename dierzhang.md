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
  
2. 安装vagrant box
 在官网上搜索合适的box, 我选择了官方的[centos/7](https://app.vagrantup.com/centos/boxes/7)  
 cd到要创建虚拟机的位置(我的位于: ~/vagrant/centos7)  
 命令行下: ```vagrant init centos/7  # 下载vagrant配置文件```  
 启动: ```vagrant up  # 将会下载镜像, 配置文件```
   





