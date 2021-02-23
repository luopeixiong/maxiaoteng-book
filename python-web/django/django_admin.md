## 优化admin

1. 创建用户
    ```
    python manage.py createsuperuser
    ```
2. app显示在admin中, 方便添加和修改
    ```
    # polls/admin.py
    from django.contrib import admin
    from .models import Question
    admin.site.register(Question)
    #
    # 展示详细可以如下
    class PostAdmin(admin.ModelAdmin):
        list_display = ['title', 'created_time', 'modified_time', 'category', 'author']
    # Register your models here.
    admin.site.register(Post, PostAdmin)
    ```