# PyExecJS python执行js代码

1. install

    ```shell
    pip install PyExecJS
    ```

2. demo

    ```python
        import execjs
        js_str = """
            function re(){
                var fo = new Fingerprint()
                return fo.getCanvasFingerprint()
        }
        """
        ctx = execjs.get().compile(js_str)
        t = ctx.call('re')
        print(t)
    ```
