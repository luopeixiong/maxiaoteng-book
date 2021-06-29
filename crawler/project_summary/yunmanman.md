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
        2. 发送<https://www.ymm56.com/ymm-cargo-search-app/cargoes/applet/multiSearch>时, 根据前一个请求的密钥, 传输密钥的md5和sign来标记请求
        3. 接收到响应后, 用密钥的后16位作为密码, 解密
        4. 所有加密采用aes.ECB, 填充方式: pkcs7padding, 数据块:128位

