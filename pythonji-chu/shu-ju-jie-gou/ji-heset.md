# 集合 Set

特点: 无序不重复


```
# list to set
l = [1, 2, 3, 1]
s = set(l)
> {1, 2, 3}
# set to list
list({1, 2, 3})
> [1, 2, 3]
# 初始化一个集合
a = set()  # {}是空字典
```

## 方法
- 添加
```
# 添加一个元素
s.add(m)
# 更新多个元素
s.update([2, 3])
```

- 删除
```
s.remove(4)  # 如果不存在则抛出异常
s.discard(4)  # 不抛出异常
```

## 不可变集合
```
fs = frozenset('hello')
> frozenset({'h', 'e', 'l', 'o'})
# 执行操作将抛出异常
```