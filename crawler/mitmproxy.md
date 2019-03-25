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
    - 证书位于 .mitmproxy
    - mitmproxy-ca.pem  # PEM格式的证书私钥
    - mitmproxy-ca-cert.p12 # PKCS12格式的证书，适用于Windows平台
    - mitmproxy-ca-cert.pem # PEM格式证书，适用于大多数非Windows平台
    - mitmproxy-ca-cert.cer # 与mitmproxy-ca-cert.pem相同，只是改变了后缀，适用于部分Android平台
    - mitmproxy-dhparam.pem # PEM格式的秘钥文件，用于增强SSL安全性

2. 带脚本启动
    ```
        mitmdump -s script.py
    ```
    - script.py样本
        ```
            # 定义flow即可
            def response(flow):
                request = flow.request
                response = flow.response

                # 过滤请求的URL
                if 'info' in request.url:

                    result = json.loads(response.text.encode('utf-8'))
                    if result.get('result') == 0:
                        # 请求正常
                        data = result.get('data')
                        user_info = {
                            "nickname": data.get('nickname'),
                            "userid": data.get('userid'),
                            "red_id": data.get('red_id'),
                        }
                    save_info_to_mongo(user_info)
    
        ```
