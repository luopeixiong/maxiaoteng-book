# Macos 使用
[TOC]

## 1. 快捷键
1. command代替大多ctrl操作
    - command + X   # 剪切
    - command + C   # 复制
    - command + V   # 黏贴
    - command + Z   # 撤销

2. 锁屏
    - control + command + Q 

3. 大小写   长按中英切换，或按住shift + 字母

4. 双指滚动，三指切换应用，四指列出桌面

5. Command + Opthon + Esc   # 强制退出应用程序
6. 截屏
   1. Command + Ctrl + Shift + 3    # 整个屏幕截屏，剪贴板
   2. Command + Shift + 4   # 对选定内容截屏，到桌面文件， 使用space可以对某个窗口截屏

7. 外接鼠标之后，滚轮和滑动加速度不匹配，参考 [https://sspai.com/post/40596](https://sspai.com/post/40596) 解决
8. 查看窗口坐标 command + shift + 4


## 2. Time Machine
### 1. nas配置时间返回舱
1. 配置备份服务器
    1. 见nas.md
2. 开启备份
    系统偏好设置 -> 时间机器 -> 选择磁盘后登录即可

### 2. mac配置时间返回舱
1. 配置airport时间返回舱
    1. 挂载磁盘
        1. 铁威马磁盘阵列组建raid10
    2. 格式化
        1. 用mac server的时间机器去备份, 会自动格式化成支持的格式[如何针对“时间机器”来格式化磁盘](https://support.apple.com/zh-cn/HT202784#format)
    3. 创建文件夹
        1. 创建timemachine文件夹用来备份
        2. 设置timemachine共享文件夹, 
            1. 系统偏好设置--共享--文件共享--选中Timemachine, 右键高级设置, 设置成支持timemachine的共享
            2. 最大500G备份
        3. 权限: 对Timemachine的文件夹 
            1. 系统偏好设置--共享--文件共享--选中Timemachine, 添加用户组timemachine为读写权限
            2. finder中打开, 右键--显示简介--权限--添加timemachine群组--读写
            3. 添加其他支持的用户
    4. 本地电脑连接后即可备份

2. MacServer用户的配置
    1. 管理员
    2. sharing only用于访问磁盘, 不支持远程控制mac
    3. 群组
        1. timemachine
            1. 所有用户只能备份timemachine
            2. 创建的用户全部都是sharing only
            3. 对Timemachine的文件夹为读写, 对Backup大文件夹是只读
        2. remote connect(暂时不需要)
            1. 允许远程连接的用户
            2. 读写共享文件夹

3. Timemachine备份指南
    1. 找我创建备份磁盘的用户
    2. 备份操作
        1. 参考[使用“时间机器”备份您的 Mac](https://support.apple.com/zh-cn/HT201250)
        2. 选择备份磁盘时, 记得选择TimeMachine(在"Ted‘s MacServer.local上")
        3. 之后弹出的登录窗口, 选择'注册用户', 使用自己的用户名和密码登录即可
    3. Tips
        1. 如何找到时间机器: 点击左上角苹果图标-->系统偏好设置-->时间机器
        2. 选中自动备份和"在菜单栏中显示时间机器", 之后就可以在菜单栏直接访问
        3. 备份不影响正常使用, 初次备份比较久, 要耐心等待

## 3. 远程控制
1. 被共享的电脑
    1. 创建用户
    2. 系统偏好设置 -> 共享 -> 远程管理
        1. VNC访问
            1. 电脑设置, 允许vnc访问
        2. 远程管理添加用户
2. 操作电脑
    1. findler连接
        1. findler位置, 会看到共享的计算机
            1. 共享屏幕, 输入允许控制的用户
    2. vnc访问
        1. vnc客户端输入局域网ip和密码
