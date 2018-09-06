# setting.py 配置

## 配置数据版本VERSION
```
date = datetime.datetime.now().strftime("%Y-%m-%d")

VERSION = date
```

## 配置item pipelines
```
# Configure item pipelines

ITEM_PIPELINES = {
   'mangoplate_scrapy.pipelines.MangoplateScrapyPipeline': 300,
}
```

## 