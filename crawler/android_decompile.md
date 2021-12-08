# 安卓逆向 Android

## 1. 原理准备

## 2. 工具准备

1. jdk
2. [apktool apk to dex](https://ibotpeaches.github.io/Apktool/)
3. [JADX Dex to Java](https://github.com/skylot/jadx)
4. [dex2jar]](<https://github.com/pxb1988/dex2jar>)
5. [JD-GUI]](<http://jd.benow.ca/#jd-gui-download>)
6. [apkScan ApkScan-PKID.jar](.)

## 3. adb

adb 操作手机

1. adb应用位置: `~/Library/Android/sdk/platform-tools/adb`
2. 命令行

    ```shell
    adb kill-server/start-server
    adb devices -l
    adb -s {device_code} shell
    adb shell    shell
    # adb启动应用
    adb -s 58d8cd167d44 shell am start cn.ninebot.ninebot/.mainshell.MainActivity
    # 查看app对应包
    adb shell ps|grep cn.ninebot.ninebot
    # 查看activi
    adb shell dumpsys package cn.ninebot.ninebot
    ```

## 4. frida动态调试

1. 安装
    1. <https://github.com/frida/frida/releases>
    2. 下载到手机

        ```shell
        adb push frida-server /data/local/tmp/frida-server
        adb shell chmod 777 /data/local/tmp/frida-server
        ```

    3. pc

        ```shell
        pip install frida 
        pip install frida-tools
        ```

2. frida启动服务

    ```shell
    cd /data/local/tmp/
    ./frida-server &
    ```

3. frida --no-pause -D 872QEDUA2224U -l hook_nio.js -f cn.com.weilaihui3
    1. -D device code
    2. -U usb设备, 如果只有一台
    3. -l 注入脚本
    4. 最后跟进程
    5. -f start模式, 最后加上 --no-pause
4. frida-ps -D 872QEDUA2224U 查看哪些进程
5. frida和Magisk冲突
    1. <https://stackoverflow.com/questions/56316329/frida-failed-to-spawn-unable-to-access-zygote64-while-preparing-for-app-launc>
6. 如果frida被app检测, 可以试试hluda-server-15.0.0-android-arm64
    `https://github.com/hluwa/strongR-frida-android/releases`

### frida objection

1. 安装

    ```shell
    pip install objection
    # objection --version要和收集的版本匹配
    ```

2. 参考[objection](https://juejin.cn/post/6844904148215808014)
3. 常用命令
    1. python

    ```shell
    # 查看b方法参数、返回值和调用栈的命令
    android hooking watch class_method com.xingin.alioth.others.a.b  --dump-args --dump-return --dump-backtrace
    ```

## 5. android studio 动态调试 smali

1. 找到app当前activate

    ```shell
    adb shell dumpsys activity top | grep ACTIVITY
    cn.ninebot.ninebot/.mainshell.MainActivity
    ```

2. adb shell am start -D -n cn.com.weilaihui3/.ui.activity.SplashActivity
    1. 调试应用
3. 其他:
    1. [smali插件未生效导致无法调试](https://blog.csdn.net/ccczhi/article/details/107597936)

## 6. 模拟器连接as调试

1. 统一adb版本
2. /Applications/NoxAppPlayer.app/Contents/MacOS/adb connect 127.0.0.1:62001
3. android studio调试时也设置为62001

## 7. xposed hook java层

[见项目xposeds](https://github.com/maxiaoteng001/xposeds)
[xposed](xposed.md)

1. Android Studio打开时选择XposedHook, 之后就会自动安装依赖后识别app模块
2. 在手机端安装后启用xposed模块, 即可在log查看到输出

## 8. 源代码反编译

1. apk to dex
    1. 如果app加壳, 参考[加固脱壳](unpack.md)
    2. 直接操作 ```apktook d xx.apk```
2. dex to jar
    1. jadx直接反编译, jadx-gui直接打开即可
    2. `jadx -d target_dir xx.apk/xx.dex/xx.class`
    3. dex2jar(`~/Downloads/dex2jar_2.1/dex-tools-2.1-SNAPSHOT/d2j-dex2jar.sh`)
        1. 支持dex2jar `./d2j-dex2jar.sh ~/projects/aspex_ninebot/unpack/classes6.dex`
            1. 得到的jar解压缩为.class文件
            2. 如果个别文件反编译失败, 参考第三项
        2. 支持dex2smali `./d2j-dex2smali.sh ~/projects/aspex_ninebot/unpack/classes7.dex`
            1. 可用于分析和动态调试
        3. max上使用可能报错权限不足, 操作`sudo chmod +x d2j*`
    4. <http://www.javadecompilers.com/>
        1. 支持选择反编译方案, 可以用于部分文件反编译, 如果jadx失败可以用这个

## 9. 加固脱壳

[加固脱壳](unpack.md)

## 10. hook so

[hook so](hook_so.md)

## 11. unidbg

模拟Android运行环境, <https://github.com/zhkl0228/unidbg>

## 12. 微信小程序

[微信小程序](/crawler/wechat_miniprogram.md)

## last

1. 蔚来汽车
    1. sign 位于
        1. package com.nio.lib.http;
        2. com.nio.keys.sign.SignUtils.signURLAndRequestParamsUsingC(r1, r2, r3, r4, r5, r6)
        3. /com/nio/lib/http/GateWay.class
            1. 调用信息 ((Map)localObject3).put("sign", SignUtils.signURLAndRequestParamsUsingC("GET", paramString2, paramString3, paramString4, (Map)localObject3, null));
            2. r1 = "GET"
            3. r6 = null
            4. r2, r3, r4, r5
    2. base64解密data位于 package cn.com.weilaihui3.chargingpile;
2. 九号出行
    1. 使用梆梆加固
