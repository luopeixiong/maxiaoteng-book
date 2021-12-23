# mysql_optimization

1. 查询时优先考虑降低查询结果的大小
   1. 比如：group_by > join
   2. select 出需要的信息减少表容量
2. 查看后台进程
   1. show full processlist;
   2. select * from information_schema.innodb_trx\G