
import urllib.request
import ssl
import json
import datetime
import uuid
from threading import Timer
import cx_Oracle
from apscheduler.schedulers.blocking import BlockingScheduler

import logging
from logging import handlers, log
import traceback

from kafka import KafkaProducer
from kafka.errors import KafkaError

path = 'E:\\test\\log\\'#logging.config.fileConfig(path)
logger = logging.getLogger('test.log')
format_str = logging.Formatter('%(asctime)s - %(pathname)s[line:%(lineno)d] - %(levelname)s: %(message)s')  # 设置日志格式
logger.setLevel(logging.INFO)
sh = logging.StreamHandler()  # 往屏幕上输出
sh.setFormatter(format_str)  # 设置屏幕上显示的格式
th = handlers.TimedRotatingFileHandler(filename=path+ 'test.log', when='MIDNIGHT', backupCount=5,interval=1,encoding='utf-8')  # 往文件里写入#指定间隔时间自动生成文件的处理器
th.suffix = '%Y_%m_%d'
th.setFormatter(format_str)  # 设置文件里写入的格式
logger.addHandler(sh)  # 把对象加到logger里
logger.addHandler(th)

OP_USER = 'system'

#开发库
DataSource = 'xxxxxxxxxxxxx'
#生产库
# DataSource_prd = 'xxxxxxxxxxxxxxxx'
#uat库
# DataSource_uat = 'xxxxxxxxxxxxx'

token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
startDate  = '2020-08-27'
endDate = '2020-08-28'

# DEV
KAFKA_HOST = "xxxxxxxxxxx"

# SIT
# KAFKA_HOST = "xxxxxxxxxxx"

# UAT
# KAFKA_HOST = "xxxxxxxxxxx"

# 生产
# KAFKA_HOST = "xxxxxxxxxxx"

KAFKA_PORT = 9092

# topic 发送kafka
topicName = "TOPIC"

# ----------------------------------------kafka_producer：生产者-------------------------------------------------------------------------------
# 生产模块：根据不同的key，区分消息
class KafkaProducerUtil():

    # 初始化
    def __init__(self, logger):
        logger.info('[KafkaProducerUtil-init]: KafkaProducer-- 开始!')
        try:
            self.kafkaHost = KAFKA_HOST
            self.kafkaPort = KAFKA_PORT
            self.logger = logger
            # 日志
            bootstrap_servers = '{kafka_host}:{kafka_port}'.format(
                kafka_host=self.kafkaHost, kafka_port=self.kafkaPort)
            logger.info("[KafkaProducerUtil-init]: bootstrap_servers-- " +
                        bootstrap_servers)
            self.producer = KafkaProducer(
                bootstrap_servers=[bootstrap_servers])
        except KafkaError as e:
            logger.debug('[KafkaProducerUtil-init]: KafkaProducer-- 异常!')
            logger.debug(e)
        else:
            logger.info('[KafkaProducerUtil-init]: KafkaProducer-- 成功!')
        pass

    # 发送至kafka
    def send_jsondata(self, params, kafkatopic):
        self.logger.info(
            '[KafkaProducerUtil-send_jsondata]: KafkaProducer-- 发送至 kafka 开始!')
        if len(params) == 0:
            self.logger.info(
                '[KafkaProducerUtil-send_jsondata]: KafkaProducer-- 发送至 kafka 未获取到数据，发送至 kafka 失败!'
            )
        else:
            try:
                self.logger.info(
                    "[KafkaProducerUtil-send_jsondata]: kafka topic-- " +
                    kafkatopic)
                producer = self.producer
                parmas_message = json.dumps(params,
                                            indent=4,
                                            sort_keys=False,
                                            ensure_ascii=False)
                self.logger.info(
                    "[KafkaProducerUtil-send_jsondata]: parmas_message-- " +
                    parmas_message)
                v = parmas_message.encode('utf-8')
                # v = bytes(str(params), 'utf-8')
                myUUid = str(uuid.uuid1())
                print(myUUid)
                headers1 = [
                    ('length', b'1115'),
                    # ('bizCode', str.encode('DATA_CHANGE_PYTHON_' + myUUid)),
                    ('id', str.encode(myUUid)),
                    ('spring_json_header_types',
                     b'{"bizCode":"java.lang.String","length":"java.lang.Integer"}'
                     )
                ]
                producer.send(kafkatopic, v, headers=headers1)
                producer.flush()
                self.logger.info(
                    '[KafkaProducerUtil-send_jsondata]: KafkaProducer-- 发送至 kafka 成功! '
                )
            except KafkaError as e:
                self.logger.debug(
                    '[KafkaProducerUtil-send_jsondata]: KafkaProducer-- 发送至 kafka 失败! '
                )
                self.logger.debug(e)

    # 关闭
    def close_kafka(self):
        self.logger.info('[KafkaProducerUtil-close_kafka]: KafkaProducer-- 关闭!')
        self.producer.close()


