# 飞常准

[TOC]

飞常准解决的问题:

1. 请求响应aes加密
2. signature作为请求参数验证
3. uniqueId注册机制可以免登录爬取, 每个uniqueId又有限制次数(app内前端设置限制三次, 实际上可使用次数更多)

版本`[vz.com_V5.0.9.apk]`

## 1. signature解密问题

1. 逆向app结合frida动态调试, 分析发现加密调用了`com.feeyo.vz.core.VZCore.g`

    ```Java
    package com.feeyo.vz.core;

    import android.content.Context;

    public class VZCore {
        static {
            System.loadLibrary("Natciml");
        }

        public static native byte[] de(String str, byte[] bArr);

        public static native byte[] en(String str, byte[] bArr);

        public static native String g(Context context, String[] strArr);

        public static native String l(Context context);
    }
    ```

2. 采用xposed hook调用实现, sekiro提供服务

## 2. uniqueId注册问题

1. uniqueId在2021年3月份只需要一个请求即可注册为有效, 6月份需要多个请求
    - <https://app.variflight.com/v4/config/newInstall?devicetimezone=28800&feeyo_mode=xe1>
    - <https://app.variflight.com/v4/tripindex/getFutureTrip?feeyo_mode=xe1>
    - <https://app.variflight.com/crawl/InstalledApps?feeyo_mode=xe1>
