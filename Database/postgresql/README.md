# Postgresql

[TOC]

## 1. 相关

1. greenplum
2. redshift

## 2. 常用语法

1. 建表
   1. 去重和类型转换

        ```sql
        insert into dw_app_sku
        select distinct on (sku_id)
        sku_id,seller_id,buyer_id,status,price::float8,  -- 类型转换
        substring(updated,1,7) as updated,substring(created,1,7) as created ,batch_id
        from ods_mercari_app_sku
        order by sku_id, batch_id desc;
        ```

   2. 权限分配

        ```sql
        grant usage on schema aspex_mercari to data_loader;
        grant all on aspex_mercari.ods_mercari_app_sku to data_loader;
        grant select, insert on aspex_mercari.ods_mercari_app_user to data_loader;
        ```

   3. 创建语句

        ```sql
        CREATE TABLE public.final_buyer_txn (
        id serial8 NOT NULL , -- 自增id
        user_id text,
        create_date text,
        create_month text,
        create_quarter text,
        yearmonth text,
        sku int8,    -- price float8,
        value int8,
        update_date text
        )WITH (APPENDONLY=TRUE, ORIENTATION=column, compresstype=ZLIB)
        DISTRIBUTED BY (user_id);
        ```

   4. 分区表

        ```sql
        CREATE TABLE aspex_mercari.ods_mercari_app_sku
        (
        sku_id text
        , seller_id text
        , buyer_id text
        , status text
        , price text
        , updated text
        , created text
        , batch_id date
        )
        WITH (APPENDONLY=TRUE, ORIENTATION=column, compresstype=ZLIB)
        DISTRIBUTED BY (seller_id)
        PARTITION BY RANGE (batch_id)
        ( START (date '2019-01-01') INCLUSIVE
        END (date '2021-01-01') EXCLUSIVE
        EVERY (INTERVAL '1 day'));
        ```

   5. 计算

        ```sql
        select 
        seller_id,ff.create_date::text, ff.create_month, ff.create_quarter,
        '2019-11-01',
        count(*)filter(where substring(tt0.created, 1, 7) = '2019-11') as sku_new,
        count(*)filter(where substring(tt0.created, 1, 7) <> '2019-11' and substring(tt0.updated, 1, 7) = '2019-11') as sku_update, 
        sum(price::int)filter(where substring(tt0.created, 1, 7) = '2019-11') as value_new,
        sum(price::int)filter(where substring(tt0.created, 1, 7) <> '2019-11' and substring(tt0.updated, 1, 7) = '2019-11') as value_update,
        num_sell_items, 0,'2019-11-19'
        from aspex_mercari.ods_mercari_app_sku tt0
        left join aspex_mercari.ods_mercari_app_user tt1
        on tt0.seller_id = tt1.user_id
        left join aspex_mercari.app_user_info ff
        on tt0.seller_id=ff.user_id 
        where tt1.batch_id='2019-11-01'
        group by seller_id, num_sell_items , ff.create_date, ff.create_month, ff.create_quarter;
        ```

   6. 类型判断

        ```sql
        set num_sell_items = decode(aaa.now_sell_items, '', '0', aaa.now_sell_items)::int - decode(bbb.now_sell_items, '', '0', bbb.now_sell_items)::int
        ```

## 3. 权限管理

information_schema.table_privileges表记录着所有用户的权限信息。

1. 查看权限

2. 修改权限
