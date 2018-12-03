## expect
和shell类似, 主要用于带交互的命令脚本, 比如rsync执行时输入密码:
```
#!/bin/expect
set timeout 30
spawn rsync -rvptgo maxiaoteng@59.110.160.185:/home/maxiaoteng/crawler/news/data/ /root/crawler/news/data
expect "password:"
send "XXXXXX\r"
interact
```