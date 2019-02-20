## 快捷键
设置: 文件 → 首选项 → 键盘快捷方式  -->  可以搜索关键字, 也可以直接按键

- Ctrl + [  ]      # 缩进
- Ctrl + D         # 删除整行
- Ctrl + Delete    # 删除光标右侧
- Alt + ⬆/⬇        # 整行上移下移
- Ctrl+ ⬆/⬇        # 行滚动页面
- Ctrl+ pagedown/pageup        # 滚动页面
- Ctrl + s         # 保存
- Ctrl + n        # 创建新文件
- Alt + Shift + ⬆/⬇    # 复制该行内容到上一行或下一行
- Alt + Shift + 鼠标    # 多行编辑
- Ctrl + L + K    # 格式化代码


## 设置
- Ctrl + Shift + p    # 打开搜索, language设置 Display language

- 语言
    ```
    {
        // Defines VS Code's display language.
        // See https://go.microsoft.com/fwlink/?LinkId=761051 for a list of supported languages.
        
        // "locale":"en" // Changes will not take effect until VS Code has been restarted.
        "locale":"zh-CN" // Changes will not take effect until VS Code has been restarted.
    }
    ```
    如果重启还是不行, 需要安装中文包, 扩展搜索: chinese / language
- 设置tab 默认缩进4个空格
    - 文件 → 首选项 → 设置 → 用户设置 → 打开setting.json → tabsize

- 设置启动的终端
setting.json中  
```
// "terminal.integrated.shell.windows":"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
// "terminal.integrated.shell.windows": "C:\\Windows\\System32\\cmd.exe",
"terminal.integrated.shell.windows": "D:\\soft\\git\\bin\\bash.exe"
```


- 导入导出配置文件
位于：/yonghu/Appdata/Roaming/code/user/setting.json