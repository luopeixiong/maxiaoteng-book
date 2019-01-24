# XPATH
XPath即为XML路径语言（XML Path Language），它是一种用来确定XML文档中某部分位置的语言。 XPath基于XML的树状结构，提供在数据结构树中找寻节点的能力。 

## 用法

```
from lxml import etree
html = response.text  # requests和scrapy都可以, html要求是str
page_source = etree.HTML(html)
tr = page_source.xpath('//div[@class="chunk"]/table/tr[1]')
```
- page_source 
HTML方法有自动修正不全tag的功能, tostring()方法转成源文件, 为bytes类型, 需要decode为str

- 也可以直接读取文本文件进行解析
```
from lxml import etree
html = etree.parse('./test.html', etree.HTMLParser())
result = etree.tostring(html)
print(result.decode('utf-8'))
```

## 常用规则
- /     # 从当前节点选取所有子节点, 返回list
- //    # 从当前节点选取所有子孙节点, 返回list
- .     # 选取当前节点
- ..    # 选取当前节点的父节点
- @     # 选取属性
- [@]   # 增加属性限定 如://div[@class="xx-name"], 父节点下所有class是xx-name的div
- /text()   # 文本获取, 返回list
- 属性多值匹配  # 某个节点的属性有多个值, 比如<a class='li tag'>, 
    - //li[contains(@class, "li")]  # 选择所有包含li的标签
    - //li[contains(@class, "li") and contains(@class, "tag")]  # 能选择上面那个标签
    - //li[contains(@class, "li") and @name="item"] # 可以同时选择多个属性条件
- | 或操作
    - //li[contains(@class, "li")] | //li[@name="item"]  # 用法和and类似

- 按序选择  # xpath的list选择是从1开始, last()表示最后一个
- 节点轴
    - html = etree.HTML(text)
    - result = html.xpath('//li[1]/ancestor::*')    # 返回li的所有祖先节点, list
    - result = html.xpath('//li[1]/ancestor::div')  # 返回li的所有div祖先节点, list
    - result = html.xpath('//li[1]/attribute::*')   # 返回li的所有属性值, list
    - result = html.xpath('//li[1]/child::a[@href="https://ask.hellobi.com/link1.html"]')   # 返回li的子节点a
    - result = html.xpath('//li[1]/descendant::span')   # 返回li的所有span子孙节点, list
    - result = html.xpath('//li[1]/following::*[2]')    # 返回li的后续的第2个节点
    - result = html.xpath('//li[1]/following-sibling::*')   # 返回li的后续所有同级节点, list
