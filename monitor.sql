-- 通用
# 整表传输注意:
# 1. 删除s3, 传输服务器上的内容
# 2. 修改run_log里的内容, 将最新一天的内容改为0

# 显示查询
select * from information_schema.innodb_trx;
show processlist;
select * from information_schema.tables where UPDATE_TIME>'2021-03-01';
select concat(round(sum(data_length/1024/1024/1024),2),'GB') from information_schema.TABLES;

# 查询表占用空间
select concat(round(sum(data_length/1024/1024/1024),2),'GB') as data 
from 
information_schema.tables where table_schema='uniqlo' and table_name='tmp_uniqlo_jp_skus_new';

# 删除后释放空间
optimize table mercari.app_user;

select table_schema, min(UPDATE_TIME), table_name, concat(round(sum(data_length/1024/1024/1024),2),'GB') as data_str,  round(sum(data_length/1024/1024/1024),2) as data,  round(sum(INDEX_LENGTH/1024/1024/1024),2) as index_data, sum(TABLE_ROWS), max(AUTO_INCREMENT), (round(sum(data_length/1024/1024/1024),2) + round(sum(INDEX_LENGTH/1024/1024/1024),2)) as all_data
from 
information_schema.tables group by table_schema, table_name order by all_data desc limit 30;

select table_schema, min(UPDATE_TIME), table_name, concat(round(sum(data_length/1024/1024/1024),2),'GB') as data_str,  round(sum(data_length/1024/1024/1024),2) as data,  round(sum(INDEX_LENGTH/1024/1024/1024),2) as index_data, sum(TABLE_ROWS), max(AUTO_INCREMENT), (round(sum(data_length/1024/1024/1024),2) + round(sum(INDEX_LENGTH/1024/1024/1024),2)) as all_data
from 
information_schema.tables where left(TABLE_NAME, 4)='tmp_' group by table_schema, table_name order by all_data desc limit 30;

# 
select TABLE_SCHEMA, TABLE_NAME, `AUTO_INCREMENT`, round(DATA_LENGTH/1024/1024/1024, 2) as memory from information_schema.TABLES where TABLE_ROWS>30000000;
select * from information_schema.tables order by `AUTO_INCREMENT` desc;
select sum(tt1.all_data), count(distinct tt1.table_name) from 
(select table_schema, table_name, (round(sum(data_length/1024/1024/1024),2) + round(sum(INDEX_LENGTH/1024/1024/1024),2)) as all_data from information_schema.tables group by table_schema, table_name order by all_data desc) tt1;

-- 计算库里有多少表
show databases;
SELECT count(*) TABLES, table_schema FROM information_schema.TABLES   
-- where table_schema = 'dianping' 
where table_schema not in ("information_schema", "mysql", "performance_schema")
GROUP BY table_schema; 

SELECT count(*)  FROM information_schema.TABLES
where table_schema not in ("information_schema", "mysql", "performance_schema")
;

-- 返回所有列
SELECT GROUP_CONCAT(COLUMN_NAME SEPARATOR ",") FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'mercari' AND TABLE_NAME = 'app_sku_2019_10_01';

## 台湾贸易数据
-- 找出上个月初步值的数量
select 
-- *
count(*)
-- DISTINCT left(Date_origin, 6)
-- delete
from customs.trade_statistics where 
left(Date_origin, 6)='108年10月' and 
Date_origin like '%初步值%'
;

-- 找出不带初步值的数量比较
select 
count(*)
-- DISTINCT left(Date_origin, 6)
from customs.trade_statistics where 
left(Date_origin, 6)='108年10月' and 
Date_origin not like '%初步值%'
;

select count(*) from customs.trade_statistics where ts_short='2019-10-18';


# raksul
select left(batch_id, 10), count(*) from raksul.raksul_info group by left(batch_id, 10);


# twitch定期统计
select ts_short, count(*) from twitch.game_list group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.channel_list group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.game_info group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.channel_info group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.game_activity_info group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct channel_id) from twitch.channel_activity_info group by ts_short order by ts_short desc;
-- select ts_short, count(*), count(distinct channel_id) from twitch.channel_stream_info group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.channel_stream_info group by ts_short order by ts_short desc;
select ts_short, count(*) from twitch.channel_activity_info_v2 group by ts_short order by ts_short desc;
select left(time_of_occurrence, 10), count(*) from twitch.tmp_channel_session_info group by left(time_of_occurrence, 10) order by left(time_of_occurrence, 10) desc;
select left(time_of_occurrence, 10), count(*), count(distinct channel_id) from twitch.channel_stream_info group by left(time_of_occurrence, 10) order by left(time_of_occurrence, 10) desc;
select left(time_data, 10), count(*) from twitch.channel_activity_info_v2 group by left(time_data, 10) order by left(time_data, 10) desc;
-- select left(time_of_occurrence, 10), count(*) from twitch.channel_stream_info group by left(time_of_occurrence, 10) order by left(time_of_occurrence, 10) desc;
select occurrence_date, count(*) from twitch.game_share group by occurrence_date order by occurrence_date DESC;


# recruit_agent
SELECT ts_short, count(*) from recruit_agent.company group by ts_short order by ts_short desc;
SELECT ts_short, count(*) from recruit_agent.company_info group by ts_short order by ts_short desc;
SELECT ts_short, count(*) from recruit_agent.job group by ts_short order by ts_short desc;

# indeed
# 每次分析
select ts_short,count(*), sum(origin_search_count) from Indeed.indeed_searchcount_final group by ts_short order by ts_short desc;
select ts_short,count(*) from Indeed.indeed_search_count group by ts_short order by ts_short desc;
select * from Indeed.indeed_search_count order by id desc;
-- select ts_short,count(*) from Indeed.indeed_info group by ts_short order by ts_short desc;
select * from Indeed.indeed_searchcount_final order by ts_short desc;
select * from Indeed.indeed_search_count where new_search_count != -1 order by id desc;
select ts_short, count(*) from Indeed.indeed_search_count where new_search_count != -1 group by ts_short desc;

-- 美国indeed
select ts_short, count(*), count(distinct city_url), sum(cast(search_count as UNSIGNED)), max(cast(search_count as UNSIGNED)), min(cast(search_count as UNSIGNED)), max(ts) from Indeed.indeed_search_count_us group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct city_url) from Indeed.indeed_us_cities group by ts_short order by ts_short desc;
select * from Indeed.indeed_search_count_us order by id desc;
select count(distinct city_url) from Indeed.indeed_us_cities;

# Hotel
select ts_short, count(*) from Hotels.jinjiang_cities group by ts_short;
select ts_short, count(*), count(distinct innId), count(distinct innName) from Hotels.jinjiang_hotels group by ts_short order by ts_short desc;

select ts_short, count(*) from Hotels.oyo_cities group by ts_short;
select ts_short, count(*) from Hotels.oyo_hotels group by ts_short order by ts_short desc;
-- select ts_short, count(*) from Hotels.oyo_hot_cities group by ts_short;
select ts_short, sum(hotelCountInCity) from Hotels.oyo_cities group by ts_short desc;

select ts_short, count(*) from Hotels.bth_hotels group by ts_short order by ts_short desc;
select ts_short, count(*) from Hotels.bth_cities group by ts_short;
select ts_short, count(*) from Hotels.bth_brands group by ts_short;

select ts_short, count(*) from Hotels.viennar_cities group by ts_short;
select ts_short, count(*) from Hotels.viennar_hotels group by ts_short order by ts_short desc;

select ts_short, count(1), count(distinct left(ts, 13)) from Hotels.bth_remain group by ts_short order by ts_short desc;
select left(ts,13), count(1) from Hotels.bth_remain group by left(ts,13) order by left(ts, 13) desc;

-- 瑞幸咖啡
select ts_short, count(*) from Hotels.luckin_shops group by ts_short;
select ts_short, count(*) from Hotels.luckin_shops_other group by ts_short;
select ts_short, count(*) from Hotels.tmp_luckin_all_info group by ts_short;

select * from Hotels.luckin_shops where ts_short='2020-12-10' and left(ts, 10)='2020-04-06';

