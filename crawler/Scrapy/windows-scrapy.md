# win7安装scrapy

需要安装pywin32 和 Twisted
- 安装pywin32
- 安装Microsoft Visual C++ 14.0
  - 直接安装会提醒`error: Microsoft Visual C++ 14.0 is required (Unable to find vcvarsall.bat)`
  - 安装链接(https://stackoverflow.com/questions/29846087/microsoft-visual-c-14-0-is-required-unable-to-find-vcvarsall-bat)
- 安装scrapy, 自动安装Twisted
  ```
  pip install scrapy
  ```