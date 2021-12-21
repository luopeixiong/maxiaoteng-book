# admin

1. 创建用户

    ```shell
    python manage.py createsuperuser
    ```

2. app显示在admin中, 方便添加和修改
    1. 展示时
        1. 在列表页展示若干字段

            ```python
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

        2. 展示全部字段

            ```python
            def getFieldsModel(model):
                return [field.name for field in model._meta.get_fields()]

            class PostAdmin(admin.ModelAdmin):
                list_display = getFieldsModel(Post)
            ```

        3. 展示外键

            ```python
            # 如果model正常处理, 外键在列表展示为 Project object (2)
            # 下述将会展示为name
            class Project(models.Model):
                project_id = models.SmallIntegerField()
                name = models.TextField()

                def __str__(self):
                    return self.name

            # 展示外键的更多信息
            class JobAdmin(admin.ModelAdmin):
                list_display.append('project__name')

                def project__name(self, obj):
                    return obj.project.name
                
                project__name.admin_order_field  = 'project'  #Allows column order sorting
                project__name.short_description = 'Project Name'  #Renames column head
            ```

        4. 展示搜索

            ```python
            search_fields = ('name',)
            ```

    2. 编辑时
        1. 自然展示所有字段
        2. 内联: 编辑时会展示所有关联

            ```python
            class JobInlineAdmin(admin.TabularInline):
                model = Job

            class ProjectAdmin(admin.ModelAdmin):
                inlines = [JobInlineAdmin]

            admin.site.register(Project, ProjectAdmin)
            ```

        3. 编辑时不展示全部字段

            ```python
            fieldsets = (
                ['Main',{
                    'fields':('job_id','name', 'project'),
                }],
                ['Advance',{
                    'classes': ('collapse',),
                    'fields': ('trigger', 'trigger_str'),
                }]
            )
            ```