select * from Hotels.luckin_shops where shop_name like '%瑞即购%' and ts_short='2020-03-10';
select * from Hotels.luckin_shops where city ='' and ts_short='2020-03-25';
select ts_short, count(*) from Hotels.luckin_shops where address not like "%敬请期待%" group by ts_short;
select * from Hotels.luckin_shops_other where shop_name="厦门东方财富广场店";
select distinct(left(ts, 13)) from Hotels.luckin_shops where ts_short="2019-11-16";
select * from Hotels.tmp_luckin_all_info where deptid='338666';
set @batch_id='2021-05-10';
set @last_batch_id='2021-04-25';

-- 更新新增店铺的城市信息
update Hotels.luckin_shops aa, Hotels.tmp_luckin_all_info bb
set aa.city=bb.city 
where aa.ts_short=@batch_id and bb.ts_short=aa.ts_short and aa.deptid=bb.deptid and aa.city is null;

update Hotels.luckin_shops_other aa, Hotels.tmp_luckin_all_info bb
set aa.city=bb.city 
where aa.ts_short=@batch_id and bb.ts_short=aa.ts_short and aa.deptid=bb.deptid and aa.city is null;

-- shopNO
update Hotels.luckin_shops aa , Hotels.tmp_luckin_all_info  bb
set aa.shop_no=bb.shop_no
where aa.shop_no ='' and aa.deptid=bb.deptid and aa.ts_short=@batch_id and bb.ts_short=aa.ts_short;

update Hotels.luckin_shops_other aa , Hotels.tmp_luckin_all_info  bb
set aa.shop_no=bb.shop_no
where aa.shop_no ='' and aa.deptid=bb.deptid and aa.ts_short=@batch_id and bb.ts_short=aa.ts_short;

-- 确认所有店铺的城市信息都已补全
select count(*) from Hotels.luckin_shops where city is null and ts_short=@batch_id;

-- 新增店铺的城市分布
-- select count(*) from
select aa.* from 
(SELECT * from Hotels.luckin_shops where ts_short=@batch_id) aa
left join 
(SELECT * from Hotels.luckin_shops where ts_short=@last_batch_id) bb
on aa.deptid=bb.deptid
where bb.shop_no is null;

-- 查看消失的店铺是否真的关闭了
select * from
(SELECT * from Hotels.luckin_shops where ts_short=@last_batch_id) aa
left join 
(SELECT * from Hotels.luckin_shops where ts_short=@batch_id) bb
on aa.deptid=bb.deptid
where bb.shop_no is null;


-- 完整验证
-- city is null or ''
select * from Hotels.luckin_shops where ts_short=@batch_id and (city is null or city ='');
select * from Hotels.luckin_shops where ts_short=@batch_id and shop_no is null or shop_no ='';
select * from Hotels.luckin_shops_other where ts_short=@batch_id and (city is null or city ='');
select count(*) from Hotels.luckin_shops_other where ts_short=@batch_id and (city is null or city ='');

-- 店铺城市变更
select * from 
(SELECT * from Hotels.luckin_shops where ts_short=@batch_id) aa
left join 
(SELECT * from Hotels.luckin_shops where ts_short=@last_batch_id) bb
on aa.deptid=bb.deptid
where aa.city !=bb.city;

update Hotels.luckin_shops aa, Hotels.luckin_shops bb
set aa.city=bb.city 
where aa.ts_short=@batch_id and bb.ts_short=@last_batch_id and aa.deptid=bb.deptid and aa.city!=bb.city;

select * from 
(SELECT * from Hotels.luckin_shops_other where ts_short=@batch_id) aa
left join 
(SELECT * from Hotels.luckin_shops_other where ts_short=@last_batch_id) bb
on aa.deptid=bb.deptid
where aa.city !=bb.city;

update Hotels.luckin_shops aa 
set aa.city='上海'
where aa.ts_short='2020-11-25' and aa.shop_no in ('No.2587', 'No.2169');

update Hotels.luckin_shops aa 
set aa.city='佛山'
where aa.ts_short='2021-01-25' and aa.shop_no in ('No.4384');


# 机票项目
select ts_short, count(*) from flight_ticket.tickets group by ts_short;
select ts_short, count(*) from flight_ticket.ctrip_tickets group by ts_short;

select ts_short, from_net, count(*), count(distinct flight_no), count(distinct dep_port, arr_port, time_interval) from flight_ticket.tickets group by ts_short, from_net order by ts_short desc;
select ts_short, from_net, count(*) from flight_ticket.ctrip_tickets group by ts_short, from_net order by ts_short desc;
select ts_short, count(*) from flight_ticket.umetrip_info group by ts_short desc;
select ts_short, count(*) from flight_ticket.sanya_flight_info group by ts_short desc;
select dep_date, count(*) from flight_ticket.umetrip_info group by dep_date desc;
select dep_date, count(*) from flight_ticket.sanya_flight_info group by dep_date desc;
select ts_short, count(*) from flight_ticket.variflight_list group by ts_short desc;
select ts_short, count(*), count(distinct flight_no) from flight_ticket.variflight_info group by ts_short desc;
select dep_date, count(*) from flight_ticket.variflight_info group by dep_date desc;


select aa.* from 
(select distinct dep_port, arr_port, time_interval from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2021-01-15" ) aa
left join 
(select distinct dep_port, arr_port, time_interval from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2021-01-29" ) bb
on aa.dep_port=bb.dep_port and aa.arr_port=bb.arr_port and aa.time_interval=bb.time_interval
where bb.arr_port is null;

select aa.* from 
(select distinct dep_port, arr_port, dep_date from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2021-01-29" and time_interval=14) aa
left join 
(select distinct dep_port, arr_port from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2021-02-05"  and time_interval=7) bb
on aa.dep_port=bb.dep_port and aa.arr_port=bb.arr_port
where bb.arr_port is null;

-- 三亚航线
select ts_short, from_net, count(*), count(distinct flight_no), count(distinct dep_port, arr_port, time_interval) from flight_ticket.sanya_tickets where dep_port='SYX' or arr_port='SYX' group by ts_short, from_net order by ts_short desc;
select ts_short, count(*), count(distinct flight_no) from flight_ticket.sanya_ctrip_tickets group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct flight_no) from flight_ticket.sanya_flight_info group by ts_short order by ts_short desc;

-- 海口航线
select ts_short, from_net, count(*), count(distinct flight_no), count(distinct dep_port, arr_port, time_interval) from flight_ticket.sanya_tickets where dep_port='HAK' or arr_port='HAK' group by ts_short, from_net order by ts_short desc;
select ts_short, count(*), count(distinct flight_no) from flight_ticket.sanya_ctrip_tickets where dep_port_tlc='HAK' or arr_port_tlc='HAK' group by ts_short order by ts_short desc;

-- 日本机票
select ts_short, count(*), count(distinct flight_no), count(distinct dep_port, arr_port, time_interval) from jp_flight_ticket.jal where from_net="jal_domestic" group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct flight_no), count(distinct dep_port, arr_port, time_interval) from jp_flight_ticket.jal where from_net="jal_internal" group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct flight_no), count(distinct dep_city, arr_city, dep_date) from jp_flight_ticket.ana group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct flight_no), count(distinct dep_city_id, arr_city_id, time_interval) from jp_flight_ticket.ctrip_tickets group by ts_short order by ts_short desc;
select * from jp_flight_ticket.ctrip_tickets order by ts desc;

select dep_city, arr_city, count(*) from jp_flight_ticket.jal where from_net="jal_domestic" and ts_short="2019-10-18" group by dep_city, arr_city;
select dep_city, arr_city, count(*) from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2019-11-08" group by dep_city, arr_city;

select dep_city_name, arr_city_name, count(*) from jp_flight_ticket.ctrip_tickets where ts_short="2019-10-18" group by dep_city_name, arr_city_name;
select dep_city, arr_city, count(*) from jp_flight_ticket.ana where ts_short="2020-04-24" group by dep_city, arr_city;

select * from jp_flight_ticket.ana where ts_short='2021-02-05'; 

# 智联
select ts_short, count(*) from Jobs.tmp_zhilian_job group by ts_short order by ts_short desc;
select count(*) from Jobs.zhilian_job where ts>'2020-01-20' and ts<'2020-01-20 12';
select ts_short, count(*), count(distinct job_number), count(distinct company) from Jobs.zhilian_job group by ts_short;
select ts_short, count(*), count(distinct company) from Jobs.zhilian_job group by ts_short;
select ts_short, count(*) from Jobs.zhilian_company group by ts_short;

