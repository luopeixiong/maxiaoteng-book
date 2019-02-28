# other


1. 为终端设置代理
```
set http_proxy=http://127.0.0.1:1080
set https_proxy=http://127.0.0.1:1080
```

2. 查看ip
```
# 已被弃用
ifconfig: command not found
#等价于
ip addr show
```

3. diff
```
# 比较文件
diff file1 file2
# 比较文件夹
diff -urNa dir1 dir2
```

4. curl
```
curl -O http://mirror.bit.edu.cn/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz  # 用于下载文件，按服务器上的文件名保存
curl -o filename url     # 文件下载后重命名为filename 
```