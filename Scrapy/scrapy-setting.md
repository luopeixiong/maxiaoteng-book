## scrapy配置

1. 网站爬虫规则  

    ROBOTSTXT_BOEY

2. 下载延迟  

    import random  
    DOWNLOAD_DELAY = random.randint(1, 2)
 
3. 是否启用cookie  

    COOKIES_ENABLED = False
4. ITEM的处理(pipeline)  
    ITEM_PIPELINES = {
    	# 'weapon.pipelines.WeaponPipeline': 300,
    	# 'weapon.mongoPipeline.MongoPipeline': 301,
    	'weapon.mysql_pipelines.MySQLPipeline': 301,
	}
5. 文件编码  

    FEED_EXPORT_ENCODING = 'utf-8'

6. LOG的配置  
    LOG_ENCODING = 'UTF-8'
7. 数据库配置  
	```
    MYSQL_HOST = 'localhost'  
	MYSQL_DATABASE = 'military'  
	MYSQL_POST = 3306  
	MYSQL_USER = 'root'  
	# MYSQL_PASSWORD = ''  
	MYSQL_PASSWORD = 'PnS_cDEZhMb4p8M3'  
	# mongodb配置  
	MONGO_URI = "localhost:27017"  
	MONGO_DATABASE = 'military'  
	```


