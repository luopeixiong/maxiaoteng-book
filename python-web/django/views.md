# views

## 1. django orm三种查询方法
1. 直接导入执行SQL
    ```
        from django.db import connection  

        cursor = connection.cursor()  
        cursor.execute("insert into hello_author(name) VALUES ('郭敬明')")  
        cursor.execute("update hello_author set name='韩寒' WHERE name='郭敬明'")  
        cursor.execute("delete from hello_author where name='韩寒'")  
        cursor.execute("select * from hello_author")  
        cursor.fetchone()  
        cursor.fetchall() 
    ```

2. 使用raw
    ```
        books=Book.objects.raw('select * from hello_book')  
        for book in books:  
            print book  
    ```

3. 使用orm方法
    ```
    # 使用extra：查询人民邮电出版社出版并且价格大于50元的书籍
    Book.objects.filter(publisher__name='人民邮电出版社').extra(where=['price>50']) 
    ```


## 2. views三种返回
1. HttpResponse()
   1. 直接返回
        ```
            from django.http import HttpResponse

            def index(request):
                return HttpResponse("欢迎访问我的博客首页！")
        ```
   2. render
        ```
            from django.shortcuts import render

            def index(request):
                post_list = Post.objects.all().order_by('-created_time')
                context = {
                    'post_list': post_list,
                    'title': '博客首页',
                    'welcome': '欢迎访问我的博客首页',
                }
                return render(request, 'blog/index.html', context=context)
        ```

2. JsonResponse()
3. redirect('/other_url')

## 3. 对cookie和session的处理
1. cookie
    ```
    request.COOKIES.get('islogin')
    response.set_cookie('islogin', 'yes')
    ```

2. session
    ```
    在django—session表中创建一条记录:
       session-key                                     session-data
       ltv8zy1kh5lxj1if1fcs2pqwodumr45t                  更新数据
    else:
        1 生成随机字符串   ltv8zy1kh5lxj1if1fcs2pqwodumr45t
        2 response.set_cookie("sessionid",ltv8zy1kh5lxj1if1fcs2pqwodumr45t)
        3 在django—session表中创建一条记录:
        session-key                                     session-data
        ltv8zy1kh5lxj1if1fcs2pqwodumr45t       {"is_login":True,"username":"yuan"}

    
    ```


## 4. request的几个属性
1. Path
2. method
3. GET
4. COOKIES
5. POST
    1. 类似字典对象, 可以通过`request.POST['choice']`来获取post的请求参数