# 反爬虫策略 Anti-spider strategy

1. 通过header
    1. User-Agent, Cookie, Referer
2. 访问行为(比如高并发)
3. JavaScript动态计算
4. 验证码
5. 蜜罐(设置一些普通用户访问不到的内容)
6. 识别到爬虫，返回假数据


## 1. 反爬措施收集
1. |Cookie |验证用户cookie   |大众点评|
2. |上行加密 |加密了上行请求的参数，导致无法分析请求   |航旅纵横|
3. |Headers中加Shield实时加密 |对每个请求都做了加密和验证   |小红书|
4. |[Protobuf](./protobuf.md) |请求和响应采用protobuf传输, 如果找不到加密模版, 就无法理解返内容   |Mercari(美国)|
5. |阻止web调试 |用脚本检测是否打开了浏览器调试工具   |同程旅游|
6. |多次请求 |通过中间请求获取token给目标请求   |JAL(日航国内版)|
7. 东航反爬记录
    1. 先发送http://observer.ceair.com/ta.png?  
        1. 发送"seriesid":"8980ed209e5811eab0aebfab2f9b3d9e", 可以随机
        2. 不需要cookie
        3. 返回set-cookie: user_ta_session_id, Webtrends
    2. 发送http://www.ceair.com/otabooking/flight-search!doFlightSearch.shtml
        1. cookie: 带user_ta_session_id, Webtrends
        2. post_data中包含seriesid
            1. seriesid
            2. {"adtCount":1,"chdCount":0,"infCount":0,"currency":"CNY","tripType":"OW","recommend":false,"reselect":"","page":"0","sortType":"a","sortExec":"a","seriesid":"8980ed209e5811eab0aebfab2f9b3d9e","segmentList":[{"deptCd":"PEK","arrCd":"SHA","deptDt":"2020-05-26","deptAirport":"","arrAirport":"","deptCdTxt":"北京","arrCdTxt":"上海","deptCityCode":"BJS","arrCityCode":"SHA"}],"version":"A.1.0"}
    3. 有的ip可能需要发送两次返回结果

8.  web端用js检测用户浏览器是否开启调试面板
    - [实现参考知乎](https://www.zhihu.com/question/24188524)
    - [github-用法](https://github.com/sindresorhus/devtools-detect)
