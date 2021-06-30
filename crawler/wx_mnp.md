# 微信小程序

1. 位置
/data/data/com.tencent.mm/MicroMsg/80b34bca4945f2aa19a92b5549781131/appbrand/pkg/小程序.wxapkg
2. 反编译

    ````shell
     cd /Users/maxiaoteng/Downloads/more_tools/wxappUnpacker
     sudo node wuWxapkg.js /Users/maxiaoteng/projects/dewu_app/dewu/_1739533637_216.wxapkg -s=.
    ```

3. 下载小程序

    ```shell
    cp /data/data/com.tencent.mm/MicroMsg/93762d3462d980bf7b53d5ef5e41158b/appbrand/pkg/* /sdcard/Download/yunmanman
    adb pull /sdcard/Download/yunmanman ~/resource_projects
    ```

4. 调试时
    1. 如果加载代码后报错, 需要在 `详情` -> `本地设置` -> 关闭`es6转es5`等一系列设置
    2. 如果小程序有定位需求, 需要在app.json中添加内容, 参考[PermissionObject](https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html#permission)
