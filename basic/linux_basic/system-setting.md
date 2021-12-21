# 系统设置

## 1. 修改dns
    ```
    vim /etc/resolv.conf
    nameserver 172.24.73.130
    nameserver 172.24.73.131
    ```

- centos7引入新的机制
重启服务
```
# 查询 
nmcli connection show
    > 显示:
    NAME    UUID    TYPE    DEVICE
    em1 5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03    802-3-ethernet  em1

# 添加配置
nmcli con mod em01 ipv4.dns "114.114.114.114 8.8.8.8"

# 重启服务
nmcli con up em1

## 注意: em1对应show命令查询的name
```

- Ubuntu修改方式:
```
sudo vim /etc/resolvconf/resolv.conf.d/base
    # 添加多条
    nameserver 8.8.8.8
    nameserver 8.8.8.8
# 执行如下, /etc/resolv.conf 便发生了更改
resolvconf -u
```

- 方法三, 简单粗暴
```
# 将文件变成只读, 修改成自己期望的即可
chattr +i /etc/resolv.conf
chattr -i /etc/resolv.conf
```

## 2. 自启动
1. chkconfig 查看自启动的服务

2. 生效禁用
    ```
    sudo systemctl disable/enable squid.service
    # 禁用输出 Removed symlink /etc/systemd/system/multi-user.target.wants/squid.service.
    ```