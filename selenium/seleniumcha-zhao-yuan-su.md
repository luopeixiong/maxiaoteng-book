# 查找元素

## 以下会查找出符合条件的第一个元素

#### find_element_by_id

```
login_form = driver.find_element_by_id('loginForm')
```
#### find_element_by_name  

```
   <input name="continue" type="button" value="Clear" />
  </form>
</body>
<html>

username = driver.find_element_by_name('username')
```

#### find_element_by_xpath

```
login_form = driver.find_element_by_xpath("//form[@id='loginForm']")
```

#### find_element_by_link_text  
#### find_element_by_partial_link_text

这是针对a标签的
```
<a href="continue.html">Continue</a>

continue_link = driver.find_element_by_link_text('Continue')
continue_link = driver.find_element_by_partial_link_text('Conti')
```

#### find_element_by_tag_name  
针对标签
```
heading1 = driver.find_element_by_tag_name('h1')
```
#### find_element_by_class_name

```
content = driver.find_element_by_class_name('content')
```
#### find_element_by_css_selector

```
content = driver.find_element_by_css_selector('p.content')
```



## 查找多个元素, 使用elements, 返回list

- find_elements_by_id
- find_elements_by_name
- find_elements_by_xpath
- find_elements_by_link_text
- find_elements_by_partial_link_text
- find_elements_by_tag_name
- find_elements_by_class_name
- find_elements_by_css_selector

## 还有一种方法

```
from selenium.webdriver.common.by import By

driver.find_element(By.XPATH, '//button[text()="Some text"]')
driver.find_elements(By.XPATH, '//button')
```


## 异常

如果找不到任何元素，会抛出`NoSuchElementException`异常




