# VSCODE

## 快捷键

设置: 文件 → 首选项 → 键盘快捷方式  -->  可以搜索关键字, 也可以直接按键

1. windows下的快捷键
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

2. Macos快捷键
    - control + shift + ⬇️/⬆️   # 往下/往上一行
    - option + ⬆️/⬇️    # 移动行
    - option + shift + ⬆️/⬇️  # 往上/下复制代码
    - option + shift + F  # 格式化代码
    - option + Shift + P    # 打开搜索, language设置 Display language
    - command + D         # 删除整行
    - command + Delete    # 删除光标右侧
    - command + backspace    # 删除光标左侧

## 设置

- Ctrl + Shift + p    # 打开搜索, language设置 Display language

- 语言

    ```python
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

```shell
// "terminal.integrated.shell.windows":"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
// "terminal.integrated.shell.windows": "C:\\Windows\\System32\\cmd.exe",
"terminal.integrated.shell.windows": "D:\\soft\\git\\bin\\bash.exe"
```

- 导入导出配置文件
位于：/yonghu/Appdata/Roaming/code/user/setting.json

### 1. 自动同步

参考： <https://juejin.im/post/5b9b5a6f6fb9a05d22728e36>

## 插件

1. todo(安装 TODO Highlight, TODO Tree)
    1. 重启后可以在左侧todo tree看到
    2. 代码中行首加入`TODO:` 即可标记todo

## 2. windows10

1. [WinDefend Windows Defender Antivirus Service占用内存高！怎么解决？](https://answers.microsoft.com/zh-hans/protect/forum/protect_defender-protect_updating-windows_10/windefend-windows-defender-antivirus/5f90145e-24f0-4552-b7e0-119e68a6db2f)
