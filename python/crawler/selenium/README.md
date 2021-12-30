# selenium

## 1. 安装selenium

```shell
sudo pip install selenium

sudo python3 -m pip install selenium
```

## 2. 安装浏览器驱动

1. 浏览器选择
    当你使用PhantomJS时, selenium会提醒PhantomJS已经被弃用,并且 PhantomJS 不再更新. 同时为了便于调试, windows上用的chrome, 所以选择chrome

2. chromedriver安装
    1. chrome安装
        - windows 安装都很简单, 主要说明linux安装
        - Amazon Linux: [安装说明](https://intoli.com/blog/installing-google-chrome-on-centos/)
        - centos: curl <https://intoli.com/install-google-chrome.sh> | bash
    2. chromedriver安装: [安装说明](https://devopsqa.wordpress.com/2018/03/08/install-google-chrome-and-chromedriver-in-amazon-linux-machine/)

        - **自动适配浏览器驱动** 参考[chromedriver-executable-needs-to-be-available-in-the-path](https://stackoverflow.com/questions/29858752/error-message-chromedriver-executable-needs-to-be-available-in-the-path/52878725#52878725)

            ```shell
            # 安装
            pip install webdriver-manager

            # 自动匹配
            from selenium import webdriver
            from webdriver_manager.chrome import ChromeDriverManager

            driver = webdriver.Chrome(ChromeDriverManager().install())
            ```

## 3. 快速入门

1. 启动浏览器

    ```python
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

2. 加载页面

    ```python
    driver = launch_driver()
    driver.get(url)
    ```

3. driver的一些属性

    ```python
    driver.title  # 页面标题
    driver.page_source  # 页面源代码
    ```

4. 调试

    有的时候页面出现未知标签, 本地又不方便复现, 就需要保留代码调试

    ```python
    # 截图
    driver.save_screenshot("codingpy.png")

    # 保留源代码
    print(driver.page_source)
    ```

5. 常用配置

    ```python
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument('--proxy-server={}'.format('127.0.0.1:8798'))
    options.add_argument('Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.103 Mobile Safari/537.36')
    options.add_argument('-disable-gpu')
    options.add_argument('--no-sandbox')
    options.add_argument('lang=zh-CN,zh,zh-TW,en-US,en')
    options.add_argument('blink-settings=imagesEnabled=false')
    options.add_argument('--ignore-ssl-errors=true')
    options.add_argument('--disk-cache=yes')
    ```

6. 添加authentication [HTTP Proxy Authentication with Chromedriver in Selenium](https://stackoverflow.com/questions/58458816/how-to-set-proxy-authentication-usernamepassword-using-python-selenium)
    - install

        ```shell
        python3 -m pip install selenium-wire
        ```

    - demo

        ```python
        from seleniumwire import webdriver

        wire_options = {
            'proxy': {
                'http': 'http://{}'.format(auth_proxies), 
                'https': 'https://{}'.format(auth_proxies)
            }
        }
        driver = webdriver.Chrome(seleniumwire_options=wire_options)
        ```
