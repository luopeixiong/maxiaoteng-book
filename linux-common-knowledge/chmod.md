# chmod  修改文件权限

## 1. 缘由
运行shell脚本时显示权限不足, 因为默认文件都是读写权限, 需要增加执行权限

## 2. 用法
```
chmod +x run.sh

./run.sh    运行方法
```

## 3. 几种用法
    ```
        chmod [-cvfR] mode file # 
        1. chmod -R 777 ./dir           # 获取所有权限
        2. chown -R maxiaoteng ./dir    # 修改文件为该用户
    ```

