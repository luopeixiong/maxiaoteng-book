# supervisor 进程守护

用来确保进程中断后的自动重启

## 安装
```
sudo yum install supervisor
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