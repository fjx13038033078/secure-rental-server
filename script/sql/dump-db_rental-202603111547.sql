-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: db_rental
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bus_car`
--

DROP TABLE IF EXISTS `bus_car`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_car` (
  `car_id` bigint NOT NULL AUTO_INCREMENT COMMENT '车辆ID',
  `plate_number` varchar(20) NOT NULL COMMENT '车牌号',
  `brand_model` varchar(100) NOT NULL COMMENT '品牌与车型(如：丰田卡罗拉)',
  `car_image_url` varchar(500) DEFAULT NULL COMMENT '车辆主图(存储MinIO返回的OSS链接)',
  `daily_rate` decimal(10,2) NOT NULL COMMENT '日租金(元)',
  `car_status` char(1) DEFAULT '0' COMMENT '车辆状态(0待租 1已租出 2维护中)',
  `create_time` datetime DEFAULT NULL COMMENT '入库时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`car_id`),
  UNIQUE KEY `uk_plate` (`plate_number`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='车辆信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_car`
--

LOCK TABLES `bus_car` WRITE;
/*!40000 ALTER TABLE `bus_car` DISABLE KEYS */;
INSERT INTO `bus_car` VALUES (1,'浙A9335V','雷克萨斯','',100.00,'1','2026-03-11 11:10:02',103,1,1,'2026-03-11 11:21:44');
/*!40000 ALTER TABLE `bus_car` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_customer`
--

DROP TABLE IF EXISTS `bus_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_customer` (
  `customer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '客户ID',
  `customer_name` varchar(50) NOT NULL COMMENT '客户真实姓名',
  `phone` varchar(255) NOT NULL COMMENT '手机号码(需AES加密存储)',
  `id_card` varchar(255) NOT NULL COMMENT '身份证号(需AES加密存储)',
  `account_status` char(1) DEFAULT '0' COMMENT '账号状态(0正常 1冻结)',
  `create_time` datetime DEFAULT NULL COMMENT '注册时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='客户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_customer`
--

LOCK TABLES `bus_customer` WRITE;
/*!40000 ALTER TABLE `bus_customer` DISABLE KEYS */;
INSERT INTO `bus_customer` VALUES (1,'李四','jndXI+Kl01ek17FfRe3LmM1JYL+CGdWmV6DN5zRsi506zLLbc6/m','ZyjmK6+j4IpKcHo0pBkPo0jr5MqugWthzvPmyjNKT/qpAZuAwjQrQQ3YtYAcHw==','0','2026-03-11 11:12:29',103,1,1,'2026-03-11 11:12:29');
/*!40000 ALTER TABLE `bus_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bus_rental_order`
--

DROP TABLE IF EXISTS `bus_rental_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bus_rental_order` (
  `order_id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(64) NOT NULL COMMENT '订单流水号',
  `customer_id` bigint NOT NULL COMMENT '租车客户ID',
  `car_id` bigint NOT NULL COMMENT '租赁车辆ID',
  `rent_start_date` date NOT NULL COMMENT '起租日期',
  `rent_end_date` date NOT NULL COMMENT '预计还车日期',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '订单总金额',
  `order_status` char(1) DEFAULT '0' COMMENT '订单状态(0租用中 1已还车 2已取消)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租赁订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bus_rental_order`
--

LOCK TABLES `bus_rental_order` WRITE;
/*!40000 ALTER TABLE `bus_rental_order` DISABLE KEYS */;
INSERT INTO `bus_rental_order` VALUES (1,'RO2031571245732577280',1,1,'2026-03-10','2026-03-26',1700.00,'0','2026-03-11 11:21:44',103,1,1,'2026-03-11 11:21:44');
/*!40000 ALTER TABLE `bus_rental_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table`
--

DROP TABLE IF EXISTS `gen_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL COMMENT '编号',
  `data_name` varchar(200) DEFAULT '' COMMENT '数据源名称',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table`
--

LOCK TABLES `gen_table` WRITE;
/*!40000 ALTER TABLE `gen_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gen_table_column`
--

DROP TABLE IF EXISTS `gen_table_column`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gen_table_column`
--

LOCK TABLES `gen_table_column` WRITE;
/*!40000 ALTER TABLE `gen_table_column` DISABLE KEYS */;
/*!40000 ALTER TABLE `gen_table_column` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_client`
--

DROP TABLE IF EXISTS `sys_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_client` (
  `id` bigint NOT NULL COMMENT 'id',
  `client_id` varchar(64) DEFAULT NULL COMMENT '客户端id',
  `client_key` varchar(32) DEFAULT NULL COMMENT '客户端key',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端秘钥',
  `grant_type` varchar(255) DEFAULT NULL COMMENT '授权类型',
  `device_type` varchar(32) DEFAULT NULL COMMENT '设备类型',
  `active_timeout` int DEFAULT '1800' COMMENT 'token活跃超时时间',
  `timeout` int DEFAULT '604800' COMMENT 'token固定超时',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统授权表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_client`
--

LOCK TABLES `sys_client` WRITE;
/*!40000 ALTER TABLE `sys_client` DISABLE KEYS */;
INSERT INTO `sys_client` VALUES (1,'e5cd7e4891bf95d1d19206ce24a7b32e','pc','pc123','password,social','pc',1800,604800,'0','0',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55'),(2,'428a8310cd442757ae699df5d894f051','app','app123','password,sms,social','android',1800,604800,'0','0',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55');
/*!40000 ALTER TABLE `sys_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='参数配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'000000','主框架页-默认皮肤样式名称','sys.index.skinName','skin-blue','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow'),(2,'000000','用户管理-账号初始密码','sys.user.initPassword','123456','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'初始化密码 123456'),(3,'000000','主框架页-侧边栏主题','sys.index.sideTheme','theme-dark','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'深色主题theme-dark，浅色主题theme-light'),(5,'000000','账号自助-是否开启用户注册功能','sys.account.registerUser','false','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'是否开启注册用户功能（true开启，false关闭）'),(11,'000000','OSS预览列表资源开关','sys.oss.previewListResource','true','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'true:开启, false:关闭');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dept`
--

DROP TABLE IF EXISTS `sys_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(500) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `dept_category` varchar(100) DEFAULT NULL COMMENT '部门类别编码',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `leader` bigint DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;
INSERT INTO `sys_dept` VALUES (100,'000000',0,'0','车辆租赁公司',NULL,0,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2026-03-09 08:58:34',1,'2026-03-11 11:36:01'),(101,'000000',100,'0,100','北京总公司',NULL,1,NULL,'15888888888','xxx@qq.com','0','0',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:39:39'),(102,'000000',100,'0,100','长沙分公司',NULL,2,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:33'),(103,'000000',101,'0,100,101','风控部门',NULL,1,1,'15888888888','xxx@qq.com','0','0',103,1,'2026-03-09 08:58:34',1,'2026-03-11 11:40:10'),(104,'000000',101,'0,100,101','市场部门',NULL,2,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:42'),(105,'000000',101,'0,100,101','测试部门',NULL,3,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:40'),(106,'000000',101,'0,100,101','财务部门',NULL,4,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:38'),(107,'000000',101,'0,100,101','运维部门',NULL,5,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:36'),(108,'000000',102,'0,100,102','市场部门',NULL,1,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:35:31'),(109,'000000',102,'0,100,102','财务部门',NULL,2,NULL,'15888888888','xxx@qq.com','0','1',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:34:50'),(2031574936300666882,'000000',101,'0,100,101','客服部门',NULL,1,NULL,NULL,NULL,'0','0',103,1,'2026-03-11 11:36:24',1,'2026-03-11 11:39:47'),(2031575046338232321,'000000',101,'0,100,101','财务部门',NULL,2,NULL,NULL,NULL,'0','0',103,1,'2026-03-11 11:36:51',1,'2026-03-11 11:39:57');
/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_data`
--

DROP TABLE IF EXISTS `sys_dict_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典数据表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

LOCK TABLES `sys_dict_data` WRITE;
/*!40000 ALTER TABLE `sys_dict_data` DISABLE KEYS */;
INSERT INTO `sys_dict_data` VALUES (1,'000000',1,'男','0','sys_user_sex','','','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'性别男'),(2,'000000',2,'女','1','sys_user_sex','','','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'性别女'),(3,'000000',3,'未知','2','sys_user_sex','','','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'性别未知'),(4,'000000',1,'显示','0','sys_show_hide','','primary','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'显示菜单'),(5,'000000',2,'隐藏','1','sys_show_hide','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'隐藏菜单'),(6,'000000',1,'正常','0','sys_normal_disable','','primary','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'正常状态'),(7,'000000',2,'停用','1','sys_normal_disable','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'停用状态'),(12,'000000',1,'是','Y','sys_yes_no','','primary','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'系统默认是'),(13,'000000',2,'否','N','sys_yes_no','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'系统默认否'),(14,'000000',1,'通知','1','sys_notice_type','','warning','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'通知'),(15,'000000',2,'公告','2','sys_notice_type','','success','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'公告'),(16,'000000',1,'正常','0','sys_notice_status','','primary','Y',103,1,'2026-03-11 09:50:55',NULL,NULL,'正常状态'),(17,'000000',2,'关闭','1','sys_notice_status','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'关闭状态'),(18,'000000',1,'新增','1','sys_oper_type','','info','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'新增操作'),(19,'000000',2,'修改','2','sys_oper_type','','info','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'修改操作'),(20,'000000',3,'删除','3','sys_oper_type','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'删除操作'),(21,'000000',4,'授权','4','sys_oper_type','','primary','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'授权操作'),(22,'000000',5,'导出','5','sys_oper_type','','warning','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'导出操作'),(23,'000000',6,'导入','6','sys_oper_type','','warning','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'导入操作'),(24,'000000',7,'强退','7','sys_oper_type','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'强退操作'),(25,'000000',8,'生成代码','8','sys_oper_type','','warning','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'生成操作'),(26,'000000',9,'清空数据','9','sys_oper_type','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'清空操作'),(27,'000000',1,'成功','0','sys_common_status','','primary','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'正常状态'),(28,'000000',2,'失败','1','sys_common_status','','danger','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'停用状态'),(29,'000000',99,'其他','0','sys_oper_type','','info','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'其他操作'),(30,'000000',0,'密码认证','password','sys_grant_type','el-check-tag','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'密码认证'),(31,'000000',0,'短信认证','sms','sys_grant_type','el-check-tag','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'短信认证'),(32,'000000',0,'邮件认证','email','sys_grant_type','el-check-tag','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'邮件认证'),(33,'000000',0,'小程序认证','xcx','sys_grant_type','el-check-tag','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'小程序认证'),(34,'000000',0,'三方登录认证','social','sys_grant_type','el-check-tag','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'三方登录认证'),(35,'000000',0,'PC','pc','sys_device_type','','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'PC'),(36,'000000',0,'安卓','android','sys_device_type','','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'安卓'),(37,'000000',0,'iOS','ios','sys_device_type','','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'iOS'),(38,'000000',0,'小程序','xcx','sys_device_type','','default','N',103,1,'2026-03-11 09:50:55',NULL,NULL,'小程序');
/*!40000 ALTER TABLE `sys_dict_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_dict_type`
--

DROP TABLE IF EXISTS `sys_dict_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `tenant_id` (`tenant_id`,`dict_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典类型表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

LOCK TABLES `sys_dict_type` WRITE;
/*!40000 ALTER TABLE `sys_dict_type` DISABLE KEYS */;
INSERT INTO `sys_dict_type` VALUES (1,'000000','用户性别','sys_user_sex',103,1,'2026-03-11 09:50:55',NULL,NULL,'用户性别列表'),(2,'000000','菜单状态','sys_show_hide',103,1,'2026-03-11 09:50:55',NULL,NULL,'菜单状态列表'),(3,'000000','系统开关','sys_normal_disable',103,1,'2026-03-11 09:50:55',NULL,NULL,'系统开关列表'),(6,'000000','系统是否','sys_yes_no',103,1,'2026-03-11 09:50:55',NULL,NULL,'系统是否列表'),(7,'000000','通知类型','sys_notice_type',103,1,'2026-03-11 09:50:55',NULL,NULL,'通知类型列表'),(8,'000000','通知状态','sys_notice_status',103,1,'2026-03-11 09:50:55',NULL,NULL,'通知状态列表'),(9,'000000','操作类型','sys_oper_type',103,1,'2026-03-11 09:50:55',NULL,NULL,'操作类型列表'),(10,'000000','系统状态','sys_common_status',103,1,'2026-03-11 09:50:55',NULL,NULL,'登录状态列表'),(11,'000000','授权类型','sys_grant_type',103,1,'2026-03-11 09:50:55',NULL,NULL,'认证授权类型'),(12,'000000','设备类型','sys_device_type',103,1,'2026-03-11 09:50:55',NULL,NULL,'客户端设备类型');
/*!40000 ALTER TABLE `sys_dict_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_logininfor`
--

DROP TABLE IF EXISTS `sys_logininfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `client_key` varchar(32) DEFAULT '' COMMENT '客户端',
  `device_type` varchar(32) DEFAULT '' COMMENT '设备类型',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) DEFAULT '' COMMENT '操作系统',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`),
  KEY `idx_sys_logininfor_s` (`status`),
  KEY `idx_sys_logininfor_lt` (`login_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统访问记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_logininfor`
--

LOCK TABLES `sys_logininfor` WRITE;
/*!40000 ALTER TABLE `sys_logininfor` DISABLE KEYS */;
INSERT INTO `sys_logininfor` VALUES (2031558643405037570,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 10:31:40'),(2031622083960225794,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 14:43:45'),(2031623623357874178,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 14:49:52'),(2031626941782147073,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 15:03:03'),(2031628589216677889,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 15:09:36'),(2031628604727214081,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 15:09:40'),(2031630579795607553,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 15:17:31'),(2031631314021105665,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 15:20:26'),(2031637133362053121,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 15:43:33'),(2031637259648352257,'000000','zhangsan','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 15:44:03'),(2031637401118031873,'000000','zhangsan','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 15:44:37'),(2031637424874569730,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','登录成功','2026-03-11 15:44:43'),(2031638056050212866,'000000','admin','pc','pc','127.0.0.1','内网IP','Chrome','Windows 10 or Windows Server 2016','0','退出成功','2026-03-11 15:47:13');
/*!40000 ALTER TABLE `sys_logininfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,'系统管理',0,1,'system',NULL,'',1,0,'M','0','0','','system',103,1,'2026-03-11 09:50:53',NULL,NULL,'系统管理目录'),(2,'系统监控',0,3,'monitor',NULL,'',1,0,'M','0','0','','monitor',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:32:30','系统监控目录'),(3,'系统工具',0,4,'tool',NULL,'',1,0,'M','1','0','','tool',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:32:24','系统工具目录'),(4,'PLUS官网',0,5,'https://gitee.com/dromara/RuoYi-Vue-Plus',NULL,'',0,0,'M','1','0','','guide',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:33:00','RuoYi-Vue-Plus官网地址'),(5,'测试菜单',0,5,'demo',NULL,'',1,0,'M','1','0','','star',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:33:04','测试菜单'),(6,'租户管理',0,2,'tenant',NULL,'',1,0,'M','1','0','','chart',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:31:52','租户管理目录'),(100,'用户管理',1,1,'user','system/user/index','',1,0,'C','0','0','system:user:list','user',103,1,'2026-03-11 09:50:53',NULL,NULL,'用户管理菜单'),(101,'角色管理',1,2,'role','system/role/index','',1,0,'C','0','0','system:role:list','peoples',103,1,'2026-03-11 09:50:53',NULL,NULL,'角色管理菜单'),(102,'菜单管理',1,3,'menu','system/menu/index','',1,0,'C','1','0','system:menu:list','tree-table',103,1,'2026-03-11 09:50:53',1,'2026-03-11 15:45:05','菜单管理菜单'),(103,'部门管理',1,4,'dept','system/dept/index','',1,0,'C','0','0','system:dept:list','tree',103,1,'2026-03-11 09:50:53',NULL,NULL,'部门管理菜单'),(104,'岗位管理',1,5,'post','system/post/index','',1,0,'C','1','0','system:post:list','post',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:40:49','岗位管理菜单'),(105,'字典管理',1,6,'dict','system/dict/index','',1,0,'C','1','0','system:dict:list','dict',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:40:55','字典管理菜单'),(106,'参数设置',1,7,'config','system/config/index','',1,0,'C','1','0','system:config:list','edit',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:41:05','参数设置菜单'),(107,'通知公告',1,8,'notice','system/notice/index','',1,0,'C','0','0','system:notice:list','message',103,1,'2026-03-11 09:50:53',NULL,NULL,'通知公告菜单'),(108,'日志管理',1,9,'log','','',1,0,'M','0','0','','log',103,1,'2026-03-11 09:50:53',NULL,NULL,'日志管理菜单'),(109,'在线用户',2,1,'online','monitor/online/index','',1,0,'C','0','0','monitor:online:list','online',103,1,'2026-03-11 09:50:53',NULL,NULL,'在线用户菜单'),(113,'缓存监控',2,5,'cache','monitor/cache/index','',1,0,'C','1','0','monitor:cache:list','redis',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:32:40','缓存监控菜单'),(115,'代码生成',3,2,'gen','tool/gen/index','',1,0,'C','0','0','tool:gen:list','code',103,1,'2026-03-11 09:50:53',NULL,NULL,'代码生成菜单'),(116,'修改生成配置',3,2,'gen-edit/index/:tableId','tool/gen/editTable','',1,1,'C','1','0','tool:gen:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'/tool/gen'),(117,'Admin监控',2,5,'Admin','monitor/admin/index','',1,0,'C','1','0','monitor:admin:list','dashboard',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:32:45','Admin监控菜单'),(118,'文件管理',1,10,'oss','system/oss/index','',1,0,'C','0','0','system:oss:list','upload',103,1,'2026-03-11 09:50:53',NULL,NULL,'文件管理菜单'),(120,'任务调度中心',2,6,'snailjob','monitor/snailjob/index','',1,0,'C','1','0','monitor:snailjob:list','job',103,1,'2026-03-11 09:50:53',1,'2026-03-11 10:32:50','SnailJob控制台菜单'),(121,'租户管理',6,1,'tenant','system/tenant/index','',1,0,'C','0','0','system:tenant:list','list',103,1,'2026-03-11 09:50:53',NULL,NULL,'租户管理菜单'),(122,'租户套餐管理',6,2,'tenantPackage','system/tenantPackage/index','',1,0,'C','0','0','system:tenantPackage:list','form',103,1,'2026-03-11 09:50:53',NULL,NULL,'租户套餐管理菜单'),(123,'客户端管理',1,11,'client','system/client/index','',1,0,'C','1','0','system:client:list','international',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:41:19','客户端管理菜单'),(130,'分配用户',1,2,'role-auth/user/:roleId','system/role/authUser','',1,1,'C','1','0','system:role:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'/system/role'),(131,'分配角色',1,1,'user-auth/role/:userId','system/user/authRole','',1,1,'C','1','0','system:user:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'/system/user'),(132,'字典数据',1,6,'dict-data/index/:dictId','system/dict/data','',1,1,'C','1','0','system:dict:list','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'/system/dict'),(133,'文件配置管理',1,10,'oss-config/index','system/oss/config','',1,1,'C','1','0','system:ossConfig:list','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'/system/oss'),(500,'操作日志',108,1,'operlog','monitor/operlog/index','',1,0,'C','0','0','monitor:operlog:list','form',103,1,'2026-03-11 09:50:53',NULL,NULL,'操作日志菜单'),(501,'登录日志',108,2,'logininfor','monitor/logininfor/index','',1,0,'C','0','0','monitor:logininfor:list','logininfor',103,1,'2026-03-11 09:50:53',NULL,NULL,'登录日志菜单'),(1001,'用户查询',100,1,'','','',1,0,'F','0','0','system:user:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1002,'用户新增',100,2,'','','',1,0,'F','0','0','system:user:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1003,'用户修改',100,3,'','','',1,0,'F','0','0','system:user:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1004,'用户删除',100,4,'','','',1,0,'F','0','0','system:user:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1005,'用户导出',100,5,'','','',1,0,'F','0','0','system:user:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1006,'用户导入',100,6,'','','',1,0,'F','0','0','system:user:import','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1007,'重置密码',100,7,'','','',1,0,'F','0','0','system:user:resetPwd','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1008,'角色查询',101,1,'','','',1,0,'F','0','0','system:role:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1009,'角色新增',101,2,'','','',1,0,'F','0','0','system:role:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1010,'角色修改',101,3,'','','',1,0,'F','0','0','system:role:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1011,'角色删除',101,4,'','','',1,0,'F','0','0','system:role:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1012,'角色导出',101,5,'','','',1,0,'F','0','0','system:role:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1013,'菜单查询',102,1,'','','',1,0,'F','0','0','system:menu:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1014,'菜单新增',102,2,'','','',1,0,'F','0','0','system:menu:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1015,'菜单修改',102,3,'','','',1,0,'F','0','0','system:menu:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1016,'菜单删除',102,4,'','','',1,0,'F','0','0','system:menu:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1017,'部门查询',103,1,'','','',1,0,'F','0','0','system:dept:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1018,'部门新增',103,2,'','','',1,0,'F','0','0','system:dept:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1019,'部门修改',103,3,'','','',1,0,'F','0','0','system:dept:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1020,'部门删除',103,4,'','','',1,0,'F','0','0','system:dept:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1021,'岗位查询',104,1,'','','',1,0,'F','0','0','system:post:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1022,'岗位新增',104,2,'','','',1,0,'F','0','0','system:post:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1023,'岗位修改',104,3,'','','',1,0,'F','0','0','system:post:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1024,'岗位删除',104,4,'','','',1,0,'F','0','0','system:post:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1025,'岗位导出',104,5,'','','',1,0,'F','0','0','system:post:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1026,'字典查询',105,1,'#','','',1,0,'F','0','0','system:dict:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1027,'字典新增',105,2,'#','','',1,0,'F','0','0','system:dict:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1028,'字典修改',105,3,'#','','',1,0,'F','0','0','system:dict:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1029,'字典删除',105,4,'#','','',1,0,'F','0','0','system:dict:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1030,'字典导出',105,5,'#','','',1,0,'F','0','0','system:dict:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1031,'参数查询',106,1,'#','','',1,0,'F','0','0','system:config:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1032,'参数新增',106,2,'#','','',1,0,'F','0','0','system:config:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1033,'参数修改',106,3,'#','','',1,0,'F','0','0','system:config:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1034,'参数删除',106,4,'#','','',1,0,'F','0','0','system:config:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1035,'参数导出',106,5,'#','','',1,0,'F','0','0','system:config:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1036,'公告查询',107,1,'#','','',1,0,'F','0','0','system:notice:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1037,'公告新增',107,2,'#','','',1,0,'F','0','0','system:notice:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1038,'公告修改',107,3,'#','','',1,0,'F','0','0','system:notice:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1039,'公告删除',107,4,'#','','',1,0,'F','0','0','system:notice:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1040,'操作查询',500,1,'#','','',1,0,'F','0','0','monitor:operlog:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1041,'操作删除',500,2,'#','','',1,0,'F','0','0','monitor:operlog:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1042,'日志导出',500,4,'#','','',1,0,'F','0','0','monitor:operlog:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1043,'登录查询',501,1,'#','','',1,0,'F','0','0','monitor:logininfor:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1044,'登录删除',501,2,'#','','',1,0,'F','0','0','monitor:logininfor:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1045,'日志导出',501,3,'#','','',1,0,'F','0','0','monitor:logininfor:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1046,'在线查询',109,1,'#','','',1,0,'F','0','0','monitor:online:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1047,'批量强退',109,2,'#','','',1,0,'F','0','0','monitor:online:batchLogout','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1048,'单条强退',109,3,'#','','',1,0,'F','0','0','monitor:online:forceLogout','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1050,'账户解锁',501,4,'#','','',1,0,'F','0','0','monitor:logininfor:unlock','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1055,'生成查询',115,1,'#','','',1,0,'F','0','0','tool:gen:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1056,'生成修改',115,2,'#','','',1,0,'F','0','0','tool:gen:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1057,'生成删除',115,3,'#','','',1,0,'F','0','0','tool:gen:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1058,'导入代码',115,2,'#','','',1,0,'F','0','0','tool:gen:import','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1059,'预览代码',115,4,'#','','',1,0,'F','0','0','tool:gen:preview','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1060,'生成代码',115,5,'#','','',1,0,'F','0','0','tool:gen:code','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1061,'客户端管理查询',123,1,'#','','',1,0,'F','0','0','system:client:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1062,'客户端管理新增',123,2,'#','','',1,0,'F','0','0','system:client:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1063,'客户端管理修改',123,3,'#','','',1,0,'F','0','0','system:client:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1064,'客户端管理删除',123,4,'#','','',1,0,'F','0','0','system:client:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1065,'客户端管理导出',123,5,'#','','',1,0,'F','0','0','system:client:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1500,'测试单表',5,1,'demo','demo/demo/index','',1,0,'C','0','0','demo:demo:list','#',103,1,'2026-03-11 09:50:53',NULL,NULL,'测试单表菜单'),(1501,'测试单表查询',1500,1,'#','','',1,0,'F','0','0','demo:demo:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1502,'测试单表新增',1500,2,'#','','',1,0,'F','0','0','demo:demo:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1503,'测试单表修改',1500,3,'#','','',1,0,'F','0','0','demo:demo:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1504,'测试单表删除',1500,4,'#','','',1,0,'F','0','0','demo:demo:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1505,'测试单表导出',1500,5,'#','','',1,0,'F','0','0','demo:demo:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1506,'测试树表',5,1,'tree','demo/tree/index','',1,0,'C','0','0','demo:tree:list','#',103,1,'2026-03-11 09:50:54',NULL,NULL,'测试树表菜单'),(1507,'测试树表查询',1506,1,'#','','',1,0,'F','0','0','demo:tree:query','#',103,1,'2026-03-11 09:50:54',NULL,NULL,''),(1508,'测试树表新增',1506,2,'#','','',1,0,'F','0','0','demo:tree:add','#',103,1,'2026-03-11 09:50:54',NULL,NULL,''),(1509,'测试树表修改',1506,3,'#','','',1,0,'F','0','0','demo:tree:edit','#',103,1,'2026-03-11 09:50:54',NULL,NULL,''),(1510,'测试树表删除',1506,4,'#','','',1,0,'F','0','0','demo:tree:remove','#',103,1,'2026-03-11 09:50:54',NULL,NULL,''),(1511,'测试树表导出',1506,5,'#','','',1,0,'F','0','0','demo:tree:export','#',103,1,'2026-03-11 09:50:54',NULL,NULL,''),(1600,'文件查询',118,1,'#','','',1,0,'F','0','0','system:oss:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1601,'文件上传',118,2,'#','','',1,0,'F','0','0','system:oss:upload','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1602,'文件下载',118,3,'#','','',1,0,'F','0','0','system:oss:download','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1603,'文件删除',118,4,'#','','',1,0,'F','0','0','system:oss:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1606,'租户查询',121,1,'#','','',1,0,'F','0','0','system:tenant:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1607,'租户新增',121,2,'#','','',1,0,'F','0','0','system:tenant:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1608,'租户修改',121,3,'#','','',1,0,'F','0','0','system:tenant:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1609,'租户删除',121,4,'#','','',1,0,'F','0','0','system:tenant:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1610,'租户导出',121,5,'#','','',1,0,'F','0','0','system:tenant:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1611,'租户套餐查询',122,1,'#','','',1,0,'F','0','0','system:tenantPackage:query','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1612,'租户套餐新增',122,2,'#','','',1,0,'F','0','0','system:tenantPackage:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1613,'租户套餐修改',122,3,'#','','',1,0,'F','0','0','system:tenantPackage:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1614,'租户套餐删除',122,4,'#','','',1,0,'F','0','0','system:tenantPackage:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1615,'租户套餐导出',122,5,'#','','',1,0,'F','0','0','system:tenantPackage:export','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1620,'配置列表',118,5,'#','','',1,0,'F','0','0','system:ossConfig:list','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1621,'配置添加',118,6,'#','','',1,0,'F','0','0','system:ossConfig:add','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1622,'配置编辑',118,6,'#','','',1,0,'F','0','0','system:ossConfig:edit','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(1623,'配置删除',118,6,'#','','',1,0,'F','0','0','system:ossConfig:remove','#',103,1,'2026-03-11 09:50:53',NULL,NULL,''),(2031559659370323969,'租车管理',0,1,'rental',NULL,NULL,1,0,'M','0','0',NULL,'number',103,1,'2026-03-11 10:35:42',1,'2026-03-11 10:51:38',''),(2031564170625294337,'车辆管理',2031559659370323969,1,'car','rental/car/index',NULL,1,0,'C','0','0','rental:car:list','monitor',103,1,'2026-03-11 10:53:38',1,'2026-03-11 10:53:38',''),(2031565397085921281,'客户管理',2031559659370323969,2,'customer','rental/customer/index',NULL,1,0,'C','0','0','rental:customer:list','user',103,1,'2026-03-11 10:58:30',1,'2026-03-11 10:58:30',''),(2031567121855029250,'租赁订单',2031559659370323969,3,'order','rental/order/index',NULL,1,0,'C','0','0','rental:order:list','shopping',103,1,'2026-03-11 11:05:21',1,'2026-03-11 11:05:21',''),(2031567289136455682,'新建订单',2031567121855029250,1,'',NULL,NULL,1,0,'F','0','0','rental:order:add','',103,1,'2026-03-11 11:06:01',1,'2026-03-11 11:06:01',''),(2031567402382663681,'车辆归还',2031567121855029250,2,'',NULL,NULL,1,0,'F','0','0','rental:order:edit','',103,1,'2026-03-11 11:06:28',1,'2026-03-11 11:06:28',''),(2031635926207807489,'新增车辆',2031564170625294337,1,'',NULL,NULL,1,0,'F','0','0','rental:car:add','',103,1,'2026-03-11 15:38:45',1,'2026-03-11 15:38:45',''),(2031635978770825218,'修改车辆',2031564170625294337,2,'',NULL,NULL,1,0,'F','0','0','rental:car:edit','',103,1,'2026-03-11 15:38:58',1,'2026-03-11 15:38:58',''),(2031636047276392449,'删除车辆',2031564170625294337,3,'',NULL,NULL,1,0,'F','0','0','rental:car:remove','',103,1,'2026-03-11 15:39:14',1,'2026-03-11 15:39:14',''),(2031636143812493313,'导出车辆',2031564170625294337,5,'',NULL,NULL,1,0,'F','0','0','rental:car:export','',103,1,'2026-03-11 15:39:37',1,'2026-03-11 15:39:37',''),(2031636325811732482,'删除订单',2031567121855029250,3,'',NULL,NULL,1,0,'F','0','0','rental:order:remove','',103,1,'2026-03-11 15:40:21',1,'2026-03-11 15:40:21',''),(2031636449145241602,'导出订单',2031567121855029250,4,'',NULL,NULL,1,0,'F','0','0','rental:order:export','',103,1,'2026-03-11 15:40:50',1,'2026-03-11 15:40:50',''),(2031636512953188354,'新增客户',2031565397085921281,1,'',NULL,NULL,1,0,'F','0','0','rental:customer:add','',103,1,'2026-03-11 15:41:05',1,'2026-03-11 15:41:05',''),(2031636572222898177,'修改客户',2031565397085921281,2,'',NULL,NULL,1,0,'F','0','0','rental:customer:edit','',103,1,'2026-03-11 15:41:19',1,'2026-03-11 15:41:19',''),(2031636673427259393,'删除客户',2031565397085921281,1,'',NULL,NULL,1,0,'F','0','0','rental:customer:remove','',103,1,'2026-03-11 15:41:44',1,'2026-03-11 15:41:44',''),(2031636743363084290,'导出客户',2031565397085921281,1,'',NULL,NULL,1,0,'F','0','0','rental:customer:export','',103,1,'2026-03-11 15:42:00',1,'2026-03-11 15:42:00','');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_notice`
--

DROP TABLE IF EXISTS `sys_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知公告表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;
INSERT INTO `sys_notice` VALUES (2031634048145276930,'000000','系统开放','1',_binary '<p>基于基于用户身份验证与数据安全存储的汽车租赁系统今日正式上线，欢迎大家访问</p>','0',103,1,'2026-03-11 15:31:18',1,'2026-03-11 15:31:18',''),(2031634187249369090,'000000','系统维护','2',_binary '<p>今日系统维护，暂停使用</p>','0',103,1,'2026-03-11 15:31:51',1,'2026-03-11 15:31:51','');
/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oper_log`
--

DROP TABLE IF EXISTS `sys_oper_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(4000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(4000) DEFAULT '' COMMENT '返回参数',
  `status` int DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(4000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint DEFAULT '0' COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`),
  KEY `idx_sys_oper_log_bt` (`business_type`),
  KEY `idx_sys_oper_log_s` (`status`),
  KEY `idx_sys_oper_log_ot` (`oper_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='操作日志记录';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oper_log`
--

LOCK TABLES `sys_oper_log` WRITE;
/*!40000 ALTER TABLE `sys_oper_log` DISABLE KEYS */;
INSERT INTO `sys_oper_log` VALUES (2031558693623439362,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":6,\"parentId\":0,\"menuName\":\"租户管理\",\"orderNum\":2,\"path\":\"tenant\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"chart\",\"remark\":\"租户管理目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:31:52',36),(2031558802574680066,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2,\"parentId\":0,\"menuName\":\"系统监控\",\"orderNum\":3,\"path\":\"monitor\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"monitor\",\"remark\":\"系统监控目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:18',22),(2031558830823317506,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":3,\"parentId\":0,\"menuName\":\"系统工具\",\"orderNum\":4,\"path\":\"tool\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"tool\",\"remark\":\"系统工具目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:24',38),(2031558852772110338,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":2,\"parentId\":0,\"menuName\":\"系统监控\",\"orderNum\":3,\"path\":\"monitor\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"monitor\",\"remark\":\"系统监控目录\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:30',37),(2031558896954908673,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":113,\"parentId\":2,\"menuName\":\"缓存监控\",\"orderNum\":5,\"path\":\"cache\",\"component\":\"monitor/cache/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"monitor:cache:list\",\"icon\":\"redis\",\"remark\":\"缓存监控菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:40',24),(2031558918958227457,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":117,\"parentId\":2,\"menuName\":\"Admin监控\",\"orderNum\":5,\"path\":\"Admin\",\"component\":\"monitor/admin/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"monitor:admin:list\",\"icon\":\"dashboard\",\"remark\":\"Admin监控菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:45',36),(2031558939824889858,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":120,\"parentId\":2,\"menuName\":\"任务调度中心\",\"orderNum\":6,\"path\":\"snailjob\",\"component\":\"monitor/snailjob/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"monitor:snailjob:list\",\"icon\":\"job\",\"remark\":\"SnailJob控制台菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:32:50',26),(2031558978869665793,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":4,\"parentId\":0,\"menuName\":\"PLUS官网\",\"orderNum\":5,\"path\":\"https://gitee.com/dromara/RuoYi-Vue-Plus\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"guide\",\"remark\":\"RuoYi-Vue-Plus官网地址\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:33:00',33),(2031558994761883650,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":5,\"parentId\":0,\"menuName\":\"测试菜单\",\"orderNum\":5,\"path\":\"demo\",\"component\":null,\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"star\",\"remark\":\"测试菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:33:04',34),(2031559659437432833,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"租车管理\",\"orderNum\":1,\"path\":\"rental\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"number\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:35:42',20),(2031563667858268162,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 10:35:42\",\"updateBy\":null,\"updateTime\":null,\"menuId\":\"2031559659370323969\",\"parentId\":0,\"menuName\":\"租车管理\",\"orderNum\":1,\"path\":\"rental\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"number\",\"remark\":\"\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:51:38',26),(2031564170692403202,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031559659370323969\",\"menuName\":\"车辆管理\",\"orderNum\":1,\"path\":\"car\",\"component\":\"rental/car/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:car:list\",\"icon\":\"monitor\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:53:38',34),(2031565397220139009,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031559659370323969\",\"menuName\":\"客户管理\",\"orderNum\":2,\"path\":\"customer\",\"component\":\"rental/customer/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:customer:list\",\"icon\":\"user\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 10:58:30',33),(2031567121922138113,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031559659370323969\",\"menuName\":\"租赁订单\",\"orderNum\":3,\"path\":\"order\",\"component\":\"rental/order/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:order:list\",\"icon\":\"shopping\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:05:21',25),(2031567289203564545,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031567121855029250\",\"menuName\":\"新建订单\",\"orderNum\":1,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:order:add\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:06:01',27),(2031567402516881409,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031567121855029250\",\"menuName\":\"车辆归还\",\"orderNum\":2,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:order:edit\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:06:28',31),(2031567634055045122,'000000','车辆管理',1,'org.dromara.rental.controller.BusCarController.add()','POST',1,'admin','研发部门','/rental/car','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"carId\":null,\"plateNumber\":\"浙A98789V\",\"brandModel\":\"雷克萨斯ES200\",\"carImageUrl\":\"\",\"dailyRate\":\"100\",\"carStatus\":\"0\"}','',1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\r\n### The error may exist in org/dromara/rental/mapper/BusCarMapper.java (best guess)\r\n### The error may involve org.dromara.rental.mapper.BusCarMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bus_car (plate_number, brand_model, car_image_url, daily_rate, car_status, create_dept, create_by, create_time, update_by, update_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\n; bad SQL grammar []','2026-03-11 11:07:23',483),(2031568300722888705,'000000','车辆管理',1,'org.dromara.rental.controller.BusCarController.add()','POST',1,'admin','研发部门','/rental/car','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"carId\":1,\"plateNumber\":\"浙A9335V\",\"brandModel\":\"雷克萨斯\",\"carImageUrl\":\"\",\"dailyRate\":\"100\",\"carStatus\":\"0\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:10:02',27),(2031568571440046082,'000000','客户管理',1,'org.dromara.rental.controller.BusCustomerController.add()','POST',1,'admin','研发部门','/rental/customer','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"customerId\":null,\"customerName\":\"李四\",\"phone\":\"13015338907\",\"idCard\":\"142402199408091830\",\"accountStatus\":\"0\"}','',1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\r\n### The error may exist in org/dromara/rental/mapper/BusCustomerMapper.java (best guess)\r\n### The error may involve org.dromara.rental.mapper.BusCustomerMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bus_customer (customer_name, phone, id_card, account_status, create_dept, create_by, create_time, update_by, update_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\n; bad SQL grammar []','2026-03-11 11:11:07',19),(2031568915830153218,'000000','客户管理',1,'org.dromara.rental.controller.BusCustomerController.add()','POST',1,'admin','研发部门','/rental/customer','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"customerId\":1,\"customerName\":\"李四\",\"phone\":\"13015338907\",\"idCard\":\"142402199408091830\",\"accountStatus\":\"0\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:12:29',14),(2031570905872318466,'000000','租赁订单',1,'org.dromara.rental.controller.BusRentalOrderController.createOrder()','POST',1,'admin','研发部门','/rental/order/create','127.0.0.1','内网IP','{\"customerId\":1,\"carId\":1,\"rentStartDate\":\"2026-03-10\",\"rentEndDate\":\"2026-03-26\"}','',1,'\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\r\n### The error may exist in org/dromara/rental/mapper/BusRentalOrderMapper.java (best guess)\r\n### The error may involve org.dromara.rental.mapper.BusRentalOrderMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO bus_rental_order (order_no, customer_id, car_id, rent_start_date, rent_end_date, total_amount, order_status, create_dept, create_by, create_time, update_by, update_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'create_dept\' in \'field list\'\n; bad SQL grammar []','2026-03-11 11:20:23',112),(2031571245883572225,'000000','租赁订单',1,'org.dromara.rental.controller.BusRentalOrderController.createOrder()','POST',1,'admin','研发部门','/rental/order/create','127.0.0.1','内网IP','{\"customerId\":1,\"carId\":1,\"rentStartDate\":\"2026-03-10\",\"rentEndDate\":\"2026-03-26\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":{\"orderId\":1,\"orderNo\":\"RO2031571245732577280\",\"customerId\":1,\"carId\":1,\"rentStartDate\":\"2026-03-10\",\"rentEndDate\":\"2026-03-26\",\"totalAmount\":\"1700.00\",\"orderStatus\":\"0\",\"createTime\":\"2026-03-11 11:21:44\"}}',0,'','2026-03-11 11:21:44',58),(2031574529486733314,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/101','127.0.0.1','内网IP','101','{\"code\":601,\"msg\":\"存在下级部门,不允许删除\",\"data\":null}',0,'','2026-03-11 11:34:47',13),(2031574541314670594,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/109','127.0.0.1','内网IP','109','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:34:50',53),(2031574573048774657,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','127.0.0.1','内网IP','108','{\"code\":601,\"msg\":\"部门存在用户,不允许删除\",\"data\":null}',0,'','2026-03-11 11:34:58',13),(2031574587296825345,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','127.0.0.1','内网IP','108','{\"code\":601,\"msg\":\"部门存在用户,不允许删除\",\"data\":null}',0,'','2026-03-11 11:35:01',7),(2031574664006451202,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"userId\":3,\"deptId\":103,\"userName\":\"test\",\"nickName\":\"本部门及以下 密码666666\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":null,\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:19',32),(2031574693454659585,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"userId\":4,\"deptId\":103,\"userName\":\"test1\",\"nickName\":\"仅本人 密码666666\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":null,\"roleIds\":[4],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:26',27),(2031574714220658689,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/108','127.0.0.1','内网IP','108','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:31',14),(2031574722802204674,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/102','127.0.0.1','内网IP','102','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:33',29),(2031574732914671617,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/107','127.0.0.1','内网IP','107','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:36',28),(2031574741223587842,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/106','127.0.0.1','内网IP','106','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:38',14),(2031574750669160450,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/105','127.0.0.1','内网IP','105','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:40',28),(2031574758185353218,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/104','127.0.0.1','内网IP','104','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:35:42',25),(2031574838422388737,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-09 08:58:34\",\"updateBy\":null,\"updateTime\":null,\"deptId\":100,\"parentId\":0,\"deptName\":\"车辆租赁公司\",\"deptCategory\":null,\"orderNum\":0,\"leader\":null,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:36:01',18),(2031574936430690306,'000000','部门管理',1,'org.dromara.system.controller.system.SysDeptController.add()','POST',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"deptId\":null,\"parentId\":100,\"deptName\":\"客服部门\",\"deptCategory\":null,\"orderNum\":1,\"leader\":null,\"phone\":null,\"email\":null,\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:36:24',35),(2031575046396952578,'000000','部门管理',1,'org.dromara.system.controller.system.SysDeptController.add()','POST',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"deptId\":null,\"parentId\":100,\"deptName\":\"财务部门\",\"deptCategory\":null,\"orderNum\":2,\"leader\":null,\"phone\":null,\"email\":null,\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:36:51',23),(2031575118312488962,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"userId\":3,\"deptId\":\"2031574936300666882\",\"userName\":\"test\",\"nickName\":\"本部门及以下 密码666666\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":null,\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:37:08',17),(2031575138365456385,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','研发部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"userId\":4,\"deptId\":\"2031575046338232321\",\"userName\":\"test1\",\"nickName\":\"仅本人 密码666666\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":null,\"roleIds\":[4],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:37:12',37),(2031575161794838530,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/103','127.0.0.1','内网IP','103','{\"code\":601,\"msg\":\"部门存在用户,不允许删除\",\"data\":null}',0,'','2026-03-11 11:37:18',7),(2031575474702499842,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/103','127.0.0.1','内网IP','103','{\"code\":601,\"msg\":\"部门存在岗位,不允许删除\",\"data\":null}',0,'','2026-03-11 11:38:33',13),(2031575496483520514,'000000','部门管理',3,'org.dromara.system.controller.system.SysDeptController.remove()','DELETE',1,'admin','研发部门','/system/dept/103','127.0.0.1','内网IP','103','{\"code\":601,\"msg\":\"部门存在岗位,不允许删除\",\"data\":null}',0,'','2026-03-11 11:38:38',9),(2031575557888131074,'000000','岗位管理',3,'org.dromara.system.controller.system.SysPostController.remove()','DELETE',1,'admin','研发部门','/system/post/4','127.0.0.1','内网IP','[4]','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:38:53',21),(2031575567438561281,'000000','岗位管理',3,'org.dromara.system.controller.system.SysPostController.remove()','DELETE',1,'admin','研发部门','/system/post/3','127.0.0.1','内网IP','[3]','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:38:55',25),(2031575579090337794,'000000','岗位管理',3,'org.dromara.system.controller.system.SysPostController.remove()','DELETE',1,'admin','研发部门','/system/post/2','127.0.0.1','内网IP','[2]','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:38:58',25),(2031575587843850242,'000000','岗位管理',3,'org.dromara.system.controller.system.SysPostController.remove()','DELETE',1,'admin','研发部门','/system/post/1','127.0.0.1','内网IP','[1]','',1,'董事长已分配，不能删除!','2026-03-11 11:39:00',7),(2031575750893223937,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"deptId\":101,\"parentId\":100,\"deptName\":\"北京总公司\",\"deptCategory\":null,\"orderNum\":1,\"leader\":null,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:39:39',42),(2031575786985209858,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 11:36:24\",\"updateBy\":null,\"updateTime\":null,\"deptId\":\"2031574936300666882\",\"parentId\":101,\"deptName\":\"客服部门\",\"deptCategory\":null,\"orderNum\":1,\"leader\":null,\"phone\":null,\"email\":null,\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:39:47',34),(2031575828924055554,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 11:36:51\",\"updateBy\":null,\"updateTime\":null,\"deptId\":\"2031575046338232321\",\"parentId\":101,\"deptName\":\"财务部门\",\"deptCategory\":null,\"orderNum\":2,\"leader\":null,\"phone\":null,\"email\":null,\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:39:57',43),(2031575881688399874,'000000','部门管理',2,'org.dromara.system.controller.system.SysDeptController.edit()','PUT',1,'admin','研发部门','/system/dept','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-09 08:58:34\",\"updateBy\":null,\"updateTime\":null,\"deptId\":103,\"parentId\":101,\"deptName\":\"风控部门\",\"deptCategory\":null,\"orderNum\":1,\"leader\":1,\"phone\":\"15888888888\",\"email\":\"xxx@qq.com\",\"status\":\"0\",\"belongDeptId\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:40:10',43),(2031576048642670594,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":104,\"parentId\":1,\"menuName\":\"岗位管理\",\"orderNum\":5,\"path\":\"post\",\"component\":\"system/post/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"system:post:list\",\"icon\":\"post\",\"remark\":\"岗位管理菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:40:50',47),(2031576073405841410,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":105,\"parentId\":1,\"menuName\":\"字典管理\",\"orderNum\":6,\"path\":\"dict\",\"component\":\"system/dict/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"system:dict:list\",\"icon\":\"dict\",\"remark\":\"字典管理菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:40:55',31),(2031576115034308609,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":106,\"parentId\":1,\"menuName\":\"参数设置\",\"orderNum\":7,\"path\":\"config\",\"component\":\"system/config/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"system:config:list\",\"icon\":\"edit\",\"remark\":\"参数设置菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:41:05',36),(2031576173393854466,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','研发部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":123,\"parentId\":1,\"menuName\":\"客户端管理\",\"orderNum\":11,\"path\":\"client\",\"component\":\"system/client/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"system:client:list\",\"icon\":\"international\",\"remark\":\"客户端管理菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 11:41:19',34),(2031633315169681410,'000000','通知公告',3,'org.dromara.system.controller.system.SysNoticeController.remove()','DELETE',1,'admin','风控部门','/system/notice/1','127.0.0.1','内网IP','[1]','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:28:23',28),(2031633323747033089,'000000','通知公告',3,'org.dromara.system.controller.system.SysNoticeController.remove()','DELETE',1,'admin','风控部门','/system/notice/2','127.0.0.1','内网IP','[2]','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:28:25',23),(2031634048334020610,'000000','通知公告',1,'org.dromara.system.controller.system.SysNoticeController.add()','POST',1,'admin','风控部门','/system/notice','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"noticeId\":null,\"noticeTitle\":\"系统开放\",\"noticeType\":\"1\",\"noticeContent\":\"<p>基于基于用户身份验证与数据安全存储的汽车租赁系统今日正式上线，欢迎大家访问</p>\",\"status\":\"0\",\"remark\":\"\",\"createByName\":\"\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:31:18',44),(2031634187383586817,'000000','通知公告',1,'org.dromara.system.controller.system.SysNoticeController.add()','POST',1,'admin','风控部门','/system/notice','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"noticeId\":null,\"noticeTitle\":\"系统维护\",\"noticeType\":\"2\",\"noticeContent\":\"<p>今日系统维护，暂停使用</p>\",\"status\":\"0\",\"remark\":\"\",\"createByName\":\"\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:31:51',18),(2031634404224909313,'000000','用户管理',1,'org.dromara.system.controller.system.SysUserController.add()','POST',1,'admin','风控部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"2031634404090691585\",\"deptId\":\"2031574936300666882\",\"userName\":\"zhangsan\",\"nickName\":\"张三\",\"userType\":null,\"email\":null,\"phonenumber\":null,\"sex\":\"0\",\"status\":\"0\",\"remark\":\"\",\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:32:43',157),(2031634524966338561,'000000','用户管理',1,'org.dromara.system.controller.system.SysUserController.add()','POST',1,'admin','风控部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"2031634524832120833\",\"deptId\":\"2031575046338232321\",\"userName\":\"lisi\",\"nickName\":\"李四\",\"userType\":null,\"email\":null,\"phonenumber\":null,\"sex\":null,\"status\":\"0\",\"remark\":\"\",\"roleIds\":[4],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:33:11',170),(2031635926274916354,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031564170625294337\",\"menuName\":\"新增车辆\",\"orderNum\":1,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:car:add\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:38:45',13),(2031635978833739778,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031564170625294337\",\"menuName\":\"修改车辆\",\"orderNum\":2,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:car:edit\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:38:58',20),(2031636047410610178,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031564170625294337\",\"menuName\":\"删除车辆\",\"orderNum\":3,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:car:remove\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:39:14',27),(2031636143875407874,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031564170625294337\",\"menuName\":\"导出车辆\",\"orderNum\":5,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:car:export\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:39:37',14),(2031636325899812866,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031567121855029250\",\"menuName\":\"删除订单\",\"orderNum\":3,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:order:remove\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:40:21',19),(2031636449212350466,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031567121855029250\",\"menuName\":\"导出订单\",\"orderNum\":4,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:order:export\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:40:50',19),(2031636513011908610,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031565397085921281\",\"menuName\":\"新增客户\",\"orderNum\":1,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:customer:add\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:41:05',27),(2031636572281618433,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031565397085921281\",\"menuName\":\"修改客户\",\"orderNum\":2,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:customer:edit\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:41:19',20),(2031636673557282817,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031565397085921281\",\"menuName\":\"删除客户\",\"orderNum\":1,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:customer:remove\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:41:44',30),(2031636743425998849,'000000','菜单管理',1,'org.dromara.system.controller.system.SysMenuController.add()','POST',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":\"2031565397085921281\",\"menuName\":\"导出客户\",\"orderNum\":1,\"path\":\"\",\"component\":null,\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"F\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"rental:customer:export\",\"icon\":\"\",\"remark\":null}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:42:00',10),(2031636870551158786,'000000','角色管理',2,'org.dromara.system.controller.system.SysRoleController.edit()','PUT',1,'admin','风控部门','/system/role','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"roleId\":3,\"roleName\":\"普通员工\",\"roleKey\":\"test1\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[1,100,1001,1002,1003,1004,1005,1006,1007,131,101,1008,1009,1010,1011,1012,130,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,132,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,1050,118,1600,1601,1602,1603,1620,1621,1622,1623,133,123,1061,1062,1063,1064,1065,5,1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511],\"deptIds\":[],\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:42:31',100),(2031636921386123265,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','风控部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 15:32:43\",\"updateBy\":null,\"updateTime\":null,\"userId\":\"2031634404090691585\",\"deptId\":\"2031574936300666882\",\"userName\":\"zhangsan\",\"nickName\":\"张三\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":\"\",\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:42:43',45),(2031636948665876482,'000000','用户管理',2,'org.dromara.system.controller.system.SysUserController.edit()','PUT',1,'admin','风控部门','/system/user','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 15:33:11\",\"updateBy\":null,\"updateTime\":null,\"userId\":\"2031634524832120833\",\"deptId\":\"2031575046338232321\",\"userName\":\"lisi\",\"nickName\":\"李四\",\"userType\":\"sys_user\",\"email\":\"\",\"phonenumber\":\"\",\"sex\":\"0\",\"status\":\"0\",\"remark\":\"\",\"roleIds\":[3],\"postIds\":[],\"roleId\":null,\"userIds\":null,\"excludeUserIds\":null,\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:42:49',47),(2031637119848005633,'000000','角色管理',2,'org.dromara.system.controller.system.SysRoleController.edit()','PUT',1,'admin','风控部门','/system/role','127.0.0.1','内网IP','{\"createDept\":null,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"roleId\":3,\"roleName\":\"普通员工\",\"roleKey\":\"test1\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":false,\"deptCheckStrictly\":true,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[100,1001,1002,1003,1004,1005,1006,1007,131,101,1008,1009,1010,1011,1012,130,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,105,1026,1027,1028,1029,1030,132,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,108,500,1040,1041,1042,501,1043,1044,1045,1050,118,1600,1601,1602,1603,1620,1621,1622,1623,133,123,1061,1062,1063,1064,1065,\"2031559659370323969\",\"2031564170625294337\",\"2031635926207807489\",\"2031635978770825218\",\"2031636143812493313\",\"2031565397085921281\",\"2031636512953188354\",\"2031636743363084290\",\"2031636572222898177\",\"2031567121855029250\",\"2031567289136455682\",\"2031567402382663681\",\"2031636449145241602\"],\"deptIds\":[],\"superAdmin\":false}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:43:30',55),(2031637372462546945,'000000','车辆管理',5,'org.dromara.rental.controller.BusCarController.export()','POST',1,'zhangsan','客服部门','/rental/car/export','127.0.0.1','内网IP','{\"pageSize\":\"10\",\"pageNum\":\"1\"}','',0,'','2026-03-11 15:44:30',2007),(2031637518281719810,'000000','菜单管理',2,'org.dromara.system.controller.system.SysMenuController.edit()','PUT',1,'admin','风控部门','/system/menu','127.0.0.1','内网IP','{\"createDept\":103,\"createBy\":null,\"createTime\":\"2026-03-11 09:50:53\",\"updateBy\":null,\"updateTime\":null,\"menuId\":102,\"parentId\":1,\"menuName\":\"菜单管理\",\"orderNum\":3,\"path\":\"menu\",\"component\":\"system/menu/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"perms\":\"system:menu:list\",\"icon\":\"tree-table\",\"remark\":\"菜单管理菜单\"}','{\"code\":200,\"msg\":\"操作成功\",\"data\":null}',0,'','2026-03-11 15:45:05',37);
/*!40000 ALTER TABLE `sys_oper_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oss`
--

DROP TABLE IF EXISTS `sys_oss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oss` (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) NOT NULL COMMENT 'URL地址',
  `ext1` text COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '上传人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='OSS对象存储表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oss`
--

LOCK TABLES `sys_oss` WRITE;
/*!40000 ALTER TABLE `sys_oss` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_oss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_oss_config`
--

DROP TABLE IF EXISTS `sys_oss_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_oss_config` (
  `oss_config_id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) DEFAULT '' COMMENT '域',
  `access_policy` char(1) NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='对象存储配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_oss_config`
--

LOCK TABLES `sys_oss_config` WRITE;
/*!40000 ALTER TABLE `sys_oss_config` DISABLE KEYS */;
INSERT INTO `sys_oss_config` VALUES (1,'000000','minio','ruoyi','ruoyi123','ruoyi','','127.0.0.1:9000','','N','','1','0','',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55',NULL),(2,'000000','qiniu','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi','','s3-cn-north-1.qiniucs.com','','N','','1','1','',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55',NULL),(3,'000000','aliyun','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi','','oss-cn-beijing.aliyuncs.com','','N','','1','1','',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55',NULL),(4,'000000','qcloud','XXXXXXXXXXXXXXX','XXXXXXXXXXXXXXX','ruoyi-1240000000','','cos.ap-beijing.myqcloud.com','','N','ap-beijing','1','1','',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55',NULL),(5,'000000','image','ruoyi','ruoyi123','ruoyi','image','127.0.0.1:9000','','N','','1','1','',103,1,'2026-03-11 09:50:55',1,'2026-03-11 09:50:55',NULL);
/*!40000 ALTER TABLE `sys_oss_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_post`
--

DROP TABLE IF EXISTS `sys_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_category` varchar(100) DEFAULT NULL COMMENT '岗位类别编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='岗位信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--

LOCK TABLES `sys_post` WRITE;
/*!40000 ALTER TABLE `sys_post` DISABLE KEYS */;
INSERT INTO `sys_post` VALUES (1,'000000',103,'ceo',NULL,'董事长',1,'0',103,1,'2026-03-11 09:50:53',NULL,NULL,'');
/*!40000 ALTER TABLE `sys_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限 5：仅本人数据权限 6：部门及以下或本人数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'000000','超级管理员','superadmin',1,'1',1,1,'0','0',103,1,'2026-03-11 09:50:53',NULL,NULL,'超级管理员'),(3,'000000','普通员工','test1',3,'4',0,1,'0','0',103,1,'2026-03-11 09:50:53',1,'2026-03-11 15:43:30',''),(4,'000000','仅本人','test2',4,'5',1,1,'0','0',103,1,'2026-03-11 09:50:53',NULL,NULL,'');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_dept`
--

DROP TABLE IF EXISTS `sys_role_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和部门关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和菜单关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (3,100),(3,101),(3,102),(3,103),(3,104),(3,105),(3,106),(3,107),(3,108),(3,118),(3,123),(3,130),(3,131),(3,132),(3,133),(3,500),(3,501),(3,1001),(3,1002),(3,1003),(3,1004),(3,1005),(3,1006),(3,1007),(3,1008),(3,1009),(3,1010),(3,1011),(3,1012),(3,1013),(3,1014),(3,1015),(3,1016),(3,1017),(3,1018),(3,1019),(3,1020),(3,1021),(3,1022),(3,1023),(3,1024),(3,1025),(3,1026),(3,1027),(3,1028),(3,1029),(3,1030),(3,1031),(3,1032),(3,1033),(3,1034),(3,1035),(3,1036),(3,1037),(3,1038),(3,1039),(3,1040),(3,1041),(3,1042),(3,1043),(3,1044),(3,1045),(3,1050),(3,1061),(3,1062),(3,1063),(3,1064),(3,1065),(3,1600),(3,1601),(3,1602),(3,1603),(3,1620),(3,1621),(3,1622),(3,1623),(3,2031559659370323969),(3,2031564170625294337),(3,2031565397085921281),(3,2031567121855029250),(3,2031567289136455682),(3,2031567402382663681),(3,2031635926207807489),(3,2031635978770825218),(3,2031636143812493313),(3,2031636449145241602),(3,2031636512953188354),(3,2031636572222898177),(3,2031636743363084290),(4,5),(4,1500),(4,1501),(4,1502),(4,1503),(4,1504),(4,1505),(4,1506),(4,1507),(4,1508),(4,1509),(4,1510),(4,1511);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_social`
--

DROP TABLE IF EXISTS `sys_social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_social` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户id',
  `auth_id` varchar(255) NOT NULL COMMENT '平台+平台唯一id',
  `source` varchar(255) NOT NULL COMMENT '用户来源',
  `open_id` varchar(255) DEFAULT NULL COMMENT '平台编号唯一id',
  `user_name` varchar(30) NOT NULL COMMENT '登录账号',
  `nick_name` varchar(30) DEFAULT '' COMMENT '用户昵称',
  `email` varchar(255) DEFAULT '' COMMENT '用户邮箱',
  `avatar` varchar(500) DEFAULT '' COMMENT '头像地址',
  `access_token` varchar(2000) NOT NULL COMMENT '用户的授权令牌',
  `expire_in` int DEFAULT NULL COMMENT '用户的授权令牌的有效期，部分平台可能没有',
  `refresh_token` varchar(255) DEFAULT NULL COMMENT '刷新令牌，部分平台可能没有',
  `access_code` varchar(2000) DEFAULT NULL COMMENT '平台的授权信息，部分平台可能没有',
  `union_id` varchar(255) DEFAULT NULL COMMENT '用户的 unionid',
  `scope` varchar(255) DEFAULT NULL COMMENT '授予的权限，部分平台可能没有',
  `token_type` varchar(255) DEFAULT NULL COMMENT '个别平台的授权信息，部分平台可能没有',
  `id_token` varchar(2000) DEFAULT NULL COMMENT 'id token，部分平台可能没有',
  `mac_algorithm` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `mac_key` varchar(255) DEFAULT NULL COMMENT '小米平台用户的附带属性，部分平台可能没有',
  `code` varchar(255) DEFAULT NULL COMMENT '用户的授权code，部分平台可能没有',
  `oauth_token` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `oauth_token_secret` varchar(255) DEFAULT NULL COMMENT 'Twitter平台用户的附带属性，部分平台可能没有',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='社会化关系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_social`
--

LOCK TABLES `sys_social` WRITE;
/*!40000 ALTER TABLE `sys_social` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_social` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant`
--

DROP TABLE IF EXISTS `sys_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant` (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(30) DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `package_id` bigint DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `account_count` int DEFAULT '-1' COMMENT '用户数量（-1不限制）',
  `status` char(1) DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant`
--

LOCK TABLES `sys_tenant` WRITE;
/*!40000 ALTER TABLE `sys_tenant` DISABLE KEYS */;
INSERT INTO `sys_tenant` VALUES (1,'000000','管理组','15888888888','XXX有限公司',NULL,NULL,'多租户通用后台管理管理系统',NULL,NULL,NULL,NULL,-1,'0','0',103,1,'2026-03-11 09:50:52',NULL,NULL);
/*!40000 ALTER TABLE `sys_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_tenant_package`
--

DROP TABLE IF EXISTS `sys_tenant_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_tenant_package` (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户套餐表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_tenant_package`
--

LOCK TABLES `sys_tenant_package` WRITE;
/*!40000 ALTER TABLE `sys_tenant_package` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_tenant_package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` bigint DEFAULT NULL COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'000000',103,'admin','疯狂的狮子Li','sys_user','crazyLionLi@163.com','15888888888','1',NULL,'$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2','0','0','127.0.0.1','2026-03-11 15:44:43',103,1,'2026-03-11 09:50:53',-1,'2026-03-11 15:44:43','管理员'),(3,'000000',2031574936300666882,'test','本部门及以下 密码666666','sys_user','','','0',NULL,'$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne','0','0','127.0.0.1','2026-03-11 09:50:53',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:37:08',NULL),(4,'000000',2031575046338232321,'test1','仅本人 密码666666','sys_user','','','0',NULL,'$2a$10$b8yUzN0C71sbz.PhNOCgJe.Tu1yWC3RNrTyjSQ8p1W0.aaUXUJ.Ne','0','0','127.0.0.1','2026-03-11 09:50:53',103,1,'2026-03-11 09:50:53',1,'2026-03-11 11:37:12',NULL),(2031634404090691585,'000000',2031574936300666882,'zhangsan','张三','sys_user','','','0',NULL,'$2a$10$XC.BwHT2MiGwLdloTUM55uksQlIz9hWFaWXBqfzpSi7H4F2L5aLK6','0','0','127.0.0.1','2026-03-11 15:44:03',103,1,'2026-03-11 15:32:43',-1,'2026-03-11 15:44:03',''),(2031634524832120833,'000000',2031575046338232321,'lisi','李四','sys_user','','','0',NULL,'$2a$10$iOzwJ/uXjB6OWUptZWqex.WThYeLStbe2cmCBs2M8ma9IqhMcDywS','0','0','',NULL,103,1,'2026-03-11 15:33:11',1,'2026-03-11 15:42:49','');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_post`
--

DROP TABLE IF EXISTS `sys_user_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户与岗位关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--

LOCK TABLES `sys_user_post` WRITE;
/*!40000 ALTER TABLE `sys_user_post` DISABLE KEYS */;
INSERT INTO `sys_user_post` VALUES (1,1);
/*!40000 ALTER TABLE `sys_user_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和角色关联表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (1,1),(3,3),(4,4),(2031634404090691585,3),(2031634524832120833,3);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_demo`
--

DROP TABLE IF EXISTS `test_demo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_demo` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `order_num` int DEFAULT '0' COMMENT '排序号',
  `test_key` varchar(255) DEFAULT NULL COMMENT 'key键',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_demo`
--

LOCK TABLES `test_demo` WRITE;
/*!40000 ALTER TABLE `test_demo` DISABLE KEYS */;
INSERT INTO `test_demo` VALUES (1,'000000',102,4,1,'测试数据权限','测试',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(2,'000000',102,3,2,'子节点1','111',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(3,'000000',102,3,3,'子节点2','222',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(4,'000000',108,4,4,'测试数据','demo',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(5,'000000',108,3,13,'子节点11','1111',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(6,'000000',108,3,12,'子节点22','2222',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(7,'000000',108,3,11,'子节点33','3333',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(8,'000000',108,3,10,'子节点44','4444',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(9,'000000',108,3,9,'子节点55','5555',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(10,'000000',108,3,8,'子节点66','6666',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(11,'000000',108,3,7,'子节点77','7777',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(12,'000000',108,3,6,'子节点88','8888',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(13,'000000',108,3,5,'子节点99','9999',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0);
/*!40000 ALTER TABLE `test_demo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_tree`
--

DROP TABLE IF EXISTS `test_tree`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_tree` (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父id',
  `dept_id` bigint DEFAULT NULL COMMENT '部门id',
  `user_id` bigint DEFAULT NULL COMMENT '用户id',
  `tree_name` varchar(255) DEFAULT NULL COMMENT '值',
  `version` int DEFAULT '0' COMMENT '版本',
  `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人',
  `del_flag` int DEFAULT '0' COMMENT '删除标志',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='测试树表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_tree`
--

LOCK TABLES `test_tree` WRITE;
/*!40000 ALTER TABLE `test_tree` DISABLE KEYS */;
INSERT INTO `test_tree` VALUES (1,'000000',0,102,4,'测试数据权限',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(2,'000000',1,102,3,'子节点1',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(3,'000000',2,102,3,'子节点2',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(4,'000000',0,108,4,'测试树1',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(5,'000000',4,108,3,'子节点11',0,103,'2026-03-11 09:50:55',1,NULL,NULL,0),(6,'000000',4,108,3,'子节点22',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(7,'000000',4,108,3,'子节点33',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(8,'000000',5,108,3,'子节点44',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(9,'000000',6,108,3,'子节点55',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(10,'000000',7,108,3,'子节点66',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(11,'000000',7,108,3,'子节点77',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(12,'000000',10,108,3,'子节点88',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0),(13,'000000',10,108,3,'子节点99',0,103,'2026-03-11 09:50:56',1,NULL,NULL,0);
/*!40000 ALTER TABLE `test_tree` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_rental'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-11 15:47:57