select ts_short, count(*) from Jobs.tmp_zhilian_job group by ts_short;
select count(*), count(distinct jobNumber) from Jobs.tmp_zhilian_company;

-- 合并职位
select count(distinct job_number) from Jobs.tmp_zhilian_job group by ts_short;

insert ignore into Jobs.zhilian_job 
select null,job_number,jobName,company,updateDate,updateDay,min_salary,max_salary,salary,eduLevel,jobType,workingExp,workingExp_str,industry,industry_first,emplType,
	applyType,saleType,companyLogo,expandCount,score,vipLevel,tagIntHighend,rootOrgId,staffId,chatWindow,timeState,rate,city_code,city_name,region_code,industry_id,
	bestEmployerLabel,ts,'2021-01-21' 
-- select count(distinct job_number) 
from Jobs.tmp_zhilian_job where ts_short >='2021-01-21';

select count(*), count(distinct job_number) from Jobs.tmp_zhilian_job where ts_short < '2021-05-10';

-- 分析新增公司比例
select distinct t1.cz_name, t1.cz_id from
-- select count(*) from 
Jobs.tmp_zhilian_company_03 t1
left join 
Jobs.tmp_zhilian_company t2
on t1.cz_id=t2.cz_id
where t2.cz_id is null
;


-- 合并智联的新公司
insert ignore into Jobs.zhilian_company
select null,cz_id,cz_name,cz_type,url,cz_size,ts,'2020-08-01' from Jobs.tmp_zhilian_company where ts_short in ('2020-08-01', '2020-08-15') and cz_name not like '%companyName%';

select ts_short, count(*) from Jobs.tmp_zhilian_company where cz_name not like '%companyName%' group by ts_short;

# 58同城
-- 690 45 475 15919
select count(*) from Jobs.`58_cities`;
select count(*) from Jobs.`58_industries`;
select count(*) from Jobs.`58_job`;
select count(*) from Jobs.`58_sub_local`;
select ts_short, count(*) from Jobs.`58_job` group by ts_short order by ts_short desc;
select batch_id, count(*) from Jobs.`58_job` group by batch_id;
select batch_id, count(*) from Jobs.`58_job_from_company` group by batch_id order by batch_id desc limit 5;
select batch_id, count(*) from Jobs.`58_company` group by batch_id;
select batch_id, count(*) from Jobs.`58_company_tag` group by batch_id;
select batch_id, count(*) from Jobs.`58_company_info` group by batch_id;
select batch_id, count(*) from Jobs.`58_job_info` group by batch_id;
select left(ts, 13), count(*) from Jobs.`58_job_info` where batch_id='2021-01-01' group by left(ts, 13);
select ts_short, count(*) from Jobs.`58_job_info` group by ts_short order by ts_short desc;


select count(distinct comp_no) from Jobs.`58_company`;
select batch_id, count(*) from Jobs.`58_job_finally` group by batch_id;

-- 最终计算
insert ignore into Jobs.`58_job_finally`
select cc.*, dd.pubdateInterval from
	(select aa.*, bb.updateInterval from
		(select * from Jobs.`58_job` where batch_id='2020-12-01') as aa
		left join 
		(select job_no, updateInterval from Jobs.`58_job_from_company` where batch_id='2020-12-01') as bb
		on aa.job_no = bb.job_no
	) cc
	left join 
	(select job_no,pubdateInterval from Jobs.`58_job_info` where batch_id='2020-12-01') dd
	on cc.job_no=dd.job_no
;


