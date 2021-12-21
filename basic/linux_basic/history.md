# history命令

参考： https://linuxtoy.org/archives/history-command-usage-examples.html

1. history # 列出所有的历史命令，相当于cat了一个文件
2. ctrl + R # 在历史命令中搜索， enter直接执行，方向键会进入修改
3. 执行上一条命令的四种方法：
    1. ↑
    2. ！！
    3. ！-1
    4. Ctrl + P
4. 配置
    ```
    # vi ~/.bash_profile

    # 配置保存历史命令的总行数
    HISTSIZE=450
    HISTFILESIZE=450
    # 历史命令的文件保存位置
    HISTFILE=/root/.commandline_warrior
    
    # 历史命令是否去重
    HISTCONTROL=ignoredups
    ```
5. 由于history相当于cat了保存历史命令的文件，所以可以执行一些常规用法
    ```
    1. history | grep xx    # 过滤制定的命令
    2. history | tail -5    # 显示最后5条命令
    ```
6. 剔除历史文件中重复的命令
    ```
    # export HISTCONTROL=erasedups
    ```
7. 清楚历史记录
    ```
    # history -c
    ```