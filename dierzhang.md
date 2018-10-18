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

软件安装
官网下载, 正常安装即可  
安装目录: `C:\Program Files (x86)\vagrant`
  

## vagrant box管理

- 选择box  
 - 选择网站: https://app.vagrantup.com/boxes/search
 - 在官网上搜索合适的box, 我选择了官方的[centos/7](https://app.vagrantup.com/centos/boxes/7)  


- 列出box
```
vagrant box list
```

- 新增box
```
vagrant box add box_name # 系统将会自动搜索并拉取下来 
vagrant box add name box_path  # 添加本地的box
```

- 删除box
```
vagrant box rm box_name
```
注意: 创建虚拟机时, vagrant会复制并解压一份到特定目录(C:\Users\jizhu\.vagrant.d\boxes\centos-VAGRANTSLASH-7\0\hyperv), 删除box不会影响虚拟机

**手动下载box, 然后添加**
1. 使用下面命令尝试下载, 可以得到box的url
 ```
vagrant up --provide hyperv  # 默认virtualbox
```
2. 下载之后放在任何文件夹下执行
 ```
 vagrant box add centos/7 box_path
 # 执行完之后就可以删除原始box
 ```

## 创建虚拟机

添加好box之后, 就能在本机基于box去创建虚拟机. 创建一个目录, 为项目目录
- 初始化
```
vagrant init box-name  # box-name可以通过vagrant box list来查看
```

- 启动虚拟机
```
vagrant up  # 默认virtualbox
vagrant up --provide hyperv  # 指定hyperv类型
```

- 查看虚拟机状态
```
vagrant status
```

- 暂停虚拟机
```
vagrant suspend
```

- 恢复虚拟机
```
vagrant resume
```

- 彻底关闭虚拟机
```
vagrant halt
```

- 删除虚拟机
```
vagrant destroy
```

- 打包虚拟机
```
vagrant package
vagrant package --output xx.box  # 指定box的名称
```

## 虚拟机ssh连接

- 启动时会显示虚拟机的ip地址
- 默认是密钥登陆, 默认位置: `C:\Users\jizhu\vagrant\centos7\.vagrant\machines\default\hyperv\private_key`

## 虚拟机网络配置
- 虚拟机默认NAT网络, 虚拟机通过宿主机上网
- 配置公开路由, 可以由局域网内其他设备访问:
```
  config.vm.network "public_network", ip: "192.168.2.222"
  # 其他设备便可通过22端口访问
```

## 不推荐的自动创建虚拟机
- cd到要创建虚拟机的位置(我的位于: ~/vagrant/centos7)  
命令行下: 
```
vagrant init centos/7  # 下载vagrant配置文件
```  
- 启动: 
```
vagrant up  # 将会下载镜像, 配置文件
```
 因为windows10安装docker必须开启Hyper-V, 所以虚拟机要以hyperv类型运行
设置vagrant启动时,虚拟机的类型: 
```
vagrant up --provide hyperv  # 默认virtualbox
# 会自动配置好
```





## [虚拟机的一个解释](https://superuser.com/questions/1208850/why-vitualbox-or-vmware-can-not-run-with-hyper-v-enabled-windows-10)
hypervisor虚拟层

VirtualBox and VMware Workstation (or VMware Player) 被称为虚拟管理程序2级.   Hyper-V(hyper-v是windows自带的虚拟化技术) or VMware ESXi 是虚拟管理程序1级. 

虚拟二级是运行在一个OS中的应用, 而虚拟1级就是这个系统. 

当windows10开启了hyperv, 就变成了一台虚拟机.

那么为什么VirtualBox和VMware不能运行在Hyper-V虚拟机里面呢,因为作为一个VM，Intel VT-X指令不再从你的虚拟机中访问，只有主机才能拥有它.





