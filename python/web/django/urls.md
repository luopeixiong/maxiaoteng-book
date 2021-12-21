# URLS

1. 路径配置位于urls.py
2. 每个应用有单独的urls.py,如`blog/urls.py`

    ```python
    from django.urls import path
    from . import views
    from django.conf.urls import url

    urlpatterns = [
        path(r'', views.index, name='index'),
        # or
        # url(r'hello/', view.hello),
    ]
    ```

3. 配置到总目录中, `projects/urls.py`

    ```python
    from django.contrib import admin
    from django.urls import path, include

    urlpatterns = [
        path('admin/', admin.site.urls),
        path(r'blog/',include('blog.urls')),
    ]
    ```
