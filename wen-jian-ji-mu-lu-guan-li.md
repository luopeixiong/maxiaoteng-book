# 文件及目录管理

## 创建和删除

- 创建: mkdir
- 删除: rm
- 删除非空目录: rm -r file_name
- 删除日志: rm *log
- 移动: mv
- 复制: cp 
- 复制目录: cp -r

查看当下目录文件个数
```
find ./ |wc -l
```

复制目录:
```
cp -r source_dir dest_dir
```

## 目录切换

- 切换位置: cd
- 切换上一级: cd .. 或: cd -
- 切换到home: cd ~  or cd
- 显示当前路径: pwd
- 更改当前工作路径为path: cd path

## 列出目录项

- ls
- 按时间排序, 以列表方式显示: ls -lrt

## 查找目录和文件 find/location


搜寻文件或目录:  
```
find ./ -name 'core*' | xargs file
```

查找目标文件夹是否有obj文件
```
find ./ -name '*.o'
```

递归删除目录及子目录的.o文件
```
find ./ -name '*.o' -exec rm {} \
```

**find**是实时查找, 要想更快, 可以使用location  
**location**为文件系统建立索引数据库, 需要定期更新
```
location string   # 寻找包含string的路径
updatedb  # 更新索引
```

## 查看文件内容

**cat, vi, head, tail, more**
```
cat -n  # 显示的同时显示行号

ls -al | more  # 按页显示列表内容

# 查看前10行
head -10 file_name

# 显示文件第一行
head -1 file_name

# 查看文件差距:
diff file1 file2

# 查看后10行
tail -10 file_name

# 动态显示文本更新
tail -f file_name
```

## 改变文件和目录权限
- chmod 改变文件读写执行属性
```
chmod a+x myscript

```

## 文件创建别名, 创建软链接/硬链接

```
ln cc ccAgain : 硬链接, 删除一个, 另一个仍能找到
ln -s cc ccNew : 软链接, 删除源, 另一个无法使用 
```

## 管道和重定向
- 批处理命令连接执行使用`|`
- 串联使用分号`;`
- 前面成功才执行,否则不执行使用`&&`
- 前面失败, 后面才执行使用`||`

```
ls /etc && echo suss! || echo failed.

等价:
if ls /etc; then echo suss; else echo fail; fi
```

重定向
```
ls /etc > list 2> &1  # 将标准输出和标准错误输出重定向到同一文件

等价:
ls /etc &> list

echo aa >> a.txt
```

清空文件:
```
: > a.txt
```

## 设置环境变量
.profile文件
```
PATH=$APPDIR:/opt/app/soft/bin:$PATH:/usr/local/bin:$TUXDIR/bin:$ORACLE_HOME/bin;export PATH
```

## 应用举例

查看文件中包含AAA 不包含BBB 的文件行数
```
cat log.log |grep AAA | grep -v BBB | wc -l
```
