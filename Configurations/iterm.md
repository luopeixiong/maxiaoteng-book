# iterm2 
mac下使用iterm作为终端模拟工具

## 1. 使用mac进行ssh登陆linux服务器
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