/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 101.201.142.43:3306
 Source Schema         : how_article

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 20/09/2020 17:09:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_article
-- ----------------------------
DROP TABLE IF EXISTS `tb_article`;
CREATE TABLE `tb_article`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `columnid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专栏ID',
  `userid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章正文',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章封面',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '发表日期',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '修改日期',
  `ispublic` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否公开',
  `istop` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否置顶',
  `visits` int(20) NULL DEFAULT NULL COMMENT '浏览量',
  `thumbup` int(20) NULL DEFAULT NULL COMMENT '点赞数',
  `comment` int(20) NULL DEFAULT NULL COMMENT '评论数',
  `state` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '审核状态',
  `channelid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属频道',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'URL',
  `type` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_article
-- ----------------------------
INSERT INTO `tb_article` VALUES ('1', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('10', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('11', '1', '123', 'test', '房管局规划局法国海军高房价', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 100, 10, 10, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('2', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('3', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('4', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('5', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('6', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('7', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('8', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');
INSERT INTO `tb_article` VALUES ('9', '1', '123', 'test', 'test', 'test', '2020-08-13 15:20:37', '2020-08-13 15:20:40', '1', '1', 1, 1, 1, '1', '1', '1', '1');

-- ----------------------------
-- Table structure for tb_channel
-- ----------------------------
DROP TABLE IF EXISTS `tb_channel`;
CREATE TABLE `tb_channel`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '频道名称',
  `state` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '频道' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_channel
-- ----------------------------
INSERT INTO `tb_channel` VALUES ('1', '测试', '1');

-- ----------------------------
-- Table structure for tb_column
-- ----------------------------
DROP TABLE IF EXISTS `tb_column`;
CREATE TABLE `tb_column`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专栏名称',
  `summary` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专栏简介',
  `userid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '申请日期',
  `checktime` datetime(0) NULL DEFAULT NULL COMMENT '审核日期',
  `state` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '专栏' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_column
-- ----------------------------
INSERT INTO `tb_column` VALUES ('1', 'test', 'test', '123', '2020-08-13 14:46:39', '2020-08-13 14:46:41', '1');

SET FOREIGN_KEY_CHECKS = 1;
