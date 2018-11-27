# python logging 
logging可以发送到控制台, 文件, 网络

## 等级
- a. logging.CRITICAL
- b. logging.ERROR
- c. logging.WARNING
- d. logging.INFO
- e. logging.DEBUG


## 配置
```python
logging.basicConfig(
  level = logging.DEBUG,  # 定义输出到文件的log级别，
  format = '%(asctime)s  %(filename)s : %(levelname)s  %(message)s',  # 定义输出log的格式
  datefmt= '%Y-%m-%d %A %H:%M:%S',  # 时间
  filename = logFilename,  # log文件名
  filemode = 'w')   
```

