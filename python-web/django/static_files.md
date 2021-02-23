# 静态文件

[官方文档](https://docs.djangoproject.com/en/2.2/howto/static-files/)

## 1. 开发使用
1. 位置: 存放在对应的应用下,django静态服务器会收集所有static目录下的文件
2. 默认app`django.contrib.staticfiles`会寻找`INSTALLED_APPS`下所有app的static文件, 比如`/polls/static/polls/style.css`,
3. `/blog/static/blog/js`or `/blog/static/blog/css`
4. settings 中配置 `STATIC_URL = '/static/'`
5. 引用
    ```html
    {\% load staticfiles \%}
    <!-- 相当于渲染：/static/blog/css/bootstrap.min.css -->
    <link rel="stylesheet" href="{\% static 'blog/css/bootstrap.min.css' \%}">
    <script src="{\% static 'blog/js/modernizr.custom.js' \%}"></script>
    ```

## 2. 部署使用
