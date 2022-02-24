# 使用vim

0. basic
   - q     # 退出
   - wq    # 保存退出
   - q!    # 强制退出
   - yy    # 复制一行
   - nyy   # 复制多行
   - p     # 粘贴
   - set number    # 显示行号
   - set nonumber    # 隐藏行号
   - u     # 还原上一次操作
   - U     # 还原整行的操作
1. 删除
   - dw    # 删除一个单词
   - d$    # 删除至行尾
   - dd    # 删除一行
   - ndd   # 删除多行
   - p     # 将上次删除的内容复制到光标之后
2. 更改
   - r     # r 后输入要替换的字符
   - ce    # 更改一个单词
   - c$    # 更改一行
3. 定位
   - Ctrl + G  # 显示当前的位置
   - G  # 跳转到文件最后一行
   - line_no + G    # 跳转到指定行
   - gg # 跳转到第一行
   - Ctrl + f  # 下翻页
   - Ctrl + b  # 上翻页

4. 搜索
   1. / + keyword   # 搜索特定的词
   2. n/N   # 下/上搜索
   3. ?    #逆向查找使用
   4. ctrl + o  # 回到之前位置，可多次执行

5. vim 中执行外部命令

## 配置

用户配置在`~/.vimrc`, 参考[Vim入门级基础配置](https://segmentfault.com/a/1190000016330314)

    ```shell
    # 粘贴是空格和tab的问题
    set paste
    ```
