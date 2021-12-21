# flask others

1. flask 返回json乱码的问题
    - 在app.config添加配置:

        ```python
        if __name__ == "__main__":
            app.config['JSON_AS_ASCII'] = False
            app.run(host='127.0.0.1', port='8080')
        ```
