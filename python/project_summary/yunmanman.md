# 运满满

[TOC]

想要解决的问题:

1. 对运满满的配货大厅感兴趣, 响应加密状态

## 1. 运满满微信小程序

1. 微信小程序反编译后调试报错, 需要在 `详情` -> `本地设置` -> 关闭`es6转es5`等一系列设置
2. 调试接口: <https://www.ymm56.com/ymm-cargo-search-app/cargoes/applet/multiSearch> 响应为aes加密
    1. 调试过程:
        1. 加载小程序后由于无法登陆, 所以接口无法返回数据, 全局搜索`decrypt`定位到`_-1963279196_115/extend/common-re.mini.js`

            ```js
            <!-- _-1963279196_115/extend/common-re.mini.js -->
            <!-- 加密工具 -->
            return o.de = {
                e1: function(t, r) {
                    console.log(t)
                    console.log(r)
                    return e.enc.U8.stringify(e.AES.decrypt(t, e.enc.U8.parse(r.substr(r.length - 16)), {
                        mode: e.mode.X__,
                        padding: e.pad.Pkcs7
                    }));
                },
                dk: function(t) {
                    console.log(t)

                    for (var r = (t.length % 10).toString(), n = r, i = 0; i < 15; i++) n += r;
                    var o = t.indexOf("#");
                    console.log(n)
                    console.log(o)
                    console.log(e.enc.U8.parse(r.substr(r.length - 16)))
                    console.log(e.enc.U8.stringify(e.AES.decrypt(t, e.enc.U8.parse(n), {
                        mode: e.mode.X__,
                        padding: e.pad.Pkcs7
                    })))

                    return o > 0 && (t = t.substr(0, o)), e.enc.U8.stringify(e.AES.decrypt(t, e.enc.U8.parse(n), {
                        mode: e.mode.X__,
                        padding: e.pad.Pkcs7
                    }));
                },
                isEx: function(t) {
                    if (t.length < 51) return !0;
                    for (var e, r = t.substr(4, 11), n = r.length, i = new Array(n), o = 0; o < n; o++) (e = r.charCodeAt(o)) >= 48 && e < 58 ? e -= 48 : e = (223 & e) - 65 + 10, 
                    i[o] = e;
                    return t = i.reduce(function(t, e) {
                        return 16 * t + e;
                    }, 0), !(new Date().getTime() < t);
                },
                sign: function(t, r) {
                    return (t ? e.MD5("key=" + r + "&body=" + e.MD5(t).toString(e.enc.Hex)) : e.MD5("key=" + r + "&body=")).toString(e.enc.Hex);
                },
                MD5: function(t) {
                    return e.MD5(t).toString(e.enc.Hex);
                }
            ```

        2. 通过log一些变量, 发现尽管无法还原response的解密, 但是构造请求的加密过程可以追踪, 证实了步骤一的假设

            ```js
            <!-- _-1963279196_115/mixins/basePage.js -->
            <!-- 加密构造请求参数 -->
            y = JSON.stringify(e.data), m = h.default.de.sign(y, v), f["re-key"] = h.default.de.MD5(v), 
            f["re-sign"] = m;
            ```

        3. 响应中有字段`isEncrypted`, 定位到响应的解密位置, v应该就是密码

            ```js
            <!-- _-1963279196_115/mixins/basePage.js -->
            case 0:
                if (console.log("payload.ignoreLogin", r), o = r.data || {}, e.isEncrypt && o.isEncrypted && (o = JSON.parse(h.default.de.e1(o.data, v))), 
                200 !== r.statusCode) {
                    t.next = 7;
                    break;
                }
                a(o), t.next = 15;
                break;
            ```

        4. 分析请求加密过程发现一段奇怪的字符串, 类似 `o6L07FylH6OhS1GFWG7Rr7FRAswUVE7bBtYRj+1ZOvrflxpuC78e3eawsa1G51FmV23+OSSEJ7rqhcI9S2MahQ==#####`, 通过调用`dk`后生成长度52的字符串(实际上就是密钥), 之后用这个字符串生成`multiSearch`请求的参数
        5. 发现`e1`方法中传入的`v`实际上就是密钥的后16位
        6. 验证猜测成立
    2. 请求逻辑
        1. 请求<https://www.ymm56.com/risk-encrypt/encrypt/key-generate> 返回加密后的密钥, 然后通过自定义解密方法`dk`解密
            1. 加密内容长度对10取余 *16 为密码
            2. aes解密得到真实密钥
        2. 发送<https://www.ymm56.com/ymm-cargo-search-app/cargoes/applet/multiSearch>时, 根据前一个请求的密钥, 传输密钥的md5和sign来标记请求
        3. 接收到响应后, 用密钥的后16位作为密码, 解密
        4. 所有加密采用aes.ECB, 填充方式: pkcs7padding, 数据块:128位
        5. key-generate产生的密钥会有效一段时间, 可以通过发送请求的`re-key`, `re-sign`来判断是否一致

