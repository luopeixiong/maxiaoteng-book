-- 通用
select * from information_schema.innodb_trx;

SELECT GROUP_CONCAT(COLUMN_NAME SEPARATOR ",") FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'mercari' AND TABLE_NAME = 'app_sku';

# raksul
select left(batch_id, 10), count(*) from raksul.raksul_info group by left(batch_id, 10);


# twitch定期统计
select ts_short, count(*) from twitch.game_list group by ts_short;
select ts_short, count(*) from twitch.channel_list group by ts_short;
select ts_short, count(*) from twitch.game_info group by ts_short;
select ts_short, count(*) from twitch.channel_info group by ts_short;
select ts_short, count(*) from twitch.game_activity_info group by ts_short;
select ts_short, count(*) from twitch.channel_activity_info group by ts_short;
select ts_short, count(*) from twitch.channel_stream_info group by ts_short;
select occurrence_date, count(*) from twitch.game_share group by occurrence_date;

# recruit_agent
SELECT ts_short, count(*) from recruit_agent.company group by ts_short;
SELECT ts_short, count(*) from recruit_agent.company_info group by ts_short;
SELECT ts_short, count(*) from recruit_agent.job group by ts_short;



# indeed
# 每次分析
select ts_short,count(*) from Indeed.indeed_searchcount_final group by ts_short;
select ts_short,count(*) from Indeed.indeed_search_count group by ts_short;
select ts_short,count(*) from Indeed.indeed_info group by ts_short;

# Hotel
select ts_short, count(*) from Hotels.jinjiang_cities group by ts_short;
select ts_short, count(*) from Hotels.jinjiang_hotels group by ts_short;

select ts_short, count(*) from Hotels.oyo_cities group by ts_short;
select ts_short, count(*) from Hotels.oyo_hotels group by ts_short;
select ts_short, count(*) from Hotels.oyo_hot_cities group by ts_short;

select ts_short, count(*) from Hotels.bth_hotels group by ts_short;
select ts_short, count(*) from Hotels.bth_cities group by ts_short;
select ts_short, count(*) from Hotels.bth_brands group by ts_short;

select ts_short, count(*) from Hotels.viennar_hotels group by ts_short;
select ts_short, count(*) from Hotels.luckin_shops group by ts_short;


# 机票项目
select ts_short, count(*) from flight_ticket.tickets group by ts_short;
select ts_short, count(*) from flight_ticket.ctrip_tickets group by ts_short;

select ts_short, from_net, count(*) from flight_ticket.tickets group by ts_short, from_net;
select ts_short,from_net, count(*) from flight_ticket.ctrip_tickets group by ts_short, from_net;
select ts_short, count(*) from flight_ticket.umetrip_info group by ts_short;

-- 日本机票
select ts_short, count(*) from jp_flight_ticket.jal where from_net="jal_domestic" group by ts_short;
select ts_short, count(*) from jp_flight_ticket.jal where from_net="jal_internal" group by ts_short;

select dep_city, arr_city, count(*) from jp_flight_ticket.jal where from_net="jal_domestic" and ts_short="2019-09-13" group by dep_city, arr_city;
select dep_city, arr_city, count(*) from jp_flight_ticket.jal where from_net="jal_internal" and ts_short="2019-09-13" group by dep_city, arr_city;


# 智联
select ts_short, count(*) from Jobs.zhilian_job group by ts_short;
select ts_short, count(*) from Jobs.zhilian_company group by ts_short;

# 58同城
select ts_short, count(*) from Jobs.`58_job` group by ts_short;
select batch_id, count(*) from Jobs.`58_job` group by batch_id;
select batch_id, count(*) from Jobs.`58_job_from_company` group by batch_id;


select left(ts, 13), count(*) from Jobs.`58_job` where batch_id="2019-09-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_from_company` where batch_id="2019-09-01" group by left(ts, 13) ;

select left(ts, 13), count(*) from Jobs.`58_job` where batch_id="2019-09-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_from_company` where batch_id="2019-09-01" group by left(ts, 13) ;
select left(ts, 13), count(*) from Jobs.`58_job_info` where batch_id="2019-07-01" group by left(ts, 13) ;
select ts_short, count(*) from Jobs.`58_job_info` where batch_id="2019-09-01" group by ts_short ;




