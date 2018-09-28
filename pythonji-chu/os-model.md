# OS Model

## 关于 os.path  和 __file__

`__file__`  # 如果当前文件调用, 显示绝对路径, 其他文件调用, 则只显示filename

使用当前文件的绝对路径: ``` os.path.dirname(os.path.abspath(__file__)) ```
其中: abspath = realpath
