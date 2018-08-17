# BeautifulSoup 解析页面

driver.page_source 或其他的html文件

selenium的html文件:
selenium stores the source HTML in the driver's page_source attribute
```
soup = BeautifulSoup(driver.page_source, 'html.parser')
```

## 解析器

python标准库: html.parser


## 获取 

### 1. 查找标签
得到的是类: <class 'bs4.element.Tag'>的实例
- soup.a  soup.li  soup.head  # 查到的第一个标签
- soup.find("div", {"class": "cities-rests"})  # 查到指定条件的第一个标签
- soup.find_all("li", {"class": "internal-link"})  # 返回查到的所有标签, 类型: <class 'bs4.element.ResultSet'>, 可迭代对象, 每个都是Tag


- soup.contents  # 按list返回子节点
- soup.children

### 2. 获得tag的属性, 和字典操作一致

- soup.title.name  # tag的名称, 返回 title
- soup.title.parent.name  # 返回title的父标签的名称

- soup.p.attrs  # 返回所有属性, 类型为**字典**

- soup.p['class']  # 返回查到的p标签的class内容
- soup.a['href']  # 返回查到的a标签的href内容
- soup.a.string  # 返回text部分
- soup.get("class")  # 另一种方法

多值属性返回为list, 如'class', 

### 3. 可以修改

