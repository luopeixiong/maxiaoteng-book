# More 

## 1. name space命名空间
1. urls.py
    ```python   
    from django.urls import include, path
    # app namespace
    app_name = 'app'
    urlpatterns = [
        # name url namespace
        path('index/', views.index, name='main-view'),
    ]
    ```
2. views.py
    ```python   
    from django.http import HttpResponsePermanentRedirect
    from django.urls import reverse
    def method(request):
        ....
        return HttpResponsePermanentRedirect(reverse('app:main-view'))
    ```
3. xx.html
    ```html   
    <a href="{% url 'app:main-view' %}">Back to home page</a>
    ```