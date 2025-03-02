REPLACE  INTO `fuadmin`.`system_users`(`password`,`last_login`,`is_superuser`,`is_staff`,`is_active`,`date_joined`,`id`,`remark`,`modifier`,`belong_dept`,`update_datetime`,`create_datetime`,`sort`,`username`,`email`,`mobile`,`avatar`,`name`,`status`,`gender`,`user_type`,`first_name`,`last_name`,`home_path`,`creator_id`,`dept_id`,`address`,`balance`,`avatars`) VALUES ('pbkdf2_sha256$320000$CzZirVJKqo0BhivWKGrh1P$zWzrE9lzvVD1qvZZrrsqfPXHsfEdcLXfvxJX8Lu1SYs=', NULL, 0, 0, 1, '2024-3-12 11:40:4.386617', 5, NULL, NULL, NULL, '2024-3-12 11:40:4.390391', '2024-2-3 19:40:40.810396', 1, 'test1', NULL, NULL, NULL, 'common', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, 'images/default.jpg');
REPLACE  INTO `fuadmin`.`system_users`(`password`,`last_login`,`is_superuser`,`is_staff`,`is_active`,`date_joined`,`id`,`remark`,`modifier`,`belong_dept`,`update_datetime`,`create_datetime`,`sort`,`username`,`email`,`mobile`,`avatar`,`name`,`status`,`gender`,`user_type`,`first_name`,`last_name`,`home_path`,`creator_id`,`dept_id`,`address`,`balance`,`avatars`) VALUES ('pbkdf2_sha256$320000$VYqsSUmCeeTdO17bEMfa1Q$zZB5tAkG5PfZzHd9T5z/5PwtTWGUFPkJzSzoAwl5rXY=', NULL, 0, 0, 1, '2024-3-10 11:26:38.564625', 16, NULL, NULL, NULL, '2024-3-10 11:26:38.570704', '2024-3-7 13:38:41.215451', 1, 'test55', NULL, NULL, NULL, 'common', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, 'images/20240325/20240325113431527499_2.jpg');
REPLACE  INTO `fuadmin`.`system_users`(`password`,`last_login`,`is_superuser`,`is_staff`,`is_active`,`date_joined`,`id`,`remark`,`modifier`,`belong_dept`,`update_datetime`,`create_datetime`,`sort`,`username`,`email`,`mobile`,`avatar`,`name`,`status`,`gender`,`user_type`,`first_name`,`last_name`,`home_path`,`creator_id`,`dept_id`,`address`,`balance`,`avatars`) VALUES ('pbkdf2_sha256$320000$diwWExcLJtrNUb5XMi24iQ$Uel68WtokMrR1xUpl2w5TYXty//HxMpsB2m8zGamVlE=', NULL, 0, 0, 1, '2024-3-21 10:28:50.474369', 18, NULL, NULL, NULL, '2024-3-21 10:28:50.474369', '2024-3-21 10:28:50.474369', 1, 'test10', NULL, NULL, NULL, 'common', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, 'images/customer.png');
REPLACE  INTO `fuadmin`.`system_users`(`password`,`last_login`,`is_superuser`,`is_staff`,`is_active`,`date_joined`,`id`,`remark`,`modifier`,`belong_dept`,`update_datetime`,`create_datetime`,`sort`,`username`,`email`,`mobile`,`avatar`,`name`,`status`,`gender`,`user_type`,`first_name`,`last_name`,`home_path`,`creator_id`,`dept_id`,`address`,`balance`,`avatars`) VALUES ('pbkdf2_sha256$320000$VK4dUrVAUOvY3RO33oyAUa$H9uBN5M8VM+Gh27iC3j5aAdzFjEG9OVYHtFl5W3SyE8=', NULL, 0, 0, 1, '2024-4-14 22:24:11.429299', 22, NULL, NULL, NULL, '2024-4-14 22:24:11.429299', '2024-4-14 22:24:11.429299', 1, 'test11', NULL, NULL, NULL, 'common', 1, 1, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0.00, 'images/customer.png');
REPLACE  INTO `fuadmin`.`system_users`(`password`,`last_login`,`is_superuser`,`is_staff`,`is_active`,`date_joined`,`id`,`remark`,`modifier`,`belong_dept`,`update_datetime`,`create_datetime`,`sort`,`username`,`email`,`mobile`,`avatar`,`name`,`status`,`gender`,`user_type`,`first_name`,`last_name`,`home_path`,`creator_id`,`dept_id`,`address`,`balance`,`avatars`) VALUES ('pbkdf2_sha256$320000$FVAq9SFUNNE7u1q65wCeWo$xkPlprLXwC/wsdTEpFsnQ9TmnfeUj6x7be41ny9+xPI=', NULL, 0, 0, 1, '2024-4-14 23:9:42.234165', 23, NULL, '超级管理员', NULL, '2024-4-14 23:9:42.390436', '2024-4-14 23:9:42.390436', 1, 'customer1', NULL, NULL, NULL, 'customer1', 1, 1, 0, NULL, NULL, NULL, 1, NULL, NULL, 0.00, 'images/customer.png');



