# Nas

契机是和LP讨论生日礼物，想要移动硬盘，我的理解是这种东西安全性很差，数据很容易丢失，遂研究了公有云，又到NAS

## 1. 选购
- 1k左右的西部数据，功能太少
- 2k群晖  ARM架构的处理器，不支持docker
- 发现了公司用的terra master，同样价格用的Intel的处理器，2G内存

最终选定F2-220，搭配单硬盘共1950元

## 2. 配置
1. 系统
   1. 安装系统，
   2. 但十分不好用，资源也少，其实是不推荐的
2. 网络
   1. 由于用光猫拨号，所以设置路由器为DMZ主机，又将NAS作为路由器的DMZ主机
   2. 动态IP解决(每次断电，再次拨号都会换IP)，域名解析
      1. 花生壳，不考虑，域名太长，据说有流量限制，收费限制多  -- 失败
      2. dyndns 反应慢，没有成功  -- 失败
      3. 路由器的ddns，TPlink不能登陆TPlinkID  -- 失败
      4. 最终使用dnspod动态解析  -- 成功
         1. 配置好二级域名解析nas,类型A
         2. 获取动态解析的API token
         3. 采用脚本部署到nas[https://github.com/kkkgo/dnspod-ddns-with-bashshell](https://github.com/kkkgo/dnspod-ddns-with-bashshell)
         4. TOS垃圾，curl命令都没有，ssh登陆到root账号，创建了centos7的docker系统，然后配置脚本和定时任务，OK
3. Docker  
系统很残，还是需要docker来做
   1. mxt_centos
      1. run
        ```
        docker run -itd -p 22222:22 -v /root/centos:/root --name mxt_centos --privileged=true docker/mxt_centos /usr/sbin/init
        docker exec -it docker_id /bin/bash
        ```
      2. crontab
         1. 系统缺少curl等命令, 但是docker对crontab的支持不好用, 最终解决如下
        ```
        /mnt/md0/application/bin/docker exec mxt_centos /bin/bash -c "cd /root & /usr/bin/sh /root/dnspod_ddns.sh >/root/cron.log"
        ```
      3. dnspod 动态ip绑定域名
        ```
        # 定时任务crontab来配置域名动态解析
        */10 * * * * sh /home/dnspod_ddns.sh >/home/cron.log

        # /home/dnspod_ddns.sh
        #Dnspod DDNS with BashShell
        #Github:https://github.com/kkkgo/dnspod-ddns-with-bashshell
        #More: https://03k.org/dnspod-ddns-with-bashshell.html
        #CONF START
        API_ID=111374
        API_Token=2551604e10be0d939b50e56d4ea1ae3f
        domain=maxiaoteng.xyz
        host=nas
        CHECKURL="http://ip.03k.org"
        #OUT="pppoe"
        #CONF END
        . /etc/profile
        date
        if (echo $CHECKURL |grep -q "://");then
        IPREX='([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]{1,2}|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'
        URLIP=$(curl -4 -k $(if [ -n "$OUT" ]; then echo "--interface $OUT"; fi) -s $CHECKURL|grep -Eo "$IPREX"|tail -n1)
        if (echo $URLIP |grep -qEvo "$IPREX");then
        URLIP="Get $DOMAIN URLIP Failed."
        fi
        echo "[URL IP]:$URLIP"
        dnscmd="nslookup";type nslookup >/dev/null 2>&1||dnscmd="ping -c1"
        DNSTEST=$($dnscmd $host.$domain)
        if [ "$?" != 0 ]&&[ "$dnscmd" == "nslookup" ]||(echo $DNSTEST |grep -qEvo "$IPREX");then
        DNSIP="Get $host.$domain DNS Failed."
        else DNSIP=$(echo $DNSTEST|grep -Eo "$IPREX"|tail -n1)
        fi
        echo "[DNS IP]:$DNSIP"
        if [ "$DNSIP" == "$URLIP" ];then
        echo "IP SAME IN DNS,SKIP UPDATE."
        exit
        fi
        fi
        token="login_token=${API_ID},${API_Token}&format=json&lang=en&error_on_empty=yes&domain=${domain}&sub_domain=${host}"
        Record="$(curl -4 -k $(if [ -n "$OUT" ]; then echo "--interface $OUT"; fi) -s -X POST https://dnsapi.cn/Record.List -d "${token}")"
        iferr="$(echo ${Record#*code}|cut -d'"' -f3)"
        if [ "$iferr" == "1" ];then
        record_ip=$(echo ${Record#*value}|cut -d'"' -f3)
        echo "[API IP]:$record_ip"
        if [ "$record_ip" == "$URLIP" ];then
        echo "IP SAME IN API,SKIP UPDATE."
        exit
        fi
        record_id=$(echo ${Record#*\"records\"\:\[\{\"id\"}|cut -d'"' -f2)
        record_line_id=$(echo ${Record#*line_id}|cut -d'"' -f3)
        echo Start DDNS update...
        ddns="$(curl -4 -k $(if [ -n "$OUT" ]; then echo "--interface $OUT"; fi) -s -X POST https://dnsapi.cn/Record.Ddns -d "${token}&record_id=${record_id}&record_line_id=${record_line_id}")"
        ddns_result="$(echo ${ddns#*message\"}|cut -d'"' -f2)"
        echo -n "DDNS upadte result:$ddns_result "
        echo $ddns|grep -Eo "$IPREX"|tail -n1
        else echo -n Get $host.$domain error :
        echo $(echo ${Record#*message\"})|cut -d'"' -f2
        fi
        ``` 
   2. mysql
    ```
    docker create -p 3306:3306 --name docker_mysql -v /root/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password mysql
    ``` 
   3. baiduyun
      1. 参考地址：https://github.com/john-shine/Docker-CodeWeavers_CrossOver-VNC/tree/master/BaiduNetdisk
    ```
    docker run -d -p 5901:5901 -v /mnt/md0/public/baiduyun:/mnt/drive_d -e vnc_password=password johnshine/baidunetdisk-crossover-vnc:latest
    ``` 
   4. 


## 3. 系统OMV
1. 安装
    1. 常用安装
        1. 使用U盘刻录omv系统镜像, 软件[balena](https://www.balena.io/etcher/)
        2. 将系统和系统U盘插入, 自动安装和启动 
    2. 也可以用虚拟机也可以安装后插入到主机上, 见[无显示器安装](https://forum.openmediavault.org/index.php/Thread/3453-Installing-OMV-w-o-keyboard-and-monitor-using-VirtualBox/)
        1. 网络配置有问题
2. 配置
    1. 服务
        1. web页面
            1. omv-firstaid设置
            2. 端口: 8181
        2. ssh
            1. 端口: 9222
        3. docker
        4. ftp
        5. smb
    2. 插件
        1. lvm
        2. omv extra
            1. ```wget http://omv-extras.org/openmediavault-omvextrasorg_latest_all4.deb
                dpkg -i openmediavault-omvextrasorg_latest_all4.deb
                ```
    3. 文件系统
        1. wipe擦写磁盘
        2. 创建raid(可选)
        3. 创建lvm分区, 并挂载
    4. 在分区上建立共享目录
        1. 