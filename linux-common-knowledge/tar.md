# tar 解压缩命令
## 1. 压缩
```shell
tar -czvf 20180725baike.tar.gz 2018-07-25/
```
.. 1. options说明  
    -c //创建一个压缩文件
    -z //具有gzip的属性, 一般gz结尾
    -v //压缩过程显示档案
    -f //后接压缩文件名, f必须在options的末尾

## 2. 解压
```
tar -xzvf 20180725baike.tar.gz 2018-07-25/
```
.. - options说明
    -x 解压缩文件指令
    其他的对应上一条命令
    
## 3. 分卷压缩
分卷实际上用到的是split命令,用来切割文件
```
tar cvzpf - baike | split -d -b 50m - baike.tar.gz.
```

### 说明:
1. 将eclipse文件夹分卷压缩
2. - 表示命令的输入和输出参数
3. 每卷50m
4. baike.tar.gz. 是压缩文件的起始文件
5. 压缩完以后会命名尾x00, x01, x02

## 4. 分卷解压
```
cat baike.tar.gz.* > eclipse.tar.gz  //先合并
tar -xzvf eclipse.tar.gz  //解压
```

```
cat baike.tar.gz.* | tar -xzvf   // 一步解决
```

## 5. 批量解压
```
ls *.tar.gz | xargs -n1 tar xzvf
# tar命令支持批量解压, 如 tar *, 所以要用脚本
```

## 6. gzip 与 tar
```
# .tar文件相当于一个文件夹
# 压缩
gzip xx.tar  # 将自动生成xx.tar.gz的压缩文件, 并替换掉之前的xx.tar
# 解压
gzip -d xx.tar.gz  # 将解压文件为xx.tar并替换掉原来的xx.tar.gz
```

## 7. zip unzip
```
# -d 指定解压目录
unzip xxx.zip -d xxdir/

# -q 不显示过程, -r 递归压缩
zip -q -r html.zip /home/html
zip -q -r html.zip *
```