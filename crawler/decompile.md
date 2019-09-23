https://my.oschina.net/f839903061/blog/72551



一、反编译Apk得到Java源代码
首先要下载两个工具：dex2jar和JD-GUI

前者是将apk中的classes.dex转化成Jar文件，而JD-GUI是一个反编译工具，可以直接查看Jar包的源代码。以下是下载地址：

dex2jar：http://sourceforge.net/projects/dex2jar/files/ （https://github.com/pxb1988/dex2jar）2017年8月25日再次更新了下载链接

JD-GUI：http://jd.benow.ca/#jd-gui-download

具体步骤：

首先将apk文件，将后缀改为zip，解压，得到其中的classes.dex，它就是java文件编译再通过dx工具打包而成的；

解压下载的dex2jar，将classes.dex复制到dex2jar.bat所在目录。在命令行下定位到dex2jar.bat所在目录

运行如下图示红框中的命令：



生成

classes.dex.dex2jar.jar

生成jar文件的截图如下：

 

运行JD-GUI（jd-gui.exe），打开上面生成的jar包，即可看到源代码了


HelloAndroid源码（编译前的apk源码对照）如下：

 



※※※※※※※※※※※※※

## dex2jar逆向之多dex
参考链接(https://blog.csdn.net/class_brick/article/details/72782772)


1. 背景原因: 
    很多大厂的Android App因为业务量大,引用库多导致其apk包的中的类于方法剧增.这样就有可能出现因为方法数过多导致编译失败的情况.产生这个问题的主因是dex文件格式的限制.一个DEX文件中method个数采用使用原生类型short来索引文件中的方法,也就是4个字节共计最多表达65536个method,field/class的个数也均有此限制。对于DEX文件，则是将工程所需全部class文件合并且压缩到一个DEX文件期间,也就是Android打包的DEX过程中,单个DEX文件可被引用的方法总数被限制为65536.  
    为解决这个问题,谷歌推出了Multidex技术,简单来说就是将一个apk中的dex文件拆分成多个分主次先后加载,当然在这之前业界已经开始使用插件化来弱化此类问题.现在市面上也有很多Multidex和插件化两种方案都使用的app.  
	在逆向apk中经常会遇到一些类丢失,反编译崩溃的情况.如果这时候去观察apk压缩包会发现其中有超过一个dex,上图中就有两个dex.那么这个app分析起来就不会很轻松了,因为这个叫dex分包的技术直接意味着你要面对超过65536个java方法.而这篇文章主要就是讲解笔者在遇到这种情况的时候一些应对手法.


2. 解决办法
好消息是现在可以使用dex2jar 2.1版本[下载地址](https://github.com/pxb1988/dex2jar/releases)解析多dex的包
```
d2j-dex2jar.sh the-apk-witch-mutidex.apk
# windows
d2j-dex2jar.bat the-apk-witch-mutidex.apk
```
	- 注意, windows解析时会




二、反编译apk生成程序的源代码和图片、XML配置、语言资源等文件

如果是只是汉化软件，这将特别有用。

首先还是下载工具，这次用到的是apktool  （官网）

安装方法：https://ibotpeaches.github.io/Apktool/install/   （2017年7月26日16:47:57  更新了此链接）

具体步骤：

总共会有两个文件：apktool.bat，apktool.jar

图片如下：



命令行解释：apktool   d   [apk文件 ]   -o [输出文件夹]  (注：上面图片不加参数-o直接后面最近路径名现在已经不可用了，如果想不想麻烦直接输入  apk tool  d   test.apk 就可以了 ，会自动在当前文件夹创建test文件夹的)

反编译的文件如下（AndroidManifest.xml为例）：



 

将反编译完的文件重新打包成apk，很简单，输入apktool b c:\***文件夹（你编译出来文件夹）即可，命令如下：

 

打包apk后的文件在目录C:\HelloAndroid下，生成了两个文件夹：

build

dist

其中，打包生成的HelloAndroid.apk，在上面的dist文件夹下，Ok