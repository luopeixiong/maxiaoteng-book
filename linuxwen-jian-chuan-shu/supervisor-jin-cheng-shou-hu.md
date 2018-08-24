# supervisor 进程守护

用来确保进程中断后的自动重启

## 安装
```
sudo yum install supervisor
```

## 启动
```
supervisord  # 启动supervisor服务

supervisord -c /etc/supervisord.conf
supervisorctl -c /etc/supervisord.conf status
    > mongodb       RUNNING   pid 2366, uptime 0:01:00
    ...
```

## 配置
> 配置文件位置:```/etc/supervisor/conf.d/..```
> 每个进程设一个配置文件, 以conf结尾
> 内容:
```
[program:mongodb]
command =  /usr/bin/mongod -port 27017 --dbpath /vr/lib/mongo
autostart = true     ; 在 supervisord 启动的时候也自动启动
startsecs = 5        ; 启动 5 秒后没有异常退出，就当作已经正常启动了
autorestart = true   ; 程序异常退出后自动重启
startretries = 3     ; 启动失败自动重试次数，默认是 3
```

- 重启supervisor
    service supervisor restart
    
- 启动相应进程
    supervisorctl start app
    
- 停止进程   
    supervisorctl start app

- 停止所有进程   
    supervisorctl start all
    
- 载入新的配置文件   
    supervisorctl reload
    
- 更新修改的配置文件, 没改变的不影响   
    supervisorctl update
    
## web界面管理

修改supervisord.conf的 inet_http_server部分

```
[inet_http_server]           ; inet (TCP) server disabled by default
port=192.168.10.129:9001     ; 外网ip(ip_address:port specifier, *:port for all iface)
username=xxxxxxx             ; (default is no username (open server))
password=xxxxxxx             ; (default is no password (open server))
```
