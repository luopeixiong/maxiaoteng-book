## 优化admin

- 后台显示数据库详情
```
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'created_time', 'modified_time', 'category', 'author']
# Register your models here.
admin.site.register(Post, PostAdmin)
```