# pyppeteer

## 1. 环境配置

安装chromium

```python
# 下载链接被墙, 直接复制/data下的文件 chromium_588429.zip
# 解压目录: /home/{{user}}/.local/share/pyppeteer/local-chromium/588429/,  {{user替换成个人用户名}}
unzip chromium_588429.zip -d /home/{{user}}/.local/share/pyppeteer/local-chromium/588429/

# 检查是否正确安装
import pyppeteer
pyppeteer.executablePath()
# 输出路径 '/home/{{user}}/.local/share/pyppeteer/local-chromium/588429/chrome-linux/chrome'
```
