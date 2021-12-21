# rsync同步
## 1. 示例

```shell
rsync -rvptgo maxiaoteng@59.110.160.185:~/crawler/baike_scrapy/data2/html
_files/baike/20180725baike.tar.gz /data/ftp/public/crawler_data/baike/
```
这个命令共4部分: 
- rsync
- options  
    **-rvptgo**
    -r  递归拷贝目录
    -v  显示命令执行详细信息
    -p  保持文件属性
    -t  保持文件时间信息
    -g  保持文件属组信息
    -o  保持文件属主信息
- origin_path
    **maxiaoteng@59.110.160.185:~/crawler/baike_scrapy/data2/baike/20180725baike.tar.gz**
- target_path
    **/data/ftp/public/crawler_data/baike/**


```
rsync -rvptgo --password-file=/root/crawler/news/rsync.ps  maxiaoteng@59.110.160.185:/home/maxiaoteng/crawler/news/data/ /root/crawler/news/data
```