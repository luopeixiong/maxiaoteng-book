# 反爬虫策略 Anti-spider strategy

1. 通过header
    1. User-Agent, Cookie, Referer
2. 访问行为(比如高并发)
3. JavaScript动态计算
4. 验证码
5. 蜜罐(设置一些普通用户访问不到的内容)
6. 识别到爬虫，返回假数据


## 1. 同城旅游



## 1. 反爬措施收集
|序号   |关键词 |描述   |采用对象|
|:--    |:--    |:--    |:--    |
|1   |Cookie |验证用户cookie   |大众点评|
|2   |上行加密 |加密了上行请求的参数，导致无法分析请求   |航旅纵横|
|3   |Headers中加Shield实时加密 |对每个请求都做了加密和验证   |小红书|
|4   |Protobuf |请求和响应采用protobuf传输, 如果找不到加密模版, 就无法理解返回内容   |Mercari(美国)|
|5   |阻止web调试 |用脚本检测是否打开了浏览器调试工具   |同程旅游|
|6   |多次请求 |通过中间请求获取token给目标请求   |JAL(日航国内版)|

1. web端用js检测用户浏览器是否开启调试面板
    - [实现参考知乎](https://www.zhihu.com/question/24188524)
    - [github-用法](https://github.com/sindresorhus/devtools-detect)
