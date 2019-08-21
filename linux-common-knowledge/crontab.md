# Cron

## 1. 命令的使用

1. 列出当前任务
```
crontab -l 
```
2. 备份当前任务列表	
```
crontab -l > my_cron   
```
3. 编辑一个命令文件      
```
nano my_crontab
```
4. 将编辑好的命令生效  
```
crontab my_crontab 
```
5. 重启crond
```
service crond restart
```

### 直接编辑
不建议这么做，通常是编辑文件然后生效，这样确保有备份
```
crontab -e  # 任何用户都可以用
vim /etc/crontab  # 仅限root用户, 通常用于给其他用户指定定时任务, 或者需要root来运行任务
```

## 2. 命令格式
	
```
# 文件格式说明
#  ——分钟（0 - 59）
# |  ——小时（0 - 23）
# | |  ——日（1 - 31）
# | | |  ——月（1 - 12）
# | | | |  ——星期（0 - 7，星期日=0或7）
# | | | | |
# * * * * * 被执行的命令
```
- 命令用空格分隔， 
- 不用的, 任意可能的使用*代替
- 多个值用','分割
- `*/2` 每两分钟，每两天。。。`(0-23)/2`11点前每两小时一次

## 3. 不发送电子邮件

如果输出结果来自crontab, 那么cron守护进程会使用电子邮件发送给用户, 位置```/var/spool/mail/ec2-user```, 需要将命令重定向到 ```>/dev/null 2>&1```


## 4. 查看日志排除问题

位置: ```/var/log/cron```

## 5. crontab设置scrapy脚本的定时任务

编写shell脚本

    ```
    #!/bin/sh
    . ~/.bash_profile
    source /etc/profile
    # 切换到scrpay命令下
    cd /home/ec2-user/crawler/mangoplate_scrapy/

    # 依次启动爬虫
    /usr/local/bin/scrapy list
    /usr/local/bin/scrapy crawl codetable
    /usr/local/bin/scrapy crawl mangoplate

    # 去重
    /usr/bin/python3 deduplicate.py
    ```


## 6. 环境变量的问题
1. 由于crontab只加载/ect/environment，并不加载/etc/profile和~/.bash_profile，所以需要在脚本里手动添加环境变量
    ```
        . /etc/profile
        . ~/.bash_profile
        export xx/xx/xx.conf  # 可以导入需要的配置文件
    ```
   - 考虑到crontab中设置复杂不一, 应该规范shell命令的格式, 确保每次使用绝对路径, 适用于crontab的运行
   - crontab的任务只有一行运行shell脚本的命令即可
2. 如果不适用shell脚本，也可以这样：
   ```
    0 10 * * 5 source ~/.bashrc;cd /home/xiaoteng/code/aspex_tickets/src && python3 all_tickets.py >/dev/null 2>&1
   ```

## 7. docker中
由于docker默认不启动，启动容器后执行如下:
```
# 后台启动cron
/usr/sbin/crond -i
```