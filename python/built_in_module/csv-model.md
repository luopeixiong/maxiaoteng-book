# csv 模块

csv用来读写csv文件
```
import csv
```

## 普通读写文件
```
with open(origin_path,'r',encoding='utf-8') as fr:
      csv_reader=csv.reader(fr)
      addresses={}
      for row in csv_reader:
            if csv_reader.line_num==1:
                  continue
```

## 按dict读写文件

- 写文件
      ```
      if not os.path.exists(data_path):
            with open(data_path, 'w', encoding='utf-8', newline='') as f:
                  csv_writer = csv.DictWriter(f, fieldnames=field)
                  csv_writer.writeheader()
      with open(data_path, 'a', encoding='utf-8', newline='') as f:
            csv_writer = csv.DictWriter(f, fieldnames=field)
            csv_writer.writerow(item)
      ```

- 读文件
      读取的row类型: `collections.OrderedDict`, 有get属性, 使用dict(row)转为普通dict
      ```
      with open(author_links_path, 'r', encoding='utf-8', newline='') as f:
            csv_reader = csv.DictReader(f, fieldnames=self.author_link_field)
            for row in csv_reader:
                  if csv_reader.line_num == 1:
                  continue
                  links.append(dict(row))
      ```

## 其他

用在csv的read和writer方法, 
- delimiter=','  # 分隔符
- quotechar='"'  # 引用符, 将内容用引号包含,避免歧义

## 读写超大文件时

[参考stackoverflow](https://stackoverflow.com/questions/15063936/csv-error-field-larger-than-field-limit-131072)

- 报错: _csv.Error: field larger than field limit (131072)
      - 原因: csv文件包含特别大的field, 需要修改最大显示
      - 解决代码
      ```
            import sys
            import csv
            maxInt = sys.maxsize
            decrement = True

            while decrement:
            # decrease the maxInt value by factor 10 
            # as long as the OverflowError occurs.

            decrement = False
            try:
                  csv.field_size_limit(maxInt)
            except OverflowError:
                  maxInt = int(maxInt/10)
                  decrement = True
      ```