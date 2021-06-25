# metaclasses

<https://stackoverflow.com/questions/100003/what-are-metaclasses-in-python>

demo

```python
def hello():
    print('hello')

cs = type('custom_class', (), {'name': 'someone'})
setattr(cs, 'hello', hello)

cs.hello()
cs.name
```
