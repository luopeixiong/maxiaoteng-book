# Others

## list (append extend)
```
mxt = ['a', 'b', 'c']
mm = ['d', 'e']

mxt.append('d')
> mxt = ['a', 'b', 'c', 'd']

mxt.append(mm)
> mxt = ['a', 'b', 'c', ['d', 'e']]

mxt.extend(mm)
> mxt = ['a', 'b', 'c', 'd', 'e']

```