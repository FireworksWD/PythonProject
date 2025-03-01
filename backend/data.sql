-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fuadmin
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `mall_product`
--

DROP TABLE IF EXISTS `mall_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mall_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(10,2) NOT NULL,
  `number` int NOT NULL,
  `user_id` int NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` varchar(256) NOT NULL,
  `img_url` varchar(100) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `categoryName` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mall_product`
--

LOCK TABLES `mall_product` WRITE;
/*!40000 ALTER TABLE `mall_product` DISABLE KEYS */;
INSERT INTO `mall_product` VALUES (1,330.00,1500,1,'8/10kg洗衣机全自动家用租房小型波轮大容量带烘干洗烘一体12公斤','8/10kg洗衣机全自动家用租房小型波轮大容量带烘干洗烘一体12公斤','images/20240314/20240314152610787951_1.jpg','2024-03-14 07:28:51','清洁电器'),(2,209.00,2566,1,'荣事达吸尘器家用大吸力小型车用强力大功率装修美缝工业吸尘机','荣事达吸尘器家用大吸力小型车用强力大功率装修美缝工业吸尘机','images/20240314/20240314152914344422_2.jpg','2024-03-14 07:30:19','清洁电器/厨房电器'),(3,23.90,15678,1,'万利达电热水壶家用304不锈钢烧水壶保温一体宿舍智能恒温开水壶','万利达电热水壶家用304不锈钢烧水壶保温一体宿舍智能恒温开水壶','images/20240314/20240314153441209719_3.jpg','2024-03-14 07:35:11','厨房电器/电暖器具'),(4,398.00,1256,1,'扬子洗衣机全自动家用波轮洗脱一体洗衣机小型出租房用宿舍10公斤','扬子洗衣机全自动家用波轮洗脱一体洗衣机小型出租房用宿舍10公斤','images/20240314/20240314153540379398_4.jpg','2024-03-14 07:36:02','清洁电器'),(5,418.00,1234,1,'中国扬子电器出品洗衣机全自动家用10KG小型出租房屋宿舍洗脱一体','中国扬子电器出品洗衣机全自动家用10KG小型出租房屋宿舍洗脱一体','images/20240314/20240314153632175277_5.jpg','2024-03-14 07:36:57','清洁电器'),(6,32.00,4778,1,'内衣裤折叠洗衣机迷你小型自动婴儿洗衣机宿舍专用洗袜子神器便携','内衣裤折叠洗衣机迷你小型自动婴儿洗衣机宿舍专用洗袜子神器便携','images/20240314/20240314153743486989_6.jpg','2024-03-14 07:38:03','清洁电器/其他电器'),(7,79.00,9876,1,'飞科吹风机家用大功率负离子恒温速干护发电吹风学生宿舍用风筒机','飞科吹风机家用大功率负离子恒温速干护发电吹风学生宿舍用风筒机','images/20240314/20240314153831428646_7.jpg','2024-03-14 07:38:57','清洁电器/其他电器/电暖器具'),(8,33.00,456,1,'折叠迷你洗衣机小型洗袜子神器内衣内裤家用洗脱一体洗袜子机家用','折叠迷你洗衣机小型洗袜子神器内衣内裤家用洗脱一体洗袜子机家用','images/20240314/20240314153925396071_8.jpg','2024-03-14 07:39:40','清洁电器/其他电器/电暖器具'),(9,89.00,256,1,'红双喜干衣机烘干机家用烘衣服小型烘衣机速干可折叠风干机宿舍CW','红双喜干衣机烘干机家用烘衣服小型烘衣机速干可折叠风干机宿舍CW','images/20240314/20240314154010802805_9.jpg','2024-03-14 07:40:24','清洁电器/其他电器/电暖器具'),(10,218.00,786,1,'好太太大吸力抽油烟机家用厨房双电机排油机出租房小型侧吸油烟机','好太太大吸力抽油烟机家用厨房双电机排油机出租房小型侧吸油烟机','images/20240314/20240314154152873568_10.jpg','2024-03-14 07:42:13','清洁电器/其他电器/电暖器具/厨房电器'),(11,189.00,123,1,'内衣裤洗衣机内裤洗袜机小型全自动迷你微型分桶专用洗袜子神器','内衣裤洗衣机内裤洗袜机小型全自动迷你微型分桶专用洗袜子神器','images/20240314/20240314154304272414_11.jpg','2024-03-14 07:43:22','清洁电器/其他电器/电暖器具'),(12,30.00,0,1,'饮水机台式小型家用全自动智能迷你冷热两用桌面桶装水宿舍办公室','饮水机台式小型家用全自动智能迷你冷热两用桌面桶装水宿舍办公室','images/20240314/20240314154402563605_12.jpg','2024-03-14 07:44:19','清洁电器/其他电器/电暖器具/厨房电器/制冷电器'),(13,28.90,986,1,'万利达电热水壶保温一体大容量快烧水壶学生宿舍自动断电热壶家用','万利达电热水壶保温一体大容量快烧水壶学生宿舍自动断电热壶家用','images/20240314/20240314154452760705_13.jpg','2024-03-14 07:45:14','其他电器/电暖器具/厨房电器'),(14,247.00,1256,1,'智能数显仪表4-20ma导轨壁挂式数字显示温度压力水位液位控制DN10','智能数显仪表4-20ma导轨壁挂式数字显示温度压力水位液位控制DN10','images/20240314/20240314154611575473_14.jpg','2024-03-14 07:46:31','声像电器/其他电器/厨房电器'),(15,68.00,1456,1,'虹润温控器 数显智能温控仪工业温度控制器pid温控表恒温恒压A300','虹润温控器 数显智能温控仪工业温度控制器pid温控表恒温恒压A300','images/20240314/20240314154706320911_15.jpg','2024-03-14 07:47:16','声像电器/其他电器/厨房电器'),(16,3970.00,1256,1,'索威 M8 专业有源同轴音箱发烧HIFI蜂巢散热声像定位客厅电脑音箱','索威 M8 专业有源同轴音箱发烧HIFI蜂巢散热声像定位客厅电脑音箱','images/20240314/20240314154751232869_16.jpg','2024-03-14 07:48:09','声像电器/其他电器'),(17,2800.00,241,1,'360磁光美容院专用OPT808冰点仪器810洗眉一体机无创黑科技','360磁光美容院专用OPT808冰点仪器810洗眉一体机无创黑科技','images/20240314/20240314154859787169_17.jpg','2024-03-14 07:49:21','整容保健电器/其他电器'),(18,53.00,246,1,'煎药壶全自动熬药多功能通用底座分体式炖汤药定时预约家用电陶炉','煎药壶全自动熬药多功能通用底座分体式炖汤药定时预约家用电陶炉','images/20240314/20240314154953728142_18.jpg','2024-03-14 07:50:10','整容保健电器/其他电器'),(19,3449.00,456,1,'【1台也优惠】美的空调大1.5匹酷省电新一级变频冷暖卧室家用挂机','【1台也优惠】美的空调大1.5匹酷省电新一级变频冷暖卧室家用挂机','images/20240314/20240314155102732577_19.jpg','2024-03-14 07:51:18','其他电器/制冷电器/空调器/电暖器具'),(20,19799.00,41,1,'大金空调旗舰官方官网大3匹变频1级能效客厅冷暖柜机帕蒂能F172机','大金空调旗舰官方官网大3匹变频1级能效客厅冷暖柜机帕蒂能F172机','images/20240314/20240314155200251745_20.jpg','2024-03-14 07:52:20','其他电器/制冷电器/空调器/电暖器具'),(21,2999.00,785,1,'华凌空调挂机1.5匹新一级能效大风口家用变频智能冷暖35HL1Pro','华凌空调挂机1.5匹新一级能效大风口家用变频智能冷暖35HL1Pro','images/20240314/20240314155252193933_21.jpg','2024-03-14 07:53:04','其他电器/制冷电器/空调器/电暖器具'),(22,148.00,567,1,'空调扇移动小空调家用静音制冷小空调不加水卧室小型一体机电风扇','空调扇移动小空调家用静音制冷小空调不加水卧室小型一体机电风扇','images/20240314/20240314155350535025_22.jpg','2024-03-14 07:54:04','其他电器/制冷电器/空调器/电暖器具'),(23,249.00,789,1,'骆驼取暖器冷暖两用空调扇家用制冷速热神器节能省电暖气冷暖风机','骆驼取暖器冷暖两用空调扇家用制冷速热神器节能省电暖气冷暖风机','images/20240314/20240314155445230129_23.jpg','2024-03-14 07:54:55','其他电器/制冷电器/空调器/电暖器具'),(24,319.00,156,1,'冷暖两用空调扇制冷风机一体机家用静音神器移动水冷风扇小型空调','冷暖两用空调扇制冷风机一体机家用静音神器移动水冷风扇小型空调','images/20240314/20240314155548458753_24.jpg','2024-03-14 07:56:01','制冷电器/空调器/电暖器具'),(25,208.00,1478,1,'冷暖两用空调扇暖风机壁挂式制热一体机卧室静音省电可移动小空调','冷暖两用空调扇暖风机壁挂式制热一体机卧室静音省电可移动小空调','images/20240314/20240314155633999234_25.jpg','2024-03-14 07:56:51','制冷电器/空调器/电暖器具'),(26,1998.75,654,1,'奥克斯空调大1/1.5匹p一三级变频壁挂机式2/3匹p冷暖省电官方旗舰','奥克斯空调大1/1.5匹p一三级变频壁挂机式2/3匹p冷暖省电官方旗舰','images/20240314/20240314155726110084_26.jpg','2024-03-14 07:57:44','制冷电器/空调器/电暖器具'),(27,179.00,446,1,'康佳空调扇制冷风扇加水冷风机冷气扇家用宿舍神器移动小型空调扇','康佳空调扇制冷风扇加水冷风机冷气扇家用宿舍神器移动小型空调扇','images/20240314/20240314155822537779_27.jpg','2024-03-14 07:58:32','制冷电器/空调器/电暖器具'),(28,278.00,159,1,'骆驼空调扇冷暖两用取暖器家用制冷速热立式负离子石墨烯冷暖风机','骆驼空调扇冷暖两用取暖器家用制冷速热立式负离子石墨烯冷暖风机','images/20240314/20240314155904572797_28.jpg','2024-03-14 07:59:14','制冷电器/空调器/电暖器具'),(29,388.00,1590,1,'工业冷风机大型水空调扇室外加水制冷风扇喷雾冷气扇厂房降温神器','工业冷风机大型水空调扇室外加水制冷风扇喷雾冷气扇厂房降温神器','images/20240314/20240314155945191046_29.jpg','2024-03-14 07:59:57','制冷电器/空调器/电暖器具'),(30,218.00,445,1,'好太太双电机抽油烟机家用厨房大吸力排油机自清洗小型侧吸油烟机','好太太双电机抽油烟机家用厨房大吸力排油机自清洗小型侧吸油烟机','images/20240314/20240314160042598790_30.jpg','2024-03-14 08:00:59','厨房电器/清洁电器'),(31,27.57,364,1,'特价万利达双层防烫烧水壶不锈钢全自动断电保温泡茶煮电热开水壶','特价万利达双层防烫烧水壶不锈钢全自动断电保温泡茶煮电热开水壶','images/20240314/20240314160131396649_31.jpg','2024-03-14 08:02:02','厨房电器'),(32,69.90,456,1,'正品半球3500W大功率电磁炉家用 爆炒防水触摸火锅多功能套装炉灶','正品半球3500W大功率电磁炉家用 爆炒防水触摸火锅多功能套装炉灶','images/20240314/20240314160228548780_32.jpg','2024-03-14 08:02:38','厨房电器'),(33,88.00,249,1,'扬子蜂窝电炒锅多功能家用电热锅蒸煮一体式炒菜不粘电锅电煮锅','扬子蜂窝电炒锅多功能家用电热锅蒸煮一体式炒菜不粘电锅电煮锅','images/20240314/20240314160525834522_33.jpg','2024-03-14 08:05:34','厨房电器'),(34,39.90,459,1,'奥卡恩筷子消毒机厨房家用小型智能紫外线充电式消毒壁挂式快子筒','奥卡恩筷子消毒机厨房家用小型智能紫外线充电式消毒壁挂式快子筒','images/20240314/20240314160605437050_34.jpg','2024-03-14 08:06:20','厨房电器/清洁电器'),(35,49.00,4599,1,'电炒锅多功能家用铸铁电热锅电炒菜锅爆炒一体式插电电煮锅涮火锅','电炒锅多功能家用铸铁电热锅电炒菜锅爆炒一体式插电电煮锅涮火锅','images/20240314/20240314160656157833_35.jpg','2024-03-14 08:07:14','厨房电器/电暖器具'),(36,39.00,569,1,'电饭煲家用1一2人多功能蒸煮两用迷你小型一人单小电饭锅煮饭锅','电饭煲家用1一2人多功能蒸煮两用迷你小型一人单小电饭锅煮饭锅','images/20240314/20240314160740379887_36.jpg','2024-03-14 08:08:07','厨房电器/电暖器具'),(37,99.00,478,1,'抽烟机家用厨房大吸力农村抽油烟机商用强力柴火灶土灶用吸油机','抽烟机家用厨房大吸力农村抽油烟机商用强力柴火灶土灶用吸油机','images/20240314/20240314160852147124_37.jpg','2024-03-14 08:09:04','厨房电器/清洁电器'),(38,119.00,119,1,'消毒碗柜家用小型厨房碗碟收纳架杯子奶瓶免沥水烘干台式紫外线','消毒碗柜家用小型厨房碗碟收纳架杯子奶瓶免沥水烘干台式紫外线','images/20240314/20240314161532400671_38.jpg','2024-03-14 08:15:48','厨房电器/清洁电器'),(39,59.00,59,1,'EIT电饭煲1一2一3人家用智能多功能可蒸煮煮饭锅迷你小型小电饭锅','EIT电饭煲1一2一3人家用智能多功能可蒸煮煮饭锅迷你小型小电饭锅','images/20240314/20240314161620722057_39.jpg','2024-03-14 08:16:28','厨房电器/清洁电器'),(40,126.00,126,1,'半球抽油烟机大吸力小型老式厨房家用租房抽烟机吸油畑姻老款排','半球抽油烟机大吸力小型老式厨房家用租房抽烟机吸油畑姻老款排','images/20240314/20240314161658984896_40.jpg','2024-03-14 08:17:13','厨房电器/清洁电器'),(41,2880.00,2465,1,'意大利水暖取暖器对流式墙暖卧室电暖气片壁挂式暖风机水电暖器','意大利水暖取暖器对流式墙暖卧室电暖气片壁挂式暖风机水电暖器','images/20240314/20240314161755274228_41.jpg','2024-03-14 08:18:10','其他电器/电暖器具/空调器'),(42,198.00,785,1,'暖风机取暖器家用节能省电石墨烯电加热冬天暖气办公室浴室烤火炉','暖风机取暖器家用节能省电石墨烯电加热冬天暖气办公室浴室烤火炉','images/20240314/20240314161835448087_42.jpg','2024-03-14 08:18:51','电暖器具/空调器'),(43,798.00,423,1,'托玛琳床垫锗石沙发垫加热垫保暖保健汗蒸垫电热垫排寒养生','托玛琳床垫锗石沙发垫加热垫保暖保健汗蒸垫电热垫排寒养生','images/20240314/20240314161928424047_43.jpg','2024-03-14 08:19:43','电暖器具'),(44,228.00,4956,1,'可爱充电暖脚宝足底按摩器揉捏暖脚神器家用桌下取暖器冬季暖脚器','可爱充电暖脚宝足底按摩器揉捏暖脚神器家用桌下取暖器冬季暖脚器','images/20240314/20240314162025217915_44.jpg','2024-03-14 08:20:36','电暖器具'),(45,11.70,963,1,'围炉煮茶烧烤火炉子聚全套装工器具桌炭火盆户外家庭用室内冬天日','围炉煮茶烧烤火炉子聚全套装工器具桌炭火盆户外家庭用室内冬天日','images/20240314/20240314162103892166_45.jpg','2024-03-14 08:21:15','电暖器具/厨房电器'),(46,160.00,442,1,'虹润配电器模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23','虹润配电器模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23','images/20240314/20240314162155450433_46.jpg','2024-03-14 08:22:08','其他电器'),(47,40.91,963,1,'家用电饭锅1-2人多功能3L4迷你小型5-6人智能煮饭学生宿舍电饭煲','家用电饭锅1-2人多功能3L4迷你小型5-6人智能煮饭学生宿舍电饭煲','images/20240314/20240314162246894735_47.jpg','2024-03-14 08:22:59','其他电器/厨房电器'),(48,458.00,997,1,'Play 00:05 00:59   艾丁新款共振音箱远程播放控制蓝牙震动发声骨传导音响APP遥控U盘','Play\n00:05\n00:59\n\n\n艾丁新款共振音箱远程播放控制蓝牙震动发声骨传导音响APP遥控U盘','images/20240314/20240314162336880067_48.jpg','2024-03-14 08:23:48','声像电器'),(49,549.00,362,1,'Divoom点音蓝牙音箱小型家庭KTV麦克风小魔女k歌音响女唱歌话筒','Divoom点音蓝牙音箱小型家庭KTV麦克风小魔女k歌音响女唱歌话筒','images/20240314/20240314162415218781_49.jpg','2024-03-14 08:24:30','声像电器'),(50,34.00,663,1,'笔记本电脑小音响台式机桌面USB多媒体小音箱办公室迷超重低音炮','笔记本电脑小音响台式机桌面USB多媒体小音箱办公室迷超重低音炮','images/20240314/20240314162511372464_50.jpg','2024-03-14 08:25:22','声像电器');
/*!40000 ALTER TABLE `mall_product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-14 16:32:18


