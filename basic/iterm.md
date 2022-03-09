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
11. Command + shift + i # 多窗口同步输入

## 2. 使用mac进行ssh登陆linux服务器

1. 直接命令行操作

    ```shell
        ssh xiaoteng@11.11.1.1
        # password ..即可
    ```

2. 配置profile实现一键登录
   <https://blog.csdn.net/Eden_M516/article/details/73741290>
   1. 编写expect脚本，`vi ～/.ssh/profile1`

        ```shell
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

   2. iterm2 preference profiles new
       填写name(profile1), command(expect ~/.ssh/profile1)

   3. 启动iterm时选择profile1的名字即可

3. 对于需要密钥登陆的服务器，可以自动登陆

## 3. 设置

1. 代理设置

   ```shell
    export http_proxy=socks5://127.0.0.1:1080 # 配置http 代理访问
    export https_proxy=socks5://127.0.0.1:1080 # 配置https 代理访问
    export all_proxy=socks5://127.0.0.1:1080 # 配置http和https访问
    unset http_proxy  # 取消http 代理访问
    unset https_proxy # 取消https 代理访问

    # 简易化设置proxy
    alias proxy_charls='export http_proxy=http://127.0.0.1:8888 https_proxy=http://127.0.0.1:8888'
    alias proxy_mitmproxy='export http_proxy=http://127.0.0.1:8080 https_proxy=http://127.0.0.1:8080'
    alias proxy_system='export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890'
    alias unproxy='unset http_proxy https_proxy'
   ```

2. zshrc配置

    ```shell
    # ~/.zshrc
    
    # If you come from bash you might have to change your $PATH.
    export PATH=$HOME/bin:/usr/local/bin:$PATH
    export PATH=$PATH:/usr/local/go/bin
    export PATH="$PATH:$(go env GOPATH)/bin"
    # Path to your oh-my-zsh installation.
    export ZSH="/Users/maxiaoteng/.oh-my-zsh"
    # Set name of the theme to load --- if set to "random", it will
    # load a random theme each time oh-my-zsh is loaded, in which case,
    # to know which specific one was loaded, run: echo $RANDOM_THEME
    # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
    ZSH_THEME="robbyrussell"
    # Which plugins would you like to load?
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

    source $ZSH/oh-my-zsh.sh

    # Example aliases
    alias zshconfig="mate ~/.zshrc"
    alias ohmyzsh="mate ~/.oh-my-zsh"
    # proxy
    alias proxy_charles='export http_proxy=http://127.0.0.1:8888 https_proxy=http://127.0.0.1:8888'
    alias proxy_mitmproxy='export http_proxy=http://127.0.0.1:8080 https_proxy=http://127.0.0.1:8080'
    alias proxy_system='export http_proxy=http://127.0.0.1:7890 https_proxy=http://127.0.0.1:7890'
    alias unproxy='unset http_proxy https_proxy'
    # brew
    alias abrew="/opt/homebrew/bin/brew"
    alias ibrew="arch -x86_64 /usr/local/bin/brew"
    # venv
    alias venv="source ~/projects/xiaoteng_venv/bin/activate"
    alias adev="source ~/projects/venvs/venv_aws/bin/activate"
    alias udev="source ~/projects/venvs/venv_dev/bin/activate"
    # POWERLINE_PATH="short"

    # python3 虚拟环境
    alias uscrapy="/Users/maxiaoteng/projects/venvs/venv_dev/bin/scrapy"
    alias ascrapy="/Users/maxiaoteng/projects/venvs/venv_aws/bin/scrapy"
    echo "请选择虚拟环境:"
    echo "udev: venv for ucloud"
    echo "adev: venv for aws"
    ```
