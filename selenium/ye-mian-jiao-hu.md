# 页面交互

## 基本操作

选中元素后, 可以对元素操作如下:

- 模拟按键 send_keys()
```
element.send_keys('some text', keys.ARROW_DOWN)  # 发送内容, 模拟按键
```

- 清理`input`或`textarea`的内容
```
element.clear()    
```

- 点击
```
element.click()
```


## 填写表格

- 选择下拉列表

```
from selenium.webdriver.support.ui import Select

select = Select(driver.find_element_by_name('name'))
select.select_by_index(index)  # 按索引选择
select.select_by_visible_text('text')  # 按显示内容选择
select.select_by_value(value)  # 按value选择

# 取消选择
select.deselect_all()

```

- 提交表单

```
element.click()

# webdriver对每个元素都有submit()的方法, 如果对表单某个元素使用, 将找到最近的form并提交, 如果不再表单内, 将抛出异常
element.submit()

```