# kafka 生产类
kafkaProducer = KafkaProducerUtil(logger)

#操作数据
def optionDataKafkaJob():
    try:
        
        #获取今日时间，时间格式为YYYY-MM-DD 
        curry_time =  datetime.datetime.now()

        logger.info('************synchronize data*************')

        #连接数据库
        conn = cx_Oracle.connect(DataSource,encoding='utf8')

        #先拿当天数据
        responseResult  = getYYIssuerRatingData()

        #总条数
        totalCount  = responseResult['total']

        #获取操作时间操作时间
        op_time = curry_time.strftime('%Y-%m-%d %H:%M:%S')

        logger.info(op_time+"开始发送kafka xxxxxxxxxxxxxxxxxx 数据,数据量:"+str(totalCount))

        #更新操作
        updateData(conn, responseResult['rows'])
        
        if len(responseResult['rows']) != 0:
            for temp in responseResult['rows']:
                # 发kafka
                # kafkaMsg = temp.to_json(orient='index')
                jsonMsg = json.loads(json.dumps(temp))
                kafkaProducer.send_jsondata(jsonMsg, topicName)

        logger.info(op_time+"已经发送kafka数据量:"+str(len(responseResult['rows'])))

    except Exception as e:
        traceback.print_exc()
        errorInfo = traceback.format_exc()
        logger.error(errorInfo)
       
    finally:
        conn.close()
        logger.info(op_time+"数据库链接已经关闭")


#变动 (当天)
def getChangeData():
    #每次访问先停1分钟，避免出现429问题
    offset = datetime.timedelta(minutes=1)
    later = (datetime.datetime.now() + offset).strftime('%Y-%m-%d %H:%M:%S')
    while(datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') != later):
        pass

    context = ssl._create_unverified_context()
    url='xxxxxxxxxxxxxxxxxxx?token='+token
    request = urllib.request.Request(url)
    response = urllib.request.urlopen(url=request,context=context)
    responseResult = json.loads(response.read().decode('utf-8'))
    return responseResult


#获取数据库数据
def getDbData(conn,yyList):
    # 修改yyList中的数据
    for temp in yyList:
        querySql = "select * from TABLE where flag = '0' and test = '"+temp['test']+"'"
        queryOp = conn.cursor()
        queryOp.execute(querySql)
        dbData = queryOp.fetchall()

        #获取列名的元组
        colsName = [d[0] for d in queryOp.description]
        #先初始化为空
        temp['a'] = ''
        temp['b'] = ''
        for row in dbData:
            #将两个对象的元素迭代起来
            data = dict(zip(colsName,row))
            if data is not None:
                temp['a'] = data['a']
                temp['b'] = data['b']
        
        queryOp.close()


# 定时任务, 每两小时一次
if __name__ == '__main__':
    # 实例化一个调度器
    # scheduler = BlockingScheduler()
    # scheduler.add_job(aJob, 'interval', hour = '2')
    # 开始运行调度器
    # scheduler.start()
    optionDataKafkaJob()