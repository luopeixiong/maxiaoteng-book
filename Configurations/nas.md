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