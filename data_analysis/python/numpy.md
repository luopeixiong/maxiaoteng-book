# numpy

n维的数组对象

1. 基本操作

    ```Python
    import numpy as np
    na = np.array([1, 2, 3])
    # 可以转换多维数组
    na.dtype # 查看元素类型, 所以所有元素类型要一致
    na1 = na.astype('str') # 转换类型
    # 批量计算
    na+1
    na*na
    na*2
    # 索引取值和赋值, 0开始
    na[2]
    na[:-1]
    na[2] = 1
    ```

2. reshape, T转置, ufunc、sort
