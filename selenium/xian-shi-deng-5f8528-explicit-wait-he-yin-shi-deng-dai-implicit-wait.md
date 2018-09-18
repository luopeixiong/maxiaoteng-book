# 显式等待(explicit wait)和隐式等待 (implicit wait)

## 显式等待(explicit wait)

```
#封装了一个方法
def check_element_by_xpath(web_driver, value):
    try:
        # 判断是否加载完毕
        element = WebDriverWait(web_driver, 10).until(
            expected_conditions.presence_of_element_located((By.XPATH, value))
     	)
     	return element
    except Exception as e:
     	# print('加载超时', e)
     	# print(traceback.format_exc())
     	return -1
     finally:
         driver.quit()
```
这段代码会等待10秒，如果10秒内找到元素则立即返回，否则会抛出`TimeoutException`异常，WebDriverWait默认每`500`毫秒调用一下ExpectedCondition直到它返回成功为止。ExpectedCondition类型是布尔的，成功的返回值就是true,其他类型的ExpectedCondition成功的返回值就是 not null


## 隐式等待 (implicit wait)

```
driver.implicitly_wait(10)
```
- 如果某些元素不是立即可用,隐式等待告诉WebDriver去等待一段时间后查找元素
- 隐式等待是设置该WebDriver的实例的生命周期 

## 一直使用显示等待, 忘记隐式等待

[StackOverflow问答](https://stackoverflow.com/questions/10404160/when-to-use-explicit-wait-vs-implicit-wait-in-selenium-webdriver)



