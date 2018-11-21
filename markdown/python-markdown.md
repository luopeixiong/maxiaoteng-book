# 支持将Markdown格式的文本渲染成HTML页面
```
pip install markdown
```
## 渲染

```
# extensions是markdown的扩展支持, 包括扩展语法, 代码高亮和目录生成
post.body = markdown.markdown(post.body, 
                            extensions=[
                                'markdown.extensions.extra',
                                'markdown.extensions.codehilite',
                                'markdown.extensions.toc',
                            ])
```

## safe标签
见template