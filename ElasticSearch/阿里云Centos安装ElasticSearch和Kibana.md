# 阿里云Centos安装ElasticSearch和Kibana

## 机器

阿里云1核2G学生机，阿里云高效云盘————注意以后购买机器要选择SSD，高效云盘是机械硬盘，性能只有SSD的一半

## 前置设置

由于是学生机，性能较差，内存较低，需要做一些设置

```shell
vim /etc/sysctl.conf 
# 添加如下配置
vm.max_map_count=655360
# 使配置生效
sysctl -p
# 重启 docker，让内核参数对docker服务生效
systemctl restart docker
```

提前创建目录结构，如下
```shell
es/
  /data
  /logs
  /plugins
   --es.yml
   --cerebro.yml
   --kibana.yml
```

## docker-compose安装elk

手动创建docker网络
```shell
docker network create elk
```

es.yml内容
```yml
# es.yml
version: '3.2'
services:
  elasticsearch:
    image: elasticsearch:7.8.0
    container_name: elk-es
    restart: always
    environment:
      # 开启内存锁定
      - bootstrap.memory_lock=true
      - "ES_JAVA_OPTS=-Xms256m -Xmx256m"
      # 指定单节点启动
      - discovery.type=single-node
      # 挂载权限问题
      - TAKE_FILE_OWNERSHIP=true
    ulimits:
      # 取消内存相关限制  用于开启内存锁定
      memlock:
        soft: -1
        hard: -1
    volumes:
      - ./data:/usr/share/elasticsearch/data
      - ./logs:/usr/share/elasticsearch/logs
      - ./plugins:/usr/share/elasticsearch/plugins
    ports:
      - 9200:9200

networks:
  default:
    external:
      name: how
```

启动前先安装IK分词器
```shell
wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.8.0/elasticsearch-analysis-ik-7.8.0.zip
```
下载后解压到plugins文件夹，重命名为IK，然后启动es

启动命令
```shell
docker-compose -f es.yml up -d
```

kibana.yml内容
```yml
# kibana.yml
version: '3.2'
services:
  kibana:
    image: kibana:7.8.0
    container_name: elk-kibana
    restart: always
    environment:
      ELASTICSEARCH_HOSTS: http://elk-es:9200
      I18N_LOCALE: zh-CN
    ports:
      - 5601:5601

networks:
  default:
    external:
      name: how
```

启动命令
```shell
docker-compose -f kibana.yml up -d
```

访问ip:5601--------记得开放阿里云防火墙

## 测试

在 Kibana 中通过 Dev Tools 可以方便的执行各种操作。
```shell
#ik_max_word 会将文本做最细粒度的拆分
#ik_smart 会做最粗粒度的拆分
#pinyin 拼音
POST _analyze
{
  "analyzer": "ik_max_word",
  "text": ["剑桥分析公司多位高管对卧底记者说，他们确保了唐纳德·特朗普在总统大选中获胜"]
} 
```