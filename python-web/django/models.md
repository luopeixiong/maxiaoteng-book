# models.py

[参考:<https://www.cnblogs.com/sss4/p/7070942.html>]

## 0. 前言

ORM是什么？：(在django中，根据代码中的类自动生成数据库的表也叫--code first)  
ORM：Object Relational Mapping(关系对象映射)  
类名对应------》数据库中的表名  
类属性对应---------》数据库里的字段  
类实例对应---------》数据库表里的一行数据  
obj.id  obj.name.....类实例对象的属性  

Django orm的优势：  
Django的orm操作本质上会根据对接的数据库引擎，翻译成对应的sql语句；所有使用Django开发的项目无需关心程序底层使用的是MySQL、Oracle、sqlite....，如果数据库迁移，只需要更换Django的数据库引擎即可；

1. 新建或修改models的三步骤:
    1. Change your models (in models.py).
    2. Run `python manage.py makemigrations` to create migrations for those changes
    3. Run `python manage.py migrate` to apply those changes to the database.
2. 说明

    ```shell
    # 生效models的创建和更改
    python manage.py makemigrations
    python manage.py makemigrations polls   # 指定app
    # 查看modles sql, 不执行仅用于调试判断是否符合预期
    python manage.py sqlmigrate polls 0001  # 0001是更新历史
    # 
    # 创建和更新表    `INSTALLED_APPS` 包含了一些默认组建方便使用, 这些组件可能需要使用数据库, 所以下列操作创建必要的表
    python manage.py migrate
    ```

## 1. 初始化Models

创建models.py来表示数据库关系

1. 数据库关系

    ```shell
    - ForeignKey  # 外键, 设置一对多, 例如: models.ForeignKey(User, on_delete=models.CASCADE)  # on_delete在1.10版本上不需要
    - ManyToManyField  # 多对多关系,tags = models.ManyToManyField(Tag, blank=True)
    ```

2. 数据库内容类型

    ```python
    - CharField  # 字符串
    - TextField  # 很长的字符串
    - DateTimeField  # 时间日期
    - DateField  # 日期
    - 枚举字段
        choice=(
            (1,'男人'),
            (2,'女人'),
            (3,'其他')
        )
        lover=models.IntegerField(choices=choice)
    ```

3. 内容参数

    ```python
    - max_length=100  
    - blank=True # 默认False
    ```

4. 例子

    ```python
    from django.db import models
    class Post(models.Model):
        # 文章标题
        tille = models.CharField(max_length=70)
        body = models.TextField()
        modified_time = models.DateTimeField()
        category = models.ForeignKey(Category, on_delete=models.CASCADE)
        tags = models.ManyToManyField(Tag, blank=True)
    ```

5. 内置Model

    ```python
    # django.contrib.auth 是 Django 内置的应用，专门用于处理网站用户的注册、登录等流程，User 是 Django 为我们已经写好的用户模型。
    from django.contrib.auth.models import User
    ```

6. 外键的创建

    ```python
    people_id = ForeignKey(XX, on_delete=models.CASCADE) 
    ```

## 2. Django操作数据库

1. 增
    - 增加单个

        ```python
            # 方法一
            from blog.models import Tag
            p1 = Publisher(name='Apress', address='2855 Telegraph Avenue',city='Berkeley', state_province='CA', country='U.S.A.',website='http://www.apress.com/')
            p1.save()

            # 方法二
            p1 = Publisher.objects.create(name='Apress',address='2855 Telegraph Avenue',city='Berkeley',state_province='CA', country='U.S.A.',website='http://www.apress.com/')
        ```

    - 批量增加

        ```python
            t1 = Tag(name='name1')
            t2 = Tag(name='name2')
            t3 = Tag(name='name3')
            t4 = Tag(name='name4')
            tags = [t1, t2, t3, t4]
            TAG.objects.bulk_create(tags)
        ```

2. 查
    1. 查询全部

        ```python
            Tag.objects.all()
            > <QuerySet [<Tag: Tag object>]>  # 返回类型
            # 可迭代类型,每个都是model实例
            # 返回list, 每个是dict
            Tag.objects.all().values()
            # 返回list, 每个是list, 只保留value
            Tag.objects.all().values_list()
        ```

    2. 条件查询

        ```python
            t = Tag.objects.get(title='test')  # 返回一条数据, 当有多条或没有错误, 抛出异常
        ```

    3. where 或 where not 查询

        ```python
            t = Tag.objects.filter(condition) 
            t = Tag.objects.exclude(condition)
            # condition语句支持 = 大于 小于, 与或非操作 
        ```

    4. 连锁查询
        需要同时进行过滤和排序查询的操作时，可以简单地写成这种“链式”的形式：

        ```python
            Publisher.objects.filter(country="U.S.A.").order_by("-name")
            [<Publisher: O'Reilly>, <Publisher: Apress>]
        ```

    5. 限制返回的语句

        ```python
            >>> Publisher.objects.order_by('name')[0]
            <Publisher: Apress>

            # 类似的，可以用Python的range-slicing语法来取出数据的特定子集：
            >>> Publisher.objects.order_by('name')[0:2]
            # 这个例子返回两个对象，等同于以下的SQL语句：
            SELECT id, name, address, city, state_province, country, website
            FROM books_publisher
            ORDER BY name
            OFFSET 0 LIMIT 2;

            # 注意，不支持Python的负索引(negative slicing)：
            >>> Publisher.objects.order_by('name')[-1]
            Traceback (most recent call last):
            ...
            AssertionError: Negative indexing is not supported.

            # 虽然不支持负索引，但是可以使用其他的方法。 比如，修改order_by() 语句来实现：
            >>> Publisher.objects.order_by('-name')[0]
        ```

3. 改, 更新
    1. save()方法

        ```python
            # save方法将会更新对象的所有信息,不管有没有更改
            t = Tag.objects.get(name='test').update(age=18)
            t.name = 'new_name'
            t.save()

            # 等效SQL
            UPDATE books_publisher SET
                name = 'Apress Publishing',
                address = '2855 Telegraph Ave.',
                city = 'Berkeley',
                state_province = 'CA',
                country = 'U.S.A.',
                website = 'http://www.apress.com'
            WHERE id = 52;
        ```

    2. update()方法

        ```python
            Publisher.objects.filter(id=52).update(name='Apress Publishing')
            # update()对任何结果集都有效,可以同时更新多条
            Publisher.objects.all().update(country='USA')

            # 等效SQL语句
            UPDATE books_publisher 
                SET name = 'Apress Publishing' 
            WHERE id = 52;

            # 返回一个int型,表示更改的条数
        ```

4. 删

    ```python
        # 删除数据库中的对象只需调用该对象的delete()方法即可：
        >>> p = Publisher.objects.get(name="O'Reilly")
        >>> p.delete()
        >>> Publisher.objects.all()
        [<Publisher: Apress Publishing>]    #少了一条记录

        # 同样我们可以在结果集上调用delete()方法同时删除多条记录。这一点与我们上一小节提到的update()方法相似：
        >>> Publisher.objects.filter(country='USA').delete()
        >>> Publisher.objects.all().delete()
        >>> Publisher.objects.all()
        []

        # 删除数据时要谨慎！ 为了预防误删除掉某一个表内的所有数据，Django要求在删除表内所有数据时显示使用all()。
        # 比如，下面的操作将会出错：
        >>> Publisher.objects.delete()
        Traceback (most recent call last):
        File "<console>", line 1, in <module>
        AttributeError: 'Manager' object has no attribute 'delete'

        # 而一旦使用all()方法，所有数据将会被删除：
        >>> Publisher.objects.all().delete()
        # 如果只需要删除部分的数据，就不需要调用all()方法。再看一下之前的例子：
        >>> Publisher.objects.filter(country='USA').delete()
    ```

5. 排序
    1. 自定义排序

    ```python
        # 升序排列：
        >>> Publisher.objects.order_by("name")
        [<Publisher: Apress>, <Publisher: O'Reilly>]

        # 降序排列：
        >>> Publisher.objects.order_by("-name")
        [<Publisher: O'Reilly>, <Publisher: Apress>]

        # 按多个字段排列（第二个字段会在第一个字段的值相同的情况下被使用到）：
        >>> Publisher.objects.order_by("state_province", "address")
        [<Publisher: Apress>, <Publisher: O'Reilly>]
    ```

    1. 缺省默认排序

    ```python
        class Publisher(models.Model):
            name = models.CharField(max_length=30)
            address = models.CharField(max_length=50)
            city = models.CharField(max_length=60)
            state_province = models.CharField(max_length=30)
            country = models.CharField(max_length=50)
            website = models.URLField()

            def __unicode__(self):
                return self.name

            class Meta:
                ordering = ['name']
            # 你可以在任意一个 模型 类中使用 Meta 类，来设置一些与特定模型相关的选项。 如果你设置了ordering这个选项，那么除非你检索时特意额外地使用了 order_by()，
            否则，当你使用 Django 的数据库 API 去检索时，Publisher对象的相关返回值默认地都会按 name 字段排序。
    ```

## 3. Django中的Q对象和复杂查询

1. 多次查询

    ```python
    # 一般我们在Django程序中查询数据库操作都是在QuerySet里进行进行，例如下面代码:

    >>> q1 = Entry.objects.filter(headline__startswith="What")
    >>> q2 = q1.exclude(pub_date__gte=datetime.date.today())
    >>> q3 = q1.filter(pub_date__gte=datetime.date.today())
    ```

2. 组合

    ```python
    # 两个Q默认为and的关系
    News.objects.get(
        Q(question__startswith='Who'),
        Q(pub_date=date(2005, 5, 2)) | Q(pub_date=date(2005, 5, 6))
    )

    # 等价SQL语句
    SELECT * from news
    WHERE question LIKE 'Who%'  AND (pub_date = '2005-05-02' ORpub_date = '2005-05-06')
    
    
    # Q语句结合关键字查询时,需要关键字在前
    #正确的做法
    News.objects.get(
        Q(pub_date=date(2005, 5, 2)) | Q(pub_date=date(2005, 5, 6)),
        question__startswith='Who')
    
    ```

## 4. 选择数据库版本

见设置文件

## 5. 安全操作

1. Avoiding race conditions using F()

    ```python
    # 数据库级别操作 
    from django.db.models import F
    reporter = Reporters.objects.get(name='Tintin')
    reporter.stories_filed = F('stories_filed') + 1
    reporter.save()
    ```
