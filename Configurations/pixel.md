# 配置pixel做开发机

## 
1. 解锁bootloader
    1. 进入bootloader
        1. 关机后长按`电源` + `音量减`
        2. adb进入: `adb reboot bootloader`
    2. fastboot boot path/to/twrp.img
2. 安装9.0
    1. 下载系统安装包
        1. https://developers.google.cn/android/images#sailfish, `sailfish-pq3a.190801.002-factory-029a3376.zip`
    2. android-platform-tools
        1. mac安装`brew cask reinstall android-platform-tools`
        2. [windows安装](https://developer.android.google.cn/studio/releases/platform-tools.html)
    3. 解压到目录, 连接手机, 手机进入`bootloader`, 电脑端运行`sh flash-all.sh`即可
3. 刷入twrp
    1. 下载 https://twrp.me/google/googlepixel.html
    2. `fastboot boot image/twrp-3.2.3-0-sailfish.img`, 确保手机处于`bootloader`
4. Magisk(root)
    1. 安装
        1. 进入twrp
        2. 安装, 选择安装包`Magisk-v20.4.zip`, https://github.com/topjohnwu/Magisk/releases
    2. 安装模块(zip文件放入download, 在app模块中选择安装, 重启即可):
        1. riru https://github.com/RikkaApps/Riru/releases
        2. EdXposed https://github.com/ElderDrivers/EdXposed/releases
        3. EdXposed Manager https://github.com/ElderDrivers/EdXposedManager/releases
5. Edxposed
    1. Xposed只支持到8.0, 之后需要edxposed
    2. 从Magisk安装即可, 见4.2.2
    3. 模块安装:
        1. mobi.acpm.sslunpinning_latest.apk
        2. TrustMeAlready-v1.11-release.apk