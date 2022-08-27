/*
 Navicat Premium Data Transfer

 Source Server         : 阿段云
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : 121.196.168.101:3306
 Source Schema         : nacos_config

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 24/02/2021 11:19:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'how-article-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    # url: jdbc:mysql://mysql:3306/how_article?characterEncoding=utf-8\n    url: jdbc:mysql://121.196.168.101:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        # server-addr: nacos:8848\n        server-addr: 121.196.168.101:8848\n\n  redis:\n    # host: redis\n    host: 121.196.168.101\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: commentdb\n\n\n# 101.201.142.43  我的阿里云服务器地址', '33f31d9c4fe89c0b67abdd558a1dd3db', '2021-02-22 08:59:05', '2021-02-24 03:06:02', NULL, '117.136.79.106', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (2, 'how-base-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9001\nspring:\n  application:\n    name: how-base #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_base?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n    generate-ddl: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n', '343b60dd791faa4463a63094cc323a5b', '2021-02-22 08:59:05', '2021-02-23 14:39:37', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (3, 'how-friend-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9010\nspring:\n  application:\n    name: how-friend #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_friend?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show‐sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n\n#开启熔断机制\nfeign:\n  hystrix:\n    enabled: true\n\njwt:\n  config:\n    key: howblog\n\n\n', '76218fa181fbeda2ec41a2a232ea765c', '2021-02-22 08:59:05', '2021-02-23 14:39:58', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (4, 'how-gateway-manager-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9011\n\nspring:\n  application:\n    name: how-gateway-manager #指定服务名\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true #路由小写\n\n      routes:\n        - id: how-gathering\n          uri: lb://how-gathering\n          predicates:\n            - Path=/gathering/** # 路径匹配\n        - id: how-article\n          uri: lb://how-article\n          predicates:\n            - Path=/article/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-base\n          uri: lb://how-base\n          predicates:\n            - Path=/base/** # 路径匹配\n        - id: how-friend\n          uri: lb://how-friend\n          predicates:\n            - Path=/friend/** # 路径匹配\n        - id: how-qa\n          uri: lb://how-qa\n          predicates:\n            - Path=/qa/** # 路径匹配\n        - id: how-spit\n          uri: lb://how-spit\n          predicates:\n            - Path=/spit/** # 路径匹配\n        - id: how-user\n          uri: lb://how-user\n          predicates:\n            - Path=/user/** # 路径匹配\n        - id: how-admin\n          uri: lb://how-user\n          predicates:\n            - Path=/admin/** # 路径匹配\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000\n', '261c047dcd8779524f56141eeb544bd7', '2021-02-22 08:59:05', '2021-02-23 14:40:16', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (5, 'how-gateway-web-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9012\n\nspring:\n  application:\n    name: how-gateway-web #指定服务名\n  cloud:\n    nacos:\n      discovery:\n        # server-addr: nacos:8848\n        server-addr: 121.196.168.101:8848\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true #路由小写\n\n      routes:\n        - id: how-gathering #活动\n          uri: lb://how-gathering\n          predicates:\n            - Path=/gathering/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-article #文章\n          uri: lb://how-article\n          predicates:\n            - Path=/article/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-base #基础\n          uri: lb://how-base\n          predicates:\n            - Path=/base/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-friend #交友\n          uri: lb://how-friend\n          predicates:\n            - Path=/friend/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-qa #问答\n          uri: lb://how-qa\n          predicates:\n            - Path=/qa/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-spit #吐槽\n          uri: lb://how-spit\n          predicates:\n            - Path=/spit/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-user #用户\n          uri: lb://how-user\n          predicates:\n            - Path=/user/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-admin #管理员\n          uri: lb://how-user\n          predicates:\n            - Path=/admin/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-search #搜索\n          uri: lb://how-search\n          predicates:\n            - Path=/search/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000', '45cea53ff265337598a8a5f8370169d5', '2021-02-22 08:59:05', '2021-02-24 02:52:33', NULL, '117.136.79.106', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (6, 'how-gathering-dev.yaml', 'DEFAULT_GROUP', 'server: \n  port: 9005\nspring: \n  application:  \n    name: how-gathering #指定服务名\n  datasource:  \n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_gathering?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa: \n    database: MySQL\n    show-sql: true\n  redis:\n    host: redis\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848', 'cb8a808e81feaa07714caeef6b1d387e', '2021-02-22 08:59:05', '2021-02-23 14:40:56', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (7, 'how-qa-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9003\nspring:\n  application:\n    name: how-qa #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_qa?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n    generate-ddl: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n#开启熔断机制\nfeign:\n  hystrix:\n    enabled: true\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n', '79346c16e5da4b4d35fe1603a0debf99', '2021-02-22 08:59:05', '2021-02-23 14:41:22', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (8, 'how-search-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9007\nspring:\n  application:\n    name: how-search #指定服务名\n  data:\n    elasticsearch:\n      cluster-nodes: 81.70.37.55:9300\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848', 'ce02348d8e4400e340bc8c1cef6b1f62', '2021-02-22 08:59:05', '2021-02-23 14:41:39', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (9, 'how-sms-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9009\nspring:\n  application:\n    name: how-sms #指定服务名\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n\naliyun:\n  sms:\n    template_code: SMS_202805933\n    sign_name: abc博客', '61149b32499fde3df89355a612a66a01', '2021-02-22 08:59:05', '2021-02-24 02:06:09', NULL, '117.136.79.106', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (10, 'how-spit-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9006\n\nspring:\n  application:\n    name: how-spit #指定服务名\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: spitdb\n\n  redis:\n    host: redis\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848', 'a7f181dd59aaa52e02c0df18fac17c7c', '2021-02-22 08:59:05', '2021-02-23 14:42:29', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');
INSERT INTO `config_info` VALUES (11, 'how-user-dev.yaml', 'DEFAULT_GROUP', 'server:\n  port: 9008\nspring:\n  application:  \n    name: how-user #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_user?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa: \n    database: MySQL\n    show-sql: true\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n  redis:\n    host: redis\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000', '58948e282263b21a88d6567db0d73ac6', '2021-02-22 08:59:05', '2021-02-23 14:42:53', NULL, '27.38.244.254', '', '', '', '', '', 'yaml', '');

-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
  `id` bigint UNSIGNED NOT NULL,
  `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
  `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
  INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
  INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------
INSERT INTO `his_config_info` VALUES (0, 1, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9004\r\nspring:\r\n  application:\r\n    name: how-article #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_article?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n\r\n  redis:\r\n    host: 81.70.37.55\r\n  data:\r\n    mongodb:\r\n      host: 81.70.37.55\r\n      database: commentdb\r\n\r\n\r\n# 81.70.37.55  周峰服务器地址', '31663a3d85ca37dbf581730f6181aff3', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 2, 'how-base-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9001\r\nspring:\r\n  application:\r\n    name: how-base #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_base?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n    generate-ddl: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n', 'd3b5b0f7d5927957a08f8b179b7b4b44', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 3, 'how-friend-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9010\r\nspring:\r\n  application:\r\n    name: how-friend #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_friend?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show‐sql: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n\r\n#开启熔断机制\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\njwt:\r\n  config:\r\n    key: howblog\r\n\r\n\r\n', '2026cdc898d05a16b285fb1c6b8064bd', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 4, 'how-gateway-manager-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9011\r\n\r\nspring:\r\n  application:\r\n    name: how-gateway-manager #指定服务名\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true #路由小写\r\n\r\n      routes:\r\n        - id: how-gathering\r\n          uri: lb://how-gathering\r\n          predicates:\r\n            - Path=/gathering/** # 路径匹配\r\n        - id: how-article\r\n          uri: lb://how-article\r\n          predicates:\r\n            - Path=/article/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-base\r\n          uri: lb://how-base\r\n          predicates:\r\n            - Path=/base/** # 路径匹配\r\n        - id: how-friend\r\n          uri: lb://how-friend\r\n          predicates:\r\n            - Path=/friend/** # 路径匹配\r\n        - id: how-qa\r\n          uri: lb://how-qa\r\n          predicates:\r\n            - Path=/qa/** # 路径匹配\r\n        - id: how-spit\r\n          uri: lb://how-spit\r\n          predicates:\r\n            - Path=/spit/** # 路径匹配\r\n        - id: how-user\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/user/** # 路径匹配\r\n        - id: how-admin\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/admin/** # 路径匹配\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000\r\n', 'd5b1b7ea171de24b382d9b6382ede7f2', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 5, 'how-gateway-web-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9012\r\n\r\nspring:\r\n  application:\r\n    name: how-gateway-web #指定服务名\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true #路由小写\r\n\r\n      routes:\r\n        - id: how-gathering #活动\r\n          uri: lb://how-gathering\r\n          predicates:\r\n            - Path=/gathering/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-article #文章\r\n          uri: lb://how-article\r\n          predicates:\r\n            - Path=/article/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-base #基础\r\n          uri: lb://how-base\r\n          predicates:\r\n            - Path=/base/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-friend #交友\r\n          uri: lb://how-friend\r\n          predicates:\r\n            - Path=/friend/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-qa #问答\r\n          uri: lb://how-qa\r\n          predicates:\r\n            - Path=/qa/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-spit #吐槽\r\n          uri: lb://how-spit\r\n          predicates:\r\n            - Path=/spit/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-user #用户\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/user/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-admin #管理员\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/admin/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-search #搜索\r\n          uri: lb://how-search\r\n          predicates:\r\n            - Path=/search/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000', '5809b277679071b2a50a3f3d0a911a81', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 6, 'how-gathering-dev.yaml', 'DEFAULT_GROUP', '', 'server: \r\n  port: 9005\r\nspring: \r\n  application:  \r\n    name: how-gathering #指定服务名\r\n  datasource:  \r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_gathering?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa: \r\n    database: MySQL\r\n    show-sql: true\r\n  redis:\r\n    host: 81.70.37.55\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', 'bef4b6ff0706f8d7b1fbc2f1f33dceaa', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 7, 'how-qa-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9003\r\nspring:\r\n  application:\r\n    name: how-qa #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_qa?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n    generate-ddl: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n#开启熔断机制\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n', 'f6014d55bfc327b90069ec7692675cc6', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 8, 'how-search-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9007\r\nspring:\r\n  application:\r\n    name: how-search #指定服务名\r\n  data:\r\n    elasticsearch:\r\n      cluster-nodes: 81.70.37.55:9300\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', '30f024229247ed80c75e93139bbc42b8', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 9, 'how-sms-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9009\r\nspring:\r\n  application:\r\n    name: how-sms #指定服务名\r\n  rabbitmq:\r\n    host: 81.70.37.55\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: 101.201.142.43:8848', '5bbea80f8eb45f942697d8e3952c3704', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 10, 'how-spit-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9006\r\n\r\nspring:\r\n  application:\r\n    name: how-spit #指定服务名\r\n  data:\r\n    mongodb:\r\n      host: 81.70.37.55\r\n      database: spitdb\r\n\r\n  redis:\r\n    host: 81.70.37.55\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', '40e4044b891440b2704558c5ba40806b', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (0, 11, 'how-user-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9008\r\nspring:\r\n  application:  \r\n    name: how-user #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_user?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa: \r\n    database: MySQL\r\n    show-sql: true\r\n  rabbitmq:\r\n    host: 81.70.37.55\r\n  redis:\r\n    host: 81.70.37.55\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000', 'd4358d2141d846d4e62087af040e448f', '2021-02-22 08:59:05', '2021-02-22 08:59:05', NULL, '117.136.39.80', 'I', '');
INSERT INTO `his_config_info` VALUES (1, 12, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9004\r\nspring:\r\n  application:\r\n    name: how-article #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_article?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n\r\n  redis:\r\n    host: 81.70.37.55\r\n  data:\r\n    mongodb:\r\n      host: 81.70.37.55\r\n      database: commentdb\r\n\r\n\r\n# 81.70.37.55  周峰服务器地址', '31663a3d85ca37dbf581730f6181aff3', '2021-02-22 09:00:41', '2021-02-22 09:00:42', NULL, '117.136.39.80', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 13, 'how-sms-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9009\r\nspring:\r\n  application:\r\n    name: how-sms #指定服务名\r\n  rabbitmq:\r\n    host: 81.70.37.55\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: 101.201.142.43:8848', '5bbea80f8eb45f942697d8e3952c3704', '2021-02-22 10:00:19', '2021-02-22 10:00:19', NULL, '117.136.39.80', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 14, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: localhost:8848\n\n  redis:\n    host: 127.0.0.1\n  data:\n    mongodb:\n      host: 81.70.37.55\n      database: commentdb\n\n\n# 81.70.37.55  周峰服务器地址', '1d421040638d671556403481ca0a13a1', '2021-02-23 01:57:12', '2021-02-23 01:57:13', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 15, 'how-base-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9001\r\nspring:\r\n  application:\r\n    name: how-base #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_base?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n    generate-ddl: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n', 'd3b5b0f7d5927957a08f8b179b7b4b44', '2021-02-23 01:57:57', '2021-02-23 01:57:57', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (3, 16, 'how-friend-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9010\r\nspring:\r\n  application:\r\n    name: how-friend #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_friend?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show‐sql: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n\r\n#开启熔断机制\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\njwt:\r\n  config:\r\n    key: howblog\r\n\r\n\r\n', '2026cdc898d05a16b285fb1c6b8064bd', '2021-02-23 01:58:28', '2021-02-23 01:58:28', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 17, 'how-gateway-manager-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9011\r\n\r\nspring:\r\n  application:\r\n    name: how-gateway-manager #指定服务名\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true #路由小写\r\n\r\n      routes:\r\n        - id: how-gathering\r\n          uri: lb://how-gathering\r\n          predicates:\r\n            - Path=/gathering/** # 路径匹配\r\n        - id: how-article\r\n          uri: lb://how-article\r\n          predicates:\r\n            - Path=/article/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-base\r\n          uri: lb://how-base\r\n          predicates:\r\n            - Path=/base/** # 路径匹配\r\n        - id: how-friend\r\n          uri: lb://how-friend\r\n          predicates:\r\n            - Path=/friend/** # 路径匹配\r\n        - id: how-qa\r\n          uri: lb://how-qa\r\n          predicates:\r\n            - Path=/qa/** # 路径匹配\r\n        - id: how-spit\r\n          uri: lb://how-spit\r\n          predicates:\r\n            - Path=/spit/** # 路径匹配\r\n        - id: how-user\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/user/** # 路径匹配\r\n        - id: how-admin\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/admin/** # 路径匹配\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000\r\n', 'd5b1b7ea171de24b382d9b6382ede7f2', '2021-02-23 01:58:53', '2021-02-23 01:58:54', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 18, 'how-gateway-web-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9012\r\n\r\nspring:\r\n  application:\r\n    name: how-gateway-web #指定服务名\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          enabled: true\r\n          lower-case-service-id: true #路由小写\r\n\r\n      routes:\r\n        - id: how-gathering #活动\r\n          uri: lb://how-gathering\r\n          predicates:\r\n            - Path=/gathering/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-article #文章\r\n          uri: lb://how-article\r\n          predicates:\r\n            - Path=/article/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-base #基础\r\n          uri: lb://how-base\r\n          predicates:\r\n            - Path=/base/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-friend #交友\r\n          uri: lb://how-friend\r\n          predicates:\r\n            - Path=/friend/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-qa #问答\r\n          uri: lb://how-qa\r\n          predicates:\r\n            - Path=/qa/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-spit #吐槽\r\n          uri: lb://how-spit\r\n          predicates:\r\n            - Path=/spit/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-user #用户\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/user/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-admin #管理员\r\n          uri: lb://how-user\r\n          predicates:\r\n            - Path=/admin/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n        - id: how-search #搜索\r\n          uri: lb://how-search\r\n          predicates:\r\n            - Path=/search/** # 路径匹配\r\n          filters:\r\n            - SwaggerHeaderFilter  #指定filter\r\n            - StripPrefix=1\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000', '5809b277679071b2a50a3f3d0a911a81', '2021-02-23 01:59:12', '2021-02-23 01:59:13', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 19, 'how-gathering-dev.yaml', 'DEFAULT_GROUP', '', 'server: \r\n  port: 9005\r\nspring: \r\n  application:  \r\n    name: how-gathering #指定服务名\r\n  datasource:  \r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_gathering?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa: \r\n    database: MySQL\r\n    show-sql: true\r\n  redis:\r\n    host: 81.70.37.55\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', 'bef4b6ff0706f8d7b1fbc2f1f33dceaa', '2021-02-23 01:59:40', '2021-02-23 01:59:40', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 20, 'how-qa-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9003\r\nspring:\r\n  application:\r\n    name: how-qa #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_qa?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa:\r\n    database: MySQL\r\n    show-sql: true\r\n    generate-ddl: true\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\n#开启熔断机制\r\nfeign:\r\n  hystrix:\r\n    enabled: true\r\n\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n', 'f6014d55bfc327b90069ec7692675cc6', '2021-02-23 02:00:09', '2021-02-23 02:00:10', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (8, 21, 'how-search-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9007\r\nspring:\r\n  application:\r\n    name: how-search #指定服务名\r\n  data:\r\n    elasticsearch:\r\n      cluster-nodes: 81.70.37.55:9300\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', '30f024229247ed80c75e93139bbc42b8', '2021-02-23 02:00:36', '2021-02-23 02:00:36', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 22, 'how-sms-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9009\nspring:\n  application:\n    name: how-sms #指定服务名\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848', 'be2c0463f9e9b20b25a5f26bc1f40150', '2021-02-23 02:01:05', '2021-02-23 02:01:06', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (10, 23, 'how-spit-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9006\r\n\r\nspring:\r\n  application:\r\n    name: how-spit #指定服务名\r\n  data:\r\n    mongodb:\r\n      host: 81.70.37.55\r\n      database: spitdb\r\n\r\n  redis:\r\n    host: 81.70.37.55\r\n\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848', '40e4044b891440b2704558c5ba40806b', '2021-02-23 02:01:40', '2021-02-23 02:01:40', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 24, 'how-user-dev.yaml', 'DEFAULT_GROUP', '', 'server:\r\n  port: 9008\r\nspring:\r\n  application:  \r\n    name: how-user #指定服务名\r\n  datasource:\r\n    driverClassName: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://101.201.142.43:3306/how_user?characterEncoding=utf-8\r\n    username: root\r\n    password: root\r\n  jpa: \r\n    database: MySQL\r\n    show-sql: true\r\n  rabbitmq:\r\n    host: 81.70.37.55\r\n  redis:\r\n    host: 81.70.37.55\r\n  # nacos服务地址\r\n  cloud:\r\n    nacos:\r\n      discovery:\r\n        server-addr: localhost:8848\r\njwt:\r\n  config:\r\n    key: howblog  #注意这个key不能太短\r\n    ttl: 360000', 'd4358d2141d846d4e62087af040e448f', '2021-02-23 02:02:55', '2021-02-23 02:02:55', NULL, '117.136.79.134', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 25, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: localhost:8848\n\n  redis:\n    host: 127.0.0.1\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: commentdb\n\n\n# 101.201.142.43  我的阿里云服务器地址', '0d1b2c2428dc977e357c915ef5f8adc6', '2021-02-23 13:46:02', '2021-02-23 13:46:02', NULL, '27.38.232.76', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 26, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n\n  redis:\n    host: 127.0.0.1\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: commentdb\n\n\n# 101.201.142.43  我的阿里云服务器地址', 'a8058664a2e6243f3c431cf26fad78dc', '2021-02-23 13:48:37', '2021-02-23 13:48:38', NULL, '27.38.232.34', 'U', '');
INSERT INTO `his_config_info` VALUES (2, 27, 'how-base-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9001\nspring:\n  application:\n    name: how-base #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_base?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n    generate-ddl: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\n', 'e65a6c9376265e5487b5b47a7a3b38fc', '2021-02-23 14:39:37', '2021-02-23 14:39:37', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (3, 28, 'how-friend-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9010\nspring:\n  application:\n    name: how-friend #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_friend?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show‐sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\n\n#开启熔断机制\nfeign:\n  hystrix:\n    enabled: true\n\njwt:\n  config:\n    key: howblog\n\n\n', 'f06c09e22e912113478fa4be7edb38d9', '2021-02-23 14:39:57', '2021-02-23 14:39:58', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (4, 29, 'how-gateway-manager-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9011\n\nspring:\n  application:\n    name: how-gateway-manager #指定服务名\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true #路由小写\n\n      routes:\n        - id: how-gathering\n          uri: lb://how-gathering\n          predicates:\n            - Path=/gathering/** # 路径匹配\n        - id: how-article\n          uri: lb://how-article\n          predicates:\n            - Path=/article/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-base\n          uri: lb://how-base\n          predicates:\n            - Path=/base/** # 路径匹配\n        - id: how-friend\n          uri: lb://how-friend\n          predicates:\n            - Path=/friend/** # 路径匹配\n        - id: how-qa\n          uri: lb://how-qa\n          predicates:\n            - Path=/qa/** # 路径匹配\n        - id: how-spit\n          uri: lb://how-spit\n          predicates:\n            - Path=/spit/** # 路径匹配\n        - id: how-user\n          uri: lb://how-user\n          predicates:\n            - Path=/user/** # 路径匹配\n        - id: how-admin\n          uri: lb://how-user\n          predicates:\n            - Path=/admin/** # 路径匹配\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000\n', '80deb400c3b7ffde86cdf1b37aa09e04', '2021-02-23 14:40:15', '2021-02-23 14:40:16', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 30, 'how-gateway-web-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9012\n\nspring:\n  application:\n    name: how-gateway-web #指定服务名\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true #路由小写\n\n      routes:\n        - id: how-gathering #活动\n          uri: lb://how-gathering\n          predicates:\n            - Path=/gathering/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-article #文章\n          uri: lb://how-article\n          predicates:\n            - Path=/article/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-base #基础\n          uri: lb://how-base\n          predicates:\n            - Path=/base/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-friend #交友\n          uri: lb://how-friend\n          predicates:\n            - Path=/friend/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-qa #问答\n          uri: lb://how-qa\n          predicates:\n            - Path=/qa/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-spit #吐槽\n          uri: lb://how-spit\n          predicates:\n            - Path=/spit/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-user #用户\n          uri: lb://how-user\n          predicates:\n            - Path=/user/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-admin #管理员\n          uri: lb://how-user\n          predicates:\n            - Path=/admin/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-search #搜索\n          uri: lb://how-search\n          predicates:\n            - Path=/search/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000', 'a8a6e926c71d0c6aa34d9e81bf04a4e9', '2021-02-23 14:40:29', '2021-02-23 14:40:30', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (6, 31, 'how-gathering-dev.yaml', 'DEFAULT_GROUP', '', 'server: \n  port: 9005\nspring: \n  application:  \n    name: how-gathering #指定服务名\n  datasource:  \n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_gathering?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa: \n    database: MySQL\n    show-sql: true\n  redis:\n    host: 127.0.0.1\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848', '9f0440cd8be38a4b459db047bb40a49f', '2021-02-23 14:40:56', '2021-02-23 14:40:56', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (7, 32, 'how-qa-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9003\nspring:\n  application:\n    name: how-qa #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_qa?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n    generate-ddl: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\n#开启熔断机制\nfeign:\n  hystrix:\n    enabled: true\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n', 'e852c17f5bff64911ab16dde4ff3011e', '2021-02-23 14:41:21', '2021-02-23 14:41:22', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (8, 33, 'how-search-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9007\nspring:\n  application:\n    name: how-search #指定服务名\n  data:\n    elasticsearch:\n      cluster-nodes: 81.70.37.55:9300\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848', 'de4216aa3f534870802a650b8663f98c', '2021-02-23 14:41:38', '2021-02-23 14:41:39', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 34, 'how-sms-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9009\nspring:\n  application:\n    name: how-sms #指定服务名\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848', 'be2c0463f9e9b20b25a5f26bc1f40150', '2021-02-23 14:41:53', '2021-02-23 14:41:54', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (10, 35, 'how-spit-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9006\n\nspring:\n  application:\n    name: how-spit #指定服务名\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: spitdb\n\n  redis:\n    host: 127.0.0.1\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848', '1abbf17cd99a1eca66d6086e7cd0e4f0', '2021-02-23 14:42:28', '2021-02-23 14:42:29', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (11, 36, 'how-user-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9008\nspring:\n  application:  \n    name: how-user #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://127.0.0.1:3306/how_user?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa: \n    database: MySQL\n    show-sql: true\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n  redis:\n    host: 127.0.0.1\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: 127.0.0.1:8848\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000', 'ce9012b7f4a144f4928eedb960744d94', '2021-02-23 14:42:53', '2021-02-23 14:42:53', NULL, '27.38.244.254', 'U', '');
INSERT INTO `his_config_info` VALUES (9, 37, 'how-sms-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9009\nspring:\n  application:\n    name: how-sms #指定服务名\n  rabbitmq:\n    host: 101.201.142.43\n    username: guest\n    password: guest\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848', '3452394d9d774449d046187984900a73', '2021-02-24 02:06:09', '2021-02-24 02:06:09', NULL, '117.136.79.106', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 38, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n\n  redis:\n    host: redis\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: commentdb\n\n\n# 101.201.142.43  我的阿里云服务器地址', '8a93180f0c12b0a0206ec52def467219', '2021-02-24 02:52:19', '2021-02-24 02:52:20', NULL, '117.136.79.106', 'U', '');
INSERT INTO `his_config_info` VALUES (5, 39, 'how-gateway-web-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9012\n\nspring:\n  application:\n    name: how-gateway-web #指定服务名\n  cloud:\n    nacos:\n      discovery:\n        server-addr: nacos:8848\n    gateway:\n      discovery:\n        locator:\n          enabled: true\n          lower-case-service-id: true #路由小写\n\n      routes:\n        - id: how-gathering #活动\n          uri: lb://how-gathering\n          predicates:\n            - Path=/gathering/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-article #文章\n          uri: lb://how-article\n          predicates:\n            - Path=/article/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-base #基础\n          uri: lb://how-base\n          predicates:\n            - Path=/base/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-friend #交友\n          uri: lb://how-friend\n          predicates:\n            - Path=/friend/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-qa #问答\n          uri: lb://how-qa\n          predicates:\n            - Path=/qa/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-spit #吐槽\n          uri: lb://how-spit\n          predicates:\n            - Path=/spit/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-user #用户\n          uri: lb://how-user\n          predicates:\n            - Path=/user/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-admin #管理员\n          uri: lb://how-user\n          predicates:\n            - Path=/admin/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n        - id: how-search #搜索\n          uri: lb://how-search\n          predicates:\n            - Path=/search/** # 路径匹配\n          filters:\n            - SwaggerHeaderFilter  #指定filter\n            - StripPrefix=1\n\njwt:\n  config:\n    key: howblog  #注意这个key不能太短\n    ttl: 360000', '492e642de7b1d459d6a58ab392c7ccb0', '2021-02-24 02:52:33', '2021-02-24 02:52:33', NULL, '117.136.79.106', 'U', '');
INSERT INTO `his_config_info` VALUES (1, 40, 'how-article-dev.yaml', 'DEFAULT_GROUP', '', 'server:\n  port: 9004\nspring:\n  application:\n    name: how-article #指定服务名\n  datasource:\n    driverClassName: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://mysql:3306/how_article?characterEncoding=utf-8\n    username: root\n    password: root\n  jpa:\n    database: MySQL\n    show-sql: true\n\n  # nacos服务地址\n  cloud:\n    nacos:\n      discovery:\n        # server-addr: nacos:8848\n        server-addr: 121.196.168.101:8848\n\n  redis:\n    host: redis\n  data:\n    mongodb:\n      host: 101.201.142.43\n      database: commentdb\n\n\n# 101.201.142.43  我的阿里云服务器地址', 'ad2ae007a6b86f6df5d7e70b0439efb2', '2021-02-24 03:06:01', '2021-02-24 03:06:02', NULL, '117.136.79.106', 'U', '');

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
  `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
  `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
  `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
  INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
