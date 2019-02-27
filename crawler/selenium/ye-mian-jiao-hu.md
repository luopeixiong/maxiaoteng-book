# 页面交互

## 1. 基本操作

选中元素后, 可以对元素操作如下:

1. 模拟按键 send_keys()
```
element.send_keys('some text', keys.ARROW_DOWN)  # 发送内容, 模拟按键
```

2. 清理`input`或`textarea`的内容
```
element.clear()    
```

3. 点击
```
element.click()
```


## 2. 填写表格

1. 选择下拉列表

```
from selenium.webdriver.support.ui import Select

select = Select(driver.find_element_by_name('name'))
select.select_by_index(index)  # 按索引选择
select.select_by_visible_text('text')  # 按显示内容选择
select.select_by_value(value)  # 按value选择

# 取消选择
select.deselect_all()
```

2. 提交表单

```
element.click()

# webdriver对每个元素都有submit()的方法, 如果对表单某个元素使用, 将找到最近的form并提交, 如果不再表单内, 将抛出异常
element.submit()

```

## 3. 一些js脚本
1. 执行js脚本的方法
``` 
driver.execute_script("script.js")
driver.execute_script("arguments[0].value = '你猜一下';", search_button)  #带参数
```

2. 比如: 
```
# 移除某个标签class的hide部分
driver.execute_script("$('.button.load-more.hide').removeClass('hide')")
# 移除整个dom标签
driver.execute_script("$('#menuContent').remove()")
# 下拉到底部
driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
```

3. 修改element的属性, 一般使用js就可以
```
new_class_name = 'new_class'
driver.execute_script("$('.ratingcontent').class=argument[0]", new_class_name)
driver.execute_script("$('.ratingcontent').class='new_class'")
```

## 4. 判断是否可见, 最好用attribute判断, 而不是is_displayed()
```
# 习惯做法
if element.get_attribute('style') == 'display: none;':
    print('那么该元素在页面上看不到')
# 之前的做法
result = element.is_displayed()
```
