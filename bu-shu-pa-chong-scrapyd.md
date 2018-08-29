# 部署爬虫

部署爬虫的两种方案:
- 开源方案 Scrapyd
- Scrapy的付费方案: Scrapy Cloud

scrapyd运行在服务器, 作为一个服务, 接收特定接口的包部署, 运行爬虫的每个服务器都需要

# Scrapyd 的使用

__服务器部署__

## 安装
```
sudo python3 -m pip install scrapyd  # 必须指定scrapyd的python版本, 因为之后默认按这个版本运行爬虫
sudo pip3 install scrapyd
```

## 配置

scrapyd自1.2版本后, 不再自动创建配置文件, 需手动添加
```
sudo mkdir /etc/scrapyd
sudo nano /etc/scrapyd/scrapyd.conf
```
配置文件内容如下: 
[官方demo](https://scrapyd.readthedocs.io/en/stable/config.html#example-configuration-file)
    ```
[scrapyd]
eggs_dir    = eggs
logs_dir    = logs
items_dir   =
jobs_to_keep = 5
dbs_dir     = dbs
max_proc    = 0
max_proc_per_cpu = 4
finished_to_keep = 100
poll_interval = 5.0
bind_address = 0.0.0.0
http_port   = 6800
debug       = off
runner      = scrapyd.runner
application = scrapyd.app.application
launcher    = scrapyd.launcher.Launcher
webroot     = scrapyd.website.Root

[services]
schedule.json     = scrapyd.webservice.Schedule
cancel.json       = scrapyd.webservice.Cancel
addversion.json   = scrapyd.webservice.AddVersion
listprojects.json = scrapyd.webservice.ListProjects
listversions.json = scrapyd.webservice.ListVersions
listspiders.json  = scrapyd.webservice.ListSpiders
delproject.json   = scrapyd.webservice.DeleteProject
delversion.json   = scrapyd.webservice.DeleteVersion
listjobs.json     = scrapyd.webservice.ListJobs
daemonstatus.json = scrapyd.webservice.DaemonStatus
    ```

## 开通服务器的6800端口

- 启动服务器
```
scrapyd
# 或者
systemctl enable scrapyd
```

- 并将scrapyd加入到supervisor来确保始终启用
```
[program:scrapyd]
command=scrapyd              ; the program (relative uses PATH, can take args)
process_name=%(program_name)s ; process_name expr (default %(program_name)s)
;directory=~                ; directory to cwd to before exec (def no cwd)
autostart=true                ; start at supervisord start (default: true)
startsecs=1                   ; # of secs prog must stay up to be running (def. 1)
startretries=3                ; max # of serial start failures when starting (default 3)
autorestart=True        ; when to restart if exited after running (def: unexpected)
stopsignal=KILL               ; signal used to kill process (default TERM)
```

## web端访问
> 访问 http://localhost:6800/





