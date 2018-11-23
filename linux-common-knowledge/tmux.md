## tmux 命令

tmux 采用c/s模型，输入tmux命令，  相当于开启了一个服务器（server），默认新建一个会话（session）,会话中默认新建一个窗口（window），窗口中默认新建一个面板（pane）。  

- 新建一个session
    ```bash
    tmux [new -s 会话名 -n 窗口名]
    ```
- 默认进入第一个session
    ```bash
    tmux at [-t 会话名]
    ```
- 列出所有会话
    ```bash
    tmux ls
    ```
- 关闭指定会话， 还有kill-server， kill-window， kill-pane
    ```bash
    tmux kill-session -t 会话名
    ```

- 按下 ctr+b以后
    s  列出所有会话
    c  创建窗口
    w  列出所有窗口
