# 安卓逆向 Android 

## 1. 原理准备


## 2. 工具准备
1. jdk
2. [apktool apk to dex](https://ibotpeaches.github.io/Apktool/)
3. [JADX Dex to Java](https://github.com/skylot/jadx)


## 3. adb
1.  ~/Library/Android/sdk/platform-tools/adb
2. adb kill-server/start-server
3. adb devices -l 
4. adb -s {device_code} shell 
5. adb shell    shell
    1. su   root权限
6. 


## 4. frida动态调试
1. frida -D 872QEDUA2224U -l hook_nio.js cn.com.weilaihui3
    1. -D device code
    2. -U usb设备, 如果只有一台
    3. -l 注入脚本
    4. 最后跟进程
2. frida-ps -D 872QEDUA2224U
    1. 查看哪些进程

## 5. android studio 动态调试 smali
1. adb shell am start -D -n cn.com.weilaihui3/.ui.activity.SplashActivity
    1. 调试应用
2. 其他:
    1. [smali插件未生效导致无法调试](https://blog.csdn.net/ccczhi/article/details/107597936)

## 6. 模拟器连接as调试
1. 统一adb版本
2. /Applications/NoxAppPlayer.app/Contents/MacOS/adb connect 127.0.0.1:62001
3. android studio调试时也设置为62001


## last
2. 蔚来汽车
    1. sign 位于 
        1. package com.nio.lib.http;
        2. com.nio.keys.sign.SignUtils.signURLAndRequestParamsUsingC(r1, r2, r3, r4, r5, r6)
        3. /com/nio/lib/http/GateWay.class
            1. 调用信息 ((Map)localObject3).put("sign", SignUtils.signURLAndRequestParamsUsingC("GET", paramString2, paramString3, paramString4, (Map)localObject3, null));
            2. r1 = "GET"
            3. r6 = null
            4. r2, r3, r4, r5
    2. base64解密data位于 package cn.com.weilaihui3.chargingpile;
    3. 