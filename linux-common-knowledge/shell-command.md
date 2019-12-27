# 

## 开头

```
#!/bin/sh
```

脚本以.sh结尾, 并且要使用```chmod +x filename.sh```来使文件为可执行脚本


## 注释

注释以" # " 来开始, 占据一行


## 变量

1. 定义变量时,变量名不加美元符号($)
``` 
a="shell" 
```
变量名和等号之间不能有空格, 除了显式赋值, 还可以用语句赋值
```
for file in 'ls /etc'
```

2. 使用变量用${}表示(花括号虽然可以不用, 但尽量使用)
```
echo "a is ${a}"
```

## 等待sleep
```
sleep 5  # 默认为秒
sleep 5s
sleep 5m
sleep 5h
sleep 5d
```

## 字符串

单引号的变量和转义字符是无效的, 只会原样输出

双引号可以有变量和转义字符, 比如:   
```
your_name='qinjx'
str="Hello, I know your are \"$your_name\"! \n"
```


## 环境变量

使用export导入环境变量, 命令可以直接使用

```
# 运行命令的两种方法

/usr/bin/python /XXX/xx.py

export

```

## shell流程控制

1. if语句
```
if condition
then
    comamnd1
    command2
    command3
elif condition2
    command4
else
    command5
fi
```

2. for
```
for var in item1 item2... itemn
do
    command1
    ...
    commandn
done
```

3. while
```
while condition
do 
    command
done
```

## 并行运行多个命令

&  
```
#!/bin/sh
# 启动爬虫
/usr/bin/python3 /home/ec2-user/crawler/baemin/baeminApp3.0.py 0 >/dev/null 2>&1 &
/usr/bin/python3 /home/ec2-user/crawler/baemin/baeminApp3.0.py 1 >/dev/null 2>&1 &
```
**解释**:
- 最后的 `&`符号可以使命令并行运行
- `>`重定向符号
- `/dev/null`  # 代表空设备文件
- `2>`  # 代表stderr标准错误
- `&1` # 中的&表示等同,就是2的输出等同于标准输出
- `1`  # 表示系统标准输出  `>/dev/null`等同于`1>/dev/null`
- `>/dev/null 2>&1`  # 表示正常输出重定向到null, 错误输出重定向到1, 也是null  
- `2>&1 >/dev/null`  # 表示错误输出重定向到1, 即屏幕, 然后正确输出重定向到null


## sh样本
兼容crontab的运行, 设置全面的环境变量和路径

```
#!/bin/sh  # 指定脚本解释器

# 生效当前用户的配置, 通常用在crontab中
source ~/.bash_profile
source /etc/profile

# 添加环境变量, 比如scrapy创建在了/usr/local/bin
# 可以通过echo $PATH来测试是否添加成功
SCRAPY_HOME=/usr/local/bin
export SCRAPY_HOME

PATH=$PATH:$SCRAPY_HOME
export PATH

# 生效虚拟环境
source /data2/home/maxiaoteng/miniconda3/bin/activate /data2/home/maxiaoteng/miniconda3/envs/sjy_conda

# 切换到目录下
cd /home/ec2-user/uber/crawler/python/zomato/
# 启动爬虫
/usr/bin/python3 zomato_apac.py
```

```
#!/bin/sh
# 启动爬虫
/usr/bin/python3 /home/ec2-user/crawler/baemin/baeminApp3.0.py 0 >/dev/null 2>&1 &
/usr/bin/python3 /home/ec2-user/crawler/baemin/baeminApp3.0.py 1 >/dev/null 2>&1 &
```

## 对目录和文件的操作
```
判断操作
#!/bin/bash
# 如果数据文件存在,先删除
data_path=/home/maxiaoteng/ss.txt
if [ ! -f $data_path ];then
  echo 不存在
else
  echo 存在, 我删掉了
  rm -f $data_path
fi
```

说明
```
-d # 判断目录是否存在
-f # 判断文件是否存在
-x # 判断路径是否存在并有可执行权限
-n # 判断变量是否为空
    if [ ! -n $var ] ; then
        echo var 变量为空
    fi
=  # 判断变量是否相等
    if [ $var1 = $var2 ]; then
        echo var1和var2相等
    fi
```

## 错误
- `syntax error: unexpected end of file`错误  
    - 是因为`\r\n`不兼容引起的  
    - 解决: `dos2unix file.sh`