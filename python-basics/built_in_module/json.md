# JSON格式
用于序列化, 内置包picking, 将变量序列化成bytes类型, 兼容差,仅适用Python

## 1. 序列化和反序列化
- json默认支持序列化Python的数据类型: list, dict等
    ```
    import json
    d = dict(name='Bob', age=20, score=88)
    # 序列化
    s = json.dumps(d)
    s == '{"age": 20, "score": 88, "name": "Bob"}'

    s = json.dumps(s, separators=(',', ':'), ensure_ascii=False)
    # separators 用来解决:后面带空格问题, ensure_ascii解决中文编码问题

    # 反序列化
    d = json.loads(s)
    ```

## 2. 序列化其他
- 序列化类
    ```
    import json

    class Student(object):
        def __init__(self, name, age, score):
            self.name = name
            self.age = age
            self.score = score


    # 实现一个方法用于序列化
    def student2dict(std):
        return {
            'name': std.name,
            'age': std.age,
            'score': std.score
        }

    # 反序列化
    def dict2student(self, d):
        return Student(d['name'], d['age'], d['score'])

    s = Student('Bob', 20, 88)
    # 便可序列化和反序列化对象
    str = json.dumps(s, default=student2dict)
    student_class = json.loads(json_str, object_hook=dict2student)
    
    # 序列化的高阶写法
    json_s = json.dumps(s, default=lambda obj: obj.__dict__)
    ```

## 第三方 demjson
http://deron.meranda.us/python/demjson/
- 用于编码和解码json数据,
```
data = [ { 'a' : 1, 'b' : 2, 'c' : 3, 'd' : 4, 'e' : 5 } ]
json = demjson.encode(data)
>> data == [{"a":1,"b":2,"c":3,"d":4,"e":5}]
text = demjson.decode(json)
>> {'a': 1, 'c': 3, 'b': 2, 'e': 5, 'd': 4}
```
