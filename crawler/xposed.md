# Xposed

## 1.安装

## 2. 项目编写说明

[见项目xposeds](https://github.com/maxiaoteng001/xposeds)  
[demo见项目xposed_demo](https://github.com/maxiaoteng001/xiaoteng_demo.git)

1. Android studio开始一个android项目
2. 添加xposed api `app/build.gradle`

    ```java
    repositories {
        jcenter();
    }
    dependencies {
        compileOnly 'de.robv.android.xposed:api:82'
    }
    ```

3. 设置属性`app/mainfests/AndroidManifest.xml`

    ```xml
    <application
    android:icon="@drawable/ic_launcher"
    android:label="@string/app_name" >

    <!-- 补充如下 -->
    <meta-data
        android:name="xposedmodule"
        android:value="true" />
    <meta-data
        android:name="xposeddescription"
        android:value="Easy example which makes the status bar clock red and adds a smiley" />
    <meta-data
        android:name="xposedminversion"
        android:value="53" />
    ```

4. hook demo
    1. input和output见`app/src/main/java/com/example/xposed_demo/HookNineBot.java`
    2. hook 调用so, 考虑集成[sekiro](https://github.com/virjar/sekiro), demo见`app/src/main/java/com/example/xposed_demo/HookNineBotSekiro.java`
        1. 服务端直接启动即可, 请求参考: `http://192.168.2.141:5601/asyncInvoke?group=ninebot&action=checkcode&query=origin_str`
        2. 在配置sekiro服务时, 尽量使用post请求发送参数(get参数可能有编码和长度限制问题, post也更直观, sekiro对post和get参数做了聚合, 可以直接提取), 参考QQmusicSekiro
    3. 关于sekiro更新
        1. 官方更新了新的demo, 环境待确认
        2. 旧服务使用方式:

            ```shell
            git clone https://github.com/virjar/sekiro
            git checkout 87a244f93878e587aeee3c05cd61c82dce73e82b
            # 将runProd.sh中更新代码部分注释掉
            cd /../sekiro && sh runProd.sh
            ```

5. 指定生效的Xposed模块
    1. 创建文件`app/src/main/assets/xposed_init`
    2. 内容`com.example.xposedhook.HookNineBot`
    3. 一个app可以支持多个模块, 直接在下方追加即可

6. 补充
    1. 使用`import com.alibaba.fastjson.JSON;`

        ```java
        <!-- app/build.gradle -->
        implementation 'com.alibaba:fastjson:1.1.54.android'
        ```

    2. app的一些属性修改`app/src/main/res/values/strings.xml`
    3. 报错`More than one file was found with OS independent path 'META-INF/LICENSE'`
        1. 参考: [More than one file was found with OS independent path 'META-INF/LICENSE](https://stackoverflow.com/questions/44342455/more-than-one-file-was-found-with-os-independent-path-meta-inf-license)
        2. `app/build.gradle`

            ```java
            buildTypes {
                release {
                    minifyEnabled false
                    proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
                }
            <!-- 添加以下 -->
            }
            packagingOptions {
                exclude 'META-INF/DEPENDENCIES'
                exclude 'META-INF/INDEX.LIST'
                exclude ('META-INF/io.netty.versions.properties')
            }
            ```
