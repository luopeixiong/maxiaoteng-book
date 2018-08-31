# Markdown 页内跳转

## 方法一: Github Flavored Markdown Anchor
支持github, 其他需要安装插件

___
**文本**:
```
[点击跳转](##应该能跳转到这里)

## 应该能跳转到这里

```

**显示效果**:


[点击跳转](##应该能跳转到这里)

我是占位符

![照片占位](http://placeimg.com/640/480/any)

我是占位符

## 应该能跳转到这里

___

## 方法二: html 语法实现

支持github和gitbook等.

- **写法**:  
```
定义锚点
<div id="target">跳转回这里</a>  
![照片占位](http://placeimg.com/640/480/any)  
![照片占位](http://placeimg.com/640/480/any)  
定义跳转点  
<a href="#target">点击这里跳转回去</a>
```

- **效果展示**:
---

定义锚点

<div id="target">跳转回这里</a>  
 
![照片占位](http://placeimg.com/640/480/any)  
![照片占位](http://placeimg.com/640/480/any)  

定义跳转点  

<a href="#target">点击这里跳转回去</a>

---