# 删除mysql部分数据的记录
因为mysql空间有限, 又因为传输程序需要核对传输前后的行数和id, 所以需要删除历史数据的同时, 将改动记录保留, 然后传输程序在传输时将这部分添加, 确保和客户数据库条数一致

1. 内容存在tmp_table_history
2. 
    id|db_name|tb_name |last_id  |rows_number|
    --|-------|--------|---------|-----------|
    1|mercari|app_user|198924347|195287127  |
3. 说明
    1. last_id 已删数的最后一个id
    2. rows_number  删掉的总数
    3. SELECT count(*), max(id) FROM mercari.us_sku where batch_id <='2020-11-02', 可得出last_id和rows_number
    4. 执行删除操作之后需要释放空间 optimize table mercari.app_user;
4. 记录
    1. 2020-04
        id|db_name|tb_name |last_id  |rows_number|
        --|-------|--------|---------|-----------|
        1|mercari|app_user|198924347|195287127  |
    2. 2020-09-02操作
        id  |db_name    |tb_name    |last_id    |rows_number    |notes  |
        --  |--         |--         |--         |--             |--     |       
        1   |xiaohongshu    |notes_by_good  |36762945    |22958306  |2020-04-09及之前
        2   |mercari        |app_user       |285699126    |86774779  |2020-07-02之前 
    3. 2020-12-28操作
        id  |db_name    |tb_name    |last_id    |rows_number    |notes  |
        --  |--         |--         |--         |--             |--     |       
        1   |mercari    |us_sku  |425021339    |206232864  |where batch_id <="2020-11-02"
        2   |Jobs    |zhilian_job  |241598823    |155866603  |where ts_short <="2020-11-19"
