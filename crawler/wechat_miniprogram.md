# 微信小程序

1. 下载小程序

    ```shell
    # 位置
    cd /data/data/com.tencent.mm/MicroMsg/93762d3462d980bf7b53d5ef5e41158b/appbrand/pkg/小程序.wxapkg

    cp /data/data/com.tencent.mm/MicroMsg/93762d3462d980bf7b53d5ef5e41158b/appbrand/pkg/* /sdcard/Download/xx
    adb pull /sdcard/Download/xx ~/resource_projects/xx
    ```

2. 反编译

    ````shell
    # node环境
    cd /Users/maxiaoteng/more_tools/wxappUnpacker
    # 先确认主包, 不加-s参数可以解包
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260.wxapkg 
    # 分包解压路径
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_-1479302957_260.wxapkg -s=/Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_-1635202514_3.wxapkg  -s=/Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_-1702001900_260.wxapkg -s=/Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_-484675448_260.wxapkg -s=/Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260
    /Users/maxiaoteng/more_tools/wxappUnpacker/bingo.sh /Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1123949441_535.wxapkg -s=/Users/maxiaoteng/resource_projects/dewu_2021_10_13/2021_10_13/_1739533637_260
    ```

3. 调试时
    1. 如果加载代码后报错, 需要在 `详情` -> `本地设置` -> 关闭`es6转es5`等一系列设置
    2. 如果小程序有定位需求, 需要在app.json中添加内容, 参考[PermissionObject](https://developers.weixin.qq.com/miniprogram/dev/reference/configuration/app.html#permission)
