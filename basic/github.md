# Github

记录github一些常用技巧

## 1. 使用github publish page实现自定义域名的跳转
用服务器托管web应用, 需要始终有云服务器, 或者nas在线, 而一些静态网页变动不大, 使用github托管更稳定一些

参考[my_routes](https://github.com/maxiaoteng001/my_routes.git)
1. 配置托管分支和自定义域名
    1. 找到特定的仓库, Settings -- GitHub Pages -- Source 选择master或其他分支
    2. GitHub Pages -- Custom domain  输入自己的域名
    3. 访问Custom domain将会访问到master的index.html
2. 然后在页面使用js或其他配置实现重定向到需要的页面, 或者添加tag a 来实现静态页面之间的自由跳转
    ```html
        <script>
            window.location.href="https://maxiaoteng001.github.io/maxiaoteng-book/"
        </script>
    ```