DROP TABLE IF EXISTS `fuadmin`.`system_users_role`;

CREATE TABLE IF NOT EXISTS `fuadmin`.`system_users_role`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `users_id` bigint NOT NULL,
    `role_id` bigint NOT NULL,
    PRIMARY KEY  (`id` ),
    UNIQUE KEY `system_users_role_users_id_role_id_efdd1ca1_uniq` (`users_id` ,`role_id` ),
    KEY `system_users_role_users_id_898e5d39` (`users_id` ),
    KEY `system_users_role_role_id_056fc093` (`role_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;
INSERT INTO `fuadmin`.`system_users_role` VALUES (1, 5, 3);
INSERT INTO `fuadmin`.`system_users_role` VALUES (4, 16, 3);
INSERT INTO `fuadmin`.`system_users_role` VALUES (6, 17, 2);
INSERT INTO `fuadmin`.`system_users_role` VALUES (7, 4, 3);
INSERT INTO `fuadmin`.`system_users_role` VALUES (8, 18, 3);
INSERT INTO `fuadmin`.`system_users_role` VALUES (9, 22, 3);
INSERT INTO `fuadmin`.`system_users_role` VALUES (10, 23, 2);


DROP TABLE IF EXISTS `fuadmin`.`system_role`;
CREATE TABLE IF NOT EXISTS `fuadmin`.`system_role`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `remark` varchar(255) NULL,
    `modifier` varchar(255) NULL,
    `belong_dept` int NULL,
    `update_datetime` datetime(6) NULL,
    `create_datetime` datetime(6) NULL,
    `sort` int NULL,
    `name` varchar(64) NOT NULL,
    `code` varchar(64) NOT NULL,
    `status` tinyint(1) NOT NULL,
    `admin` tinyint(1) NOT NULL,
    `data_range` int NOT NULL,
    `creator_id` bigint NULL,
    PRIMARY KEY  (`id` ),
    UNIQUE KEY `code` (`code` ),
    KEY `system_role_creator_id_ea515370` (`creator_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;
INSERT INTO `fuadmin`.`system_role` VALUES (1, NULL, NULL, NULL, '2024-3-12 14:59:15.168514', '2024-2-1 15:43:28.704542', 1, '超级管理员', 'official', 1, 0, 4, NULL);
INSERT INTO `fuadmin`.`system_role` VALUES (2, NULL, NULL, NULL, '2024-3-14 11:25:41.688868', '2024-2-1 15:43:28.704542', 2, '销售员', 'shop', 1, 0, 4, NULL);
INSERT INTO `fuadmin`.`system_role` VALUES (3, NULL, NULL, NULL, '2024-2-3 19:54:26.295302', '2024-2-3 19:38:53.34862', 3, '普通用户', 'common', 1, 0, 4, NULL);




DROP TABLE IF EXISTS `fuadmin`.`system_role_menu`;
CREATE TABLE IF NOT EXISTS `fuadmin`.`system_role_menu`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `role_id` bigint NOT NULL,
    `menu_id` bigint NOT NULL,
    PRIMARY KEY  (`id` ),
    UNIQUE KEY `system_role_menu_role_id_menu_id_bceffeea_uniq` (`role_id` ,`menu_id` ),
    KEY `system_role_menu_role_id_381c2e52` (`role_id` ),
    KEY `system_role_menu_menu_id_400f4f82` (`menu_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;
INSERT INTO `fuadmin`.`system_role_menu` VALUES (1, 3, 16);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (2, 3, 17);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (3, 3, 18);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (4, 3, 20);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (5, 3, 21);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (6, 3, 22);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (7, 3, 23);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (8, 3, 1);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (9, 3, 4);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (10, 3, 5);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (11, 3, 6);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (12, 3, 7);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (13, 3, 8);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (14, 3, 19);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (15, 2, 34);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (16, 2, 36);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (17, 2, 37);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (18, 2, 38);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (19, 2, 39);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (20, 1, 34);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (21, 1, 36);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (22, 1, 37);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (23, 1, 38);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (24, 1, 39);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (25, 2, 16);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (26, 2, 17);
INSERT INTO `fuadmin`.`system_role_menu` VALUES (27, 2, 18);






DROP TABLE IF EXISTS `fuadmin`.`system_role_permission`;
CREATE TABLE IF NOT EXISTS `fuadmin`.`system_role_permission`(
    `id` bigint NOT NULL AUTO_INCREMENT,
    `role_id` bigint NOT NULL,
    `menubutton_id` bigint NOT NULL,
    PRIMARY KEY  (`id` ),
    UNIQUE KEY `system_role_permission_role_id_menubutton_id_5fb41eb5_uniq` (`role_id` ,`menubutton_id` ),
    KEY `system_role_permission_role_id_ca5e9412` (`role_id` ),
    KEY `system_role_permission_menubutton_id_aef88309` (`menubutton_id` )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ;
INSERT INTO `fuadmin`.`system_role_permission` VALUES (1, 3, 1);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (2, 3, 2);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (3, 3, 3);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (4, 3, 4);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (5, 3, 5);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (6, 3, 6);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (7, 3, 7);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (8, 3, 8);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (9, 3, 9);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (10, 3, 10);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (11, 3, 11);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (12, 3, 12);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (13, 3, 13);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (14, 3, 14);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (15, 3, 15);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (16, 3, 16);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (17, 3, 17);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (18, 3, 18);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (19, 3, 19);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (20, 3, 20);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (21, 3, 21);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (22, 3, 22);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (23, 3, 23);
INSERT INTO `fuadmin`.`system_role_permission` VALUES (24, 3, 24);




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

 Date: 02/03/2025 10:42:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `modifier` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `belong_dept` int(11) NULL DEFAULT NULL,
  `update_datetime` datetime(6) NULL DEFAULT NULL,
  `create_datetime` datetime(6) NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  `icon` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `permission` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `is_ext` tinyint(1) NOT NULL,
  `type` int(11) NOT NULL,
  `path` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `redirect` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `component` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `keepalive` tinyint(1) NOT NULL,
  `hide_menu` tinyint(1) NOT NULL,
  `creator_id` bigint(20) NULL DEFAULT NULL,
  `parent_id` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `system_menu_creator_id_d58495af`(`creator_id` ASC) USING BTREE,
  INDEX `system_menu_parent_id_c715739f`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of system_menu
-- ----------------------------
INSERT INTO `system_menu` VALUES (1, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.196483', '2024-02-01 15:43:28.196483', 2, 'ion:settings-outline', '系统管理', NULL, 0, 0, '/system', '/system/account', 'LAYOUT', NULL, 1, 0, 0, 1, NULL);
INSERT INTO `system_menu` VALUES (2, NULL, '超级管理员', NULL, '2025-03-02 10:39:59.093424', '2024-02-01 15:43:28.203392', 3, 'ant-design:appstore-outlined', '系统工具', NULL, 0, 0, '/tool', NULL, 'LAYOUT', NULL, 0, 0, 0, NULL, NULL);
INSERT INTO `system_menu` VALUES (3, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.210403', '2024-02-01 15:43:28.210403', 4, 'ant-design:code-filled', '日志管理', NULL, 0, 0, '/log', NULL, 'LAYOUT', NULL, 1, 0, 0, 1, NULL);
INSERT INTO `system_menu` VALUES (4, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.212072', '2024-02-01 15:43:28.212072', 1, 'ant-design:bars-outlined', '菜单管理', NULL, 0, 1, 'menu', NULL, '/fuadmin/system/menu/index', 'MenuManagement', 1, 0, 0, 1, 1);
INSERT INTO `system_menu` VALUES (5, NULL, '超级管理员', NULL, '2025-03-02 10:39:26.540280', '2024-02-01 15:43:28.216525', 2, 'ant-design:contacts-outlined', '岗位管理', NULL, 0, 1, 'post', NULL, '/fuadmin/system/post/index', 'PostManagement', 1, 0, 0, NULL, 1);
INSERT INTO `system_menu` VALUES (6, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.216525', '2024-02-01 15:43:28.216525', 3, 'ant-design:user-outlined', '用户管理', NULL, 0, 1, 'account', NULL, '/fuadmin/system/account/index', 'AccountManagement', 1, 0, 0, 1, 1);
INSERT INTO `system_menu` VALUES (7, NULL, '超级管理员', NULL, '2025-03-02 10:39:37.138338', '2024-02-01 15:43:28.227637', 4, 'ant-design:project-outlined', '部门管理', NULL, 0, 1, 'dept', NULL, '/fuadmin/system/dept/index', 'DeptManagement', 1, 0, 0, NULL, 1);
INSERT INTO `system_menu` VALUES (8, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.230600', '2024-02-01 15:43:28.230600', 5, 'ant-design:team-outlined', '角色管理', NULL, 0, 1, 'role', NULL, '/fuadmin/system/role/index', 'RoleManagement', 1, 0, 0, 1, 1);
INSERT INTO `system_menu` VALUES (9, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.235612', '2024-02-01 15:43:28.235612', 1, 'ant-design:database-outlined', '数据字典', NULL, 0, 1, 'dict', NULL, '/fuadmin/system/data-dict/index', 'DataDict', 1, 0, 0, 1, 2);
INSERT INTO `system_menu` VALUES (10, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.246432', '2024-02-01 15:43:28.246432', 2, 'ant-design:database-filled', '分类字典', NULL, 0, 1, 'category', NULL, '/fuadmin/system/category_dict/index', 'CategoryDict', 1, 0, 0, 1, 2);
INSERT INTO `system_menu` VALUES (11, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.246432', '2024-02-01 15:43:28.246432', 3, 'ant-design:clock-circle-outlined', '定时任务', NULL, 0, 1, 'celery', NULL, '/fuadmin/system/celery/index', 'Celery', 1, 0, 0, 1, 2);
INSERT INTO `system_menu` VALUES (12, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.258449', '2024-02-01 15:43:28.258449', 4, 'ant-design:folder-open-outlined', '文件管理', NULL, 0, 1, 'file', NULL, '/fuadmin/system/file/index', 'FileManagement', 1, 0, 0, 1, 2);
INSERT INTO `system_menu` VALUES (13, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.275362', '2024-02-01 15:43:28.275362', 1, 'ant-design:book-outlined', '登录日志', NULL, 0, 1, 'login_log', NULL, '/fuadmin/system/log/login_log/index', 'LoginLogManagement', 1, 0, 0, 1, 3);
INSERT INTO `system_menu` VALUES (14, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.307445', '2024-02-01 15:43:28.307445', 2, 'ant-design:book-outlined', '操作日志', NULL, 0, 1, 'operation_log', NULL, '/fuadmin/system/log/operation_log/index', 'OperationLogManagement', 1, 0, 0, 1, 3);
INSERT INTO `system_menu` VALUES (15, NULL, '超级管理员', NULL, '2024-03-10 11:22:00.302848', '2024-02-01 15:43:28.324168', 3, 'ant-design:book-outlined', '任务日志', NULL, 0, 1, 'celery_log', NULL, '/fuadmin/system/log/celery_log/index', 'CeleryLog', 0, 0, 1, NULL, 3);
INSERT INTO `system_menu` VALUES (16, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.327694', '2024-02-01 15:43:28.327694', 1, 'bx:bx-home', 'Dashboard', NULL, 0, 0, '/dashboard', '/dashboard/analysis', 'LAYOUT', NULL, 1, 0, 0, 1, NULL);
INSERT INTO `system_menu` VALUES (17, NULL, '超级管理员', NULL, '2024-03-19 11:11:42.958716', '2024-02-01 15:43:28.340494', 1, 'bx:bx-home', '首页', NULL, 0, 1, 'analysis', NULL, '/dashboard/analysis/index', 'Analysis', 1, 0, 0, NULL, 16);
INSERT INTO `system_menu` VALUES (18, NULL, '超级管理员', NULL, '2025-03-02 10:41:27.852851', '2024-02-01 15:43:28.340494', 2, 'bx:bx-home', '工作台', NULL, 0, 1, 'workbench', NULL, '/dashboard/workbench/index', 'Workbench', 1, 0, 0, NULL, 16);
INSERT INTO `system_menu` VALUES (19, NULL, '超级管理员', NULL, '2025-03-02 10:39:45.900600', '2024-02-01 15:43:28.340494', 6, 'ant-design:setting-outlined', '个人设置', NULL, 0, 1, 'account/setting/:id', NULL, '/fuadmin/system/account/setting/index', 'AccountSetting', 1, 0, 0, NULL, 1);
INSERT INTO `system_menu` VALUES (20, NULL, '超级管理员', NULL, '2025-03-02 10:40:09.531637', '2024-02-01 15:43:28.340494', 5, 'ant-design:bar-chart-outlined', '图表演示', NULL, 0, 0, '/chart', '/chart/amap', 'LAYOUT', NULL, 1, 0, 0, NULL, NULL);
INSERT INTO `system_menu` VALUES (21, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.353998', '2024-02-01 15:43:28.353998', 1, 'ant-design:environment-outlined', '百度地图', NULL, 0, 1, 'bmap', NULL, '/fuadmin/charts/map/Baidu', 'BaiduMap', 1, 0, 0, 1, 20);
INSERT INTO `system_menu` VALUES (22, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.353998', '2024-02-01 15:43:28.353998', 2, 'ant-design:environment-outlined', '高德地图', NULL, 0, 1, 'amap', NULL, '/fuadmin/charts/map/Gaode', 'AMap', 1, 0, 0, 1, 20);
INSERT INTO `system_menu` VALUES (23, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.353998', '2024-02-01 15:43:28.353998', 3, 'ant-design:bar-chart-outlined', 'Echart Map', NULL, 0, 1, 'echartmap', NULL, '/fuadmin/charts/Map', 'AMap', 1, 0, 0, 1, 20);
INSERT INTO `system_menu` VALUES (24, NULL, '超级管理员', NULL, '2024-03-10 11:19:50.286973', '2024-02-01 15:43:28.369626', 7, 'ant-design:audit-outlined', '项目演示', NULL, 0, 1, '/demo', NULL, '/demo/index', 'Demo', 0, 0, 1, NULL, NULL);
INSERT INTO `system_menu` VALUES (25, NULL, '超级管理员', NULL, '2025-03-02 10:41:04.618798', '2024-02-01 15:43:28.369626', 6, 'ant-design:fund-projection-screen-outlined', '运维管理', NULL, 0, 0, '/operation', '/chart/amap', 'LAYOUT', NULL, 1, 0, 0, NULL, NULL);
INSERT INTO `system_menu` VALUES (26, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.369626', '2024-02-01 15:43:28.369626', 1, 'ant-design:monitor-outlined', '服务监控', NULL, 0, 1, 'monitor', NULL, '/fuadmin/system/monitor/server', 'Server', 1, 0, 0, 1, 25);
INSERT INTO `system_menu` VALUES (29, NULL, '超级管理员', NULL, '2024-03-10 11:19:57.831985', '2024-02-01 15:43:28.385251', 8, 'ant-design:border-outlined', '代码生成', NULL, 0, 0, '/code-generator', '/code-generator/generator-template', 'LAYOUT', NULL, 0, 0, 1, NULL, NULL);
INSERT INTO `system_menu` VALUES (30, NULL, '超级管理员', NULL, '2024-02-01 15:43:28.393754', '2024-02-01 15:43:28.393754', 1, 'ant-design:book-outlined', '代码模板', NULL, 0, 1, 'generator-template', NULL, '/fuadmin/system/code-generator/template/index', 'generatorTemplate', 1, 0, 0, 1, 29);
INSERT INTO `system_menu` VALUES (33, NULL, '超级管理员', NULL, '2024-03-11 10:34:51.262147', '2024-02-01 15:43:28.393754', 8, 'ant-design:one-to-one-outlined', '生成项目', NULL, 0, 0, '/generator_project', NULL, 'LAYOUT', NULL, 0, 0, 1, NULL, NULL);
INSERT INTO `system_menu` VALUES (34, NULL, '超级管理员', NULL, '2024-02-06 20:30:13.187009', '2024-02-06 20:30:13.187009', 1, 'ant-design:book-outlined', '商城', NULL, 0, 0, '/mall', NULL, 'LAYOUT', NULL, 1, 0, 0, 1, NULL);
INSERT INTO `system_menu` VALUES (35, NULL, '超级管理员', NULL, '2024-03-10 11:54:25.590040', '2024-02-06 20:31:36.974920', 1, 'ant-design:medium-circle-filled', '商品类型管理', NULL, 0, 1, '/mall/index', NULL, '/fuadmin/mall/home/CategoryManage', NULL, 1, 0, 0, NULL, 34);
INSERT INTO `system_menu` VALUES (36, NULL, '超级管理员', NULL, '2024-03-15 11:13:02.007840', '2024-02-20 17:15:22.475736', 2, 'ant-design:container-outlined', '订单处理', NULL, 0, 1, '/mall/details', NULL, '/fuadmin/mall/home/OrderHandle', NULL, 1, 0, 0, NULL, 34);
INSERT INTO `system_menu` VALUES (37, NULL, '超级管理员', NULL, '2024-03-15 11:12:49.705869', '2024-02-21 09:25:44.062321', 1, 'ant-design:comment-outlined', '消息中心', NULL, 0, 1, '/mall/shop-car', NULL, '/fuadmin/mall/home/MessageHandle', NULL, 1, 0, 0, NULL, 34);
INSERT INTO `system_menu` VALUES (38, NULL, '超级管理员', NULL, '2024-03-14 11:26:42.738233', '2024-03-07 09:31:35.591332', 1, 'ant-design:book-outlined', '个人中心', NULL, 0, 1, '/mall/user', NULL, '/fuadmin/mall/home/userPage', NULL, 0, 0, 1, NULL, 34);
INSERT INTO `system_menu` VALUES (39, NULL, '超级管理员', NULL, '2024-03-10 11:54:40.629075', '2024-03-07 09:33:53.475559', 1, 'ant-design:android-outlined', '商品管理', NULL, 0, 1, '/mall/show', NULL, '/fuadmin/mall/home/ProductManage', NULL, 1, 0, 0, NULL, 34);
INSERT INTO `system_menu` VALUES (41, NULL, '超级管理员', NULL, '2024-03-15 11:17:21.576305', '2024-03-15 11:17:21.576305', 1, 'ant-design:function-outlined', '数据可视化', NULL, 0, 1, '/mall/views', NULL, '/fuadmin/mall/home/views', NULL, 1, 0, 0, 1, 34);

SET FOREIGN_KEY_CHECKS = 1;