select left(ts, 13), count(*) from Jobs.`58_job` where batch_id="2020-06-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_company` where batch_id="2020-06-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_from_company` where batch_id="2019-10-01" group by left(ts, 13) ;

select left(ts, 13), count(*) from Jobs.`58_job` where batch_id="2019-09-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_from_company` where batch_id="2019-10-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_info` where batch_id="2020-08-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_company_tag` where batch_id="2019-10-01" group by left(ts, 13) ;
select ts_short, count(*) from Jobs.`58_job_info` where batch_id="2019-0-01" group by ts_short ;


# 小红书
select pub_date, count(*) from xiaohongshu.kol_user group by pub_date order by pub_date desc;
select find_date, count(*) from xiaohongshu.kol_user group by find_date order by find_date desc;

-- 周更
select ts_short, count(*) from xiaohongshu.brands group by ts_short order by ts_short desc;
select ts_short, count(*), count(account_id) from xiaohongshu.brand_info group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct brand_id) from xiaohongshu.notes_by_brand group by ts_short order by ts_short desc limit 10;
select ts_short, count(*) from xiaohongshu.note_info group by ts_short order by ts_short desc;
select pub_date, count(*) from xiaohongshu.note_info group by pub_date order by pub_date DESC;
select ts_short, count(*) from xiaohongshu.user_info group by ts_short;

select count(*) from
(select note_id from xiaohongshu.notes_by_brand where ts_short="2020-05-07") aa
left join 
(select note_id from xiaohongshu.notes_by_brand where ts_short="2020-04-30") bb
on aa.note_id=bb.note_id
where bb.note_id is null;

select ts_short, count(*) from xiaohongshu.tmp_user_info group by ts_short;

-- 月更
select ts_short, count(*) from xiaohongshu.goods_by_brand group by ts_short;
select ts_short, count(*) from xiaohongshu.notes_by_good group by ts_short;
select ts_short, count(*) from xiaohongshu.app_classification group by ts_short;
select ts_short, count(*) from xiaohongshu.app_brand_category group by ts_short;
-- 更新小红书
select * from xiaohongshu.brand_info where brand_name="三只松鼠";

-- 周一更新
select ts_short, count(*) from xiaohongshu.z_notes_by_keyword group by ts_short order by ts_short desc;
select ts_short,keyword, sort, count(*) from xiaohongshu.z_notes_by_keyword group by ts_short, keyword, sort order by ts_short desc;
select ts_short, count(*) from xiaohongshu.z_note_info group by ts_short;
select * from xiaohongshu.z_note_info order by ts desc limit 10;
select * from xiaohongshu.z_notes_by_keyword order by ts desc limit 10;
select ts_short, count(*) from xiaohongshu.z_ats_tag group by ts_short order by ts_short desc;

# 珀莱雅
-- 月更
select ts_short, count(*) from proya.cities group by ts_short;
select ts_short, count(*) from proya.stores group by ts_short;

select count(*) from proya.canadagoose_countries;
select ts_short, count(*) from proya.canadagoose_stores group by ts_short;
select ts_short, country, count(*) from proya.canadagoose_stores where ts_short>'2021' group by ts_short, country order by ts_short, country desc;
select ts_short, country, count(*) from proya.canadagoose_stores where ts_short>'2020-09' and `type`='direct_store' group by ts_short, country order by ts_short, country desc;

select ts_short, count(*) from proya.moncler_stores group by ts_short;

select ts_short, count(*), count(distinct shop_id) from proya.muji_stores group by ts_short;
select country, ts_short, count(*) from proya.muji_stores where ts_short>"2020-10" group by country, ts_short;
select ts_short, count(*) from proya.muji_address group by ts_short;
select ts_short, count(*) from proya.muji_news group by ts_short;
update proya.muji_stores aa, proya.muji_address bb 
set aa.country=bb.country, aa.city=bb.city
where aa.shop_id=bb.shop_id and aa.country is null and aa.ts_short='2021-02-15';
select ts_short, count(*) from proya.nome_stores group by ts_short;
select ts_short, count(*) from proya.uniqlo_stores group by ts_short;
select country, ts_short, count(*) from proya.uniqlo_stores where ts_short>"2020-10" group by country, ts_short;
select country, count(*) from proya.uniqlo_stores where ts_short="2019-12-16" group by country;
select * from proya.uniqlo_stores where ts_short="2019-12-16" and country="Japan";

-- 检查地址为空的, 可能出错的就是wx_stores
select ts_short, count(*) from miniso.store_address group by ts_short;
select ts_short, disable, count(*) from miniso.tmp_wx_stores_check group by ts_short, disable;
select * from miniso.store_address where is_match=0;
select * from miniso.wx_stores where city is null order by id desc;
select ts_short, count(*) from miniso.wx_stores group by ts_short;
select * from miniso.wx_stores order by id desc;
select ts_short, count(*), count(DISTINCT country_code) from miniso.areas group by ts_short;
select ts_short, count(*), count(distinct store_name) from miniso.stores group by ts_short;
select ts_short, count(distinct storeId) from miniso.tmp_stores_by_loc group by ts_short;
select ts_short, count(*), count(distinct store_name), count(distinct shop_no), sum(case when disable=1 then 0 else 1 end) from miniso.wx_stores_finally group by ts_short;

update miniso.wx_stores aa, miniso.store_address bb 
set aa.province=bb.province, aa.city=bb.city
where aa.shop_id=bb.shop_id and aa.province is null and aa.ts_short="2021-02-15";

update miniso.wx_stores_finally aa, miniso.wx_stores bb 
set aa.province=bb.province, aa.city=bb.city
where aa.shop_id=bb.shop_id and aa.province is null and aa.ts_short="2021-01-15";

# 2021-02开始从另一张表导出
select * from miniso.tmp_stores_by_loc;
select ts_short, task_type, count(*), count(distinct storeId)  from miniso.tmp_stores_by_loc group by ts_short, task_type;

-- insert ignore into miniso.wx_stores_finally
-- (shop_no, store_name, address, city, ts, ts_short, disable)
select storeId, storeName, storeAddress, storeCity, ts, ts_short, 0 from miniso.tmp_stores_by_loc where ts_short='2021-02-20';

# 还需要更新省份信息
update miniso.wx_stores_finally aa, (select distinct province, city, shop_no from miniso.wx_stores_finally where ts_short='2021-01-15') bb 
set aa.province=bb.province, aa.city=bb.city
where aa.shop_no=bb.shop_no and aa.province is null and aa.ts_short='2021-02-20';

# 检查全部更新
select * from miniso.wx_stores_finally where province is null;


-- 新增店铺验证
set @batch_id='2021-05-15';
set @last_batch_id='2021-05-10';
select aa.* from 
(SELECT * from miniso.wx_stores_finally where ts_short=@batch_id) aa
left join 
(SELECT distinct shop_no from miniso.wx_stores_finally where ts_short<=@last_batch_id) bb
on aa.shop_no=bb.shop_no
where bb.shop_no is null;

select aa.* from 
(SELECT * from miniso.wx_stores_finally where ts_short=@batch_id) aa
left join 
(SELECT * from miniso.wx_stores_finally where ts_short=@last_batch_id) bb
on aa.shop_no=bb.shop_no
where bb.shop_no is null;

select * from miniso.wx_stores_finally where shop_no='Z4MU';

-- popmart
select ts_short, count(*) from popmart.shops group by ts_short order by ts_short desc;

-- yadea
select ts_short, count(*) from proya.yadea_cities group by ts_short order by ts_short desc;
select ts_short, count(*) from proya.yadea_stores group by ts_short order by ts_short desc;

-- 哈啰hello
select ts_short, count(*) from hellobike.hellobike_store_app_finally where businessType=0 and pointType=0 group by ts_short;
select ts_short, count(*) from hellobike.hellobike_store_app_finally group by ts_short;
select ts_short, count(*), count(distinct pointId) from hellobike.tmp_hellobike_store_app where businessType=0 and pointType=0 group by ts_short;

# hello少的店
set @batch_id='2021-05-15';
set @last_batch_id='2021-05-01';
select aa.* from 
(SELECT * from hellobike.hellobike_store_app_finally where ts_short=@batch_id) aa
left join 
(SELECT * from hellobike.hellobike_store_app_finally where ts_short<=@last_batch_id) bb
on aa.pointId=bb.pointId
where bb.pointId is null;

select aa.* from 
(SELECT * from hellobike.hellobike_store_app_finally where ts_short=@last_batch_id) aa
left join 
(SELECT * from hellobike.hellobike_store_app_finally where ts_short=@batch_id) bb
on aa.pointId=bb.pointId
where bb.pointId is null;



# 大众点评
select ts_short, count(*) from dianping.categories c group by ts_short;
select ts_short, count(*) from dianping.tmp_city_list cl group by ts_short;
select ts_short, count(*) from dianping.city_list cl group by ts_short;
select count(*),count(distinct shop_id) from dianping.shops;
select * from dianping.shops order by id desc;
select left(ts,13), count(*) from dianping.shops group by left(ts,13);
select left(ts, 16), count(*) from dianping.shops_wx where ts_short="2019-10-30" group by left(ts, 16);
select count(*) from dianping.shops_2021_01;
select count(*) from dianping.shops_2_2020_11;
select ts_short, count(*), count(distinct city_id), count(distinct left(ts, 13)), max(ts) from dianping.shops_m_search_count group by ts_short;
select ts_short, count(*), sum(total_count) from dianping.shops_m_search_count where parent_id=0 and cate_id=10 group by ts_short;

-- 生成表2 shops_2_2019_07
create table dianping.shops_2020_12 like dianping.shops_2020_11;
create table dianping.shops_2_2021_04 like dianping.shops_2_2021_03;

create table dianping.shops_2021_04 like dianping.shops_2021_03;
alter table dianping.shops drop index ts_short_index;

-- 去重
insert ignore into dianping.shops_2021_04
select * from dianping.shops;

-- 置空原始数据
TRUNCATE dianping.shops;

insert ignore into dianping.shops_2_2021_04
select e.province_short, e.cate_2_name, sum(count_num) as count_num
from
	(
		select d.cate_2_name, c.*
		from
			(
				## 09-22为第二批分类
				select cate_2_id, cate_2_name from dianping.categories where ts_short='2020-09-22') d
				left join 
				(
				    select a.province_short, b.city_id, b.cate_id, b.count_num
					from
						(select province_short, city_id from dianping.city_list_province )as a
						left join
						(
							select city_id,cate_id, count(*) as count_num from dianping.shops_2021_04 group by city_id, cate_id
						) as b
						on a.city_id=b.city_id
			) c
			on d.cate_2_id=c.cate_id
	) as e
group by e.province_short, e.cate_2_name;


-- 公有云

select ts_short, cloud, count(*) from cloud.Uniform group by ts_short, cloud;
select ts_short, cloud, count(*) from cloud.Uniform_bk group by ts_short, cloud;

-- ali
-- 会出现新增cpu和新增实例类型(不一定全可用)
select ts_short, count(*), count(distinct cpuName), count(distinct instanceTypeId) from cloud.aliyun_instance group by ts_short;
-- 核对各地区的是否匹配, 核对有多少新增可用实例
select ts_short, count(distinct regionId), count(*), count(distinct instanceTypeId) from cloud.aliyun_instance_zone group by ts_short;
select regionId, count(distinct `zone`) from cloud.aliyun_instance_zone where ts_short='2021-01-05' group by regionId;
select ts_short, count(*), count(distinct localId) from cloud.aliyun_prices group by ts_short;
select ts_short, count(*) from cloud.aliyun_regions group by ts_short;
-- tencent
select ts_short, count(*), count(distinct region_id), count(distinct zone_id) from cloud.tencent_regions group by ts_short;
select ts_short, count(*), count(distinct region_id), count(distinct zoneId) from cloud.tencent_instances group by ts_short;
select zoneId, count(*) from cloud.tencent_instances where ts_short='2020-12-02' group by zoneId;
select ts_short, count(*), count(distinct cpuName), count(distinct InstanceTypeId), count(distinct region_id), count(distinct cpuName, InstanceTypeId, region_id) from cloud.tencent_basic_instances group by ts_short;

-- aws
select ts_short, count(*) from cloud.aws_regions group by ts_short;
select ts_short, count(*), count(distinct location), count(distinct cpuName) from cloud.aws_instances group by ts_short;

select distinct location from cloud.aws_instances where ts_short="2020-11-03";
select * from cloud.Uniform where ts_short="2020-05-07" and Cloud="AWS" and Region is null;

-- cpu变更
select * from 
(select distinct cpuName from cloud.aws_instances where ts_short='2020-10-09') aa 
left join 
(select distinct cpuName from cloud.aws_instances where ts_short='2020-09-07') bb
on aa.cpuName =bb.cpuName;


-- azure
select ts_short, count(*) from cloud.azure_os group by ts_short;
select ts_short, count(*) from cloud.azure_regions group by ts_short;
select ts_short, count(*), count(distinct os_name), count(distinct location), count(distinct location, os_name) from cloud.azure_prices group by ts_short;
select ts_short, count(*) from cloud.azure_instance_info group by ts_short;

# azure新增了哪些系列, 如果有匹配不上的group_id(series_code), 需要手动填写cpu到azure_gpu_group
select * from 
(select distinct series_code from cloud.azure_prices where ts_short='2020-12-02') aa 
left join 
(select distinct series_code from cloud.azure_prices where ts_short<='2020-11-03') bb
on aa.series_code =bb.series_code;

select * from 
(select distinct instance_name from cloud.azure_prices where ts_short='2020-12-02') aa 
left join 
(select distinct instance_name from cloud.azure_prices where ts_short<='2020-11-03') bb
on aa.instance_name=bb.instance_name
where bb.instance_name is null;


# 新增哪些实例
select * from
(select distinct InstanceType, CPUbrand, CPUseries from cloud.Uniform where Cloud='Azure' and ts_short='2020-08-04') aa
left join 
(select distinct InstanceType, CPUbrand, CPUseries from cloud.Uniform where Cloud='Azure' and ts_short='2020-07-08') bb 
on aa.InstanceType=bb.InstanceType 
where bb.InstanceType is null;


-- gcp
select ts_short, count(*) from cloud.gcp_instances group by ts_short;
select ts_short, count(*) from cloud.gcp_prices group by ts_short;
-- select ts_short, count(*) from cloud.gcp_cpu_group group by ts_short;
select ts_short, count(*) from cloud.gcp_regions group by ts_short;


-- 最终统计
select Cloud, count(*) from cloud.Uniform where ts_short='2020-01-09' group by Cloud;
select ts_short, Cloud, count(*) from cloud.Uniform group by ts_short, Cloud order by Cloud, ts_short;
select ts_short, Cloud, count(*) from cloud.Uniform_bk group by ts_short, Cloud;

select *
from cloud.Uniform
where  CPUbrand is null;

-- Mercari

-- 分析当前批次新增用户
select batch_id, count(1), count(distinct brand_id), count(distinct brand_group_id) from mercari.brands group by batch_id;
select ts_short, count(1), count(distinct child_category_id) from mercari.categories group by ts_short;
select batch_id, count(1), count(distinct child_category_id) from mercari.categories group by batch_id;
select batch_id, count(1) from mercari.brands_by_category group by batch_id;
select ts_short, count(1) from mercari.app_sku_2020_02_02 group by ts_short;
select count(*) from mercari.app_sku;
select * from mercari.app_sku order by id desc;
select left(ts, 13), count(*) from mercari.app_sku group by left(ts, 13);
select count(*) from mercari.app_user where batch_id="2020-06-01";

select batch_id, count(1) from mercari.app_user group by batch_id;
select * from mercari.app_user order by id desc;
select ts_short, count(1) from mercari.app_user group by ts_short order by ts_short DESC;
select left(ts, 13), count(1) from mercari.app_user group by left(ts, 13) order by left(ts, 13) DESC limit 10;
select ts_short, count(1) from mercari.all_user group by ts_short;
select count(*) from mercari.all_user;
select * from mercari.app_sku_2019_10_02 where batch_id="2019-10-01";

create table mercari.app_sku like mercari.app_sku_2021_05_01;

-- 计算表的验证
select yearmonth, count(*), sum(value) from mercari.final_buyer_txn group by yearmonth; 
select yearmonth, count(*), sum(value) from mercari.final_seller_txn group by yearmonth; 

select yearmonth, count(*) from mercari.final_buyer_txn group by yearmonth; 
select yearmonth, count(*) from mercari.final_seller_txn group by yearmonth; 
select yearmonth, count(*) from mercari.final_seller_listing group by yearmonth; 
select update_date, count(*) from mercari.final_seller_listing group by update_date; 

select yearmonth, sum(value), sum(sku), count(*) from mercari.us_final_buyer_txn group by yearmonth; 
select yearmonth, sum(value), sum(sku), count(*) from mercari.us_final_seller_txn group by yearmonth; 
select update_date, sum(value), sum(sku), count(*) from mercari.us_final_seller_txn group by update_date; 
select yearmonth, count(*) from mercari.us_final_seller_txn group by yearmonth; 
select yearmonth, count(*) from mercari.us_final_seller_listing group by yearmonth;

-- mercari us
select ts_short, count(1) from mercari.us_categories group by ts_short;
select ts_short, count(1) from mercari.us_brands group by ts_short;
select ts_short, count(1) from mercari.us_brands_by_category group by ts_short;
select ts_short, count(1) from mercari.us_sku group by ts_short;
select ts_short, count(1) from mercari.us_sku_info group by ts_short;
select left(ts,13), count(1) from mercari.us_sku group by left(ts,13);
select count(1) from mercari.us_app_sku_info_for_all;
select * from mercari.us_app_sku_info_for_all where id>121867057;

-- 列表页共发现多少sku
select batch_id, count(1) from mercari.us_sku group by batch_id;
-- 有多少新增的sku需要详情
select batch_id, count(1) from mercari.tmp_us_sku_new group by batch_id;
select count(1) from mercari.us_sku_from_seller where batch_id="2020-01-02";
select left(ts,13), count(1) from mercari.us_brands_by_category group by left(ts,13);
select left(ts,13), count(1) from mercari.us_sku where batch_id="2020-02-02" group by left(ts,13);
select left(ts,13), count(1) from mercari.us_sku_info where batch_id="2020-02-02" group by left(ts,13);
select left(ts,13), count(1) from mercari.us_sku_from_seller where batch_id="2019-11-02" group by left(ts,13);
select ts_short, count(1) from mercari.us_sku_info_for_all where batch_id="2020-01-02" group by ts_short order by ts_short desc;
select  left(ts,13), count(1) from mercari.us_sku_from_seller where batch_id="2019-10-02" group by  left(ts,13);
select count(*) from mercari.us_app_sku_info_for_all;
select left(ts,13), count(1) from mercari.us_app_sku_info_for_all group by left(ts,13);
select ts_short, count(1) from mercari.us_all_user group by ts_short;
-- 查看各批次分别新增多少用户
select ts_short, count(1) from mercari.us_all_user group by ts_short;
select batch_id, count(1) from mercari.us_user_info group by batch_id;

create table mercari.us_app_sku_info_for_all like mercari.us_app_sku_info_for_all_2021_04;

-- fangtianxia 房天下
select ts_short, count(*), count(distinct url), count(distinct livindate) from fangtianxia.community_list group by ts_short;
select ts_short, count(*), count(distinct community) from fangtianxia.community_info group by ts_short;
select ts_short, count(*), count(distinct community) from fangtianxia.community_live_history group by ts_short;
select ts, live_date_std, count(*) from fangtianxia.final_delivery group by ts, live_date_std;
select ts, count(*) from fangtianxia.final_delivery group by ts;

-- 判断数据是否漏爬或误爬
set @batch_id='2021-04-21';
select * from 
(select distinct decoration_origin from fangtianxia.community_info where ts_short=@batch_id) aa
left join 
(select distinct decoration_origin from fangtianxia.community_info where ts_short<@batch_id) bb
on aa.decoration_origin=bb.decoration_origin;

select distinct price_origin from fangtianxia.community_info where  ts_short=@batch_id and price = 0;
select distinct decoration_origin, decoration from fangtianxia.community_info where ts_short=@batch_id and decoration ='无法确定';
select distinct construction_area_origin from fangtianxia.community_info where (construction_area =0 or construction_area is null) and ts_short=@batch_id;
select distinct total_houses_origin from fangtianxia.community_info where (total_houses =0 or total_houses is null) and ts_short=@batch_id;
select distinct property_costs_origin from fangtianxia.community_info where (property_costs =0 or property_costs is null) and ts_short=@batch_id;

select ts, decoration, count(*), sum(construction_area_p), sum(total_houses_p) from fangtianxia.final_delivery group by ts, decoration;

-- 数据计算
insert ignore into fangtianxia.final_delivery
    select null, bb.community, aa.name, aa.city , bb.decoration, bb.price, bb.property_costs, bb.developer, bb.manager, aa.livindate, bb.construction_area/cc.live_count, bb.total_houses/cc.live_count, left(aa.ts_short, 7) from
    (select * from fangtianxia.community_list where ts_short= @batch_id ) aa
    left join
    (select * from fangtianxia.community_info where ts_short= @batch_id ) bb
    on aa.url=bb.community
    left join
    (
    select community, count(*) as live_count from fangtianxia.community_live_history where ts_short= @batch_id group by community
    ) cc
    on aa.url = cc.community
    where bb.community is not null
    ;
   

-- wow
select ts_short, count(*) from wow.topics group by ts_short;
select `language`, region, ts_short, count(*) from wow.topics group by `language`, region, ts_short order by ts_short desc;
select left(created_at, 10), count(*) from wow.topics where ts_short='2020-04-07' and region='eu' and `language`='English (EU)' group by left(created_at, 10);

-- paypay
select ts_short, count(*) from paypay.categories group by ts_short;
select ts_short, count(*) from paypay.brands group by ts_short;

-- 每周一
select ts_short, count(*), sum(total_count), count(distinct brand_id, category_id, item_status), max(ts) from paypay.search_count group by ts_short desc;
select ts_short, item_status, count(*), sum(total_count), count(distinct brand_id, category_id, item_status), max(ts) from paypay.search_count group by ts_short, item_status order by ts_short desc;
-- 每天
select ts_short, count(*) from paypay.sku_status group by ts_short desc;
-- 第一第三周的周一
select ts_short, count(*), count(distinct seller_id) from paypay.sku_by_seller group by ts_short desc;


select DISTINCT category_id_1 from paypay.category_new;
select * from paypay.search_count WHERE total_count=149999;
select * from paypay.search_count WHERE ts_short="2019-12-09"  order by total_count desc;
select left(ts, 16), count(*) from paypay.sku_by_seller where ts_short="2019-11-07" group by left(ts, 16);


select aa.*, bb.total_count as bb_total_count, aa.total_count-bb.total_count as m FROM
(select brand_id, category_id, item_status, total_count from paypay.search_count where ts_short="2019-11-25") aa
left join 
(select  brand_id, category_id, item_status, total_count  from paypay.search_count where ts_short="2019-11-18") bb
on aa.brand_id=bb.brand_id and aa.category_id=bb.category_id and aa.item_status=bb.item_status and aa.total_count>bb.total_count
order by m DESC;

select * FROM
(select * from paypay.search_count where ts_short="2019-11-04") aa
left join 
(select * from paypay.search_count where ts_short="2019-11-04") bb

-- muji网络商城
select ts_short, count(*), count(distinct category_3_id) from muji.categories group by ts_short order by ts_short desc;
select ts_short, count(*) from muji.goods group by ts_short order by ts_short desc;
select ts_short, count(*) from muji.tmp_sku_v2 group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct goods_id) from muji.sku group by ts_short order by ts_short desc;


-- 台湾上市公司
select ts_short, count(*) from twse.company_income group by ts_short order by ts_short desc;
select data_date, count(*) from twse.company_income group by data_date;
select ts_short, count(*) from twse.tsmc_speech group by ts_short;
select * from twse.company_income order by ts_short desc;

-- talabat
# 8号
select ts_short, count(*), count(distinct area_url), count(distinct country) from talabat.areas group by ts_short;
select count(*) from talabat.cuisines;
select ts_short, count(*),count(distinct restaurant_id), count(distinct area_url) from talabat.area_restaurants group by ts_short;
select ts_short, count(*) from talabat.trav_areas group by ts_short;
select ts_short, count(*) from talabat.trav_restaurants group by ts_short;
select ts_short, count(*) from talabat.rba_map group by ts_short;
## 每天
select ts_short, count(*) from talabat.restaurants group by ts_short order by ts_short desc;
select left(ts, 13), count(*), count(distinct area_url) from talabat.`21_area_restaurants` where ts_short='2020-09-22' group by left(ts, 13) order by left(ts, 13) desc;
select ts_short, count(*), count(distinct area_url), count(distinct left(ts, 13)) from talabat.`21_area_restaurants` group by ts_short;

select tt1.* from 
(select * from talabat.areas where ts_short='2020-09-08')tt1
left join 
(select distinct area_url from talabat.area_restaurants where ts_short='2020-09-08')tt2
on tt1.area_url=tt2.area_url
where tt2.area_url is null;

-- hungerstation
## 每天
select ts_short, count(*) from hungerstation.`3_areas` group by ts_short;
select ts_short, count(*) from hungerstation.`3_restaurants_by_area` group by ts_short;
select left(ts, 13), count(*), count(distinct branch_id), count(distinct restaurant_id), count(distinct area_id, city_id), count(distinct left(ts, 13)) from hungerstation.`3_restaurants_by_area` where ts_short='2020-09-22' group by left(ts, 13) order by left(ts, 13) desc;
select ts_short, area_id, city_id, count(*), count(distinct branch_id), count(distinct restaurant_id), count(distinct left(ts, 13)) from hungerstation.`3_restaurants_by_area` group by ts_short, area_id, city_id order by ts_short desc;


## 每月
select ts_short, count(*) from hungerstation.areas group by ts_short;
select ts_short, count(*) from hungerstation.cuisines group by ts_short;
select ts_short, count(*), count(distinct restaurant_id), count(distinct area_id, city_id) from hungerstation.restaurants_by_area group by ts_short;
select ts_short, count(*), count(distinct branch_id) from hungerstation.reviews_by_branch group by ts_short;
delete from talabat.area_restaurants where ts_short='2020-12-08';

-- yogiyo
# 每月5 20
select ts_short, count(*) from yogiyo.restaurants group by ts_short;
select count(distinct restaurant_id) from yogiyo.restaurants where franchise_id in ("18", "37");

select franchise_id, franchise_name, count(distinct restaurant_id) as cnt from yogiyo.restaurants group by franchise_id, franchise_name order by cnt desc;
select ts_short, count(*) from yogiyo.tmp_total_objects group by ts_short;

# 每天
select ts_short, from_site, count(*) from yogiyo.res_info_by_day group by ts_short, from_site order by ts_short desc;
select ts_short, count(*) from yogiyo.res_info_by_day group by ts_short order by ts_short desc;
select * from baemin.restaurants_baemin_solo order by id desc;
select ts_short, count(*) from baemin.restaurants_baemin_solo group by ts_short;



-- baemin
select ts_short, count(*) from baemin.franchises group by ts_short;
select ts_short, count(*) from baemin.franchises_list group by ts_short;
select ts_short, query_type, count(*) from baemin.restaurants_baemin_solo group by query_type, ts_short;
select ts_short, count(*) from baemin.restaurants_riders group by ts_short;
select ts_short, count(*) from baemin.restaurants_takeout group by ts_short;
select ts_short, count(*), max(ts) from baemin.res_info group by ts_short;
select left(ts, 13), count(*) from baemin.res_info where ts_short='2020-07-21' group by left(ts, 13);
select ts_short, query_type, count(*) from baemin.tmp_all_restaurants group by query_type, ts_short;
select ts_short, count(distinct shopNumber) from baemin.tmp_all_restaurants group by ts_short;
select count(distinct shopNumber) from baemin.tmp_all_restaurants where ts_short >'2020-05' and query_type='baemin';
select ts_short, count(*) from baemin.tmp_restaurants_in group by ts_short;

select ts_short, count(*) from baemin.restaurants_finally group by ts_short;
select ts_short, count(*) from baemin.restaurants_finally where in_baemin is NULL group by ts_short;


select count(distinct Shop_No) from baemin.franchises_list where Fr_No in ('2011100211', '2011100212');

-- baemin bmart
select ts_short, count(*), count(distinct market_shopNo) from baemin.tmp_b_mart group by ts_short;
select ts_short, count(*), count(distinct market_shopNo) from baemin.b_mart group by ts_short;
select distinct market_shopNo from baemin.b_mart;

select * from 
(select * from baemin.b_mart where ts_short='2021-05-10') tt1
left join 
(select distinct market_shopNo from baemin.b_mart where ts_short<'2021-05-10') tt2
on tt1.market_shopNo=tt2.market_shopNo
where tt2.market_shopNo is null;



select count(*) from baemin.tmp_b_mart_categories ;
select * from baemin.tmp_b_mart_products;
select left(ts, 13), count(*) from baemin.tmp_b_mart_products group by left(ts, 13);
select left(ts, 13), count(distinct market_shopNo), count(*), sum(stockCount),  max(ts) from baemin.tmp_b_mart_skus group by left(ts, 13);
select market_shopNo, count(distinct product_id), count(distinct sku_id), count(distinct product_id, sku_id), count(distinct catalogContentId), sum(stockCount) as cnt from baemin.tmp_b_mart_skus where ts>'2021-03-22 10' group by market_shopNo order by cnt desc;

# 按商店看库存变化
select left(ts, 13), count(distinct market_shopNo), count(*), max(ts) from baemin.tmp_b_mart_skus group by left(ts, 13);
select batch_day, count(*), sum(sold_cnt), sum(sold_cnt*avg_salePrice), count(distinct market_shopNo) from baemin.b_mart_sku_finally where sold_cnt>0 group by batch_day;

# 按sku count
select sku_id, count(distinct catalogContentId), sum(stockCount) as cnt from baemin.tmp_b_mart_skus where ts>'2021-03-22 10' group by sku_id order by cnt desc; 
select sku_id, count(*), count(distinct catalogContentId), count(distinct product_id), sum(stockCount)/count(*) as cnt from baemin.tmp_b_mart_skus where ts>'2021-03-22 10' and market_shopNo=13289685 group by sku_id order by cnt desc;
select left(ts, 13), count(distinct catalogContentId), count(*), sum(stockCount) from baemin.tmp_b_mart_skus where market_shopNo=13289685 and sku_id=3707 group by left(ts, 13);



-- tesla
select left(ts, 13), count(*) from tesla.cur_visitors where ts_short='2020-09-14' group by left(ts, 13);
select ts_short, count(*), count(distinct user_id), max(cast(user_id as unsigned)) from tesla.cur_visitors group by ts_short order by ts_short desc;
select * from tesla.online_statistics order by ts desc;
select ts_short, count(*) from tesla.visitor_info where status = 1 group by ts_short;
select * from tesla.cur_visitors order by cast(user_id as unsigned) desc;
select * from tesla.visitor_info order by cast(user_id as unsigned) desc;
-- 每周二
select ts_short, count(distinct user_id), count(*) from tesla.visitor_info group by ts_short;
select left(joined, 10), max(user_id), count(*) from tesla.visitor_info group by left(joined, 10) order by left(joined, 10) desc; 

select * from tesla.visitor_info where left(joined, 10)>left(last_activity, 10);
select * from tesla.visitor_info order by user_id desc;

select aa.status, bb.status, count(*) from 
(select * from tesla.visitor_info where ts_short='2020-04-14') aa
left join
(select * from tesla.visitor_info where ts_short!='2020-04-14') bb
on aa.user_id=bb.user_id
group by aa.status, bb.status
;

# uniqlo
-- 中国
select * from uniqlo.uniqlo_cn_products_sum;
-- 每天四次
select ts_short, count(*), count(distinct productCode), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_products group by ts_short order by ts_short desc;
select ts_short, count(*), count(distinct sku_code), count(distinct product_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_sku_stock group by ts_short;
select ts_short, count(*), count(distinct product_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_product_stock group by ts_short;

-- 10分钟一次
-- select ts_short, count(*), count(distinct productCode), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_products_20 group by ts_short;
select ts_short, count(distinct sku_code), count(*) from uniqlo.uniqlo_cn_sku_stock_by_store group by ts_short;

-- 两小时一次
select left(ts, 13), count(*) from uniqlo.uniqlo_cn_sku_stock_by_store where ts_short='2020-09-09' group by left(ts, 13);

select ts_short, count(*), count(distinct product_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_product_stock_sample group by ts_short;
select ts_short, count(*), count(distinct product_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_cn_sku_stock_sample group by ts_short;


-- 日本
## 10分钟一次
-- select ts_short, count(*), count(distinct product_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_product_stock_jp group by ts_short;
-- select ts_short, count(*), count(distinct sku_code), count(distinct left(ts, 13)) from uniqlo.uniqlo_sku_stock_jp group by ts_short;

## 每天13次
select left(ts, 13),is_visible, count(*), count(distinct productID), count(distinct left(ts, 13)) from uniqlo.uniqlo_jp_products group by left(ts, 13), is_visible order by left(ts, 13) desc;
select * from uniqlo.uniqlo_jp_products where is_visible=0 and ts_short='2020-08-03'  order by sku_realstock_sum desc;
-- select left(ts, 13), count(*), count(distinct left(ts, 13)) from uniqlo.uniqlo_jp_skus group by left(ts, 13);
select ts_short, count(*), count(distinct productID) from uniqlo.uniqlo_jp_products group by ts_short order by ts_short;


## sushiro
select * from sushiro.sushiro order by id desc;
select left(ts, 13), count(*) from sushiro.sushiro group by left(ts, 13) order by left(ts, 13) desc;

select ts_short, count(*) from sushiro.sushiro group by ts_short order by ts_short desc;
select * from sushiro.sushiro where table_number is null order by id desc;
select distinct appointment_number from sushiro.sushiro order by appointment_number;
select distinct bar_seat_number from sushiro.sushiro order by bar_seat_number;
select distinct table_number from sushiro.sushiro order by table_number;

-- 外卖
select left(ts, 15), count(*), count(distinct shop_name) from sushiro.sushiro_takeout group by left(ts, 15) order by left(ts, 15) desc;
select ts_short, count(*), count(distinct shop_name) from sushiro.sushiro_takeout group by ts_short order by ts_short desc;
select left(ts, 13), count(*), count(distinct shop_name) from sushiro.sushiro_takeout group by left(ts, 13) order by left(ts, 13) desc;

select * from
(select shop_name, max(wait) as max_wait, min(wait) as min_wait from sushiro.sushiro_takeout group by shop_name) tt1
where tt1.max_wait != tt1.min_wait;

select * from 
sushiro.sushiro aa 
left JOIN
sushiro.sushiro bb 
on aa.channel_id=bb.channel_id
where aa.ts_short=bb.ts_short and aa.ts_short>'2020-06-07' and bb.bar_seat_number != '' and aa.id<bb.id and aa.bar_seat_number>bb.bar_seat_number;


select distinct aa.channel_name, aa.ts from 
sushiro.sushiro aa 
left JOIN
sushiro.sushiro bb 
on aa.channel_id=bb.channel_id
where aa.ts_short=bb.ts_short and aa.ts_short>'2020-06-02' and bb.bar_seat_number != '' and aa.ts<bb.ts and aa.bar_seat_number=bb.bar_seat_number and aa.table_number=bb.table_number and aa.appointment_number=bb.appointment_number and aa.next_number=bb.next_number;

# popmart

--  15号
select ts_short, count(*) from popmart.shops group by ts_short order by ts_short desc;

-- 每天
select ts_short, count(*), count(distinct left(ts, 13)) from popmart.goods group by ts_short order by ts_short desc;
select left(ts, 13), count(*), count(distinct shop_id) from popmart.goods group by left(ts, 13) order by left(ts, 13) desc;

-- 抽盒机
-- 10分钟一次
select left(ts, 15), count(*), sum(box_count) from popmart.chouhe_boxes_10 where box_position>=1 group by left(ts, 15) order by left(ts, 15) desc;
-- 每天2次
select ts_short, count(*) from popmart.chouhe_boxes group by ts_short order by ts_short desc;
select ts_short, count(*) from popmart.chouhe_goods group by ts_short order by ts_short desc;
select left(ts, 13), count(*), count(distinct goods_id), count(distinct box_no), count(distinct left(ts, 16)) from popmart.chouhe_boxes where state=0 group by left(ts, 13) order by left(ts, 13) desc;
select goods_id, max(box_count), min(set_no), max(set_no) from popmart.chouhe_boxes where left(ts, 13)='2020-06-30 06' group by goods_id;
select distinct shop_id, kdtId from popmart.shops;
-- 每小时一次
-- select left(ts, 13), count(*), count(distinct goods_id), count(distinct left(ts, 16)) from popmart.tmp_chouhe_boxes_test group by left(ts, 13) order by left(ts, 13) desc;
select left(ts, 13), count(*), count(distinct shop_id) from popmart.chouhe_shops group by left(ts, 13) order by left(ts, 13) desc;
select ts_short, count(*), count(distinct left(ts, 13)) from popmart.chouhe_shops group by ts_short order by ts_short desc;
select left(ts, 13), count(*), count(distinct shop_id) from popmart.chouhe_goods group by left(ts, 13) order by left(ts, 13) desc;

select * from popmart.chouhe_finally where ts_short='2021-01-09';

-- 特殊情况
-- 查看白天新上架商品, 结合看, 第一个语句是包含中途补充盒子的情况
select * from 
(
select left(ts, 13) as ts, goods_id from popmart.chouhe_boxes where box_position=1 and right(left(ts, 13), 2)>8 group by left(ts, 13), goods_id
) tt1
order by tt1.ts desc;

select * from 
(select goods_id, ts_short, min(ts) as start_h FROM popmart.chouhe_boxes_10 where box_position=1 group by goods_id, ts_short) tt1
where right(left(tt1.start_h, 13), 2)>8
order by tt1.ts_short desc
;
-- 是否有盒子范围是超出上限后从1开始
select * from popmart.chouhe_boxes where set_no=1;
-- box count突增的情况
select * from popmart.chouhe_boxes where ts>'2020-07-01 11';

                               
-- 判断set_no和box_no的关系(set_no不唯一)
select goods_id, set_no, count(distinct box_no) as cnt from popmart.chouhe_boxes group by goods_id, set_no order by cnt desc;
select goods_id, count(distinct series_id) as cnt from popmart.chouhe_goods group by goods_id order by cnt desc;
select series_id, count(distinct goods_id) as cnt from popmart.chouhe_goods group by series_id order by cnt desc;

-- 计算结果
select ts_short, sale_type, sum(sales/100), sum(sold_cnt) from popmart.chouhe_finally group by ts_short, sale_type order by ts_short desc;
select ts_short, sum(sales/100), sum(sold_cnt), count(distinct goods_id) from popmart.chouhe_finally where sale_type !=2 group by ts_short order by ts_short desc;
select * from
(select sale_type, goods_id, cast(sold_cnt as UNSIGNED) as sold_cnt from popmart.chouhe_finally where ts_short='2021-03-01' and sale_type=1) tt1 order by tt1.sold_cnt desc;

select ts_short, sale_type, sum(sales/100) from popmart.tmp_chouhe_finally_bk group by ts_short, sale_type;
select ts_short, batch_id, count(*) from popmart.tmp_chouhe_batch group by ts_short,batch_id order by ts_short, batch_id desc;

-- 避免多条结果
select ts_short, sale_type, goods_id, count(*) as cnt from popmart.chouhe_finally group by ts_short, sale_type, goods_id order by cnt desc;
select ts_short,batch_id, box_no, count(*) as cnt from popmart.tmp_chouhe_batch group by ts_short,batch_id, box_no order by cnt desc;

select * from popmart.chouhe_boxes where ts_short='2020-12-17';

select ts_short, count(*), count(distinct box_no) from popmart.tmp_chouhe_batch_origin group by ts_short;

select ts_short, res, count(*) from popmart.tmp_res group by ts_short, res order by ts_short desc;


# nio蔚来汽车

select left(ts, 15), count(*) from nio.chargingpile where group by left(ts, 15) order by left(ts, 15) desc;
select left(ts, 15), sum(charger_total_number), sum(free_number), sum(resource_number) from nio.merged_info group by left(ts, 15) order by left(ts, 15) desc;
select left(ts, 13), count(*) from nio.chargingpile group by left(ts, 13) order by left(ts, 13) desc;

select ts_short, count(*) from nio.tmp_merged_info group by ts_short;
select count(distinct power_id) from nio.tmp_loc_chargingpile order by id desc;

select ts_short, count(*) from nio.loc_chargingpile group by ts_short;
select ts_short, count(*), count(distinct power_id) from nio.tmp_loc_chargingpile group by ts_short;

select ts_short, count(*) from nio.tmp_loc_chargingpile_etl group by ts_short;
select ts_short, count(*) from nio.tmp_loc_chargingpile_unique group by ts_short;

# monitor
select ts_short, count(*) from monitor.monitor_log group by ts_short;

SELECT ts_short, query, count(*) from wechat.wechat_search_index group by ts_short, query;

# ninebot
select ts_short, count(*), count(distinct circle_id) from ninebot.circle_list group by ts_short;
select ts_short, count(*), count(distinct shop_id) from ninebot.shop_list group by ts_short;
select ts_short, count(*) from ninebot.user_list group by ts_short;
select ts_short, count(*) from ninebot.user_info group by ts_short;
select ts_short, count(*), count(nickname) from ninebot.newuser_info group by ts_short;
select left(regdate, 10), count(*), count(nickname), count(distinct uid), max(uid), min(uid),max(uid)-min(uid)  from ninebot.newuser_info where nickname is not null group by left(regdate, 10);
select left(regdate, 13), count(*), count(nickname), count(distinct uid), max(uid), min(uid),max(uid)-min(uid)  from ninebot.newuser_info where nickname is not null group by left(regdate, 13) order by left(regdate, 13) desc;
select * from ninebot.newuser_info where left(regdate, 10) = '2018-12-26';

# coupang eats
select ts_short, count(*), count(distinct restaurant_id) from coupang_eats.tmp_restaurants group by ts_short;
select ts_short, count(*), sum(case when expressDeliveryBadge like '%"expressBadge": true%' then 1 else 0 end) from coupang_eats.restaurants group by ts_short;
delete from coupang_eats.restaurants where ts_short='2021-04-21';

insert ignore into coupang_eats.tmp_tmp_restaurants
select * from coupang_eats.tmp_restaurants;


# bizreach
select ts_short, count(*), 
	sum(case when industryList is not null then allRecordCount else 0 end) as industry, 
	sum(case when jobIncomeCd is not null then allRecordCount else 0 end) as income, 
	sum(case when jobCategoryList is not null then allRecordCount else 0 end) as job_category 
from bizreach.job_search_count jsc  group by ts_short;

select ts_short, count(*), count(distinct jobId), max(ts) from bizreach.job_list group by ts_short;

select ts_short, count(*), max(cast(company_id as unsigned)) from bizreach.tmp_company group by ts_short;
select ts_short, count(*), max(cast(company_id as unsigned)) from bizreach.company_info group by ts_short;
select count(distinct company_id) from bizreach.tmp_company;
select * from bizreach.company_info where company_id='17024';

select * from xiaomi.kefu order by id desc;

# reddit
select ts_short, count(*), count(distinct origin_flair) from reddit.tmp_post_list_new group by ts_short;
select ts_short, count(*), count(distinct origin_flair) from reddit.tmp_post_list_hot group by ts_short;
select ts_short, count(*), count(distinct origin_flair) from reddit.tmp_post_list_top group by ts_short;

select distinct origin_flair from reddit.tmp_post_list where ts_short='2021-03-09';
select distinct flair from reddit.tmp_post_list where ts_short='2021-03-09' and origin_flair ='Chart';


# phxlabs
select ts_short, count(*) from phxlabs.job_info group by ts_short;
select * from phxlabs.job_infojob_info order by id desc;


# qqmusic
select left(ts, 7), count(*) from qqmusic.tmp_user_info group by left(ts, 7);
select left(ts, 7), count(*) from qqmusic.user_info group by left(ts, 7);


# marine traffic
select left(ts, 13), count(*), count(distinct SHIP_ID) from marinetraffic.tmp_marinetraffic_ships group by left(ts, 13) order by left(ts,13) desc;
select * from marinetraffic.marinetraffic_ships_finally order by id desc;

select * from 
(select distinct SHIP_ID from marinetraffic.tmp_marinetraffic_ships where left(ts, 13)='2021-04-22 04' )tt1
left join 
(select distinct SHIP_ID from marinetraffic.tmp_marinetraffic_ships where left(ts, 13)='2021-04-22 08' )tt2
on tt1.SHIP_ID=tt2.SHIP_ID
where tt2.SHIP_ID is null;

select * from 
(select distinct SHIPNAME from marinetraffic.tmp_marinetraffic_ships where left(ts, 13)='2021-04-22 04' )tt1
left join 
(select distinct SHIPNAME from marinetraffic.tmp_marinetraffic_ships where left(ts, 13)='2021-04-22 08' )tt2
on tt1.SHIPNAME=tt2.SHIPNAME
where tt2.SHIPNAME is null;


# 得物
select ts_short, count(*) from dewu.spus_unique group by ts_short;
select ts_short, count(*) from dewu.brands group by ts_short;
select ts_short, count(*) from dewu.categories group by ts_short;

