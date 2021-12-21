# 加固脱壳

1. 判断加壳方案

    使用软件, 参考[ApkScan-PKID查壳工具+脱壳](https://www.52pojie.cn/thread-708085-1-1.html)
    ApkScan-PKID.jar 备份在百度云
    ```java -jar ~/more_tools/ApkScan-PKID.jar```

2. fDex2脱壳方案
    1. 梆梆企业版方案(ninebot)
    2. 脱壳后的dex统一命名为classes.dex, classes1.dex, 打包.zip, 重命名.apk, 使用jadx反编译即可

3. [https://github.com/CodingGay/BlackDex](https://github.com/CodingGay/BlackDex)
    1. 有32位/64位两个app, 分别尝试
    2. 运满满(32位应用[如何检测Android应用是32位还是64位](https://blog.csdn.net/u010194271/article/details/115694727))使用爱加密加固, 脱壳成功

    ```shell
        adb pull /storage/emulated/0/Android/data/top.niunaijun.blackdexa32/dump/com.xiwei.logistics/ ../resource_projects/yunmanman/ymm_apk_dex/ymm_v6.70
    ```

4. [https://github.com/Youlor/Youpk](https://github.com/Youlor/Youpk)
    1. 参考: <https://www.jianshu.com/p/07cbe154879b>
    2. 需要刷机, 还未做
