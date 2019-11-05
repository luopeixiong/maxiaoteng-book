# iterm2 
mac下使用iterm作为终端模拟工具

## 1. Iterm快捷键
1. Command + d  # 垂直分屏
2. Command + shift + d  # 水平分屏
3. Command + ] /[   # 最近使用的分屏切换
4. Command + opthon + 方向键    # 切换到指定的分屏
5. Command + 数字/方向键   # 切换标签页
6. shift + Command + s  # 保存当前窗口快照
7. Command + option + b # 快照回放 
8. ctrl + u # 删除整行
9. ctrl + w # 删除前一个单词
10. ctrl + c    # 直接下一行重新输入


## 2. 使用mac进行ssh登陆linux服务器
1. 直接命令行操作
    ```
        ssh xiaoteng@11.11.1.1
        # password ..即可
    ```
2. 配置profile实现一键登录
   https://blog.csdn.net/Eden_M516/article/details/73741290
   1. 编写expect脚本，`vi ～/.ssh/profile1` 
    ```
        #!/usr/bin/expect -f
        set user <用户名>
        set host <ip地址>
        set password <密码>
        set timeout -1

        spawn ssh $user@$host
        expect "*assword:*"
        send "$password\r"
        interact
        expect eof
    ```
   2.  iterm2 preference profiles new 
       填写name(profile1), command(expect ~/.ssh/profile1)

   3. 启动iterm时选择profile1的名字即可

3. 对于需要密钥登陆的服务器，可以自动登陆

## 3. 设置
1. 代理设置
   ```
    export http_proxy=socks5://127.0.0.1:1080 # 配置http 代理访问
    export https_proxy=socks5://127.0.0.1:1080 # 配置https 代理访问
    export all_proxy=socks5://127.0.0.1:1080 # 配置http和https访问
    unset http_proxy  # 取消http 代理访问
    unset https_proxy # 取消https 代理访问
   ```