# 安装和基本操作

## 安装selenium
```
sudo pip install selenium

sudo python3 -m pip install selenium
```

## 安装浏览器驱动

当你使用PhantomJS时, selenium会提醒PhantomJS已经被弃用,并且 PhantomJS 不再更新. 同时为了便于调试, windows上用的chrome, 所以选择chrome

** windows 安装都很简单, 主要说明linux安装 **
- 环境: Amazon Linux
- chrome安装: [安装说明](https://intoli.com/blog/installing-google-chrome-on-centos/)
- chromedriver安装: [安装说明](https://devopsqa.wordpress.com/2018/03/08/install-google-chrome-and-chromedriver-in-amazon-linux-machine/)


## 快速入门

- 启动浏览器

```
def launch_driver():
    # Chrome配置
    option = webdriver.ChromeOptions()
    option.add_argument('headless')  # 无界面, 服务器使用
    prefs = {"profile.managed_default_content_settings.images": 2}  # 不加载图片
    option.add_experimental_option("prefs", prefs)

    driver = webdriver.Chrome(chrome_options=option)
    driver.implicitly_wait(10)

    return driver
    
```

- 加载页面
```
    driver = launch_driver()
    driver.get(url)
```

- driver的一些属性

```
    driver.title  # 页面标题
    driver.page_source  # 页面源代码
```
