# 查找元素

## 1. 以下会查找出符合条件的第一个元素

1. find_element_by_id
```
login_form = driver.find_element_by_id('loginForm')
```

2. find_element_by_name  
```
   <input name="continue" type="button" value="Clear" />
  </form>
</body>
<html>

username = driver.find_element_by_name('username')
```

3. find_element_by_xpath
```
login_form = driver.find_element_by_xpath("//form[@id='loginForm']")
```

4. find_element_by_link_text 和 find_element_by_partial_link_text
这是针对a标签的
```
<a href="continue.html">Continue</a>

continue_link = driver.find_element_by_link_text('Continue')
continue_link = driver.find_element_by_partial_link_text('Conti')
```

5. find_element_by_tag_name  
针对标签
```
heading1 = driver.find_element_by_tag_name('h1')
```

6. find_element_by_class_name
```
content = driver.find_element_by_class_name('content')
```

7. find_element_by_css_selector
```
content = driver.find_element_by_css_selector('p.content')
```

## 2. 查找多个元素, 使用elements, 返回list

1. find_elements_by_id
2. find_elements_by_name
3. find_elements_by_xpath
4. find_elements_by_link_text
5. find_elements_by_partial_link_text
6. find_elements_by_tag_name
7. find_elements_by_class_name
8. find_elements_by_css_selector

## 3. 还有一种方法

```
from selenium.webdriver.common.by import By

driver.find_element(By.XPATH, '//button[text()="Some text"]')
driver.find_elements(By.XPATH, '//button')
```


## 4. 异常

如果找不到任何元素，会抛出`NoSuchElementException`异常




