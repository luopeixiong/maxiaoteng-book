# tar 解压缩命令
## 1. 压缩
```shell
tar -czvf 20180725baike.tar.gz 2018-07-25/
```
1. options说明  
    -c //创建一个压缩文件
    -z //具有gzip的属性, 一般gz结尾
    -v //压缩过程显示档案
    -f //后接压缩文件名, f必须在options的末尾

## 2. 解压
```
tar -xzvf 20180725baike.tar.gz 2018-07-25/
```
- options说明
    -x 解压缩文件指令
    其他的对应上一条命令
## 3. 分卷压缩
分卷实际上用到的是split命令,用来切割文件
```
tar cvzpf - eclipse | split -d -b 50m
```
说明:
1. 将eclipse文件夹分卷压缩
2. 每卷50m
3. 压缩完以后会命名尾x01, x02

## 4. 分卷解压