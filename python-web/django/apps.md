# apps

对应app/apps.py

1. 应用初始

    ```python
    class JobManagerConfig(AppConfig):
        default_auto_field = 'django.db.models.BigAutoField'
        name = 'job_manager'

        # Subclasses can override this method to perform initialization tasks such as registering signals. It is called as soon as the registry is fully populated.
        # python manage.py runserver 会使ready运行两次, 可以加参数 python manage.py runserver --noreload
        def ready(self) -> None:
            print('初始化app')
    ```