/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:00:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_address
-- ----------------------------
DROP TABLE IF EXISTS `mall_address`;
CREATE TABLE `mall_address`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `contact_number` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `delivery_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `detailed_address` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `is_default` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_address
-- ----------------------------
INSERT INTO `mall_address` VALUES (1, '霍建华', '1008611', '北京市/市辖区/朝阳区', '北京大学', 0, '2024-03-14 17:42:07.871891', 16);
INSERT INTO `mall_address` VALUES (2, '胡歌', '123456', '上海市/市辖区/黄浦区', '清华大学', 1, '2024-03-14 18:02:16.342295', 16);
INSERT INTO `mall_address` VALUES (3, '赵丽颖', '10086', '天津市/市辖区/河西区', '麻省理工大学', 1, '2024-04-16 21:11:09.329409', 4);
INSERT INTO `mall_address` VALUES (4, '童锦程', '110', '浙江省/杭州市/西湖区', '印度理工大学', 0, '2024-04-16 21:11:54.482818', 4);

SET FOREIGN_KEY_CHECKS = 1;


DROP TABLE IF EXISTS `fuadmin`.`mall_cart`;

CREATE TABLE IF NOT EXISTS `fuadmin`.`mall_cart`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `user_id` int NOT NULL,
    `shop_id` int NOT NULL,
    `status` varchar(32) NOT NULL,
    `shop_price` decimal(10,2) NOT NULL,
    `shop_name` varchar(128) NOT NULL,
    `username` varchar(150) NOT NULL,
    `create_time` timestamp DEFAULT (CURRENT_TIMESTAMP) COMMENT '����ʱ��',
    `product_num` int NOT NULL,
    `img_url` varchar(100) NULL,
    PRIMARY KEY  (`id` ),
    UNIQUE KEY `shop_name` (`shop_name` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;

INSERT INTO `fuadmin`.`mall_cart`(`id`,`user_id`,`shop_id`,`status`,`shop_price`,`shop_name`,`username`,`create_time`,`product_num`,`img_url`) VALUES (45, 4, 42, '0', 198.00, '暖风机取暖器家用节能省电石墨烯电加热冬天暖气办公室浴室烤火炉', 'test', '2024-4-16 21:17:8.', 1, 'images/20240314/20240314161835448087_42.jpg');



/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:00:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_category
-- ----------------------------
DROP TABLE IF EXISTS `mall_category`;
CREATE TABLE `mall_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `categoryName`(`categoryName` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_category
-- ----------------------------
INSERT INTO `mall_category` VALUES (1, '制冷电器', '2024-03-07 14:42:46.000000');
INSERT INTO `mall_category` VALUES (2, '空调器', '2024-03-07 14:42:56.000000');
INSERT INTO `mall_category` VALUES (3, '清洁电器', '2024-03-07 14:43:07.000000');
INSERT INTO `mall_category` VALUES (4, '厨房电器', '2024-03-07 14:43:16.000000');
INSERT INTO `mall_category` VALUES (5, '电暖器具', '2024-03-07 14:43:25.000000');
INSERT INTO `mall_category` VALUES (6, '整容保健电器', '2024-03-07 14:43:38.000000');
INSERT INTO `mall_category` VALUES (7, '声像电器', '2024-03-07 14:43:52.000000');
INSERT INTO `mall_category` VALUES (8, '其他电器', '2024-03-07 14:44:01.000000');

SET FOREIGN_KEY_CHECKS = 1;



/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:01:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_hit_product
-- ----------------------------
DROP TABLE IF EXISTS `mall_hit_product`;
CREATE TABLE `mall_hit_product`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `product` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `hit` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_hit_product
-- ----------------------------
INSERT INTO `mall_hit_product` VALUES (1, 50, '笔记本电脑小音响台式机桌面USB多媒体小音箱办公室迷超重低音炮', 12, '2024-03-16 17:04:10.061040');
INSERT INTO `mall_hit_product` VALUES (2, 49, 'Divoom点音蓝牙音箱小型家庭KTV麦克风小魔女k歌音响女唱歌话筒', 7, '2024-03-16 17:04:28.902342');
INSERT INTO `mall_hit_product` VALUES (3, 48, 'Play 00:05 00:59   艾丁新款共振音箱远程播放控制蓝牙震动发声骨传导音响APP遥控U盘', 5, '2024-03-16 17:04:34.534484');
INSERT INTO `mall_hit_product` VALUES (4, 46, '虹润配电器模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23', 9, '2024-03-16 17:04:45.980827');
INSERT INTO `mall_hit_product` VALUES (5, 41, '意大利水暖取暖器对流式墙暖卧室电暖气片壁挂式暖风机水电暖器', 8, '2024-03-16 17:04:51.844789');
INSERT INTO `mall_hit_product` VALUES (6, 36, '电饭煲家用1一2人多功能蒸煮两用迷你小型一人单小电饭锅煮饭锅', 3, '2024-03-16 17:04:57.981916');
INSERT INTO `mall_hit_product` VALUES (7, 31, '特价万利达双层防烫烧水壶不锈钢全自动断电保温泡茶煮电热开水壶', 1, '2024-03-16 17:05:01.338641');
INSERT INTO `mall_hit_product` VALUES (8, 33, '扬子蜂窝电炒锅多功能家用电热锅蒸煮一体式炒菜不粘电锅电煮锅', 1, '2024-03-16 17:05:16.623713');
INSERT INTO `mall_hit_product` VALUES (9, 32, '正品半球3500W大功率电磁炉家用 爆炒防水触摸火锅多功能套装炉灶', 3, '2024-03-16 17:05:19.861438');
INSERT INTO `mall_hit_product` VALUES (10, 27, '康佳空调扇制冷风扇加水冷风机冷气扇家用宿舍神器移动小型空调扇', 2, '2024-03-16 17:05:24.470290');
INSERT INTO `mall_hit_product` VALUES (11, 30, '好太太双电机抽油烟机家用厨房大吸力排油机自清洗小型侧吸油烟机', 3, '2024-03-16 17:05:30.497464');
INSERT INTO `mall_hit_product` VALUES (12, 47, '家用电饭锅1-2人多功能3L4迷你小型5-6人智能煮饭学生宿舍电饭煲', 3, '2024-03-16 17:12:16.571614');
INSERT INTO `mall_hit_product` VALUES (13, 45, '围炉煮茶烧烤火炉子聚全套装工器具桌炭火盆户外家庭用室内冬天日', 4, '2024-03-17 11:47:05.857534');
INSERT INTO `mall_hit_product` VALUES (14, 52, '拜格 锅铲套装不锈钢铲勺家用炒菜铲子汤勺打蛋器削皮刀厨具套装 厨具六件套', 14, '2024-03-19 13:55:52.285463');
INSERT INTO `mall_hit_product` VALUES (15, 53, '拜格刀具套装菜刀菜板家用不锈钢切片刀斩骨刀水果刀剪刀全套套刀组合 刀具6件套+木纹pp刀座', 14, '2024-03-19 14:01:23.704476');
INSERT INTO `mall_hit_product` VALUES (16, 1, '8/10kg洗衣机全自动家用租房小型波轮大容量带烘干洗烘一体12公斤', 3, '2024-03-21 16:16:01.045921');
INSERT INTO `mall_hit_product` VALUES (17, 54, '优赏水果刀家用案板套装宿舍便携小刀切菜刀和菜板组合刀具辅食厨房 菜刀+水果刀+瓜刨+菜板4件套', 17, '2024-04-12 12:24:26.801743');
INSERT INTO `mall_hit_product` VALUES (18, 51, '维艾（Newair）玻璃油壶调料盒油瓶盐罐调味瓶调料瓶调料罐调味罐酱油瓶8件套', 2, '2024-04-12 13:26:00.579634');
INSERT INTO `mall_hit_product` VALUES (19, 40, '半球抽油烟机大吸力小型老式厨房家用租房抽烟机吸油畑姻老款排', 2, '2024-04-12 13:26:10.364143');
INSERT INTO `mall_hit_product` VALUES (20, 4, '扬子洗衣机全自动家用波轮洗脱一体洗衣机小型出租房用宿舍10公斤', 1, '2024-04-15 21:50:30.315981');
INSERT INTO `mall_hit_product` VALUES (21, 22, '空调扇移动小空调家用静音制冷小空调不加水卧室小型一体机电风扇', 2, '2024-04-16 13:09:54.253199');
INSERT INTO `mall_hit_product` VALUES (22, 6, '内衣裤折叠洗衣机迷你小型自动婴儿洗衣机宿舍专用洗袜子神器便携', 2, '2024-04-16 13:10:07.759919');
INSERT INTO `mall_hit_product` VALUES (23, 5, '中国扬子电器出品洗衣机全自动家用10KG小型出租房屋宿舍洗脱一体', 2, '2024-04-16 21:13:11.154049');
INSERT INTO `mall_hit_product` VALUES (24, 42, '暖风机取暖器家用节能省电石墨烯电加热冬天暖气办公室浴室烤火炉', 4, '2024-04-16 21:15:51.394891');
INSERT INTO `mall_hit_product` VALUES (25, 37, '抽烟机家用厨房大吸力农村抽油烟机商用强力柴火灶土灶用吸油机', 2, '2024-04-16 21:15:54.552285');
INSERT INTO `mall_hit_product` VALUES (26, 26, '奥克斯空调大1/1.5匹p一三级变频壁挂机式2/3匹p冷暖省电官方旗舰', 2, '2024-04-16 21:18:44.252060');
INSERT INTO `mall_hit_product` VALUES (27, 14, '智能数显仪表4-20ma导轨壁挂式数字显示温度压力水位液位控制DN10', 4, '2024-04-16 21:18:58.427828');

SET FOREIGN_KEY_CHECKS = 1;



/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:01:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_keyword
-- ----------------------------
DROP TABLE IF EXISTS `mall_keyword`;
CREATE TABLE `mall_keyword`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `keyword` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `num` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_keyword
-- ----------------------------
INSERT INTO `mall_keyword` VALUES (1, '意大利', 10, '2024-03-16 17:08:48.561375');
INSERT INTO `mall_keyword` VALUES (2, '正品', 12, '2024-03-16 17:09:09.480269');
INSERT INTO `mall_keyword` VALUES (3, '半球', 10, '2024-03-16 17:09:22.714019');
INSERT INTO `mall_keyword` VALUES (4, '油烟', 12, '2024-03-16 17:09:30.625385');
INSERT INTO `mall_keyword` VALUES (5, '免费', 1, '2024-03-16 17:09:41.774545');
INSERT INTO `mall_keyword` VALUES (6, '自动', 4, '2024-03-16 17:09:47.799480');
INSERT INTO `mall_keyword` VALUES (7, '万达', 1, '2024-03-16 17:09:53.726954');
INSERT INTO `mall_keyword` VALUES (8, '特价', 8, '2024-03-16 17:09:58.133382');
INSERT INTO `mall_keyword` VALUES (9, '万', 1, '2024-03-16 17:10:08.741388');
INSERT INTO `mall_keyword` VALUES (10, '电热', 9, '2024-03-16 17:10:14.352048');
INSERT INTO `mall_keyword` VALUES (11, '扬子蜂', 8, '2024-03-16 17:10:25.608998');

SET FOREIGN_KEY_CHECKS = 1;



/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:01:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_msg
-- ----------------------------
DROP TABLE IF EXISTS `mall_msg`;
CREATE TABLE `mall_msg`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `dateTime` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `read_state` int(11) NOT NULL,
  `receive_user` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(256) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_msg
-- ----------------------------
INSERT INTO `mall_msg` VALUES (1, 16, 'test55', '1710410993369', '在吗？', 0, 'customer', 'http://localhost:8088/media/images/20240325/20240325113431527499_2.jpg');
INSERT INTO `mall_msg` VALUES (2, 17, 'customer', '1710411312627', '在的亲!', 0, 'test55', 'http://localhost:8088/media/images/customer.png');
INSERT INTO `mall_msg` VALUES (3, 16, 'test55', '1711084132376', 'hi', 0, 'customer', 'http://localhost:8088/media/images/20240325/20240325113431527499_2.jpg');
INSERT INTO `mall_msg` VALUES (4, 16, 'test55', '1713110531243', 'lalala', 0, 'customer1', 'http://localhost:8088/media/images/20240325/20240325113431527499_2.jpg');
INSERT INTO `mall_msg` VALUES (5, 4, 'test', '1713110616679', 'heiheihei', 0, 'customer1', 'http://localhost:8088/media/images/20240325/20240325113351146122_R-C_(1).jpg');
INSERT INTO `mall_msg` VALUES (6, 4, 'test', '1713110643094', 'shide', 0, 'customer', 'http://localhost:8088/media/images/20240325/20240325113351146122_R-C_(1).jpg');
INSERT INTO `mall_msg` VALUES (7, 23, 'customer1', '1713111292555', 'ok', 0, 'test', 'http://localhost:8088/media/images/customer.png');
INSERT INTO `mall_msg` VALUES (8, 17, 'customer', '1713111300447', 'sf', 0, 'test', 'http://localhost:8088/media/images/customer.png');
INSERT INTO `mall_msg` VALUES (9, 23, 'customer1', '1713111323951', 'lk', 0, 'test55', 'http://localhost:8088/media/images/customer.png');
INSERT INTO `mall_msg` VALUES (10, 17, 'customer', '1713341836548', 'ee', 0, 'test55', 'http://localhost:8088/media/images/customer.png');

SET FOREIGN_KEY_CHECKS = 1;


/*
 Navicat Premium Data Transfer

 Source Server         : localhost8.0
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : fuadmin

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 01/03/2025 17:14:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mall_order
-- ----------------------------
DROP TABLE IF EXISTS `mall_order`;
CREATE TABLE `mall_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_number` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `total_amount` decimal(10, 2) NOT NULL,
  `payment_amount` decimal(10, 2) NOT NULL,
  `payment_status` int(11) NOT NULL,
  `transaction_status` int(11) NOT NULL,
  `recipient_phone` varchar(15) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `recipient_address` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `create_time` datetime(6) NOT NULL,
  `checkout_time` datetime(6) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_order
-- ----------------------------
INSERT INTO `mall_order` VALUES (2, '1712899585', '霍建华', 4389.70, 4389.70, 1, 1, '1008611', '北京市/市辖区/朝阳区/清华大学', '2024-04-12 13:26:25.879227', '2024-04-12 13:26:25.879227', 16);
INSERT INTO `mall_order` VALUES (3, '1713244165', '霍建华', 1233.90, 1233.90, 1, 0, '1008611', '北京市/市辖区/朝阳区/清华大学', '2024-04-16 13:09:25.121361', '2024-04-16 13:09:25.121361', 16);
INSERT INTO `mall_order` VALUES (4, '1713271554', '霍建华', 2493.90, 2493.90, 0, 2, '1008611', '北京市/市辖区/朝阳区/清华大学', '2024-04-13 20:45:54.753000', '2024-04-16 20:45:54.753187', 16);
INSERT INTO `mall_order` VALUES (5, '1713273195', '童锦程', 1913.70, 1913.70, 1, 0, '110', '浙江省/杭州市/西湖区/清华大学', '2024-04-15 21:13:15.976000', '2024-04-16 21:13:15.976526', 4);
INSERT INTO `mall_order` VALUES (6, '1713273346', '赵丽颖', 1171.70, 1171.70, 1, 0, '10086', '天津市/市辖区/河西区/清华大学', '2024-04-14 21:15:46.471000', '2024-04-16 21:15:46.471749', 4);
INSERT INTO `mall_order` VALUES (7, '1713273410', '赵丽颖', 2297.00, 2297.00, 1, 0, '10086', '天津市/市辖区/河西区/清华大学', '2024-04-10 21:16:50.873000', '2024-04-16 21:16:50.873110', 4);
INSERT INTO `mall_order` VALUES (8, '1713273424', '赵丽颖', 8960.00, 8960.00, 1, 0, '10086', '天津市/市辖区/河西区/清华大学', '2024-04-09 21:17:04.333000', '2024-04-16 21:17:04.333095', 4);
INSERT INTO `mall_order` VALUES (9, '1713273555', '胡歌', 3729.75, 3729.75, 1, 0, '123456', '上海市/市辖区/黄浦区/北京大学', '2024-04-11 21:19:15.657000', '2024-04-16 21:19:15.656218', 16);
INSERT INTO `mall_order` VALUES (10, '1713341674', '胡歌', 276.89, 276.89, 1, 1, '123456', '上海市/市辖区/黄浦区/北京大学', '2024-04-17 16:14:34.207678', '2024-04-17 16:14:34.207678', 16);

SET FOREIGN_KEY_CHECKS = 1;


DROP TABLE IF EXISTS `fuadmin`.`mall_order_detail`;

CREATE TABLE IF NOT EXISTS `fuadmin`.`mall_order_detail`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `img_url` varchar(100) NULL,
    `product_num` int NOT NULL,
    `shop_price` decimal(10,2) NOT NULL,
    `shop_name` varchar(128) NOT NULL,
    `user_id` int NOT NULL,
    `order_number` varchar(20) NOT NULL,
    `is_delete` int NOT NULL,
    `create_time` datetime(6) NOT NULL,
    `shop_id` int NOT NULL,
    PRIMARY KEY  (`id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;



INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (1, 'images/20240319/20240319135524635240_52.jpg', 1, 29.89, '拜格 锅铲套装不锈钢铲勺家用炒菜铲子汤勺打蛋器削皮刀厨具套装 厨具六件套', 16, '1712897733', 1, '2024-4-12 12:55:33.258334', 52);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (2, 'images/20240319/20240319135638903928_53.jpg', 1, 34.11, '拜格刀具套装 菜刀菜板家用不锈钢切片刀斩骨刀水果刀剪刀全套套刀组合 刀具6件套+木纹pp刀座', 16, '1712897733', 1, '2024-4-12 12:55:33.258334', 53);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (3, 'images/20240319/20240319140432438292_54.jpg', 1, 25.90, '优赏水果刀家 用案板套装宿舍便携小刀切菜刀和菜板组合刀具辅食厨房 菜刀+水果刀+瓜刨+菜板4件套', 16, '1712897733', 1, '2024-4-12 12:55:33.258334', 54);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (4, 'images/20240314/20240314160042598790_30.jpg', 3, 218.00, '好太太双电机抽油烟机家用厨房大吸力排油机自清洗小型侧吸油烟机', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 30);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (5, 'images/20240314/20240314161755274228_41.jpg', 1, 2880.00, '意大利水暖 取暖器对流式墙暖卧室电暖气片壁挂式暖风机水电暖器', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 41);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (6, 'images/20240314/20240314161658984896_40.jpg', 2, 126.00, '半球抽油烟机大吸力小型老式厨房家用租房抽烟机吸油畑姻老款排', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 40);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (7, 'images/20240314/20240314162155450433_46.jpg', 3, 160.00, '虹润配电器模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 46);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (8, 'images/20240319/20240319135402453272_51jpg.jpg', 3, 29.90, '维艾（Newair）玻璃油壶调料盒油瓶盐罐调味瓶调料瓶调料罐调味罐酱油瓶8件套', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 51);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (9, 'images/20240314/20240314162511372464_50.jpg', 1, 34.00, '笔记本电脑小 音响台式机桌面USB多媒体小音箱办公室迷超重低音炮', 16, '1712899585', 0, '2024-4-12 13:26:25.876115', 50);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (44, 'images/20240314/20240314162511372464_50.jpg', 1, 34.00, '笔记本电脑小音响台式机桌面USB多媒体小音箱办公室迷超重低音炮', 16, '1713244165', 0, '2024-4-16 13:9:25.119356', 50);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (45, 'images/20240319/20240319135524635240_52.jpg', 1, 29.89, '拜格 锅铲套 装不锈钢铲勺家用炒菜铲子汤勺打蛋器削皮刀厨具套装 厨具六件套', 16, '1713244165', 0, '2024-4-16 13:9:25.119356', 52);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (46, 'images/20240319/20240319135638903928_53.jpg', 1, 34.11, '拜格刀具套装菜刀菜板家用不锈钢切片刀斩骨刀水果刀剪刀全套套刀组合 刀具6件套+木纹pp刀座', 16, '1713244165', 0, '2024-4-16 13:9:25.119356', 53);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (47, 'images/20240319/20240319140432438292_54.jpg', 1, 25.90, '优赏水果刀家用案板套装宿舍便携小刀切菜刀和菜板组合刀具辅食厨房 菜刀+水果刀+瓜刨+菜板4件套', 16, '1713244165', 0, '2024-4-16 13:9:25.119356', 54);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (48, 'images/20240314/20240314153743486989_6.jpg', 1, 32.00, '内衣裤折叠洗 衣机迷你小型自动婴儿洗衣机宿舍专用洗袜子神器便携', 16, '1713271554', 0, '2024-4-16 20:45:54.751187', 6);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (49, 'images/20240314/20240314155350535025_22.jpg', 1, 148.00, '空调扇移动 小空调家用静音制冷小空调不加水卧室小型一体机电风扇', 16, '1713271554', 0, '2024-4-16 20:45:54.751187', 22);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (50, 'images/20240314/20240314160228548780_32.jpg', 1, 69.90, '正品半球3500W大功率电磁炉家用 爆炒防水触摸火锅多功能套装炉灶', 16, '1713271554', 0, '2024-4-16 20:45:54.751187', 32);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (51, 'images/20240314/20240314153632175277_5.jpg', 2, 418.00, '中国扬子电器出品洗衣机全自动家用10KG小型出租房屋宿舍洗脱一体', 4, '1713273195', 0, '2024-4-16 21:13:15.974529', 5);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (52, 'images/20240319/20240319140432438292_54.jpg', 3, 25.90, '优赏水果刀家用案板套装宿舍便携小刀切菜刀和菜板组合刀具辅食厨房 菜刀+水果刀+瓜刨+菜板4件套', 4, '1713273195', 0, '2024-4-16 21:13:15.974529', 54);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (53, 'images/20240314/20240314162103892166_45.jpg', 1, 11.70, '围炉煮茶烧烤火炉子聚全套装工器具桌炭火盆户外家庭用室内冬天日', 4, '1713273346', 0, '2024-4-16 21:15:46.468748', 45);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (54, 'images/20240314/20240314162155450433_46.jpg', 1, 160.00, '虹润配电器 模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23', 4, '1713273346', 0, '2024-4-16 21:15:46.468748', 46);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (55, 'images/20240314/20240314160852147124_37.jpg', 1, 99.00, '抽烟机家用厨房大吸力农村抽油烟机商用强力柴火灶土灶用吸油机', 4, '1713273410', 0, '2024-4-16 21:16:50.869109', 37);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (56, 'images/20240314/20240314161835448087_42.jpg', 1, 198.00, '暖风机取暖 器家用节能省电石墨烯电加热冬天暖气办公室浴室烤火炉', 4, '1713273410', 0, '2024-4-16 21:16:50.869109', 42);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (57, 'images/20240314/20240314161755274228_41.jpg', 3, 2880.00, '意大利水暖取暖器对流式墙暖卧室电暖气片壁挂式暖风机水电暖器', 4, '1713273424', 0, '2024-4-16 21:17:4.330095', 41);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (58, 'images/20240314/20240314162155450433_46.jpg', 2, 160.00, '虹润配电器 模拟量输出4-20mA隔离器一进二出分配信号隔离模块M23', 4, '1713273424', 0, '2024-4-16 21:17:4.330095', 46);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (59, 'images/20240314/20240314152610787951_1.jpg', 3, 330.00, '8/10kg洗衣机全自动家用租房小型波轮大容量带烘干洗烘一体12公斤', 16, '1713273555', 0, '2024-4-16 21:19:15.654217', 1);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (60, 'images/20240314/20240314154611575473_14.jpg', 3, 247.00, '智能数显仪 表4-20ma导轨壁挂式数字显示温度压力水位液位控制DN10', 16, '1713273555', 0, '2024-4-16 21:19:15.654217', 14);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (61, 'images/20240314/20240314155726110084_26.jpg', 1, 1998.75, '奥克斯空调大1/1.5匹p一三级变频壁挂机式2/3匹p冷暖省电官方旗舰', 16, '1713273555', 0, '2024-4-16 21:19:15.654217', 26);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (62, 'images/20240314/20240314154611575473_14.jpg', 1, 247.00, '智能数显仪 表4-20ma导轨壁挂式数字显示温度压力水位液位控制DN10', 16, '1713341674', 0, '2024-4-17 16:14:34.202676', 14);
INSERT INTO `fuadmin`.`mall_order_detail`(`id`,`img_url`,`product_num`,`shop_price`,`shop_name`,`user_id`,`order_number`,`is_delete`,`create_time`,`shop_id`) VALUES (63, 'images/20240319/20240319135524635240_52.jpg', 1, 29.89, '拜格 锅铲套 装不锈钢铲勺家用炒菜铲子汤勺打蛋器削皮刀厨具套装 厨具六件套', 16, '1713341674', 0, '2024-4-17 16:14:34.202676', 52);