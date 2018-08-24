# supervisor 进程守护

用来确保进程中断后的自动重启

## 安装
```
sudo yum install supervisor

supervisord  # 启动supervisor服务
```

## 配置
> 配置文件位置:```/etc/supervisor/conf.d/..```
> 每个进程设一个配置文件, 以conf结尾
> 内容:
```
[program:app]  # 进程名
command=/usr/bin/gunicorn -w 1 wsgiapp:application  # 进程命令 
directory=/srv/www  # 进程当前目录
user=ec2-user  # 进程运行的用户名
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