## 2. app 运满满司机客户端

1. 检测frida

    ```Java
    package com.mb.lib.device.security;

    class SecurityServiceImpl(){
        private boolean continueCheckFrida(CheckOption checkOption, final ContinueCheckListener continueCheckListener) {
            ...
        }
    }
    ```

2. 当天货源接口
    app当天货源在匿名和用户登陆后, 分别使用不同的接口

    ```Java
    // 加密方式也不同, 登陆后接口返回参数有etype=1, 调用
    // 响应包含 var tmp etype三个参数
    if (rawResponseObj.geteType() == 0) {
        response = decryptByPShell(response, rawResponseObj);
    } else {
        response = decryptByIE(response, rawResponseObj, isEmpty);
    }
    ```

    解密后发现, 订单列表等一些请求做了压缩

    ```Java
    package com.ymm.lib.commonbusiness.ymmbase.network.interceptor;

    public class EncryptInterceptor extends BaseInterceptor{
        if (isEmpty && (split = response.header("M-X").split("&")) != null) {
            for (String str : split) {
                if (str.trim().equals("type=2")) {
                    try {
                        response.body().contentLength();
                        response.request().url().toString();
                        byte[] decompress = DelfateUtil.decompress(response.body().bytes());
                        int length = decompress.length;
                        response = response.newBuilder().body(ResponseBody.create(response.body().contentType(), new String(decompress, this.mCharset.name()))).removeHeader("M-X").build();
                    } catch (Exception e2) {
                    }
                }
            }
        }
    }


    // package com.ymm.lib.commonbusiness.ymmbase.util.DelfateUtil

    public static byte[] decompress(byte[] bArr)
    ```

    - 登陆搜索: <https://www.ymm56.com/ymm-cargo-search-app/cargoes/multiSearch>

        ```Java
        package com.ymm.lib.commonbusiness.ymmbase.network.interceptor;

        public class EncryptInterceptor extends BaseInterceptor{
            private c iEncrypt = cl.a.a("random_cipher");

            private Response decryptByIE(Response response, RawResponseObj rawResponseObj, boolean z2) throws IOException {
                PatchProxyResult proxy = PatchProxy.proxy(new Object[]{response, rawResponseObj, new Byte(z2 ? (byte) 1 : 0)}, this, changeQuickRedirect, false, 20146, new Class[]{Response.class, RawResponseObj.class, Boolean.TYPE}, Response.class);
                if (proxy.isSupported) {
                    return (Response) proxy.result;
                }
                if (rawResponseObj.isVarEmpty()) {
                    throw new EncryptException(201);
                } else if (z2) {
                    try {
                        byte[] c2 = this.iEncrypt.c(com.ijiami.a.a(rawResponseObj.getVar()));
                        if (c2.length != 0) {
                            return response.newBuilder().body(ResponseBody.create(response.body().contentType(), c2)).build();
                        }
                        throw new EncryptException(202);
                    } catch (Exception unused) {
                        throw new EncryptException(200);
                    }
                } else {
                    try {
                        String c3 = this.iEncrypt.c(rawResponseObj.getVar());
                        if (!TextUtils.isEmpty(c3)) {
                            return response.newBuilder().body(ResponseBody.create(response.body().contentType(), c3)).build();
                        }
                        throw new EncryptException(202);
                    } catch (Exception unused2) {
                        throw new EncryptException(200);
                    }
                }
            }
        }

        // cl.a
        // return cl.e.a
        public byte[] a(byte[] bArr) throws Exception {
            PatchProxyResult proxy = PatchProxy.proxy(new Object[]{bArr}, this, changeQuickRedirect, false, 4486, new Class[]{byte[].class}, byte[].class);
            return proxy.isSupported ? (byte[]) proxy.result : d.a(bArr);
        }

        // cl.d.a
        public static byte[] a(byte[] bArr) throws Exception {
            PatchProxyResult proxy = PatchProxy.proxy(new Object[]{bArr}, null, changeQuickRedirect, true, 4480, new Class[]{byte[].class}, byte[].class);
            return proxy.isSupported ? (byte[]) proxy.result : JMEncryptBoxByRandom.a(bArr);
        }

        // 解密
        // this.iEncrypt.c
        // com.ijiami.JMEncryptBoxByRandom
        public class JMEncryptBoxByRandom {
            public static native byte[] dencryptByRandom(byte[] bArr);

            public static native byte[] encryptByRandom(byte[] bArr);

            static {
                new JMEncryptBox();
            }

            public static byte[] c(byte[] bArr) throws Exception {
                return dencryptByRandom(bArr);
            }
        }

        ```

    - 访客搜索: <https://www.ymm56.com/ymm-cargo-search-app/cargoes/visitorSearch>

        ```Java
        package com.ymm.lib.commonbusiness.ymmbase.network.interceptor;

        private Response decryptByPShell(Response response, RawResponseObj rawResponseObj) throws IOException {
            PatchProxyResult proxy = PatchProxy.proxy(new Object[]{response, rawResponseObj}, this, changeQuickRedirect, false, 20147, new Class[]{Response.class, RawResponseObj.class}, Response.class);
            if (proxy.isSupported) {
                return (Response) proxy.result;
            }
            URL url = new URL(response.request().url().toString());
            if (SecurityCenter.getInstance().needRefresh(rawResponseObj.getOverload(), rawResponseObj.getTemp(), rawResponseObj.getVar())) {
                SecurityCenter.getInstance().requestRefreshAlgorithm(new RefreshParam.Builder().setKey(url.toString()).setOldPolicyNumber(rawResponseObj.getNumber()).setPath(rawResponseObj.getPath()).setOverload(rawResponseObj.getOverload()).setAim(rawResponseObj.getAim()).build());
            }
            if (!rawResponseObj.isTmpVarEmpty()) {
                DecryptResultObj decrypt = SecurityCenter.getInstance().decrypt(url.toString(), rawResponseObj.getVar(), buildFactors(response.request()), rawResponseObj.getTemp(), Integer.valueOf(rawResponseObj.getNumber()));
                if (decrypt.getDecrypt() == null || decrypt.getDecrypt().length <= 0) {
                    SecurityCenter.getInstance().requestRefreshAlgorithm(new RefreshParam.Builder().setKey(url.toString()).setOldPolicyNumber(rawResponseObj.getNumber()).setPath(rawResponseObj.getPath()).setOverload(rawResponseObj.getOverload()).setAim(rawResponseObj.getAim()).build());
                    throw new EncryptException(102);
                }
                return response.newBuilder().body(ResponseBody.create(response.body().contentType(), decrypt.getDecrypt())).build();
            }
            throw new EncryptException(101);
        }

        ```
