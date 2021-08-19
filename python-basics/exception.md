# 异常处理 Exception

## 1. try/finally

如果既要将异常向上传播，又要异常发生时执行清理工作，就可以使用try/finally

## 2. try/except/else

如果没有异常抛出，要执行的内容，就放在else中执行, 和try分隔开

## 3. try/except/else/finally

```python
try:
    ...
except Exception:
    ...
except BaseException:
    # 是SystemExit/Exception的父类
    ...
except SystemExit:
    ...
except:
    # 捕获所有异常
    ...
```
