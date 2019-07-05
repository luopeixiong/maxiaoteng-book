# mitmproxy

## 1. 安装
1. mac
    ```
    brew install mitmproxy
    ```
2. docker
    ```
    https://hub.docker.com/r/mitmproxy/mitmproxy/

    # docker启动
    docker run --rm -it -p 8080:8080 mitmproxy/mitmproxy mitmdump

    # 获取ca证书可以挂载磁盘
    docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 mitmproxy/mitmproxy mitmdump

    # 启动mitmweb
    docker run --rm -it -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmweb
    ```

## 2. 使用
1. 客户端需信任CA证书
    - 证书位于 ./mitmproxy
    - mitmproxy-ca.pem  # PEM格式的证书私钥
    - mitmproxy-ca-cert.p12 # PKCS12格式的证书，适用于Windows平台
    - mitmproxy-ca-cert.pem # PEM格式证书，适用于大多数非Windows平台
    - mitmproxy-ca-cert.cer # 与mitmproxy-ca-cert.pem相同，只是改变了后缀，适用于部分Android平台
    - mitmproxy-dhparam.pem # PEM格式的秘钥文件，用于增强SSL安全性

2. 脚本内容
    - script.py实践
        ```Python
        import mitmproxy.http
        from mitmproxy import ctx
        from mitmproxy.http import HTTPFlow as flow
                        
        class Ctrip:
            def __init__(self):
                self.num = 0
            
            def request(self, flow: mitmproxy.http.HTTPFlow):
                # 修改request请求，headers或者代理
                if "xx.com" in flow.request.url:
                    flow.request.headers["User-Agent"] = 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Mobile Safari/537.36'
                    return

            def response(self, flow: mitmproxy.http.HTTPFlow):
                # 修改响应
                if "page/brands/" in flow.request.url:
                    # 将js代码注入到浏览器首页，防止无头浏览器被检测
                    # 所需注入的js代码
                    injected_javascript = '''
                        // overwrite the `languages` property to use a custom getter
                        Object.defineProperty(navigator, "languages", {
                        get: function() {
                            return ["zh-CN","zh","zh-TW","en-US","en"];
                        }
                        });

                        // Overwrite the `plugins` property to use a custom getter.
                        Object.defineProperty(navigator, 'plugins', {
                        get: () => [1, 2, 3, 4, 5],
                        });

                        // Pass the Webdriver test
                        Object.defineProperty(navigator, 'webdriver', {
                        get: () => false,
                        });


                        // Pass the Chrome Test.
                        // We can mock this in as much depth as we need for the test.
                        window.navigator.chrome = {
                        runtime: {},
                        // etc.
                        };

                        // Pass the Permissions Test.
                        const originalQuery = window.navigator.permissions.query;
                        window.navigator.permissions.query = (parameters) => (
                        parameters.name === 'notifications' ?
                            Promise.resolve({ state: Notification.permission }) :
                            originalQuery(parameters)
                        );
                    '''
                    html = flow.response.text
                    html = html.replace('<head>', '<head><script>%s</script>' % injected_javascript)
                    flow.response.text = str(html)

                # 处理响应
                if "xx" in flow.request.url:
                    # http api
                    host = flow.request.host
                    sort = flow.request.query.get('sort')
                    resp = flow.response.text
            
            # 直接拦截
            def http_connect(self, flow: mitmproxy.http.HTTPFlow):
                if flow.request.host == "www.google.com":
                    flow.response = http.HTTPResponse.make(404)

        addons = [Ctrip()]
        ```

3. 命令行启动脚本
    ```
    mitmdump -s script.py

    # 使用阿布云代理, -p为指定代理端口
    mitmdump --mode upstream:http-dyn.abuyun.com:9020 --upstream-auth username:password -s mitm_for_script.py -p 8090
    ```