# Cron

## 命令的使用

1. 列出当前任务	crontab -l 
2. 备份当前任务列表	crontab -l > my_cron   
3. 编辑一个命令文件      nano my_crontab
4. 将编辑好的命令生效  crontab my_crontab 
5. 重启crond
    service crond restart


## 命令格式	

格式: [1] [2] [3] [4] [5] [6] 
[1]	分
[2]	时
[3]	日
[4]	月
[5]	星期
[6]	要运行的命令
> 命令用空格分隔， 
> 不用的, 任意可能的使用*代替
> 多个值用','分割