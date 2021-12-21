# Docsify

## start_up

1. 基本命令

    ```shell
    npm i docsify-cli -g
    docsify init docsify_demo

    # 一个docsify项目至少包含index.md, README.md
    docsify serve docsify_demo
    ```

2. path映射关系

    - docs/README.md        => <http://domain.com>
    - docs/guide.md         => <http://domain.com/guide>
    - docs/zh-cn/README.md  => <http://domain.com/zh-cn/>
    - docs/zh-cn/guide.md   => <http://domain.com/zh-cn/guide>

## sidebar

1. 根目录下包含`_sidebar.md`文件
2. 内容

    ```markdown
    # Summary

    ## 大类 Docsify/Python/Go

    - [Docsify](docsify/README.md)
    - [sidebar]](docsify/sidebar.md)
    ```

3. `_sidebar.md`规则, 方便自动生成
    1. 大类可以自动匹配到Navbar
    2. 做多三级分类, 如果还多, 自动提升一级, 单列主题
    3. 每个大类为一个文件夹, 包含README.md, 可以被目录下自动识别
    4. 所有的目录名称和一级标题匹配

## navbar

1. 简易版

    ```html
    <body>
        <nav>
            <a href="#/" target="_blank">主页</a>
            <a href="#/python">Python</a>
            <a href="#/go" target="_blank">Go</a>
        </nav>
    <div id="app"></div>
    </body>
    ```
