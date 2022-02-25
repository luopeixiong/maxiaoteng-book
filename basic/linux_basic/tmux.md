# tmux 命令

tmux 采用c/s模型，输入tmux命令，  相当于开启了一个服务器（server），默认新建一个会话（session）,会话中默认新建一个窗口（window），窗口中默认新建一个面板（pane）。  

1. 基本命令

    ```bash
    # 新建一个session
    tmux [new -s 会话名 -n 窗口名]
    # 默认进入第一个session
    tmux at [-t 会话名]
    # 列出所有会话
    tmux ls
    # 关闭指定会话， 还有kill-server， kill-window， kill-pane
    tmux kill-session -t 会话名
    # 按下 ctr+b以后
        s  列出所有会话
        c  创建窗口
        w  列出所有窗口
        [  屏幕内滚动
    ```

2. 配置[tmux create new window on current directory](https://serverok.in/tmux-create-new-window-on-current-directory)

    ```shell
    # vi ~/.tmux.conf
    bind c new-window -c "#{pane_current_path}"
    bind '"' split-window -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"

    # 生效文件
    tmux source-file ~/.tmux.conf
    ```
