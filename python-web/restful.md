# Restful API

核心是面向资源
所有事务都可以抽象为资源
每个资源都有唯一标识

资源: 歌曲,文章,文本,视频

## 1. SOAP 和 RESTful架构
1. 效率和易用性, soap易用性差
2. 安全性方面: RESTful使用安全要求不高的资源型服务接口.

## 2. 如何设计RESTful API
1. 资源路径
    1. 资源常用复数
        - https://api.example.com/v1/posts  // 博客资源
2. HTTP动词
    1. GET
        - /posts/ID
    2. POST
        - /posts
    3. PUT / PATCH    都是update
        - 幂等性, 多次请求结果一致
        - PUT 要求幂等性, 如果位置不存在,则创建一个, 要求带有完整的信息
        - PATCH 不是幂等的, 如果位置不存在,则出现错误, 也不会自动重新尝试失败的请求
        - /posts/ID
    4. DELETE
        - /posts/ID
3. 过滤信息
    1. api提供参数进行筛选
        - ?offset=10
        - ?page=2&per_page=100
        - ?sortby=name&order=asc
        - ?post_id=1
4. 状态码
    1. 成功状态码
        1. 200  OK  服务器成功返回用户请求的数据
        2. 201  CREATED 新建或修改数据成功
        3. 204  NO CONTENT  删除数据成功  
    2. 客户端请求有问题
        1. 400  BAD REQUEST 用户发出的请求有错误
        2. 401  Unauthorized    表示用户没有认证,无法进行当前操作
        3. 403  Forbidden   表示当前用户访问是被禁止的
        4. 422  Unprocesable Entity   表示当创建一个对象时,发生一个验证错误

    3. 服务端错误
        1. 500  INTERNAL SERVER ERROR   服务器发生错误,用户将无法判断发出的请求是否成功

5. 错误处理
    1. 响应提示
        - ```
            {
                "error": "参数错误"
            }
        ```
6. 返回结构
    1. GET  /collections    返回资源对象的列表
    2. GET  /collections/identity   返回单个资源对象
    3. POST /collections    返回新生成的资源对象
    4. PUT  /collections/identity   返回完整的资源对象
    5. PATCH    /collections/identity   返回被修改的属性
    6. DELETE   /collections/identity   返回一个空文档
