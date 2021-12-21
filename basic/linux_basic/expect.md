# expect

和shell类似, 主要用于带交互的命令脚本, 比如rsync执行时输入密码:

```
#!/bin/expect
set timeout 30
spawn rsync -rvptgo maxiaoteng@59.110.160.185:/home/maxiaoteng/crawler/news/data/ /root/crawler/news/data
expect "password:"
send "XXXXXX\r"
interact
```

```
#!/usr/bin/expect
set timeout 360
set host [lindex $argv 0]
set port [lindex $argv 1]
set username [lindex $argv 2]
set password [lindex $argv 3]
set src_file [lindex $argv 4]
set dest_file [lindex $argv 5]
#spawn scp $src_file $username@$host:$dest_file
spawn scp -P $port -r $username@$host:$src_file $dest_file
expect {
 "(yes/no)?" {
   send "yes\n"
   expect "*assword:" { send "$password\n"}
  }
  "*assword:" {
   send "$password\n"
  }
}
expect "100%"
expect eof

```

```
#!/bin/sh
 
src_dir=/data/huiyzl/runtime/
dest_dir=/data/huiyzl/
host=219.135.214.146
port=60203
username=root
password=LENOVOap123
 
# 目录不存在，则创建，如果存在先删除再创建
if [ ! -d $src_dir ]; then
  mkdir -p $src_dir
else
  rm -rf $src_dir
  mkdir -p $src_dir
fi
 
# 将远程服务器上的文件拷贝到本机
./expect_scp $host $port $username $password $src_dir $dest_dir

echo "end"
```
