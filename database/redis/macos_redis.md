# macos redis

1. 安装
    ```
        brew install redis
    ```

2. 启动
    ```
        # 推荐
        brew services start redis

        # 手动，不推荐
        redis-server /etc/redis.conf
    ```

3. 配置
   ```
    见/etc/redis.conf
   ```

4. 自启动和后台运行
    1. brew安装后提示：
        To have launchd start redis now and restart at login:
        brew services start redis
        Or, if you don't want/need a background service you can just run:
        redis-server /usr/local/etc/redis.conf
    2. 常用命令
        1. 开机启动redis命令
            ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
        2. 使用launchctl启动redis server
            launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
        3. 使用配置文件启动redis server
            redis-server /usr/local/etc/redis.conf
        4. 停止redis server的自启动
            launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
        5. redis 配置文件的位置
            /usr/local/etc/redis.conf
        6. 卸载redis和它的文件
            brew uninstall redis 
            rm ~/Library/LaunchAgents/homebrew.mxcl.redis.plist
        7. 测试redis server是否启动
            redis-cli ping
