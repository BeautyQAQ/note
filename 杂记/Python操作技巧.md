# 操作

 1. DataFrame做数据处理很快, 但是循环取数很慢, 需要转成dict进行循环取数操作

```python
import pandas as pd

# 字典的值是长度相等的列表
Student_dict = {'姓名':['张三', '李四', '王五', '赵六'],
                '性别':['男', '女', '男', '女'],
                '年龄':[20, 21, 19, 18],
                'Python成绩':[70, 80, 90, 50]}


# 字典创建DataFrame，字典键变DataFrame的列名
df = pd.DataFrame(data=Student_dict)

df.to_dict(orient = 'records')

# 输出
[{'姓名': '张三', '性别': '男', '年龄': 20, 'Python成绩': 70},
 {'姓名': '李四', '性别': '女', '年龄': 21, 'Python成绩': 80},
 {'姓名': '王五', '性别': '男', '年龄': 19, 'Python成绩': 90},
 {'姓名': '赵六', '性别': '女', '年龄': 18, 'Python成绩': 50}]
orient='records'是平时工作中常用的，转换后的形式如下：[{column:value}...{column:value}]，输出结果是一个列表，列表里有多个字典，每个字典都是DataFrame的一行，字典数=DataFrame的行数。字典的键是DataFrame 列名，字典的值是DataFrame值。

orient='index'，转换后字典：{index:{column:value}}
输入：
df.to_dict(orient = 'records')
# 输出：
# [{'姓名': '张三', '性别': '男', '年龄': 20, 'Python成绩': 70},
#  {'姓名': '李四', '性别': '女', '年龄': 21, 'Python成绩': 80},
#  {'姓名': '王五', '性别': '男', '年龄': 19, 'Python成绩': 90},
#  {'姓名': '赵六', '性别': '女', '年龄': 18, 'Python成绩': 50}]
# orient='records'是平时工作中常用的，转换后的形式如下：[{column:value}...{column:value}]，输出结果是一个列表，列表里有多个字典，每个字典都是DataFrame的一行，字典数=DataFrame的行数。字典的键是DataFrame 列名，字典的值是DataFrame值
```

2. DataFrame在做groupBy操作时, 需要添加`as_index=False`参数, 否则会丢失被groupBy的那一列的索引
   
```python
# 对id进行分组并且取每个分组的第一条数据
groupByData = myDataFrame.groupby('ID', as_index=False).first()
```

3. Python操作数据库, 对于多个update语句, 执行时需要添加`cur.execute(sql, multi=True)`参数, 这个方法会返回一个游标, 需要在for循环使用, sql才会生效
   
```python
for result in cur.execute(sql, multi=True):
    pass
```