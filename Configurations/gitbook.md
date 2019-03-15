# Gitbook的坑
## 原因

本来使用github登陆, 但是由于hotmail把gitbook的**验证邮件放到了垃圾箱**, 好像是自动将邮箱注册了一个新账号, 再使用新账号关联github时便不能绑定. 

## 1. 目前已解决, 使用github登陆
1. 每次建立新的space和project以后  
2. 点击左下角的更多, 选择integrations,在选择github即可.  

gitbook自动同步github上的内容

## 2. gitbook 安装和开始
[教程](https://yangjh.oschina.io/gitbook/faq/Step.html)

## 3. gitbook 对多级目录的支持

[说明](https://yangjh.oschina.io/gitbook/faq/Contents.html)
gitbook通过根目录下的SUMMARY.md来管理目录结构, 最多三级目录


## 4. 将gitbook配置在自己的服务器
1. 安装nodejs和gitbook-cli
```
# 安装依赖
sudo yum install epel-release
# 安装nodejs
sudo yum install nodejs
# 验证
node -v
# 安装gitbook
sudo npm install gitbook -g
```
2. 导入一本书
```
# 将在该目录下创建一本书, 包含两个文件README.md和SUMMARY.md两个文件
gitbook init ./directory_name
## 导入书籍可以直接clone到指定目录下
```
3. 启动它
```
# 在书籍的根目录下, 即有readme的目录下
gitbook serve
# 结束后将运行来localhost:4000下面
```
4. 编写cronlab定时任务自动更新gitbook内容


## 5. gitbook配置文件
1. gitbook的插件
    book.json中不能有注释， 注释在这里
    // 安装插件  
    // 1. 折叠目录， 2. 分块显示 3. 自由移动目录侧 
    ```json
    "plugins": ["toggle-chapters", "sectionx", "splitter"]
    ```

    ```python
    # 安装插件
    gitbook install
    ```
    - 目录前面加序号
    ```json
    "theme-default": {
            "showLevel": true
        },
    ```

## 6. 启动两个gitbook服务
参考： https://blog.csdn.net/moxiaomomo/article/details/53026645
gitbook web服务端口:4000  重启服务端口:35729
    ```
    gitbook serve --lrport 35288 --port 4001 /path2/your_another_doc_dir/
    ```

## 7. gitbook插件

### 1. 使用
1. 插件需要在book.json中配置
2. 位于plugins中, 添加`-`将会取消插件
    ```
    "plugins": ["-toggle-chapters", "sectionx", "splitter"]
    ```
3. 安装
    ```
        gitbook install
    ```

### 2. 插件列表

1. copy-code-button  # 为代码添加复制按钮
2. edit-link    # 直接链接到源文件
    ```
        "plugins": ["edit-link"],
        "pluginsConfig": {
            "edit-link": {
                "base": "https://github.com/USER/REPO/edit/BRANCH",
                "label": {
                "en": "Edit This Page",
                "ch": "编辑本页"
                }
            }
        }
    ```
3. anchor-navigation-ex # 添加toc到侧边悬浮,并添加回到顶部