# 小红书
-- 周更
select ts_short, count(*) from xiaohongshu.brands group by ts_short;
select ts_short, count(*) from xiaohongshu.brand_info group by ts_short;
select ts_short, count(*) from xiaohongshu.notes_by_brand group by ts_short;
select ts_short, count(*) from xiaohongshu.note_info group by ts_short;
select ts_short, count(*) from xiaohongshu.user_info group by ts_short;

-- 月更
select ts_short, count(*) from xiaohongshu.goods_by_brand group by ts_short;
select ts_short, count(*) from xiaohongshu.notes_by_good group by ts_short;
select ts_short, count(*) from xiaohongshu.app_classification group by ts_short;
select ts_short, count(*) from xiaohongshu.app_brand_category group by ts_short;
-- 更新小红书
select * from xiaohongshu.brand_info where brand_name="三只松鼠";

# 珀莱雅
-- 月更
select ts_short, count(*) from proya.cities group by ts_short;
select ts_short, count(*) from proya.stores group by ts_short;


# 大众点评
select count(*) from dianping.shops;
select count(*) from dianping.shops_2019_07;
select count(*) from dianping.shops_2_2019_07;

-- 生成表2 shops_2_2019_07
create table dianping.shops like dianping.shops_2019_09;
create table dianping.shops_2_2019_09 like dianping.shops_2_2019_08;

insert ignore into dianping.shops_2_2019_09
select e.province_short, e.cate_2_name, sum(count_num) as count_num
from
	(
		select d.cate_2_name, c.*
		from
			(
				select cate_2_id, cate_2_name from dianping.categories) d
				left join 
				(
				    select a.province_short, b.city_id, b.cate_id, b.count_num
					from
						(select province_short, city_id from dianping.city_list_province )as a
						left join
						(
							select city_id,cate_id, count(*) as count_num from dianping.shops_2019_09 group by city_id, cate_id
						) as b
						on a.city_id=b.city_id
			) c
			on d.cate_2_id=c.cate_id
	) as e
group by e.province_short, e.cate_2_name;


-- 公有云
-- ali
select ts_short, count(*) from cloud.aliyun_instance group by ts_short;
select ts_short, count(*) from cloud.aliyun_instance_zone group by ts_short;
select regionId, count(*) from cloud.aliyun_instance_zone where ts_short='2019-08-07' group by regionId;
select ts_short, count(*) from cloud.aliyun_prices group by ts_short;
select ts_short, count(*) from cloud.aliyun_regions group by ts_short;
-- tencent
select ts_short, count(*) from cloud.tencent_regions group by ts_short;
select ts_short, count(*) from cloud.tencent_instances group by ts_short;

select ts_short, count(*) from cloud.tencent_basic_instances group by ts_short;

-- aws
select ts_short, count(*) from cloud.aws_regions group by ts_short;
select ts_short, count(*) from cloud.aws_instances group by ts_short;

select distinct location from cloud.aws_instances where ts_short="2019-09-05";
select distinct Region from cloud.Uniform where ts_short="2019-09-05" and Cloud="AWS";


-- azure
select ts_short, count(*) from cloud.azure_os group by ts_short;
select ts_short, count(*) from cloud.azure_regions group by ts_short;
select ts_short, count(*) from cloud.azure_prices group by ts_short;


-- gcp
select ts_short, count(*) from cloud.gcp_instances group by ts_short;
select ts_short, count(*) from cloud.gcp_cpu_group group by ts_short;
select ts_short, count(*) from cloud.gcp_regions group by ts_short;

-- 最终统计
select Cloud, count(*) from cloud.Uniform where ts_short='2019-09-05' group by Cloud;
select ts_short, count(*) from cloud.Uniform group by ts_short;

select count(*)
from cloud.Uniform
where ts_short="2019-09-05" and Cloud="Azure" and (CPUseries is NULL or GPUseries is NULL or Region is NULL or InstanceType is NULL );

-- Mercari

-- 分析当前批次新增用户
select ts_short, count(1) from mercari.all_user group by ts_short;
alter table mercari.all_user add index ts_short(ts_short);

-- 计算表的验证
select sum(value) from mercari.final_buyer_txn where yearmonth="2019-09"; 
select sum(value) from mercari.final_seller_txn where yearmonth="2019-09"; 

select sum(value) from mercari.us_final_buyer_txn where yearmonth="2019-09"; 
select sum(value) from mercari.us_final_seller_txn where yearmonth="2019-09"; 
select count(*) from mercari.us_final_buyer_txn where yearmonth="2019-09"; 
select count(*) from mercari.us_final_seller_txn where yearmonth="2019-09"; 


