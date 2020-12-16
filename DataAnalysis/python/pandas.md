# Pandas
[TOC]

## 数据结构
两个主要的数据结构，Series和DataFrame
### 1. Series
类似array和numpy, 一维
带有数据标签
1. 基本使用
    ```Python
    import pandas as pd
    pa = pd.Series([1, 2, 3, 4, 5])
    # 自定义索引
    pa = pd.Series([1, 2, 3, 4, 5], index=['a', 'b', 'c', 'd', 'e'])
    # 查看索引
    pa.index
    # 查看数据
    pa['a']
    pa[['a', 'b']]

    # 自动解析字典
    dd = {
        'lulu': 'lluu',
        'qinqin': 'qqiinn',
    }
    pdd = pd.Series(dd)
    # 也可以指定索引, 不存在的自动表示Nan
    pdd = pd.Series(dd, index={'lulu', 'qinqin', 'c'})
    ```
2. 其他



### 2. DataFrame
类似表格的数据结构, 既有行索引, 也有列索引
1. 基本使用
    ```Python
    # 传入字典
    dict = {
        'name': ['张三', '李四'],
        'sex': ['男', '女'],
        'age': ['21', '76'],
    }
    df = pd.DataFrame(dict)
    df.info()
    df.head()
    df.tail()
    # 类型转换
    df.age = df.age.astype('str')
    # df选取列的方式
    df['age']   # 返回Series
    df[['age', 'name']]   # 返回Series
    # 选取行
    df.ix[0]   
    df.iloc[0]   
    df.loc[0]   # 用于通过标签选取, 没有标签的df和iloc通用   
    df[1:2]
    # 行列共同选择
    df.ix['a', 'age']
    df.ix[['a', 'c'], 'age']
    df.ix[['a': 'c'], 'age']

    # 修改和新增列
    df['age'] = [1, 2]
    df['age'] = '2'
    df.age = '2'

    # 判断
    df.sex == '男'  # 返回series, True or False
    df[(df.sex=='男')]
    ```
2. 查询
    ```Python
    # 类sql语句
    df.query('(age==18 and sex=="男") & (age>18 and sex=="女")')
    ```
3. 计算
    ```Python
    # distinct
    df.age.unique()
    len(df.age.unique())

    # 去重 drop_duplicates
    df_duplicates = df.drop_duplicates(subset='age', keep='first')

    # 格式清洗 other_key可选参数
    def cut_word(word, other_key=None):
        return str(word)+'_'
    df_duplicates.salary.apply(cut_word, other_key=1)

    # 平均计算/统一行的多列计算, axis=1表示用在行
    def avg_dup_colum(line):
        return (line.x + line.y)/2
    df_duplicates['avg_data'] = df_duplicates.apply(avg_dup_colum, axis=1)
    # lambda函数
    df_duplicates['avg_data'] = df_duplicates.apply(lambda x:(x.x+x.y)/2, axis=1)

    # 聚合group by
    # 等价 group by city, count(1), order by cnt desc
    df.city.value_counts()
    
    ```


## 载入数据
1. read_csv
    ```Python
    pd.read_csv(file_path, encoding='utf-8')
    ```
2. read_excel
3. read_table
4. read_sql