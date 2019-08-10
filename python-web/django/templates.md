# Templates 模板

## 1. 使用django模板
1. 位置，项目根目录下`/templates`
   1. 每个应用存放在单独的文件夹中
2. `/project/settings.py`中生效
    ```
    ...
    TEMPLATES = [
        {
            ...
            'DIRS': [os.path.join(BASE_DIR, 'templates'),],       # 修改位置
            ...
        },
    ]
    ```
3. 使用render渲染
    ```python
    # 见views
    render(request, 'blog/index.html', context=context)
    ```

4. 静态文件[static_files.md](static_files.md)
    