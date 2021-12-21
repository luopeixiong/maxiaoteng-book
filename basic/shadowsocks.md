# Shadowsocks

[安装参考教程：https://doub.io/ss-jc5/](https://doub.io/ss-jc5/)

1. 一键安装脚本 sh ssr.sh  
可以用来配置各种参数

2. 2019.3.1 发现vpn无法使用
    1. 之前的办法是重启aws来更换ip，
    1. 这次通过尝试将443换为27233之后可以正常访问，这样就不用修改域名的绑定啦！
    1. 之前27233运行着squid，没什么用就关闭了