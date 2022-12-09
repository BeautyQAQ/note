#!/usr/bin/env python3.10.0
# -*- coding: utf-8 -*-
"""
@Description : 数据插入
"""
__author__ = 'xxxx'

import os
import sys
import time


sys.path.append(os.getcwd())
sys.path.append(os.path.join(os.getcwd(), ".."))
from util.logs_utils import logger
from util.snowflake import get_id
from handler import BaseHandler
from datetime import datetime


class a(BaseHandler):

    def __init__(self):
        super().__init__('aaaa')

    def handling_aaaa(self):
        sdt = datetime.now()
        logger.info(f"开始同步数据, 执行开始时间：{sdt}")
        num = 0
        retry = 1
        page_size = 1000
        while retry:
            try:
                t_data = self.fetch_t_bo_data()
                if not t_data.empty:
                    once_num = len(t_data)
                    logger.info(f"同步数据, 表查询出{once_num}条数据")
                    # 对t_data数据进行group by处理
                    first_records = t_data.groupby('a', as_index=False).first()
                    # 分页持久化这个数据到t_ml_sec表
                    first_records_num = len(first_records)
                    logger.info(f"同步数据, 经过group by处理后出还有{first_records_num}条数据")
                    # 每次1000条同步
                    # 计算总页数
                    num_pages = first_records_num // page_size
                    if first_records_num % page_size > 0:
                        num_pages += 1
                    try:
                        cnx = self.db.get_cnx()
                        for i in range(num_pages):
                            # 计算分页的起始和结束位置
                            start = i * page_size
                            end = min((i + 1) * page_size, first_records_num)
                            # 将数据分页
                            page_data = first_records[start:end]
                            sql = f"""
                                INSERT INTO T_ML_SEC (a, b, c, d, e, f, g,
                                                  h, i, j, k, l, m,
                                                  n, o)
                                VALUES
                                """
                            # 修改id
                            for index in page_data.index:
                                time.sleep(0.001)
                                page_data.loc[index, 'a'] = snowflake.get_id()
                                sql += "("+self.strDefault(page_data.loc[index, 'a'])+","+self.strDefault(page_data.loc[index,'b'])+",'"+self.strDefault(page_data.loc[index,'c'])+"','"+self.strDefault(page_data.loc[index,'d'])+"','"+self.strDefault(page_data.loc[index,'e'])+"','"+self.strDefault(page_data.loc[index,'F'])+"',"+self.strDefault(page_data.loc[index,'g'])+",'"+self.strDefault(page_data.loc[index,'h'])+"','"+self.strDefault(page_data.loc[index,'i'])+"',"+"'1970-01-01 00:00:00',"+"'2999-12-31 23:59:59',"+self.strDefault2(page_data.loc[index,'l'])+",now(),"+self.strDefault2(page_data.loc[index,'n'])+",now()),"
                            # 将最后一个逗号换为分号
                            new_sql = sql[:len(sql)-1] + ";"
                            # logger.info(f"执行的sql={new_sql}")
                            # 执行sql
                            self.biz_db.execute_uncommit(cnx, new_sql)
                            logger.info(f"执行了第{i}页")
                            # 提取需要插入的列
                            # insert_data = page_data[['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k']]
                            # logger.info(insert_data)
                            # sql = f"""
                            #     INSERT INTO T_ML_SEC (a, b, c, d, e, f, g,
                            #                       h, i, j, k, l, m,
                            #                       n, o)
                            #     VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s,
                            #              '1970-01-01 00:00:00', '2999-12-31 23:59:59', %s, NOW(), %s, NOW())
                            #     """
                            
                            # cnx = self.db.get_cnx()
                            # # 持久化表数据
                            # self.db.execute_uncommit(cnx, sql, insert_data.values.tolist())
                        if cnx:
                            cnx.commit()   
                    except Exception as err:
                        logger.error(f"持久化表数据!err = {err}")
                        if cnx:
                            cnx.rollback()
                        raise Exception("持久化表数据失败")
                    finally:
                        if cnx:
                            cnx.close()
                    
                    edt = datetime.now()
                    logger.info(f"完成同步持久化表数据,本次更新数量:{first_records_num}, 执行结束时间：{edt},本次耗时时间: {(edt - sdt).seconds}s")
                    # 结束while
                    break
                else:
                    edt = datetime.now()
                    logger.info(f"完成持久化表数据,本次更新数量:{num}, 执行结束时间：{edt},本次耗时时间: {(edt - sdt).seconds}s")
                    return
            except Exception as err:
                retry -= 1
                logger.error(f"同步持久化表数据, 进行失败重试,ex={err}")
                if not retry:
                    raise err

    def fetch_t_bo_data(self):
        """
        1. 从数据库中取数据
        2. order by start_dt desc
        :return:
        """
        data_source = 'x'
        sql = f"""
            SELECT a,
                   b,
                   c,
                   d,
                   e,
                   f,
                   g,
                   h,
                   i,
                   j,
                   k,
                   l,
                   m,
                   n,
                   o
            FROM x T
            ORDER BY T.START_DT DESC
        """
        return self.fetch_data(data_source, sql)

    def biz_db_persist_table_ml_sec(self, data_list):
        """
        # 持久化表数据
        :param data_list:
        :return:
        """
        if data_list.empty:
            return
        sql = f"""
              INSERT INTO xxxxx (a, b, c, d, e, f, g,
                                                h, i, j, k, l, m,
                                                n, o)
              VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s,
                      '1970-01-01 00:00:00', '2999-12-31 23:59:59', %s, now(), %s, now())
        """
        cnx = None
        try:
            cnx = self.db.get_cnx()
            # 持久化表数据
            self.db.execute_uncommit(cnx, sql, data_list.values.tolist())
            if cnx:
                cnx.commit()
        except Exception as err:
            logger.error(f"持久化表数据!err = {err}")
            if cnx:
                cnx.rollback()
        finally:
            if cnx:
                cnx.close()

    def strDefault(self, string):
        if string is not None:
            return str(string)
        else:
            return ""

    def strDefault2(self, string):
        if string is not None:
            return str(string)
        else:
            return "null"

if __name__ == '__main__':
    aaaaa().run()
