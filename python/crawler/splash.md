# Splash

## 1. splash的优势
1. selenium + Chrome + Chromedriver的方案需要调起浏览器，占用资源较多，无法实现异步和大规模爬取需求
2. Splash是一个Javascript渲染服务。
3. Splash是一个实现了HTTP API的轻量级浏览器
4. Splash是用Python实现的，同时使用Twisted和QT。Twisted（QT）用来让服务具有异步处理能力，以发挥webkit的并发能力。
5. 通过安装配置，实现一个页面渲染服务器，返回渲染后的页面，便于爬取，便于规模应用。


## 2. Splash的安装
1. 提供docker安装
[安装教程](https://splash.readthedocs.io/en/stable/install.html#linux-docker)
```
sudo docker pull scrapinghub/splash
sudo docker run -it -p 8050:8050 scrapinghub/splash
# 服务启动在：localhost:8050
```
2. http API
[api文档](https://splash.readthedocs.io/en/stable/api.html#render-html)
