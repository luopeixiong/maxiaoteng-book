# PyExecJS python执行js代码

1. install
    ```
    pip install PyExecJS
    ```
2. demo
    ```
        import execjs
        js_str = """var re = function(){
            var fo = new Fingerprint()
            return fo.getCanvasFingerprint()
        }
        """
        ctx = execjs.get().compile(js_str)
        t = ctx.call('re')
        # or
        t =execjs.get().eval(js_str)
        print(t)
    ```