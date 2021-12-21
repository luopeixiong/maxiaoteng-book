# Python 应用服务器

## WSGI协议
(Python Web Server Gateway Interface)

- Web框架和Web服务器之间进行通信, 如果在设计时他们不匹配, 那选择框架就会限制服务器的选择. 
- WSGI在PEP 333中定义并被许多框架实现, 规定了Web服务器与Web应用程序/框架之间推荐的标准接口, 确保Web应用程序在不同的Web服务器之间具有可移植性. 
- WSGI协议,使Web开发者能够任意选择自己的组合, 而Web服务器和Web框架的开发者也可以把精力集中到各自的领域.


## 常见的WSGI容器- Gunicorn
易于配置, 兼容性好, CPU消耗少
```
# Work模式
1. 同步worker: 默认模式, 一次只处理一个请求
2. 异步Worker: 通过Eventlet, Gevent实现异步模式
3. 异步IO Worker: 目前支持gthread和gaiohttp两种模式
``` 
```
# 启动命令
# > gunicorn [OPTIONS] MODULE_NAME: VARIABLE_NAME
> gunicorn --workers=3 section19.app:app -b 0.0.0.0:9000
# worker 个数: 推荐cpu个数*2 +1
```

