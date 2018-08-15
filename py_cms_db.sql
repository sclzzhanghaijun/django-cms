/*
Navicat MySQL Data Transfer

Source Server         : 开发数据库
Source Server Version : 50625
Source Host           : 10.3.32.13:3306
Source Database       : py_cms_db

Target Server Type    : MYSQL
Target Server Version : 50625
File Encoding         : 65001

Date: 2018-08-15 18:15:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nick_name` varchar(50) NOT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(10) NOT NULL,
  `address` varchar(11) DEFAULT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `is_delete` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admin_users
-- ----------------------------
INSERT INTO `admin_users` VALUES ('1', 'pbkdf2_sha256$100000$HiIkJTTF02UU$LbgXytdACI56ubEjhD9fkseGtocqvKfnNfc9NCLJg2s=', '2018-04-08 01:59:40.361752', '1', 'admin', '', '', 'admin@163.com', '1', '1', '2018-03-29 08:16:18.976481', '主人', '2018-04-04', 'female', '', '15184426015', '0');
INSERT INTO `admin_users` VALUES ('4', 'pbkdf2_sha256$100000$rx6KgajjbZx0$r8+uS1d3hg3bmpTqZDEYc2RWNHrLb+4oCw/mBEDTeLY=', null, '1', 'xiaohai', '', '', 'xiaohai@qq.com', '1', '1', '2018-04-04 01:46:51.632235', '小海', '2018-04-04', 'female', '', '15184426015', '0');

-- ----------------------------
-- Table structure for admin_users_groups
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_groups`;
CREATE TABLE `admin_users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_groups_adminuser_id_group_id_4e56097c_uniq` (`adminuser_id`,`group_id`),
  KEY `admin_users_groups_group_id_ce0b9e1b_fk_auth_group_id` (`group_id`),
  CONSTRAINT `admin_users_groups_adminuser_id_4d2c6118_fk_admin_users_id` FOREIGN KEY (`adminuser_id`) REFERENCES `admin_users` (`id`),
  CONSTRAINT `admin_users_groups_group_id_ce0b9e1b_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admin_users_groups
-- ----------------------------

-- ----------------------------
-- Table structure for admin_users_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `admin_users_user_permissions`;
CREATE TABLE `admin_users_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_user_permiss_adminuser_id_permission__086fa3b0_uniq` (`adminuser_id`,`permission_id`),
  KEY `admin_users_user_per_permission_id_84d767f4_fk_auth_perm` (`permission_id`),
  CONSTRAINT `admin_users_user_per_adminuser_id_f9e5891d_fk_admin_use` FOREIGN KEY (`adminuser_id`) REFERENCES `admin_users` (`id`),
  CONSTRAINT `admin_users_user_per_permission_id_84d767f4_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admin_users_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('2', 'Can add log entry', '2', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can change log entry', '2', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete log entry', '2', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('8', 'Can add permission', '4', 'add_permission');
INSERT INTO `auth_permission` VALUES ('10', 'Can change permission', '4', 'change_permission');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete permission', '4', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('14', 'Can add group', '6', 'add_group');
INSERT INTO `auth_permission` VALUES ('16', 'Can change group', '6', 'change_group');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete group', '6', 'delete_group');
INSERT INTO `auth_permission` VALUES ('20', 'Can add content type', '8', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('22', 'Can change content type', '8', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete content type', '8', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('26', 'Can add session', '10', 'add_session');
INSERT INTO `auth_permission` VALUES ('28', 'Can change session', '10', 'change_session');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete session', '10', 'delete_session');
INSERT INTO `auth_permission` VALUES ('32', 'Can add test', '12', 'add_test');
INSERT INTO `auth_permission` VALUES ('34', 'Can change test', '12', 'change_test');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete test', '12', 'delete_test');
INSERT INTO `auth_permission` VALUES ('38', 'Can add 用户信息', '14', 'add_adminuser');
INSERT INTO `auth_permission` VALUES ('40', 'Can change 用户信息', '14', 'change_adminuser');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete 用户信息', '14', 'delete_adminuser');
INSERT INTO `auth_permission` VALUES ('44', 'Can add p admin groups', '16', 'add_padmingroups');
INSERT INTO `auth_permission` VALUES ('46', 'Can change p admin groups', '16', 'change_padmingroups');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete p admin groups', '16', 'delete_padmingroups');
INSERT INTO `auth_permission` VALUES ('50', 'Can add p admin groups permission', '18', 'add_padmingroupspermission');
INSERT INTO `auth_permission` VALUES ('52', 'Can change p admin groups permission', '18', 'change_padmingroupspermission');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete p admin groups permission', '18', 'delete_padmingroupspermission');
INSERT INTO `auth_permission` VALUES ('56', 'Can add p admin groups user', '20', 'add_padmingroupsuser');
INSERT INTO `auth_permission` VALUES ('58', 'Can change p admin groups user', '20', 'change_padmingroupsuser');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete p admin groups user', '20', 'delete_padmingroupsuser');
INSERT INTO `auth_permission` VALUES ('62', 'Can add p article', '22', 'add_particle');
INSERT INTO `auth_permission` VALUES ('64', 'Can change p article', '22', 'change_particle');
INSERT INTO `auth_permission` VALUES ('66', 'Can delete p article', '22', 'delete_particle');
INSERT INTO `auth_permission` VALUES ('68', 'Can add p article category', '24', 'add_particlecategory');
INSERT INTO `auth_permission` VALUES ('70', 'Can change p article category', '24', 'change_particlecategory');
INSERT INTO `auth_permission` VALUES ('72', 'Can delete p article category', '24', 'delete_particlecategory');
INSERT INTO `auth_permission` VALUES ('74', 'Can add p article comment', '26', 'add_particlecomment');
INSERT INTO `auth_permission` VALUES ('76', 'Can change p article comment', '26', 'change_particlecomment');
INSERT INTO `auth_permission` VALUES ('78', 'Can delete p article comment', '26', 'delete_particlecomment');
INSERT INTO `auth_permission` VALUES ('80', 'Can add p friend link', '28', 'add_pfriendlink');
INSERT INTO `auth_permission` VALUES ('82', 'Can change p friend link', '28', 'change_pfriendlink');
INSERT INTO `auth_permission` VALUES ('84', 'Can delete p friend link', '28', 'delete_pfriendlink');
INSERT INTO `auth_permission` VALUES ('86', 'Can add p mail record', '30', 'add_pmailrecord');
INSERT INTO `auth_permission` VALUES ('88', 'Can change p mail record', '30', 'change_pmailrecord');
INSERT INTO `auth_permission` VALUES ('90', 'Can delete p mail record', '30', 'delete_pmailrecord');
INSERT INTO `auth_permission` VALUES ('92', 'Can add p slide category', '32', 'add_pslidecategory');
INSERT INTO `auth_permission` VALUES ('94', 'Can change p slide category', '32', 'change_pslidecategory');
INSERT INTO `auth_permission` VALUES ('96', 'Can delete p slide category', '32', 'delete_pslidecategory');
INSERT INTO `auth_permission` VALUES ('98', 'Can add p slide manage', '34', 'add_pslidemanage');
INSERT INTO `auth_permission` VALUES ('100', 'Can change p slide manage', '34', 'change_pslidemanage');
INSERT INTO `auth_permission` VALUES ('102', 'Can delete p slide manage', '34', 'delete_pslidemanage');
INSERT INTO `auth_permission` VALUES ('104', 'Can add p system menu', '36', 'add_psystemmenu');
INSERT INTO `auth_permission` VALUES ('106', 'Can change p system menu', '36', 'change_psystemmenu');
INSERT INTO `auth_permission` VALUES ('108', 'Can delete p system menu', '36', 'delete_psystemmenu');
INSERT INTO `auth_permission` VALUES ('110', 'Can add p system route', '38', 'add_psystemroute');
INSERT INTO `auth_permission` VALUES ('112', 'Can change p system route', '38', 'change_psystemroute');
INSERT INTO `auth_permission` VALUES ('114', 'Can delete p system route', '38', 'delete_psystemroute');
INSERT INTO `auth_permission` VALUES ('116', 'Can add p topic', '40', 'add_ptopic');
INSERT INTO `auth_permission` VALUES ('118', 'Can change p topic', '40', 'change_ptopic');
INSERT INTO `auth_permission` VALUES ('120', 'Can delete p topic', '40', 'delete_ptopic');
INSERT INTO `auth_permission` VALUES ('122', 'Can add p topic comment', '42', 'add_ptopiccomment');
INSERT INTO `auth_permission` VALUES ('124', 'Can change p topic comment', '42', 'change_ptopiccomment');
INSERT INTO `auth_permission` VALUES ('126', 'Can delete p topic comment', '42', 'delete_ptopiccomment');
INSERT INTO `auth_permission` VALUES ('128', 'Can add 用户信息', '44', 'add_pusers');
INSERT INTO `auth_permission` VALUES ('130', 'Can change 用户信息', '44', 'change_pusers');
INSERT INTO `auth_permission` VALUES ('132', 'Can delete 用户信息', '44', 'delete_pusers');
INSERT INTO `auth_permission` VALUES ('134', 'Can add p download', '46', 'add_pdownload');
INSERT INTO `auth_permission` VALUES ('136', 'Can change p download', '46', 'change_pdownload');
INSERT INTO `auth_permission` VALUES ('138', 'Can delete p download', '46', 'delete_pdownload');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_admin_users_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_admin_users_id` FOREIGN KEY (`user_id`) REFERENCES `admin_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('2', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('6', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('16', 'common', 'padmingroups');
INSERT INTO `django_content_type` VALUES ('18', 'common', 'padmingroupspermission');
INSERT INTO `django_content_type` VALUES ('20', 'common', 'padmingroupsuser');
INSERT INTO `django_content_type` VALUES ('22', 'common', 'particle');
INSERT INTO `django_content_type` VALUES ('24', 'common', 'particlecategory');
INSERT INTO `django_content_type` VALUES ('26', 'common', 'particlecomment');
INSERT INTO `django_content_type` VALUES ('46', 'common', 'pdownload');
INSERT INTO `django_content_type` VALUES ('28', 'common', 'pfriendlink');
INSERT INTO `django_content_type` VALUES ('30', 'common', 'pmailrecord');
INSERT INTO `django_content_type` VALUES ('32', 'common', 'pslidecategory');
INSERT INTO `django_content_type` VALUES ('34', 'common', 'pslidemanage');
INSERT INTO `django_content_type` VALUES ('36', 'common', 'psystemmenu');
INSERT INTO `django_content_type` VALUES ('38', 'common', 'psystemroute');
INSERT INTO `django_content_type` VALUES ('40', 'common', 'ptopic');
INSERT INTO `django_content_type` VALUES ('42', 'common', 'ptopiccomment');
INSERT INTO `django_content_type` VALUES ('44', 'common', 'pusers');
INSERT INTO `django_content_type` VALUES ('8', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('10', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('14', 'user', 'adminuser');
INSERT INTO `django_content_type` VALUES ('12', 'user', 'test');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0001_initial', '2018-03-29 08:11:40.859546');
INSERT INTO `django_migrations` VALUES ('4', 'contenttypes', '0002_remove_content_type_name', '2018-03-29 08:11:40.899870');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0001_initial', '2018-03-29 08:11:41.018055');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0002_alter_permission_name_max_length', '2018-03-29 08:11:41.044289');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0003_alter_user_email_max_length', '2018-03-29 08:11:41.056399');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0004_alter_user_username_opts', '2018-03-29 08:11:41.069491');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0005_alter_user_last_login_null', '2018-03-29 08:11:41.081503');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0006_require_contenttypes_0002', '2018-03-29 08:11:41.087505');
INSERT INTO `django_migrations` VALUES ('18', 'auth', '0007_alter_validators_add_error_messages', '2018-03-29 08:11:41.099515');
INSERT INTO `django_migrations` VALUES ('20', 'auth', '0008_alter_user_username_max_length', '2018-03-29 08:11:41.112524');
INSERT INTO `django_migrations` VALUES ('22', 'auth', '0009_alter_user_last_name_max_length', '2018-03-29 08:11:41.124532');
INSERT INTO `django_migrations` VALUES ('24', 'user', '0001_initial', '2018-03-29 08:11:41.238655');
INSERT INTO `django_migrations` VALUES ('26', 'admin', '0001_initial', '2018-03-29 08:11:41.288690');
INSERT INTO `django_migrations` VALUES ('28', 'admin', '0002_logentry_remove_auto_add', '2018-03-29 08:11:41.304701');
INSERT INTO `django_migrations` VALUES ('30', 'admin', '0003_auto_20180319_1655', '2018-03-29 08:11:41.339724');
INSERT INTO `django_migrations` VALUES ('32', 'admin', '0004_auto_20180319_1656', '2018-03-29 08:11:41.369745');
INSERT INTO `django_migrations` VALUES ('36', 'sessions', '0001_initial', '2018-03-29 08:11:41.432787');
INSERT INTO `django_migrations` VALUES ('48', 'common', '0001_initial', '2018-03-30 01:27:07.102273');
INSERT INTO `django_migrations` VALUES ('50', 'common', '0002_ptopiccomment_user_type', '2018-03-30 05:52:32.976823');
INSERT INTO `django_migrations` VALUES ('52', 'common', '0003_pdownload', '2018-04-03 09:35:07.732450');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('3xkneh88bhh9kzud15mg6j7a21n0qcyo', 'NTliMDQ3YzVjNzViYzU3ZmM0NjM3NTljMTllM2Y4ZGJlNjdhNWI5Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6IiIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX19', '2018-04-16 01:10:57.790380');
INSERT INTO `django_session` VALUES ('552cw4d9z0u4hdo5zn7nw44cznih5ir9', 'ZTMxMzZjOWZjNjdhNmE0YWQwNWE3MmM5YzUzZDJjZjlhZjI4ODVjZDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6Ilx1NGUzYlx1NGViYSIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX0sInVzZXJfaWQiOjEwNiwibmlja25hbWUiOiJwZC1jbXNcdTc1MjhcdTYyMzciLCJ1c2VybmFtZSI6InpoYW5ndGFvX3dob0AxNjMuY29tIiwicmVnaXN0ZXJfY29kZSI6Ijk3OTQ2MSIsImF2YXRhciI6IiJ9', '2018-04-23 01:43:40.436988');
INSERT INTO `django_session` VALUES ('626kfrbep37oeoifvyaqu0ibfa29btt4', 'OTExNDE5Y2MyMjk5Y2E0OTY5YTMwZDk4NjRmNTY5ZWFjNTRkMTExZjp7InVzZXJfaWQiOjEwNCwibmlja25hbWUiOiJwZC1jbXNcdTc1MjhcdTYyMzciLCJ1c2VybmFtZSI6InNjbHp6aGFuZ2hhaWp1bkAxNjMuY29tIiwiYXZhdGFyIjoiIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjRkODNhZGJhODcyNmE3YzIwNzU2YTcwMDNlOTgzNGFhYjQ4MzRmMjciLCJ1c2VyX2luZm8iOnsiaWQiOjEsInVzZXJfbmFtZSI6ImFkbWluIiwibmlja19uYW1lIjoiXHU0ZTNiXHU0ZWJhIiwiY2FjaGVfcm91dGVfbGlzdCI6W10sImdyb3VwX2lkIjoxLCJjYWNoZV9tZW51X3JvdXRlX2xpc3QiOnt9fX0=', '2018-04-18 02:47:38.779596');
INSERT INTO `django_session` VALUES ('9s4rggcdqyxdzt4e8xq1hekjceritxmg', 'MTMxYmE2MWMyNjI0NWQyNWExNzgyMzRlZTA2OWVjMGMyZmUzZjRjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6Ilx1NGUzYlx1NGViYSIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX19', '2018-04-22 02:01:35.122997');
INSERT INTO `django_session` VALUES ('ax0dxvx1yjilsse40znd4cffhio2001y', 'YmI4MTkzYzJjZGUyYmNhYmYxMmIwZTRiYWE3NjEzYTBkYzAwY2QwNDp7InVzZXJfaWQiOjcyfQ==', '2018-04-13 01:44:48.662572');
INSERT INTO `django_session` VALUES ('d4axb3p1klx3j86cc38xioq35n8db4ox', 'OTg3MzY4MDRiZGJjYmQ2NjhmYTFlNTBiODgxOWY2YTc1NjFmNDljYjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6Ilx1NGUzYlx1NGViYSIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX0sInVzZXJfaWQiOjEwMiwibmlja25hbWUiOiJhMTIzNDU2IiwidXNlcm5hbWUiOiJhMTIzNDU2In0=', '2018-04-18 07:24:02.414760');
INSERT INTO `django_session` VALUES ('f2zr15sur2fesnkd6b8qamb5536g4d84', 'YTg0MmI1NjFmMDBjZWZiNzYwYzM1MDlkZDcwZTA3ZjI2YTUzZjQwZTp7InVzZXJfaWQiOjcyLCJyZWdpc3Rlcl9jb2RlIjoiNjA2OTIzIiwiX2F1dGhfdXNlcl9pZCI6IjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjRkODNhZGJhODcyNmE3YzIwNzU2YTcwMDNlOTgzNGFhYjQ4MzRmMjciLCJ1c2VyX2luZm8iOnsiaWQiOjEsInVzZXJfbmFtZSI6ImFkbWluIiwibmlja19uYW1lIjoiXHU0ZTNiXHU0ZWJhIiwiY2FjaGVfcm91dGVfbGlzdCI6W10sImdyb3VwX2lkIjoxLCJjYWNoZV9tZW51X3JvdXRlX2xpc3QiOnt9fSwibmlja25hbWUiOiJcdTg4ODFcdTZkNjkiLCJ1c2VybmFtZSI6Inl1YW5oYW8iLCJhdmF0YXIiOiIifQ==', '2018-04-18 02:03:10.259886');
INSERT INTO `django_session` VALUES ('gkdslgmmaanp1lfzztqvtr2cqggknz6b', 'NTliMDQ3YzVjNzViYzU3ZmM0NjM3NTljMTllM2Y4ZGJlNjdhNWI5Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6IiIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX19', '2018-04-12 08:48:17.927662');
INSERT INTO `django_session` VALUES ('p5vkc4xlspkbw6b9p0u23c27umb0rzm0', 'ZDI4YmY5MTQzNzQ2MzllZjQyMjhhOWIxYTQ2ZmEzNDdkOWIwM2IxYjp7InVzZXJfaWQiOjcyLCJuaWNrbmFtZSI6Ilx1ODg4MVx1NmQ2OSIsInVzZXJuYW1lIjoieXVhbmhhbyIsImF2YXRhciI6IiJ9', '2018-04-17 02:14:09.184265');
INSERT INTO `django_session` VALUES ('trvhzl1vj3tw0s15s8t691t8fepicvzi', 'NTliMDQ3YzVjNzViYzU3ZmM0NjM3NTljMTllM2Y4ZGJlNjdhNWI5Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6IiIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX19', '2018-04-12 09:19:21.805368');
INSERT INTO `django_session` VALUES ('vnyjwd5rwuir95ontnxvxcghx3bcc9mg', 'NTliMDQ3YzVjNzViYzU3ZmM0NjM3NTljMTllM2Y4ZGJlNjdhNWI5Yzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6IiIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX19', '2018-04-12 08:46:39.554060');
INSERT INTO `django_session` VALUES ('vrbgmt6kddy7j3vmpp28zeflhgm8rn8u', 'ZWU2NDE0OTAyODg5MmE1M2MwZGMwOWNiMjg0ODkzMTAwNWE5MzE2NDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0ZDgzYWRiYTg3MjZhN2MyMDc1NmE3MDAzZTk4MzRhYWI0ODM0ZjI3IiwidXNlcl9pbmZvIjp7ImlkIjoxLCJ1c2VyX25hbWUiOiJhZG1pbiIsIm5pY2tfbmFtZSI6IiIsImNhY2hlX3JvdXRlX2xpc3QiOltdLCJncm91cF9pZCI6MSwiY2FjaGVfbWVudV9yb3V0ZV9saXN0Ijp7fX0sInJlZ2lzdGVyX2NvZGUiOiI1MDU3NDEiLCJ1c2VyX2lkIjo4Niwibmlja25hbWUiOiJcdTYyMTFcdTY2MmZcdTVjMGZcdTc2N2QiLCJ1c2VybmFtZSI6IjU2ODg5NDQ0OUBxcS5jb20iLCJhdmF0YXIiOiIifQ==', '2018-04-18 01:40:23.000172');
INSERT INTO `django_session` VALUES ('xpukgp8bd1hqyjvc1ts7ccn0hk1h60r1', 'NTA5NTBjNGVkY2JkNGNiNWVlMDI0YTRkZjMwMDFjMWJiN2U4NTRmYTp7InJlZ2lzdGVyX2NvZGUiOiIxNDk3NDgiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNGQ4M2FkYmE4NzI2YTdjMjA3NTZhNzAwM2U5ODM0YWFiNDgzNGYyNyIsInVzZXJfaW5mbyI6eyJpZCI6MSwidXNlcl9uYW1lIjoiYWRtaW4iLCJuaWNrX25hbWUiOiIiLCJjYWNoZV9yb3V0ZV9saXN0IjpbXSwiZ3JvdXBfaWQiOjEsImNhY2hlX21lbnVfcm91dGVfbGlzdCI6e319LCJ1c2VyX2lkIjo3Mn0=', '2018-04-17 08:30:41.149068');
INSERT INTO `django_session` VALUES ('zjuhmh3w12kmwl0jd0l0z4hyftj6efy5', 'YmI4MTkzYzJjZGUyYmNhYmYxMmIwZTRiYWE3NjEzYTBkYzAwY2QwNDp7InVzZXJfaWQiOjcyfQ==', '2018-04-12 09:10:06.675314');

-- ----------------------------
-- Table structure for p_admin_groups
-- ----------------------------
DROP TABLE IF EXISTS `p_admin_groups`;
CREATE TABLE `p_admin_groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL COMMENT '组名称',
  `group_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '组状态 0:正常 1:禁用',
  `group_description` varchar(1000) NOT NULL COMMENT '组描述',
  `is_delete` tinyint(1) unsigned DEFAULT '0' COMMENT '是否删除 0：否 1：是',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='后台管理员组';

-- ----------------------------
-- Records of p_admin_groups
-- ----------------------------
INSERT INTO `p_admin_groups` VALUES ('1', '超级管理员', '0', '超级管理员', '0', '2018-03-23 15:33:33', '2018-03-23 15:33:33');
INSERT INTO `p_admin_groups` VALUES ('2', '文章管理组', '0', '文章管理组', '0', '2018-03-23 07:40:29', '2018-03-23 07:40:29');
INSERT INTO `p_admin_groups` VALUES ('4', '其他用户组', '0', '其他用户组11111', '0', '2018-03-27 06:09:17', '2018-03-27 06:24:39');

-- ----------------------------
-- Table structure for p_admin_groups_permission
-- ----------------------------
DROP TABLE IF EXISTS `p_admin_groups_permission`;
CREATE TABLE `p_admin_groups_permission` (
  `permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `menu_id` int(10) unsigned NOT NULL,
  `route_permission` varchar(1000) NOT NULL,
  `is_delete` int(10) unsigned NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`permission_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_admin_groups_permission
-- ----------------------------
INSERT INTO `p_admin_groups_permission` VALUES ('2', '2', '24', '96', '1', '2018-03-23 07:55:18.596273', '2018-03-23 07:55:18.596273');
INSERT INTO `p_admin_groups_permission` VALUES ('4', '2', '26', '8', '1', '2018-03-23 07:55:18.596273', '2018-03-23 07:55:18.596273');
INSERT INTO `p_admin_groups_permission` VALUES ('6', '2', '28', '98|108', '1', '2018-03-23 07:55:18.596273', '2018-03-23 07:55:18.596273');
INSERT INTO `p_admin_groups_permission` VALUES ('8', '2', '16', '32', '0', '2018-03-23 08:26:24.837932', '2018-03-23 08:26:24.837932');
INSERT INTO `p_admin_groups_permission` VALUES ('10', '2', '18', '22|24|130', '0', '2018-03-23 08:26:24.837932', '2018-03-23 08:26:24.837932');
INSERT INTO `p_admin_groups_permission` VALUES ('12', '2', '24', '96', '0', '2018-03-23 08:42:32.417706', '2018-03-23 08:42:32.417706');
INSERT INTO `p_admin_groups_permission` VALUES ('14', '2', '26', '8', '1', '2018-03-23 08:42:32.417706', '2018-03-23 08:42:32.417706');
INSERT INTO `p_admin_groups_permission` VALUES ('16', '2', '28', '98|108', '0', '2018-03-23 08:42:32.417706', '2018-03-23 08:42:32.417706');
INSERT INTO `p_admin_groups_permission` VALUES ('18', '2', '2', '6', '0', '2018-03-23 08:46:27.795291', '2018-03-23 08:46:27.795291');
INSERT INTO `p_admin_groups_permission` VALUES ('20', '4', '6', '14', '0', '2018-03-27 06:09:27.468593', '2018-03-27 06:09:27.468593');
INSERT INTO `p_admin_groups_permission` VALUES ('22', '4', '8', '10|12|28|30', '0', '2018-03-27 06:09:27.468593', '2018-03-27 06:09:27.468593');
INSERT INTO `p_admin_groups_permission` VALUES ('24', '4', '10', '16|18', '0', '2018-03-27 06:09:27.468593', '2018-03-27 06:09:27.468593');
INSERT INTO `p_admin_groups_permission` VALUES ('26', '4', '32', '14|2|6|10', '1', '2018-03-27 06:09:27.469583', '2018-03-27 06:09:27.469583');
INSERT INTO `p_admin_groups_permission` VALUES ('28', '4', '24', '96', '1', '2018-03-27 06:09:31.989632', '2018-03-27 06:09:31.990632');
INSERT INTO `p_admin_groups_permission` VALUES ('30', '4', '26', '8', '1', '2018-03-27 06:09:31.990632', '2018-03-27 06:09:31.990632');
INSERT INTO `p_admin_groups_permission` VALUES ('32', '4', '28', '98|108', '1', '2018-03-27 06:09:31.990632', '2018-03-27 06:09:31.990632');
INSERT INTO `p_admin_groups_permission` VALUES ('34', '4', '52', '156', '0', '2018-03-28 08:43:40.506659', '2018-03-28 08:43:40.506659');

-- ----------------------------
-- Table structure for p_admin_groups_user
-- ----------------------------
DROP TABLE IF EXISTS `p_admin_groups_user`;
CREATE TABLE `p_admin_groups_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) unsigned NOT NULL,
  `admin_id` int(10) unsigned NOT NULL,
  `is_delete` int(10) unsigned NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_admin_groups_user
-- ----------------------------
INSERT INTO `p_admin_groups_user` VALUES ('1', '1', '1', '0', '2018-03-23 16:35:18.000000', '2018-03-23 16:35:20.000000');
INSERT INTO `p_admin_groups_user` VALUES ('20', '1', '4', '0', '2018-04-04 01:46:51.633237', '2018-04-04 01:46:51.633237');

-- ----------------------------
-- Table structure for p_article
-- ----------------------------
DROP TABLE IF EXISTS `p_article`;
CREATE TABLE `p_article` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_title` varchar(300) NOT NULL,
  `article_content` longtext NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `thumb` varchar(200) NOT NULL DEFAULT '',
  `last_modified_time` datetime(6) NOT NULL,
  `status` smallint(5) unsigned NOT NULL,
  `article_abstract` varchar(500) DEFAULT NULL,
  `views` int(10) unsigned NOT NULL,
  `comment` int(10) unsigned NOT NULL,
  `topped` tinyint(1) NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `user_type` smallint(5) unsigned NOT NULL,
  `is_delete` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_article
-- ----------------------------
INSERT INTO `p_article` VALUES ('2', '这几个2018可能大火的物联网应用', '<div class=\"page_top\" style=\"margin: 0px 0px 35px; padding: 0px; background-repeat: no-repeat; background-position: center 0px; position: relative; overflow: hidden; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, &quot;hiragino sans gb&quot;, &quot;ST HeiTi&quot;, &quot;microsoft yahei&quot;, 微软雅黑, tahoma, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><div class=\"page_top_nav small gray poa\" style=\"margin: 0px; padding: 0px;\"><br/></div><div class=\"page_top_bg\" style=\"margin: 0px; padding: 0px; background: none;\"><div class=\"page_top_content\" style=\"margin: 0px auto; padding: 0px; overflow: hidden;\">每年这个时候，知名物联网研究机构IoT Analytics都会基于市场上纷繁的信息来探索物联网项目的具体实施情况，今年也不例外。作为其追踪物联网生态的一个重要组成部分，IoT Analytics对1600个在企业中实际运行的物联网项目进行了整合、验证和分类，并将其进行结构化处理，归纳整理至一个易于使用的数据库中。<br/></div></div></div><div class=\"main_article\" style=\"margin: 0px; padding: 0px; word-wrap: break-word; clear: both; color: rgb(51, 51, 51); font-family: &quot;helvetica neue&quot;, &quot;hiragino sans gb&quot;, &quot;ST HeiTi&quot;, &quot;microsoft yahei&quot;, 微软雅黑, tahoma, sans-serif; white-space: normal; background-color: rgb(255, 255, 255);\"><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">基于对数据库的更新，IoT Analytics发布了“2018 Top物联网项目排名”，其中包含了大量隐藏在数据背后的深入洞察，仅通过本篇文章，分享其中的一些见解。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">作为对比，我们可以先来回顾一下 2016年的物联网应用排名 ：</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\"><img src=\"http://img.php.cn//upload/image/807/962/854/1520989837842515.jpg\" title=\"1520989837842515.jpg\" alt=\"1.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">图：2016年Top物联网应用排名</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">下图则是更新过的“ 2018 Top物联网项目排名 ”：</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\"><img src=\"http://img.php.cn//upload/image/173/642/766/1520989856666359.jpg\" title=\"1520989856666359.jpg\" alt=\"1.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">图：2018年Top物联网应用排名</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">我们探索的大多数物联网项目都集中在智慧城市(367个)领域，其次是互联工业(265个)和互联建筑(193个)领域。从地域上来看，大多数(45%)物联网项目集中在美国，其次是欧洲(35%)和亚洲(16%)。在考察某一特定种类的物联网应用时，地域分布又有较大差异：大部分的智慧城市项目位于欧洲(45%);而美洲，特别是北美，在智慧医疗(55%)和车联网(54%)领域都很强大;亚洲/太平洋地区则在智慧农业领域表现的较为突出(31%)。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">相比2016年的排名，智慧城市物联网应用(由政府和市政机构驱动)一举超过工业物联网，成为了我们研究的所有物联网项目中种类最多的领域;而互联建筑(由能帮助业主提高运营效率并降低成本的楼宇自动化解决方案所驱动)则连爬四阶，成为第三大类物联网应用。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">1.智慧城市</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">交通流量管理和公用事业的需求驱动了智慧城市物联网应用的发展</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\"><img src=\"http://img.php.cn//upload/image/208/471/477/1520989869432991.jpg\" title=\"1520989869432991.jpg\" alt=\"1.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">智慧城市是目前是我们研究的物联网项目中数量最多的一大类(23%)，一举超过了2016年最热的工业物联网。最近，世界各地的政府和市政机构发起了数百项有关智慧城市的创新，而新加坡和巴塞罗那就是典型的范例。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">目前，最受欢迎的智慧城市应用是包括智慧停车系统、智能交通监控、共享单车、智能公交车专用道路等项目在内的智能交通类应用。当然，也有一些更具特色的应用，比如智能渡船系统或智能公交候车厅等……</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">其它智慧城市的创新围绕着以照明、环境监测和公众安全为主的公用事业领域展开。就地域上来看，欧洲的智慧城市项目数量最多(164个)。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">2.互联工业</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在“非工厂”环境中，有很多优秀的物联网项目</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在我们调查的物联网项目中，17%与工业相关。该领域涵盖了“工厂内”和“工厂外”两大类广泛连接。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">最受欢迎的工业物联网应用是对非工厂环境中的设备进行监控，典型的“非工厂型”项目比如对起重机、叉车、钻井、甚至整个矿山和油田(例如思科在西澳大利亚和力拓矿业集团联合开展的互联采矿业务)等互联机器进行远程监控。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">“智能工厂”自动化和控制是第二受欢迎的工业物联网应用——包括产品生产监控、工业现场人员的可穿戴设备、远程控制PLC以及自动质量控制系统(例如：汽车零件制造商Varroc正在使用Altizon的数字化工厂解决方案以使其工业设备实现互联)在内的整体解决方案。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">3.互联建筑</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">2016年以来，互联建筑类的物联网项目数量增加得最多</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">与2016年的研究成果相比，在所有物联网项目类别中，互联建筑类的物联网应用增加得最多(增加了7个百分点)。61%的互联建筑项目都涉及到楼宇自动化，目的是降低能源成本。39%的项目与建筑安全相关，31%的项目涉及暖通空调/制冷/制暖。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">案例</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">未来，随着城镇人口的增加及消费者结构趋于年轻化，对酒店入住体验的需求将发生明显变化。由此，从酒店设计规划开始，到实施建设、投入运行等各阶段，住客体验、服务及管理将成为焦点，全新挑战也由此而生。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">施耐德电气作为能效管理和自动化领域的领导者，始终深耕酒店行业，并将与酒店管理集团的紧密合作作为自身发展的重要战略之一。依托全新EcoStruxure架构与平台，针对酒店在动力及电能管理、设备管理及运维、智能化手段及数字化应用等环节，以及住客在安全、安静、私密、舒适、操作性等方面的更高需求，施耐德电气已为众多酒店提供了定制化解决方案。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">其中，从2008年起，希尔顿酒店集团以施耐德电气Resource Advisor资源顾问系统作为基础，在其全部设置中部署施耐德电气智慧酒店产品，并建立可跟踪能源成本的云端软件平台，通过模块化应用程序协调旗下1000家酒店的能源数据，并定期收到施耐德电气提出的改善建议，从而释放节能潜力，利用能源采购支持为其每年节省3%的能源开销，在双方合作的第一年便实现了能耗降低14.5%。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">此外，苏州吴江盛虹万丽酒店、香港万丽海景酒店、上海宝华万豪酒店，乃至未来万豪集团旗下更多不同等级的酒店，都将运用施耐德电气基于EcoStruxure的系统与服务，包括能效及可持续顾问、智能配电系统、楼宇自动化、照明、客房解决方案和UPS等，使能效成本节省高达10%-15%。万豪集团能源使用效率的提高，得益于更优异的系统设计，和更高的系统集成度。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">4.车联网</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">领头的应用是车辆诊断和车队管理</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\"><img src=\"http://img.php.cn//upload/image/730/348/407/1520989887652103.jpg\" title=\"1520989887652103.jpg\" alt=\"1.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">自2016年发布物联网项目排名以来，我们统计到的车辆网项目数量增加了一倍还多，其中大部分集中在车联诊断(77%)和车队管理(57%)解决方案领域。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">例如，位于爱尔兰的一家远程监控软件公司TracknStop发布了其车辆诊断解决方案，包括实时追踪、传感器读书监测以及远程车辆控制等功能。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">5.其它值得注意的洞察</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">低功耗广域网络(LPWAN)连接技术快速发展</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在我们调查的所有项目中，7%的物联网项目应用了全新的、即将到来的LPWAN技术。这些项目中有64%都集中在智慧城市领域，其它项目则专注于智慧农业和智慧能源。在这些项目中，应用LoRa技术的占到了37%，紧随其后的是SigFox(21%)和NB-IoT(19%)。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在《沃达丰2017年度物联网市场晴雨表》中，对LPWAN的发展同样持乐观态度</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">报告中表示：选择了正确的连接服务至关重要。随着应用者使用设备的数量与种类的增多，需要部署更复杂的项目时，连接服务的需求自然也会增加。物联网项目的种类数不胜数，连接服务需求自然也就五花八门。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">企业需要针对不同用途的连接服务做出最佳选择，但很少有企业仅仅依靠一种连接服务方案。有接近1/4的受访企业表示正在考虑使用窄带物联网来部署物联网项目。这是低功耗广域网络新技术的重磅开端。即使那些已经完成物联网部署且物联网已投入使用的企业仍对低功耗广域网络(LP-WAN)饶有兴趣(16%的物联网应用者)。但计划部署物联网的企业对低功耗广域网络的兴趣更浓，28%考虑应用物联网的企业正在研究低功耗广域网络(LP-WAN)，这可能会掀起新一波的物联网应用潮。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">大多数企业物联网项目都注重降低成本</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">大多数的企业物联网项目的主要价值驱动因素都是成本节约(54%);只有35%的物联网项目目的是为了增加收入(例如，提供新的与物联网相关的产品和服务);24%的项目也增加了企业整体的安全性(例如，通过提供具有实时警报和通知功能的增强型监控系统。)</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">物联网企业的就业人数正在增长，但大多数都是小规模的部署</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">虽然这1600个物联网项目的清单并不完整，但我们的分析依然可以帮助我们得出这样的结论：全球宣布和启动的物联网项目总数仍然十分有限。将这一物联网项目清单与其它数据点集进行结合，我们相信全球企业级物联网项目的总数(包括未公开发布的物联网项目)在10000-30000之间。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">这一数据范围符合我们的整体市场模型以及我们的洞察——物联网市场并没有进入爆发阶段，而是依靠许多试点项目和小规模的应用，仍然在以30-40%的速度稳步增长——一些垂直行业的增长率超过了平均增长水平，比如智慧城市。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">预计这一稳定增长的趋势将持续到2018年结束。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">6.其它有趣的材料</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">最后，为了好玩，分享一些我们在研究中发现的独特的物联网项目：</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在苏格兰，一个非常酷的项目是使用智能遥测标签和NB-IoT技术来跟踪和监控海豹的移动。海洋科学家将把无害的遥测标签贴在海豹头部的皮毛上来监测海豹的数量。这种情况下，海洋标签在以类似智能手机的方式工作，依靠物联网技术收集海豹身上的重要信息。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\"><img src=\"http://img.php.cn//upload/image/866/148/585/1520989906729933.jpg\" title=\"1520989906729933.jpg\" alt=\"1.jpg\"/></p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">在北美的另一端，龙卷风监测解决方案正在为居住在危险地带的居民提供预测报警服务，以拯救生命。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">由于气候变化目前是一个热门话题，所以我们是伦敦“Smogmobile”的狂热粉丝，该解决方案中包含了能够测量二氧化碳、甲烷、臭氧、二氧化氮以及微小颗粒污染物等温室气体的传感器，这些污染物明显对健康有害。</p><p style=\"margin-top: 0px; margin-bottom: 1em; padding: 0px;\">最后，美国国家航天局(NASA)正在太空中使用互联 Robonauts进行空气质量检测。NASA 一直都希望研发灵巧的机器人宇航员，于是他们研发出了 Robonauts 系列机器人，以帮助或代替人类到太空中作业。NASA 在其网站上写道：太空机器人将在国际空间站上从事一些简单的，重复性的或危险的工作。NASA 在太空机器人建设方面取得了长足的进步，就在 2011 年，他们将机器人 Robonaut 2 成功地送到了国际空间站，并对其做了远程操控。</p></div><p><br/></p>', '2018-03-29 09:08:58.878611', '/media/default02.jpg', '2018-04-11 06:34:42.933207', '1', '每年这个时候', '1', '0', '0', '6', '72', '2', '0');
INSERT INTO `p_article` VALUES ('4', 'App域名劫持之DNS高可用开源版HttpDNS方案详解', '<div class=\"article_intro\" style=\"width: 660px; height: auto; color: rgb(102, 102, 102); font-family: &quot;Microsoft Yahei&quot;; font-size: 14px; line-height: 26px; border: 0px dashed rgb(238, 238, 238); padding: 10px; background: rgb(252, 252, 252); margin-top: 20px; white-space: normal;\">HttpDNS是使用HTTP协议向DNS服务器的80端口进行请求，代替传统的DNS协议向DNS服务器的53端口进行请求,绕开了运营商的LocalDNS</div><div class=\"article_content\" style=\"width: 670px; height: auto; color: rgb(51, 51, 51); font-family: &quot;Microsoft Yahei&quot;; text-align: justify; line-height: 35px; margin-top: 50px; min-height: 1280px; padding-bottom: 50px; word-wrap: break-word; word-break: normal; overflow: hidden; white-space: normal;\"><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">鹅厂往事中提到</p><div style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">HttpDNS主要解决三类问题：<ol style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\" class=\" list-paddingleft-2\"><li><p>LocalDNS劫持: 由于HttpDNS是通过ip直接请求http获取服务器A记录地址，不存在向本地运营商询问domain解析过程，所以从根本避免了劫持问题。 （对于http内容tcp/ip层劫持，可以使用验证因子或者数据加密等方式来保证传输数据的可信度）</p></li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">用户连接失败率下降: 通过算法降低以往失败率过高的服务器排序，通过时间近期访问过的数据提高服务器排序，通过历史访问成功记录提高服务器排序。如果ip(a)访问错误，在下一次返回ip(b)或者ip(c) 排序后的记录。（LocalDNS很可能在一个ttl时间内（或多个ttl）都是返回记录</p><h2 style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">HttpDNSLib库主要由三个模块组成，查询模块，缓存模块，评估模块。</h2><h4 style=\"padding: 0px; list-style: none outside none;\"></h4><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">检查本地是否有对应的 domain 缓存</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">如果没有 则从本地LocalDNS获取然后从httpdns更新domain记录</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">有数据则检测是否过期 已过期则更新记录返回 LocalDNS 记录， 未过期则直接返回缓存层数据。</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">从HttpDNS 接口查询本次app开启后使用过的domain 记录定时访问，更新内存缓存，数据库缓存等记录</p></li></ol><h4 style=\"padding: 0px; list-style: none outside none;\"><ul class=\" list-paddingleft-2\"><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">根据SP（或Wifi名）缓存域名信息</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">更具SP（或Wifi名）缓存服务器ip信息、优先级</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">记录服务器ip每次请求成功数、错误数</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">记录服务器ip最后成功访问时间、最后测速</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">添加 内存 》数据库 之间的缓存层</p></li><h4 style=\"padding: 0px; list-style: none outside none;\"></h4><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">根据本地数据，对一组IP排序</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">处理用户反馈回来的请求明细，入库</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">针对用户反馈是失败请求，进行分析上报预警</p></li><li><p style=\"margin-top: 15px; margin-bottom: 0px; padding: 0px; word-break: break-all;\">给HttpDns服务端智能分配A记录提供数据依据</p></li><li><p>&lt;h2 color:#333333;fontsize:18px;textindent:1em;backgroundcolor:#fefefe;&quot;=&quot;&quot; style=&quot;margin: 0px; padding: 0px; font-size: 16px; font-weight: 400; word-wrap: break-word; word-break: break-all;&quot;&gt;HttpDNS交互流程</p></li></ul></h4></div></div><p><br/></p>', '2018-03-29 09:16:17.380302', '/media/default02.jpg', '2018-04-10 08:42:08.550849', '1', 'HttpDNS是使用HTTP协议向DNS服务器的80端口进行请求，代替传统的DNS协议向DNS服务器的53端口进行请求,绕开了运营商的LocalDNS', '7', '0', '0', '6', '72', '2', '0');
INSERT INTO `p_article` VALUES ('6', 'python学习', '<p>python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习</p>', '2018-04-03 09:45:45.113854', '/media/default02.jpg', '2018-04-04 10:14:05.000000', '0', 'python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习python学习', '0', '0', '0', '8', '82', '2', '0');
INSERT INTO `p_article` VALUES ('8', '222222', '<p>22222</p>', '2018-04-04 01:35:50.025181', '/media/default02.jpg', '2018-04-04 01:35:50.025181', '0', '2222', '0', '0', '0', '2', '1', '1', '0');
INSERT INTO `p_article` VALUES ('10', '又一巨头重大宣布！有驾照的恭喜了！', '<p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">今天<a href=\"http://www.yidianzixun.com/channel/w/%E5%9C%A8%E7%BA%BF%E6%97%85%E6%B8%B8\" style=\"margin: 0px; padding: 0px; color: rgb(18, 154, 238); font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: 24px; -webkit-font-smoothing: antialiased; border: none; cursor: pointer; transition: all 0.3s; text-decoration-line: none; outline: none;\">在线旅游</a>巨头携程已经彻底拿到网约照车牌，更意味着携程专车可以在全国使用。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"a-image\" style=\"margin: 0px; padding: 0px;\"><img src=\"http://i1.go2yd.com/image.php?url=0IiQI58iad\"/></span></p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">犹如平地一声惊雷！整个网络今天都感觉要炸了！！所有人都没有想到；美团，高德，宝马奔驰，之后；又一个巨头也宣布加入战斗，瞄准滴滴开枪。。。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">屋漏偏逢连夜雨 ；船迟又遇打头风！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">真的是怕什么就来什么。。。</p><blockquote style=\"margin: 0px 0px 35px; padding: 0px 0px 0px 12px; color: rgb(153, 153, 153); border-left: 5px solid rgb(213, 213, 213); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; text-indent: 34px; white-space: normal; background-color: rgb(255, 255, 255);\"><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 2em; line-height: 25px; font-size: 16px;\">人变了，司机变了。。。</p></blockquote><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">美团，高德，携程为什么三年前不杀进来，偏偏选择这个时间，这个时候突然出手！！！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">一、人变了。三年前滴滴，快的，uber掀起的第一轮互联网打车的狂潮；直到今天，相信所有人都还记忆犹新。。。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">当时为了快速打开市场，培养乘客网上打车的习惯，三大平台疯狂烧钱；短短一年的时间，95%的消费者都已经改变了乘车习惯；从路边等出租车，演变为了网上约好车，在出门。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"a-image\" style=\"margin: 0px; padding: 0px;\"><img src=\"http://i1.go2yd.com/image.php?url=0IiQI5I3cV\"/></span></p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">这极大的节省了普通人出行的时间，也改变了整个中国出租车行业，这是第一次最大的变革！三年后的今天，乘客已经习惯网约车了。。。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">二、司机变了。三四年前的司机，绝大多数都是出租车司机；这部分人群要忍受每月高额的份子钱，每天不停的接客开车；工作十个小时，五个小时赚的钱交份子，2个小时加油费，只有3个小时赚自己的工资；</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">三年后的今天，出租车司机基本已经全部变了。门槛彻底已经没有了，只要你有一个驾照！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">这演变的不只是从出租车到快车，专车，顺风车，拼车，出租车的大合流。而是司机的思想观念彻底的改变！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">三年后的今天，你问问还有哪个出租车司机会傻乎乎的每月交10000元份子钱给租赁公司。。。</p><blockquote style=\"margin: 0px 0px 35px; padding: 0px 0px 0px 12px; color: rgb(153, 153, 153); border-left: 5px solid rgb(213, 213, 213); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; text-indent: 34px; white-space: normal; background-color: rgb(255, 255, 255);\"><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 2em; line-height: 25px; font-size: 16px;\">最好的时代也是最坏的时代。。。</p></blockquote><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">美团打车刚刚正式对外宣布，美团在上海上线仅仅三天，就已经拿下了滴滴快车在上海30%以上的份额！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\"><span class=\"a-image\" style=\"margin: 0px; padding: 0px;\"><img src=\"http://i1.go2yd.com/image.php?url=0IiQI5IvTD\"/></span></p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">并且这个数字还在一天一天扩大。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">所以你现在知道为什么美团明明已经知道滴滴接近垄断了中国网约车市场；还要义无反顾在这个时候冲进来吗？</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">因为乘客变了，司机变了，人变了！</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">现在创业的壁垒，根本没有以前那么坚固！！！各行各业都是这样....</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">美团看懂了，高德看懂了，携程也看懂了；然后，他们都来抢蛋糕了...</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">全中国顶级的那些<a href=\"http://www.yidianzixun.com/channel/w/%E4%BA%92%E8%81%94%E7%BD%91%E5%A4%A7%E4%BD%AC\" style=\"margin: 0px; padding: 0px; color: rgb(18, 154, 238); font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: 24px; -webkit-font-smoothing: antialiased; border: none; cursor: pointer; transition: all 0.3s; text-decoration-line: none; outline: none;\">互联网大佬</a>们，也都早已看出来了！！！马云放不下身份去自己动手抢蛋糕，就投了点钱，拿了点股份；<a href=\"http://www.yidianzixun.com/channel/w/%E9%A9%AC%E5%8C%96%E8%85%BE\" style=\"margin: 0px; padding: 0px; color: rgb(18, 154, 238); font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; line-height: 24px; -webkit-font-smoothing: antialiased; border: none; cursor: pointer; transition: all 0.3s; text-decoration-line: none; outline: none;\">马化腾</a>就更加聪明了；美团也有股份，滴滴也有股份。。。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">这是一个最好的时代，也是一个最坏的时代；互联网在快速普及；手机占用人们的时间越来越多！人们的消费习惯，上网习惯，全部都已经发生了翻天覆地的变化。</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">各行各业都在经历大换血，大迭代！这是一场改革，更是一场大冲击......</p><p style=\"margin-top: 20px; margin-bottom: 20px; padding: 0px; text-indent: 34px; line-height: 1.8; color: rgb(29, 29, 29); font-family: &quot;Microsoft YaHei&quot;, Arial, &quot;\\\\5B8B体&quot;, &quot;Arial Narrow&quot;; font-size: 17px; text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);\">谁都逃不过！</p><p><br/></p>', '2018-04-04 01:53:34.563707', '/media/default02.jpg', '2018-04-04 01:53:34.563707', '0', '今天在线旅游巨头携程已经彻底拿到网约照车牌，更意味着携程专车可以在全国使用。', '0', '0', '0', '18', '86', '2', '0');
INSERT INTO `p_article` VALUES ('12', '法撒旦飞洒', '<p>发送分散发顺丰<br/></p>', '2018-04-08 01:40:20.570670', '/media/default02.jpg', '2018-04-08 01:40:20.570718', '0', '发放的萨菲大厦', '0', '0', '0', '2', '102', '2', '0');
INSERT INTO `p_article` VALUES ('14', '法师法师法倒萨', '<p>发送范德萨范德萨</p>', '2018-04-08 01:43:48.836604', '/media/default02.jpg', '2018-04-08 01:43:48.836655', '0', '飞洒发撒的发生', '0', '0', '0', '2', '102', '2', '0');
INSERT INTO `p_article` VALUES ('16', 'fa', '<p><img src=\"/media/20180408/VNC-Viewer-6.17.1113-MacOSX-x86_64_20180408054757_563.png\" title=\"\" alt=\"VNC-Viewer-6.17.1113-MacOSX-x86_64.png\"/></p>', '2018-04-08 05:48:07.902814', '/media/default02.jpg', '2018-04-08 05:48:07.902911', '0', 'fas', '0', '0', '0', '2', '102', '2', '0');
INSERT INTO `p_article` VALUES ('18', '平凡的风景，不平凡的心情', '<div id=\"main_content\">\n<p>　　迎着朝阳，又在一次走在上班的路上。</p><p>　　我喜欢这个时候，说不上来为什么，或许这短暂的一段时间是一天中最放松的时候。</p><p>　　农村的清晨不想城市里那样，生活节奏没那么快，一切也都没有那么匆忙。</p><p>　　没有拥挤的早高峰，也没有匆匆忙忙的脚步，</p><p>　　我常常会习惯摇下一点点车窗，微微的凉风拂过脸庞，整个人立马清醒了起来。</p><p>　　清晨是一天的开始，路上车不多，一切都那么安静，时不时耳畔还传来几声清脆的鸟叫。</p><p>　　虽然只有单调的叽叽喳喳却也是难得的动人旋律。</p><p>　　此时微风不燥，阳光正好，偶尔我会放慢车速看看路边刚刚萌发的柳芽或者含苞待放的野花。</p><p>　　许多时候，我都会把这很段的一段路当做是一次旅行来享受。很多时候也会忘记了在不远处的目的地还有一天疲惫的工作。</p><p>　　安静的环境用能够让心情放松，我很清醒自己可以融身这种环境。</p><p>　　有人厌恶工作的繁琐，有人埋怨生活的疲惫。</p><p>　　然而繁琐与疲惫的背后都只是人们不愿停下匆匆的脚步，哪怕只留一秒钟的时间让这些平凡的风景钻入眼中。</p><p>　　生活其实很简单，不过只是一日三餐而已，所有的烦恼不过是庸人自扰的抱怨。</p><p>　　如果对于生活过于悲观，那不如抽个时间去看看清晨朝阳迸发的活力或者欣赏野花新春的热情，那个时候你会发现生活其实不单单只有烦恼，一些平凡的风景也拥有不平凡的意义。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-10 02:20:00.406350', '1', '迎着朝阳，又在一次走在上班的路上。我喜欢这个时候，说不上来为什么，或许这短暂的一段时间是一天中最放松的时候。农村的清晨不想城市里那样，生活节奏没那么快，一切也都没有那么匆忙。没有拥挤的早高峰，也没有匆匆忙忙的脚步，我常常会习惯摇下一点点车窗，微微的凉风拂过脸庞，整个人立马清醒了起来。清晨是一天的开始......', '5', '0', '0', '0', '0', '1', '0');
INSERT INTO `p_article` VALUES ('20', '千古绝恋“神都”与“花王”', '<div id=\"main_content\">\n<p>　　春风一阵阵的接连而来，好像在用她那双温和的，宛如母亲的手去轻轻扶拍着，试图叫醒那些沉睡在梦乡已久的姑娘们。</p><p>　　她们像是感受到了大自然母亲的呼唤，一个个的接连着从哪梦乡中走出。她们先是活动了一下松散的双手，让它们先拥有第一层活力，以便能给自己披上绝美的绿衣。</p><p>　　千古绝配神都与花王</p><p>　　一点点的苏醒，让她们全身上下充满了朝气。她们开始抬头挺胸，再为天空送去那最美的笑意，像是在回报母亲所给予的珍贵的生命一般。</p><p>　　有一座身处天地之中，具有独到气运的都城。他面对这些早已露出笑意的姑娘们，显得漠不关心的模样，她们并没有打动他的身心!</p><p>　　千古绝配神都与花王</p><p>　　他好像在期待着，像期待绝世仙女一般的期待着。他的灵魂与身心，只属于那迟迟未到的一个姑娘。他知道，属于他的那个姑娘还未苏醒而已。</p><p>　　千古绝配神都与花王</p><p>　　这样的一个姑娘，你不能试图去叫醒她。曾有一人为了一己私欲，要去尝试的叫醒她，就像叫醒其他姑娘一般。可也只有她不畏权贵，只求自我活得洒脱，毅然决然的坚守本心不被世俗所打败!</p><p>　　纵使你要那她的性命相要挟，要用最残酷的火刑去惩罚她，她也会用她的傲骨去证明，她也决不退缩!</p><p>　　同样，她也会用她那烧的不成样子的焦骨去向你证明，她不会被打败!就像这世间的真理，永远不能被扭曲一样!</p><p>　　千古绝配神都与花王</p><p>　　她们之间的命运都是如此的坎坷，所以在相遇的那一刻，便让自己都属于对方一人所有!</p><p>　　她会在每年的谷雨时节过后，以自己最美的样子出现在他的眼前，他则一直为她坚守不移!</p><p>　　他们是如此的般配，就连人们赠与他们的称呼也是一样神都洛阳和花王牡丹。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-12 01:14:07.670316', '1', '春风一阵阵的接连而来，好像在用她那双温和的，宛如母亲的手去轻轻扶拍着，试图叫醒那些沉睡在梦乡已久的姑娘们。她们像是感受到了大自然母亲的呼唤，一个个的接连着从哪梦乡中走出。她们先是活动了一下松散的双手，让它们先拥有第一层活力，以便能给自己披上绝美的绿衣。千古绝配神都与花王一点点的苏醒，让她们全身上下充......', '40', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('22', '岁月轻轻偶尔会多一些吧', '<div id=\"main_content\">\n<p>　　偶尔刺痛的心，偶尔长叹的人，一遍遍上演的偶尔，不知何时休，似曾看见了相识得自己，似曾听见了类的话，才会不由得唏嘘感慨，才会被偶尔深深触动，只因看到了曾经的自己，心才会隐隐的痛，暗暗的伤，有些许失落，也有一份执着，萦绕着我，激励着我。</p><p>　　是什么样的漂泊，让人居无定所，是什么样的自我，被自己迷惑，花花世界有激情澎湃，也有转头无奈，情深过后是不是分开，偶尔也有想念的人在脑海，可想念只是想念，错过的就是错过，偶尔心情很好，想写快乐却还是写了忧伤，其实人生就像那缺少诗意的生活，就像那少了宋词的完美，才是完美，有缺陷才衬托出了完美，有坎坷才衬托出了人生的辉煌，所以有时候缺点完美就是完美，不必太过强求，该活的潇洒的年纪就活的潇洒一点，该担起责任的时候就勇敢担当，不惧怕前方，不悔恨以后，只珍惜眼前，过好现在。</p><p>　　读不懂偶尔涌上心头的感觉，是喜是忧，解不了的话，是记住还是忘记，我不明白也看不清未来，我还在徘徊，生活还在不堪，人离梦还很远，说曾经的自己如何，其时现在与曾经依旧很累，走的越远越明白，别去幻想未来，怕到时候没有那么美，生活多了乏味少了乐趣，工作混了晨昏添了枯燥，失了本有的朝气。</p><p>　　跑掉的灵感让我想了许久，才能写出一句话，有些烦意的心想停下，却被内心深处唤了回来，告诉我你应该坚持，哪怕灵感也会离开，哪怕人也会疲惫，唯有一篇篇叠加才能离梦更近，很多时候也曾质疑过自己，多年的努力日夜的付出，真的不会白费吗?偶尔也很怕一无所获，以前也如同现在一样，为了灵感想了又想改了又改，写写停停中我仿佛看到了另一个自己，不去想一些不同方面的压力，只是静下心来去写没有说的话。</p><p>　　也请你偶尔有感的时候，用笔记下来，也请你用灵魂去感受文字的美，该写下来的就写下来，留给以后的自己，也留给爱阅读的朋友，苦短一生恐怕快乐会少一些吧!几时偶感恐怕现实会多一些吧!岁月轻轻偶尔会多一些吧!</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '偶尔刺痛的心，偶尔长叹的人，一遍遍上演的偶尔，不知何时休，似曾看见了相识得自己，似曾听见了类的话，才会不由得唏嘘感慨，才会被偶尔深深触动，只因看到了曾经的自己，心才会隐隐的痛，暗暗的伤，有些许失落，也有一份执着，萦绕着我，激励着我。是什么样的漂泊，让人居无定所，是什么样的自我，被自己迷惑，花花世界有......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('24', '爱若不可追，人言却可谓', '<div id=\"main_content\">\n<p>　　那人怎么又懂来了又走的滋味，所有期许无非成为岁月面前的尘埃，风一吹就散的假面，成了伤心人不敢奢求的美，任风尘滚滚过客匆匆，任岁月变迁繁华没落，唯留伤心人爱着伤心人。</p><p>　　想一些物是人非的人，做一些时过境迁的事?喝一杯甘美的酒成了回忆的苦涩，等一些忘记的人旧爱成了新欢。赌一局不愿输的梦现实成了不眠人的夜，看一变自己就好，看一遍自己就好。</p><p>　　以前不明白人言可畏，现在倒是深有体会，流言止于智者，何必议人长短，当去诋毁别人的时候，岂不知自己的嘴脸有多么恶心。你不是一个完美的人，就别议论别人的缺点，你没有自我认为的那么好，只是你那看似好心的嘴脸，掩盖了肮脏的内心，别在那里惺惺作态，弄得别人以为你很古怪，谁不知是好是坏，请别像疯子一样左右乱摆。</p><p>　　芸芸众生万千姿态，笑了凡尘却很无奈，川流不息的城市，彻夜不眠的夜，是可望不可即的繁华，让人陶醉让人担惊受怕，让人向往让人逃避，总有一些人熬了一些不该熬的夜，总有一些人说着连自己都讨厌的话，我想他早已迷失了真假，迷失了道德与素质的方向。</p><p>　　一个人总有他的好坏，我们也不比别人优秀多少，何必议人长短，何必揪着别人的缺点，你真的就那么完美吗?你有超脱一切的平淡吗?你应该没有吧!用一颗平常心去对待波澜壮阔的世界，用一颗爱心去温暖风餐露宿，守做人根本，处万事不惊，盼此生无憾。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '那人怎么又懂来了又走的滋味，所有期许无非成为岁月面前的尘埃，风一吹就散的假面，成了伤心人不敢奢求的美，任风尘滚滚过客匆匆，任岁月变迁繁华没落，唯留伤心人爱着伤心人。想一些物是人非的人，做一些时过境迁的事?喝一杯甘美的酒成了回忆的苦涩，等一些忘记的人旧爱成了新欢。赌一局不愿输的梦现实成了不眠人的夜，看......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('26', '种在眉弯的花香', '<div id=\"main_content\">\n<p>　　春天，就是让眉弯，种上缕缕花香。微笑，从心田溢出，变成嘴角的一缕明媚的暖阳。人间芳菲四月天，阳光暖暖，温婉着如水的心事。春风几许，伴随着鸟语花香，在光阴的路径上洒满馥郁的花香，心间盛满明媚，眼里就流淌出诗情画意。站在四月的季节，收集属于春天的妩媚，思念在枝头上萌芽，嫩绿的好似满满的欢喜。就让我，赤脚走过一汪春水，用芬芳的涟漪，洗涤我内心的茫然。春风，唤醒一颗沉睡的爱，在凡尘烟火里萌芽生长。</p><p>　　记忆如莲，在碧波里绽放，莲叶依依，鱼影闪烁，蝴蝶与枝头的花儿相戏，一切都是那么美好，琉璃心事，翠色的思念，俏然种植进眉间。四月，洒满阳光的味道，回眸滚滚红尘，心间植满草长莺飞的梦想。愿每一天都是春光满园，眉心洒满欢喜，心间植满希望。</p><p>　　细数时光，安暖春光里的芳心。我的心事，是满山开遍的桃花朵朵，是水中一朵粉色的荷。心间盛满美好，就会拥有花香弥漫的日子，馨香着，明媚岁月的安然。生命匆匆，需要一场春天，时光如梭，需要一段美好。陌上花开，岁月静好。望见四月里的春色，旖旎而来，逶迤成葱茏的锦瑟年华。</p><p>　　我愿守候心间的暖，期待一场缤纷的花雨。鸟儿婉转啁啾，彩蝶伴着繁花飞舞，时光在微风里细香 ，时光滴答着，落进眉眼。于是，欣喜着，握紧翠柳的笔，饱蘸苍翠的墨，熏香一段文字，时光里，一首浅浅的诗句，便落入眉弯。</p><p>　　将琉璃心事，拨动一弦清音。心间漾满着温柔，眼底盛满欣喜，望尽碧草茵茵，望见繁花似锦。心间盛满一汪清泉，洒满落英缤纷。桃花点点，樱花娇艳，芬芳的心湖，让爱芳香馥郁。春风拂过，清新芳菲的空气里，散落细碎的欢喜。姹紫嫣红的春色，葱茏明朗的春光，都彷如一坛酿造的桃花醉，流淌进心扉的佳酿，醉了纯美的爱情。</p><p>　　淡淡的爱着，淡淡的欢喜，幸福在心间摇曳。快乐是枝头上高歌的鸟鸣，传唱着美好的时光。眉弯里，开放着甜美的芬芳，爱于心间萌芽，开花，绽放成嘴角的那抹甜蜜的笑容，春风拂面的日子，就会聆听花开的声音。心间，种下一颗快乐的种子，于是，眉弯，就会盛满花香，用心去爱，珍惜生命中的每一次遇见，珍爱生活中的每一次真情。微风细细，穿过眉梢，携带着缕缕花香，飘飞进一汪心湖，微醺的春风，微澜清波缕缕，芳草依依，花香四溢，人生就如同春花，绽放醉美的馨怡。</p><p>　　春天，砚一池的花香，在翻飞的桃花雨间，捻一弦心曲，袅绕进爱的春风里，曼妙的旋律萦绕进心扉，拂绿了思绪，馨香了内心。眉弯里的花香，让眼眸脉脉温情。游弋在温婉的思念，心心念念的深情，都沉醉在温柔的春色里。期许，春天播种下的爱情，倾尽半世的深情，最终，都成为沁心的温暖，馨香四溢的花季。</p><p>　　春风轻拂，让思绪悠长。草木青青，微漾在缕缕花香里。万千思绪，挂在一弯眉梢上，时光轻盈，漫舞思念的芬芳。一汪如水的情愫，让岁月明媚，让时光深情。缠绵在春花的芳香里，暖润了芳菲的记忆。暖阳，为岁月，投下馨香的剪影，好似水波间，摇曳的柳枝，纷繁的桃花朵朵，都成为水中的倒影，为岁月留香，更显光阴摇曳多情，丰润多姿。</p><p>　　细碎的心思，把一段春光变得悠长，弥漫在时光里的倩影，是彩蝶翩然炫舞在粉嫩的樱花丛间，美好，在此刻扬起，心间，轻弹婉约的弦音。凝眉浅望，幽幽的清香里，春花正在述说着一段深情，爱在春天里谱写出美妙的诗句芳菲莺舞燕轻啼，半眸馨香柳青青。桃花纷繁迷人醉，爱入春城处处欣。于是，春光如水而来，醉了心扉。</p><p>　　种进眉弯的花香，让春色如烟，款款深情落入水云间，温柔的词章，书写成时光里的安恬，生命的脉络，印刻上春天的美好，于是，爱情，于春光里，风情万种而来，茂密成生命的苍翠，春花的旖旎。春色如烟，爱情如烟，青萝拂绿的思念，落一笺暗香浮动的温婉，眉弯，几许春光，几许安暖，就让我，随着花香，找寻到时光里的深情，丰盈着，在眸光里，开满馨香的爱情。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '春天，就是让眉弯，种上缕缕花香。微笑，从心田溢出，变成嘴角的一缕明媚的暖阳。人间芳菲四月天，阳光暖暖，温婉着如水的心事。春风几许，伴随着鸟语花香，在光阴的路径上洒满馥郁的花香，心间盛满明媚，眼里就流淌出诗情画意。站在四月的季节，收集属于春天的妩媚，思念在枝头上萌芽，嫩绿的好似满满的欢喜。就让我，赤脚......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('28', '烟花三月三月烟花', '<div id=\"main_content\">\n<p>　　快乐的时光总是过得很快，轻柔无声，恰似一条从指尖上悄然滑过的透明的纱巾，一秒一分，一天一年，都在舞动着妙曼的身姿。时光是美妙的，也是最公平的，从来不厚此薄彼，也不会因某个人而放慢脚步。总是带着自己的色彩，轻盈的从远方走来，轻抚一下尘世间的万物生灵，便又匆匆而去，还未来得及读懂今天诗句，转眼间太阳沉西，倦鸟已归巢。时光是雕刻人生画卷的一支笔，它将旅途中的奔波刻进了生命的里程碑，涂鸦着跌跌撞撞、起起伏伏的坎坷人生，勾绘了满脸的沧海桑田。夕阳染绯红，摇曳了满心的思念，立在小桥流水边，剪下一片火红的晚霞，用初心在上面写满深情的诗行，让思绪如行云流水，披星戴月飞跃万水千山，驶入你的梦乡。时光是美妙的，有的人觉得时间不够用，韶华易逝，而有人觉得日子过得很无聊，整天都在游戏人生，这主要取决于个人的心态吧。</p><p>我喜欢一个人静静地呆在自己的时光里，或闭目深思，梳理一下曾经的点点滴滴，不管是辛酸，还是甜蜜，都是自己的经历，其中的滋味也只有自己才能体会。或立于花前月下，将心与自然交融，看青山绿水，花海里素手折香，煮一壶静好的时光，听清泉叮咚，那藕荷色的爱恋，芬芳了岁月，也温柔了永存的执念。或端坐窗前，借皎洁的月光，研一方古老的砚台，字字如弦，句句若歌，温婉了一纸鹅黄的思念。岁月深处，心曲轻弹，让心香漫过心海，随暖风一起飘远。默默相守的日子里，梦依旧清晰如昨，回眸时光的角落里，无处不是心灵的桃花源。心若在，爱就在，爱在心里激荡似水流年。举杯邀明月，一种陶然自乐的微醉弥漫开来，心融融，意绵绵，一切的烦忧与郁结瞬间飘飞天外，只想沉醉在这份难得的安逸里，和心爱的风雨丽人一梦千年。</p><p>　　三月是个多情的时节，拂面不寒的杨柳风，吹来了连连新喜，拉开了阳春的帷幕，和煦的阳光普照大地，绿染江河两岸。池塘里欢快的青蛙唱响了春天的序曲，传来阵阵清脆的蛙声，似乎要唱出自己所有的情感，那歌声里充满了眷念和希望。细嫩的小草，偷偷探出头来，将大地染上一抹鲜绿，草尖戴露娇艳欲滴。枝头的桃花，悄悄含苞待放，给凡世间铺染春意，那颗颗丰盈的花骨朵，桃红乍露羞羞答答，宛如略饰粉黛的少女。最张扬的当属田野里的油菜花，早早的为神州大地渲染了一片金黄，将那抹迷人的黄涂抹成一幅春意盎然的水墨丹青，肆意怒放。还有那迎风飘扬的垂柳，纤细的柳枝舞弄着一树鹅黄，远远望去，就像是舞者的水袖，随风蹁跹妩媚动人。关不住的十里春色，一草一木都在奋力绽放自己的风姿，将一抹充满生命力的绿涂满山川大地。就连那最最不起眼的无名小花，也极尽所能的恣意怒放，姹紫嫣红，将一条条乡间小道点缀得春色无边，青草伊伊花儿招展绚丽迷人。又逢一年春来到，仔细想来，岁月悠悠，时光悠长，那些光阴的故事并未走远，一切还都在身边。云卷云舒里有自己的喜怒哀乐，冬去春来中有自己的青春年华，日出月落里有自己期盼的目光，斗转星移中有自己无悔的爱恋。</p><p>时光静流，岁月沉香，三月满怀深情地微笑着向尘世间走来，柳暗花明又一春。此时的雨也变得轻柔起来，春雨细无声随风潜入夜了，细雨蒙蒙缠缠绵绵，似情丝亦如烟，梨花带雨诗话滚滚红尘。虽说毛毛细雨使烟花三月增添了几分阴冷，但却滋润了萌动的生命，带走了花瓣上的尘埃，让春色更加绚丽多彩。诚然，人们还是比较喜欢阳光明媚的日子，风和日丽让人心旷神怡，再轻柔的雨久下不止，也会使心情感到压抑了。风霜雨雪乃是自然现象，非人力所能为也，我们既然生活在大自然里，就应该学会适应生存，学会欣赏自然。人生就是一步一步的向前走，一点一点的积累，所有的事物，都要有一个过程，所有的经历，都是一种懂得，所有的过往，都是岁月的一种恩赐。无论是风和日丽，还是雷电交加，都应该坦然面对，时光的长河里，不会一直都是风平浪静。烟花三月里，不管是艳阳高照，还是细雨菲菲，都是生命勃发的时节，到处都是绿意盎然。在这无垠的绿意里，总喜欢于暖阳中沐浴阳光，登青山之巅，饱揽春韵春色，将心里的春语春念迎风飞扬，让风捎信邀牵念心头的风雨丽人，共赏莺歌燕舞。于春雨里为影子爱人撑起一把红色的油纸伞，立小桥之上，看一河春水向东流，期盼着与你千年一梦共同舟，一起迎接春雨洗过的太阳。</p><p>　　烟花三月，三月烟花，写不完的花事一场接着一场，总有一处风景，渲染了欢喜，那魂牵梦绕的遇见，宛如一曲清音，在心与心的相惜中流淌，葱茏了一季花事，写意了一季明媚。春天是属于花朵的季节，与山城相逢是缘，与花朵相遇是美好。生命中注定会有那么一个人，千山万水与你相遇，和你一起体会春风拂面的温柔，将爱放在与鲜花和阳光同在的地方，深爱如同开在灵魂深处的花朵，以最绚丽的色彩，写意生命中最美的风景。春天也是属于相思的季节，每一缕和煦的阳光，都是个暖暖的拥抱，每一朵鲜艳的花朵，都似你雅致的容颜，每一阵轻柔的风儿，都能让你那靓丽的秀发在眼前飘扬，任发丝缠绕双眸。是三月的烟花见证了我们的一世情缘，相遇在十里春风里，相知在如烟的柳黄中，相爱在姹紫嫣红的花儿边。若生命可以像四季一样轮回，下辈子我还要与你相知相爱，一份情早已刻在骨子里，再美丽的风景，如果没有了你，也会黯然失色。花开只为等你，深情只为懂得，人至中年才渐渐明白，当心里的那份吸引演变成爱恋的时候，原来你一直都在我的生命里。</p><p>春风解花语，你却解我的留白，我不是春的使者，却是春的守护者，爱的信仰者。我终于相信，美好的情缘就是一场花开，即便凋谢成泥，也是一捧更护花的春泥，爱的花香依然如故。天地光阴，薄凉红尘，唯深情可依托，唯挚爱可永存。或许，在别人眼里，我恰似一粒不起眼的沙，风过无痕，因为我总是那样目不斜视，陶然沉醉在自己丰富的想象里，花开千里，唯你最美丽。越成长越懂得内敛自持，认真生活，认真爱一个人，不负初心，才不枉来这世上走一趟，才不愧对自己默许的山盟海誓。三月烟花，为眷念涂染了浓烈的春色，我知道，这份眷恋终究离不开红尘里的一念真情和一份初见。就像桃李遇见春风，柳色遇见花容，蝴蝶遇见花朵，花朵遇见春天，花香赋予了思念。凡世间每个人的心中，都有一份无法释怀的情结，即便是时过境迁，却总是无法忘怀。曾经因为三生三世前的一次回眸，今生今世，我便在风雨中寻找，寻找那棵开满紫花的树，寻找树下那个莞尔一笑，寻找紫花旁那个亭亭玉立的身影。精诚所至金石为开，蓦然回首时，你却在烟花阑珊处，从此，寻觅的双眸便有了归依。我要邀一生光阴明媚入诗，卸下无谓的浮躁，带上欣喜的微笑，好好地再爱一次时光，爱一次自己的风雨丽人，让岁月留下的印记随风而行。</p><p>　　一年之计在于春，暖暖的春风已经叩响了季节的窗棂，烟花三月，是乍暖还寒，也是春意悠然。沉睡了一个冬季的杨柳，正在欣欣然张开了绿枝，积压了一个冬季的繁花，正在春的召唤下蓄势待发。三月如歌，万物齐吟，三月如画，流光溢彩。南风暖窗，草绿花开，熙熙攘攘，皆为春来。不知何时我喜欢上了临窗端坐，听一曲深情的红尘情歌，伴随着微风的轻叩，打开窗，迎面吹来了春天的味道。于是，我在匆忙间告别了二月的喧闹，转身便投进了三月的怀抱。春韵春色使得那些可爱的文字也芳香四溢，每当她们含情脉脉地出现在我面前，我都会与之深情以对、温柔相拥，然后便在春那温软的怀抱里，沉醉不愿醒来。春来了，你是鲜花，我不是诗人，但是我的素笺上有你灵动的音容笑貌，遥望柳绿花红，是唐诗宋韵里的留白，我只想沿着被南风吹绿的阡陌，写一行桃花诗，落一笺杨柳清风，等风起，等雨落，等你来。和煦的风里，有相守的暖，有相思的泪，也有相聚的喜。一次感动一生的初见，惊醒了姹紫嫣红，芬芳了有你的岁月。我在微醺的时光里沉醉，不知归，想必你已读懂那眸里的心语，只为你，只为你。</p><p>真的很想，很想让你在我的诗仄韵律中幽居，提笔，你与文字一起蹁跹，花红为仄，柳绿做韵。你只需以轻轻又温婉的深情，我便安静守候，那一个不需轮回，不诺来生的约。春天里的每处跃动，都在彰显着无穷的生命力，那些破土而出的绿芽，那些含苞待放的花儿，那些潺潺流动的泉水，因春的到来而活力四射。窗台上那片被春韵染绿的苔藓，沐浴朦胧的月光，静静地舒展着毛茸茸的绿意。它似乎早已明白我的心绪，在这花好月圆的春夜里，将我的思念和自己的新绿交融在一起，任思念在每一丝绿色里流动。冬去春来，在我流年岁月的繁华里，又悄然多了一抹梨花的洁白，我深深的知道，遥远的苍穹你一定化作了我心中最为明亮的一颗。我站在灯火阑珊的春夜里，任凭思绪化作一缕无尽的思念，星月缠缠绵绵，如一湾眸子的清澈，让我游弋在你那永远也无法干涸的清泓里。朦胧的月光缓缓而落，任由我的思绪划过千山万水，三月的夜里依然薄凉，可我的情怀早已凝聚在了那一抹梨花的洁白，凝聚了一份爱的力量。杨柳千寻色，桃花一苑香，山城里的桃花开了，繁花朵朵，开在春天里，开在有你的心海里，形成了桃红柳绿，柳暗花明的春日胜景。不知为何，年龄越长，越渴望一种安稳，恋上了日子里淡淡的烟火味道，向往一种低调从容的生活，不畏浮云遮望眼，只想着平淡中将你守候一生，相守一生唇红齿白的时光。</p><p>　　能在有生之年遇见你是我的缘，自从那年三月，烟花陌上相逢，你就成了我心中的歌，成了我笔尖的诗行，成了我梦中最深的抵达。如果人生是一趟旅程，而能遇上你，便成了我此趟旅程的终点站。隔着季节的锦卷定格在春意阑珊的枝头，而我的欢喜就这样落在了眉间，是属于光阴的一枚落款，是一段光阴的故事。喜欢一种懂得，没有太多的牵绊，只是简简单单，干干净净的喜欢和欣赏，如青花瓷的美丽，隔山隔水依然生动，如春天明媚的阳光，润泽了无悔的生命。生命中总有一种情愫，会在一瞬间直抵心灵，有种懂得，不言不语，唯在遇见的刹那，喜悦如莲，张扬也好，低眉也罢，都开在心上。等值得等待的人，爱值得相守的人，这是春暖与花开的深情，亦是不语也相知的安暖与相伴。</p><p>无论春天有多美好，总会把时光的舞台交给下个季节，带着姹紫嫣红与尘世间渐行渐远。那些繁花因春来而开，又因春去而谢，注定花儿是深爱着春天的，无论春来的多么深情，走的多么匆匆，花儿都如痴如醉的守候，不变不移的眷恋。 花开无声，花落有情，因为花儿懂得春的无奈，亦懂春的不易。这世上最温柔的守护，莫过于一份无言也懂的默契，如此，春去春来，花开花谢，便总是相随相伴，不离不弃，无怨无悔。这是一种深情，也是一种情怀，就像相爱的两个人，总有一个用情更深，包容更多。不论怎样，我都还是那么喜欢你，就像期盼洒落天涯，不远万里，就像鱼儿游于荷边安逸得呼吸，痴极嗔极。</p><p>　　烟花三月，鸳鸯双栖，蝶恋花，细雨缠绵，念如丝。在这样如诗如画的时节里，只想着心念如花，静静地守护着一缕刻骨铭心的花香，采一段七彩祥云，等风，等雨，等你来，携手共渡这颠沛流离的红尘，相伴一生唇红齿白的时光。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '快乐的时光总是过得很快，轻柔无声，恰似一条从指尖上悄然滑过的透明的纱巾，一秒一分，一天一年，都在舞动着妙曼的身姿。时光是美妙的，也是最公平的，从来不厚此薄彼，也不会因某个人而放慢脚步。总是带着自己的色彩，轻盈的从远方走来，轻抚一下尘世间的万物生灵，便又匆匆而去，还未来得及读懂今天诗句，转眼间太阳沉西......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('30', '当你老了', '<div id=\"main_content\">\n<p>　　当你老了，是的，我们都老了，白霜飘在了我们的额顶。</p><p>　　我们要做一些什么?</p><p>　　韶光未尽，眼前夕阳尚好，很多人认为，人当此时，就当对自己的生命，进行一次彻底的解放，敞开生命和灵魂，能唱的，放开地去唱，能跳的，放开地去跳，跑得动的，若钱财也给力，天涯海角地去转一转，总之，就是要放纵一下自己的余生。最近，看到网上流传的一些<a href=\"//mingyan.chazidian.com/geyan/\" target=\"_blank\">格言</a>警句，大多是此意。</p><p>　　放开，如鲜花的开绽，如焰火的迸发，是人生不可或缺的一面，人生于此若有所缺失，不妨赶紧补上。</p><p>　　但我在这里，提倡一下老年人应该具有的另一方面__收敛!</p><p>　　收敛，就是安静下来，把自己放在阳光下晾一晾。人生缺少的不是活跃，绽放，放纵，而是收敛，安静。安静，是一种美妙的人生境界，其实，尤是人生的一种财富。</p><p>　　人到了老年，犹如时光到了秋季。五十岁的时候，是初秋，六十岁的时候，是到了晚秋。秋天最重要的是什么?秋天最重要的是晾晒。如果你是一粒种子，晾一晾，你就会更加的成熟，如果你是一片叶子，晾一晾，你就不会很快地腐烂，更久地保持你的金黄色。对我们的生命 ，对我们的人生进行晾晒，就会产生一种沉淀。</p><p>　　沉淀后的人生，如若一潭秋水，清泠于内，澄澈于外，碧波涟涟。此时，你就会聚明月清风于一怀之中。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '当你老了，是的，我们都老了，白霜飘在了我们的额顶。我们要做一些什么?韶光未尽，眼前夕阳尚好，很多人认为，人当此时，就当对自己的生命，进行一次彻底的解放，敞开生命和灵魂，能唱的，放开地去唱，能跳的，放开地去跳，跑得动的，若钱财也给力，天涯海角地去转一转，总之，就是要放纵一下自己的余生。最近，看到网上流......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('32', '三月的春', '<div id=\"main_content\">\n<p>　　清明将至，然而并没有所谓的雨纷纷。</p><p>　　二三十度的艳阳天儿丝毫没有透露出一丁点春天的气息，夏日的燥热仿佛早已捷足先登。放眼望去，十里长廊，好一片腾腾热浪。</p><p>　　大清早儿的鸟雀儿调皮的叽叽喳喳将人从睡梦中拉将起来。揉揉惺忪的睡眼，伸伸慵懒的四肢，余梦尚未完结便迷迷糊糊地挪步到窗前。打开窗儿，朝气的温热不由分说的便吻了上来。吸一口神清气爽，吸两口满腹清香。</p><p>　　喜欢三月的风，但又迷恋六月的雨;钟情于九月的霜，而又青睐于十二月的雪。人生，仿佛亦如此罢，总会在不同的时候却喜欢着相同的美好。三月，风和日丽，艳阳高照。天朗气清，惠风和畅。万事万物昂扬一派勃勃生机。我给三月取了一个好听的名字灵韵。灵，取天地之灵气，万物复苏。韵，万事万物皆呈美态，甚有韵味儿。</p><p>　　看自然，万里长卷，一派繁荣。阳光下的花儿，红的、黄的、绿的、紫的......欣欣姿态，煞是喜人。那风中的柳枝，飘飘然若少女的裙。摇曳着婀娜身段，丝丝缕缕，妩媚动人。又恍然如娇羞的姑娘，掩着羞红的脸，挡着性感的唇。哦?再看那路边儿、湖畔、小溪旁那团团簇簇的小草芽儿，默不作声，吭哧吭哧地一个劲儿往上窜。不张扬，不显摆，低调的将自己融为这盛世画卷里的一抹新绿。对呀，这是春天，这是大自然的春天。</p><p>　　如果将这大地描摹成一幅秀美的风景画，那蓝天白云，便是这画的印拓。游遍山河，览尽万千，不觉便喟叹于大自然的神奇。啊!此情此景，我想吟诗一首朝阳初露闪金光，春风拂柳着新妆。且听枝头鸟声脆，梨花开罢桃花香。哈哈，真是醉心于这美妙的春天里。</p><p>　　清明将至，关注了一下天气预报，依然没有所谓的雨纷纷。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '清明将至，然而并没有所谓的雨纷纷。二三十度的艳阳天儿丝毫没有透露出一丁点春天的气息，夏日的燥热仿佛早已捷足先登。放眼望去，十里长廊，好一片腾腾热浪。大清早儿的鸟雀儿调皮的叽叽喳喳将人从睡梦中拉将起来。揉揉惺忪的睡眼，伸伸慵懒的四肢，余梦尚未完结便迷迷糊糊地挪步到窗前。打开窗儿，朝气的温热不由分说的便......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('34', '春天是个诗意的季节', '<div id=\"main_content\">\n<p>　　在一阵阵春风的吹拂下，大西北萧条而单调的土地上又焕发出了一片生机盎然的活力。</p><p>　　春姑娘用纤细修长的手指把每一片土地轻轻唤醒。枯草中的嫩芽儿晃了晃脑袋，用朦胧的双眼打量着这个诗意的季节;桃李像怀胎十月的母亲，精心孕育着每一个蓓蕾;小河哗啦啦地唱着歌谣，把内心的感情尽情地抒发。</p><p>　　老话说的好，一场春雨一场暖，细蒙蒙的春雨过后，大地上的植物争先恐后地爬出了大地的被窝，草长莺飞，桃红柳绿，漫山望去，一片诗的海洋。那一朵朵花儿，有红的的，黄的，白的，粉的，一眼望去像一条条美丽的丝带相互交织着。行走在季节深处，看着争相绽放的花朵，闻着缕缕带着香味的空气，有一种赏心悦目的感觉。</p><p>　　春天是一个诗意的季节，春天是文人墨客们抒发情怀的季节，干渴的笔尖等待着翰墨的浇灌，洁白的稿纸等待着文人的播种。于是，积压在内心的诗句一串串，一朵朵，在每一根血管里来来回回地流淌;最后它们如一个个小精灵，走向了田野，走向了山川，走向了江河，走向了天空，走进了书本，走进了人们的心中。梨花带雨春满面，燕过呢喃歌细语。这个季节以她独有的魅力，夺得了四季的桂冠。</p><p>　　一车车农家肥冒着热气被拉到了田间地头，一吨吨经济肥走出了工厂。他们是大地最精美的食物。沉睡了一个冬天的土地，敞开饥饿的胃口，尽情地等待着农人的喂养。</p><p>　　春天是一个充满激情的季节，土地醒了，万物一片欣欣向荣的景象。工人们尽情地生产，一滴滴汗水把小康实现;农民伯伯挥动着有力的农具，在软绵绵的土地上播下希望，等待着幸福的绽放。看，新世纪的旗帜在蓝天上招展;听，奋斗的歌谣已响起;闻，馥郁的花香已传来;让我们伴着这有节奏，有旋律，有色彩，有希望的季节尽情地奋斗，尽情地奔跑吧。</p><p>　　一抹青色，一抹情动。浓浓的诗意，春风八百里而过，大江南北，恰似人间天堂。每一滴雨都能成诗，每一朵花都传着情，每一声鸟鸣都是一首曲。</p><p>　　这是一个美妙的季节，这是一个缤纷的季节，这是一个生机盎然的季节，这更是一个诗意的季节。三月笔墨流转，已近末尾，四月诗画连绵，即将起航。让我们怀着期待的眼眸，扬起手中的风帆，尽情地与春天来一场浪漫的约会。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-10 07:53:38.900824', '1', '在一阵阵春风的吹拂下，大西北萧条而单调的土地上又焕发出了一片生机盎然的活力。春姑娘用纤细修长的手指把每一片土地轻轻唤醒。枯草中的嫩芽儿晃了晃脑袋，用朦胧的双眼打量着这个诗意的季节;桃李像怀胎十月的母亲，精心孕育着每一个蓓蕾;小河哗啦啦地唱着歌谣，把内心的感情尽情地抒发。老话说的好，一场春雨一场暖，细......', '2', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('36', '几年一梦', '<div id=\"main_content\">\n<p>　　旧梦扔在心中燃烧，回忆还在心头徘徊，茫然的心却停在现在，说何惧未来，却看不清眼前，叹不完现实，有很多事不知是悔恨还是怀念，有些许人不知是逃避还是留恋，说不清的感觉，道不完的情绪，续写着人世沧桑离别。</p><p>　　一时的内心澎湃，想写却不知落笔诉何意，沉下心来去想，却不知全是酸心苦楚，夜深人轻叹，不扰梦来，不扰他人睡意深，只默默的想，默默的构思，怎样才能写完心中情，字间句来几更改，段落清晰怎安排，恐要多少时，方能表大概，只为一篇有味文，苦了多少写书人。</p><p>　　语来未尽，缘未休，遇人几求，若能此处人情好，便也留下几多情，不算谋来，只助人，不凉薄来，不忘恩，记住帮你的人，谢谢还在陪伴你的人，不论人生如何不堪，有他们就好，不论生活如何苦累，有诗就美，我们有很多要做的事，有太长要走的路，所以别轻易否认自己，别轻易看低自己，万事皆可成，多谈心交友，认识别人也去认识自己，教导别人也去吸取经验，没谁是谁的老师，本是共同学习，共同吸取，微薄人情，该看淡就看淡，难猜的人心，想不明就不去想，自己的故事自己慢慢写，路上的艰辛自己慢慢品。</p><p>　　不惧风大雨又狂，只为心中怀梦想，管他以前何妨，现实有多伤，该忘的就忘，该淡的就淡，人生还长，莫要困在原地失了方向，用酒浇惆怅，恨意渐多人渐消，苦了穷途客，伤了自己身，欲欲何为，唯有不轻伤，不自伤，不连伤，方能有可为，有所收获。</p><p>　　不论旧人旧梦如何变，唯有初心要切记，不论几年如何不堪，唯有不失品德，不失初衷，我们抛不开工作，也抛不开自己本该扛起的责任，我们丢不完烦恼，也逃不开压抑，百味百态，茫茫人海，谁人不是有太多说不出的无奈，写不完的内心交杂。</p><p>　　添几分不安，刹那间失落，绕几回愁绪，叹几声悔意，不时恐慌的心，偶时胆怯的人，似乎难避免，也曾想跳出弱点的，可还是跳了回来，也曾想努力改变，可似乎没有多大变化，心里的波动回击着自己，难表的话暗压着自己，恍惚是煎熬，也恍惚是甘甜，左右恍似曾，一生喜忧唯有自己懂，爱恨交缠唯有自己知，何必执念他人心，看过的没看过的，写过的没写过的，我们可以慢慢去看，静静去想。</p><p>　　日月论回寒暑交替，亦心无悔意，只是想写下人生留给以后看，只是想拥有一本属于自己的书，送给我的朋友，亲人，也是我的一个梦想一份执着，所以我还在努力，我还在学习，虽然有很多时候我也感觉很累，也想过要不要放弃，不过后来我还是坚持了下来，并对自己说你不能放弃也不会放弃，管他写作路上有多少汗水，管他是不是被生活掩盖，调整好心情望梦扔在，写作扔在，我相信会有文成书的一天，我也很期待那一天的到来。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '旧梦扔在心中燃烧，回忆还在心头徘徊，茫然的心却停在现在，说何惧未来，却看不清眼前，叹不完现实，有很多事不知是悔恨还是怀念，有些许人不知是逃避还是留恋，说不清的感觉，道不完的情绪，续写着人世沧桑离别。一时的内心澎湃，想写却不知落笔诉何意，沉下心来去想，却不知全是酸心苦楚，夜深人轻叹，不扰梦来，不扰他人......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('38', '城南花已开，君自城北来', '<div id=\"main_content\">\n<p>　　灯下执笔，染三分春风辞藻;案前凝眸，结三分倾情才思;梦中呓语，许心仪景图一裾。我自年少，不负韶华迢迢。</p><p>　　静夜思量，笔追过往。独守阑珊月光，一缕晚风微凉，初透心上。浮生梦断弦，一步踏尽一树白，一桥烟雨一伞开。何人与我共剪烛，低吟浅唱，销良夜，尽壶觞。而今城南花已开，君当无恙，城北来。</p><p>　　在漫漫的人生旅途之中，我们都是孤独的修行者，往往用一个灵魂去温暖另一个受伤的灵魂，这就是人性，这就是善，这就是爱。</p><p>　　城南花已开是网易云音乐中的一个普通的用户名，也是一位正在与骨癌抗争的受难者。在生命的弥留之际，他希望音乐人三亩地用他的用户名为他写一首曲子，也就是我正在听的这首曲子。在这首曲子的评论中，我看到的是一个平凡的人在遭受病苦时的积极乐观，在生命弥留之际满怀期许的度过了一天又一天。当旋律在脑海里慢慢的徘徊，指尖缓缓的敲打出一行又一行的文字，我的思绪却短暂的在此停留。</p><p>　　有些人活在记忆里，刻骨铭心;有些人在身边，却很遥远。这个世界很大，即使擦肩而过的陌生人，相遇时也飘着淡淡的缘。我们用语言和文字进行彼此之间生活的联系，我们用承诺和关爱维持彼此之间灵魂的温度，所以城南的花会一直开下去，城南的人会一直等下去，城北的人也终究会安然无恙的赶赴这一场与花的约定。</p><p>　　也曾徙旅千山，只为赶赴一场与雪的约定;也曾飞宣百卷，只为不负一人曾许的诺言。经年未忘，流年未央。那些起起伏伏的人生经历告诉我看得懂的，都不是命运;忘得了的，都不是遗憾;猜得透的，都不是人生;躲得开的，都不是缘分。</p><p>　　我们可以撑一柄油纸伞，穿过多情的雨季，寻觅江南繁华旧梦。亦不会忘记曾经雨中奔跑，再美的风景也无法顾及，一个人在闹市里辗转流徙。我们可以沏一盏清茶，点检琉璃的过往，醉于从前的欢笑。亦不会忘记曾经囿于琐事斑杂，一人幸苦打拼，月光下怀着坚定的目光自言自语。</p><p>　　人生如渡，我如萍，起起伏伏，聚散合离。如果真的有一天，某个回不来的人消失了，离不开的人离开了，思念的人不再联系了，也没有关系。我们还是要学会好好爱自己。得到的不一定长久，失去的不一定不再拥有。离别本是人生的常态，我们不停辗转在一个又一个渡口，要么等人归来，要么悄然离去。</p><p>　　而今日子安稳，无忧明朝雨落倾城几度，不伤昨夜冰绡中酒几分。灯下执笔，染三分春风辞藻;案前凝眸，结三分倾情才思;梦中呓语，许心仪景图一裾。我自年少，不负韶华迢迢。</p><p>　　城南的花已经开了，或许那一同开的还有我们每个人对生活的美好期望吧。尽管我们囿于琐事斑杂，我们依然愿意于某个特定的时间里与友人相约一起共赏这一场花见。三月将尽春未褪，城南花开多葳蕤。还待君自城北来，共鉴落花逐流水。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-10 07:32:45.271046', '1', '灯下执笔，染三分春风辞藻;案前凝眸，结三分倾情才思;梦中呓语，许心仪景图一裾。我自年少，不负韶华迢迢。静夜思量，笔追过往。独守阑珊月光，一缕晚风微凉，初透心上。浮生梦断弦，一步踏尽一树白，一桥烟雨一伞开。何人与我共剪烛，低吟浅唱，销良夜，尽壶觞。而今城南花已开，君当无恙，城北来。在漫漫的人生旅途之中......', '1', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('40', '四月，你好', '<div id=\"main_content\">\n<p>　　四月，你好</p><p>　　翻开日历，崭新的一月，崭新的一天映入眼帘。窗外阳光明媚，春光无限。不禁想起南宋朱文公的几句诗。胜日寻芳泗水滨，无边光景一时新。等闲识得东风面，万紫千红总是春。</p><p>　　张开怀抱，打开尘封的心扉。向着这个四月的新的起点说一声四月你好。</p><p>　　走过了过了烟花三月，四月，就这样在悄无声息中涉水而来。春风漾漾，碧柳成荫，山青水碧，天高云淡。舒心的景，络绎不绝地缓缓赶来，落在四月的枝头，摇曳着醉人的芬芳。</p><p>　　夜莺婉转地曲调悠扬动听，新燕啄着春泥，辛勤地搭建幸福的港湾。三月嫩黄的新芽，在四月天里尽情地招展。</p><p>　　你好，四月。树树梨花，桃花，杏花等等，排着队地赶来赴着人间最美的会。穿梭于一片片花海中，每根神经都被这醉人的芬芳所唤醒。天地之间的豁然开朗，让人们的心情也跟着明快起来。</p><p>　　四月的小雨，淅淅沥沥，像一位曼妙的女子。走在雨中有种特别的韵味。看到雨总会想起江南的烟雨亭台，想起那撑油纸伞结着愁怨的姑娘。看到干渴的大地在雨的滋润下越显清秀的模样。心头不觉便吟起了古人的诗句。好雨知时节，当春乃发生。随风潜入夜，润物细无声。春天的雨是温柔浪漫的，是珍贵的。不然怎会有春雨贵如油的说法。</p><p>　　最美人间四月天，四月，美在花开，也美在花落。花开如海，锦团簇拥;花落如雪，纷纷扰扰。这个季节可以大起大落，也可以大喜大悲。</p><p>　　清晨，迎着朝阳的影子，在晨跑中把一缕缕新鲜的空气，尽情地吸收;黄昏中，伴着落日的余晖，去小河边散散步，体验一下河畔的金柳是否是夕阳中的新娘?</p><p>　　四月的风，恣意地吹拂亲吻着我们的脸，轻轻摇曳着我们的心;四月的云，躲在星空的幕后，把蔚蓝的天空隆重推出。绿油油的庄稼地，笑的春光灿烂。微风过处，迷了眉梢，甜了心窝。</p><p>　　日历翻开了崭新的一天，春意到了最浓的气候。让我们打点好心头的迷茫。向着这有生命力，有色彩，有光泽的一天努力奋斗吧。让我们在人生的路上，且行且珍惜，坦然以待，去感受时光的惊艳，去感悟生命的生长。</p><p>　　在清晨，在午后，在黄昏，向着春光说一句四月，你好!阳光明媚，春暖花开，莫负四月好时光。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '四月，你好翻开日历，崭新的一月，崭新的一天映入眼帘。窗外阳光明媚，春光无限。不禁想起南宋朱文公的几句诗。胜日寻芳泗水滨，无边光景一时新。等闲识得东风面，万紫千红总是春。张开怀抱，打开尘封的心扉。向着这个四月的新的起点说一声四月你好。走过了过了烟花三月，四月，就这样在悄无声息中涉水而来。春风漾漾，碧柳......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('42', '你是我的天使', '<div id=\"main_content\">\n<p>　　一双眼睛明若星辰，闪烁淡淡神光。脸上一贯严肃表情，令我总是不寒而栗。虽然我们已经分离了差不多两年，关于你的事情却总总闪现在我脑海。</p><p>　　思绪飘回到很久很久以前......</p><p>　　那时，校园的生活总是平淡的像一湖死水，波澜不惊，平淡的连一点涟漪也没有。我每天生活过的是那么有规律，有规律到连我都能把我每天该做的事情倒背如流。每一天的生活仿佛都是可以预测的，每天的生活仿佛都是一模一样的，真的是很无聊很无聊。有时，看着那些无精打采的同学们，我觉得我有可能一辈子都这么过下去。</p><p>　　可是，事情却在这时候有了转机。那是不平凡的一天，那天正是又一年的开学时，我百无聊赖的趴在桌子上，拿着笔在本子上胡乱涂鸦。这时，一个黑黑瘦瘦的人走了进来，他带着一副金丝框眼镜，脸上写满了严肃，然后他笔直的走到了讲台，砰一声拍在了桌子上，大吼道你们都给老子起来!瞬间，班上的人好像都打了鸡血似的迅速抬起了头，惊疑不定地望着讲台上那个那刻是那么高大的身影。那个人似乎很满意我们现在的状态，点了点头又接着说道大家好，我叫范谋军，从现在起，我就是大家的班主任了。说完，还友好地笑了笑。范谋军?我在心里默默想着，呀，不会就是那个传说中号称全校第一威猛，人见人怕的灭绝师太吧。</p><p>　　自从老范接管了我们班后，我就没有一天日子是好过的。</p><p>　　记得开学不久，老范就展现出了他那强硬的一面。那天我们跑操，大家都在整齐有序地跑着步，而我为了偷懒，脚像生锈的齿轮似的，缓缓地跑着，还时不时伴随着各种职业的偷懒行为。跑操过后，我正打算向教学楼走去，这时，一堵黑黑的墙拦住了我的去路，定睛一看，正是老范。范老师，你这是干什么?我不解问道。去，多跑两圈操场。老范用坚定的语气缓缓说道。凭什么!别以为你刚刚干的事情没有人知道，赶紧的，再去多跑两圈，不然就别回来了。他淡淡地说着，一边向教室走去了，只留下孤零零的我站在这个操场上。范谋军，你这个混蛋!我气急败坏又无可奈何，只得又去多跑了两圈。从此，我再也不敢偷懒了。</p><p>　　第一次段考后，我的成绩还是和平常一样，不突出，也不落后。接过成绩单，我正准备收进去。老范轻轻走到了我的身旁，夹住了那一张印着一堆数据的纸片，拍了拍我的肩膀，说道跟我出来一下。我随着他来到办公室，他拿着我的成绩单，对我说道你本来可以考得更好的，可是你看......我感觉这时的他就像一个啰嗦老太婆，絮絮叨叨的，烦得要死，于是便连连点头，蒙混过去就算了。从办公室出来后，我同往常一样，照样在食堂里拉拉扯扯，谈天说地，那时的我，犹如一个不良少年。可是，老范这时来检查了，等我们发觉时，他早已站在食堂门口，这就尴尬了，于是乎我们一起给抓了。老范那天什么也没说，只是用眼睛看着我们，不知道为什么，我感觉，那天他的眼睛里，除了愤怒，还有隐隐的悲哀，他看了我们半响，知了口气，自嘲似地摇了摇头，就走开了。看着他那萧条的身影，我心突然刺痛了。我先上去了，你们玩吧。我说罢，便向楼上走去。记得，那是我最后一次在学校里肆意狂欢。</p><p>　　我最记得的是老范发火的那次经历。那一天，我借到了一本新的小说，对于这种东西一向痴迷的我，自然是趁着晚自习的时间偷偷看了起来，可是不巧，给老范抓了。他坐在讲台上，朝我说道你在看什么，给我拿上来!霎时间，全班头同学齐刷刷回过头来。我在众目睽睽之下，只好硬着头皮，捂住羞红的脸，书给交了上去。可没想到，老板一看到那本小说，拿到手上，二话不说就开撕了，他不是那种一整本地撕，而是整齐的，把它撕成一条条，令我竟然有种感觉，感觉他当时是在撕我，而不是书。老范把那书撕毁后，随手往窗外一丢，然后用手指着我，朝我大吼这他妈都快要中考了，你还给老子看这种垃圾东西。说完手又一拍桌子，你今晚给老子留下来。我被骂得大气不敢喘一声，低着头，唯唯喏喏。后来老范留我下来后讲的话我早已淡忘，但有一句我始终记得，那时，他走到窗前，既像在对我说，又像在自言自语你记住，如果想成功，你就不能贪图安乐，不能沉迷于一个幻想的世界，你要努力，活在这个真实的世界里。听完这句话后，我心头一震。</p><p>　　转眼间，我就毕业了。记得毕业那天，他仍然坐在讲台，没有罗嗦，匆匆讲了几句，便放学了。没有什么所谓的毕业典礼，没有太多的哀愁别离。我和他也并没有过多的言语，直到临走时我才向他说了一句范老师，你觉得我能被好的初中选上吗?废话，我的学生，个个都是好样的!说着，他脸上泛起了在我记忆中从来没有过的笑容。</p><p>　　现在，我多么想再有个人，那样逼着我去跑步，逼着我去学习，逼着我去抵制自己的欲望，再有人像他那样关心我，保护我啊。可惜，那样的日子再也回不来了，那个人也只能留在我的记忆里，再也不能出来。</p><p>　　老范，我想你了。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '一双眼睛明若星辰，闪烁淡淡神光。脸上一贯严肃表情，令我总是不寒而栗。虽然我们已经分离了差不多两年，关于你的事情却总总闪现在我脑海。思绪飘回到很久很久以前......那时，校园的生活总是平淡的像一湖死水，波澜不惊，平淡的连一点涟漪也没有。我每天生活过的是那么有规律，有规律到连我都能把我每天该做的事情倒......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('44', '不负光阴，将生活过成诗', '<div id=\"main_content\">\n<p>　　风中谁寄花笺来，是花、是鸟、是清风、还是故人你?料峭春寒，窗外细雨绵绵，点滴间回荡曾时的心声。风景年年依旧，只是再也无法寻回最初与我赏花之人。尘烟如梦染，尽落三千温情脉脉。只叹梦随风，寻去处，千百度，却不能在灯火阑珊处与你的目光温柔相对，只能在千百度回首时，发现自己独自徘徊的身影。</p><p>　　或许，流年早已散作风尘，随风消散而去，不复存在。亦或是，化作满地的落红，在风中，弥漫着淡淡馥郁的芳香。也许只是那一瞬，那一瞬间的蹙眉思考，那一瞬间的轻声哭泣，或是那一瞬间嘴角不经意间地轻轻扬起，在那瞬间，突然地回忆起某段经年往事，回忆起昔日的自己。那点滴的温情与感动，都会在瞬间涌上心头，但你我又都深知，回不去的是曾经，继续的是生活。</p><p>　　红尘陌上，你我都是匆匆过客，缘来缘去，都是如此匆匆，从未有过片刻的停歇。过去与现在，也许我们都更为怀念从前的自己，更为喜欢过去的自己。但唯有活在当下，安于今朝，全力以赴每一件事，才是最重要的。过往再美好，亦终究只是一场梦，如若你每次能在梦中邂逅最初的温暖，又能够在梦醒之后砥砺前行，不忘初心，梦里梦外，又有何分别?</p><p>　　其实，一路走来，我们总是太沉迷于繁琐的名利，而忽略了人生除了浮名虚利，还有太多的美好值得留恋。比如世间旖旎的风光，万古不变的青山，滔滔不绝的江河，这世间的一花一草，一树一菩提，乃至每一粒尘埃，都是最为干净、质朴的美景，以至于成为了我们每个人心中至高的信仰，搁置在心灵最纯净神圣的角落，不轻易与人诉说。我们一路患得患失，不是因为失去的太多，而是我们渴望得到的太多。拥有的越多，越是患得患失，太在乎得失，太在乎成败，身上的包袱已是很重，再徒增心上的负担，又如何能让自己感到快乐?</p><p>　　生命对于某些人来说，也许原本就是件忧伤的事，是一场无可避免的错误。就像是一只美丽的蝴蝶误入尘网;一苇渡江的小舟，错过了港湾;一株洁净的花木，开错了季节。但这世间，又有谁能做到十全十美?事若求全又有何所乐?我很喜欢这么一段话执意栽花花不开，偶然插柳柳成荫。一世浮沉因缘幻，任随晴雨一禅心。生命或许就是一场修行，是一首平仄的诗句，亦是一趟旅途，唯有你跋山涉水，披荆斩棘，才能抵达生命的彼岸，找寻到心灵最终的归宿。</p><p>　　你站在桥上看风景，看风景的人在楼上看你。明月装饰了你的窗子，你装饰了别人的梦。无需艳羡别人所拥有或得到的，因为你所得到的，正是别人所错过的。外界的风景如何，全由你的心境。你若心胸开阔明朗，世界便是辽阔的;你若心中是狭隘的，也只能看见这世间的荒芜与炎凉;若你心灵洁净无尘，以静观物，你若清风朗月，即便尘世污浊，你也能以清净之心在此尘世中修行。外界之景，都抵不过你的心景。你自己，就是那道独一无二的风景。</p><p>　　从明天起，做一个幸福的人，喂马、劈柴、周游世界。从明天起，关心粮食和蔬菜。我有一所房子，面朝大海，春暖花开。从明天起，和每一个亲人通信，告诉他们我的幸福。那幸福的闪电告诉我的，我将告诉每一个人，给每一条河流每一座山取一个温暖的名字。陌生人，我也为你祝福，愿你有一个灿烂的前程，愿你有情人终成眷属。愿你在尘世获得幸福，我只愿，面朝大海，春暖花开。一个人唯有以清为欢的时候，才能够体会到人生清明的滋味，才能通向心灵的澄澈之境。</p><p>　　只愿不负光阴，不负韶华，将生活过成一首平仄的诗句，起落有致，跌宕起伏，意境优美典雅，将似水流年绘成一幅水墨丹青的画卷。不求得掬水月在手，花香沾满衣，只求得能采禅意入墨，寄静美于心，走过红尘中许多宛转迂回的道路，心却仍旧愈发地谦逊慈悲。于此尘世中，只做最真实简单的自己，不受世扰，若莲花般明净无尘，优雅从容地度过这一生，便好。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '风中谁寄花笺来，是花、是鸟、是清风、还是故人你?料峭春寒，窗外细雨绵绵，点滴间回荡曾时的心声。风景年年依旧，只是再也无法寻回最初与我赏花之人。尘烟如梦染，尽落三千温情脉脉。只叹梦随风，寻去处，千百度，却不能在灯火阑珊处与你的目光温柔相对，只能在千百度回首时，发现自己独自徘徊的身影。或许，流年早已散作......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('46', '那个少年成了回忆', '<div id=\"main_content\">\n<p>　　时间在我们面前，转眼之间我不再少年，行向了儿时羡慕的方向，一路曲折迷茫，却时常听到有人说看那个少年多坚强。</p><p>　　不再一遇到困难就给父母打电话，不再一不高兴就乱发脾气，现在却是沉稳了不少，反而显得有点老气，有了自己的爱好就是每天都写一篇自己的文章，有了期盼就是希望父母别老的那么快，让我有时间回报父母的爱。</p><p>　　转眼之间已不复少年，脸上却舔了不少风霜，也不再听到有人说，看那个少年多坚强，耳边却时常响起了孩子的哭声，和一些经年累月的琐事，很多时间都忙到忘了回忆，现在才明白曾经的美好，我们还是孩子等着父母叫我们回家吃饭，没有杂七杂八的小事，也没有为钱劳累的疲惫，对那时我们还是孩子。</p><p>　　长大了长成了儿时说的大孩子，大孩子也有了自己的孩子，有了自己的家，开始以子女为中心的操心，担心孩子学习怎么样，自己那还有时间去放松一下，问问自己是不是很累，又看看身边的子女。</p><p>　　好像每个人的一生都被安排好了一样，生老病死结婚生子，为家为了孩子，努力来努力去却不知努力的对吗?年轻时阳光的模样那是我吗?曾经的朋友你们是不是也如我一样，好多年没见了吧!认识的新朋友多了，还是觉得老朋友可贵。</p><p>　　岁月如流水，那个少年成了回忆，成了如今羡慕的美，不管将来如何，现在还是要选择快乐，能做多少努力就做多少，尽力就好!活过了一世经历了该经历的，还有一些自己想经历的就好。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '时间在我们面前，转眼之间我不再少年，行向了儿时羡慕的方向，一路曲折迷茫，却时常听到有人说看那个少年多坚强。不再一遇到困难就给父母打电话，不再一不高兴就乱发脾气，现在却是沉稳了不少，反而显得有点老气，有了自己的爱好就是每天都写一篇自己的文章，有了期盼就是希望父母别老的那么快，让我有时间回报父母的爱。转......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('48', '女子温婉，一世芳华', '<div id=\"main_content\">\n<p>　　轻轻地同阳春三月挥手道别，作别过往深深浅浅的悲欢，再深情地同人间四月招手，迎接这春雨煮茗，桃柳抽芽的人间四月天。芳菲四月天，有一种轻灵鲜艳的美丽，亦有一种如亭亭少女般的活泼与灵动。在这样的人间四月天，总会让人在不经意间，想起那个集美貌与才华一身的女子，林徽因，想起她的那句诗你是一树一树的开花，是燕在梁间呢喃，你是爱、是暖、是希望、你是人间的四月天。</p><p>　　这个出生于杭州的女子，自幼被水乡的温柔与毓秀的灵气所沾染，无论外貌、才华、事业、爱情，她的一生，都永远如一朵清水芙蓉，开在人间芳菲四月，给予人们无限的温暖与感动。我们爱林徽因，爱的不仅是她一身诗意，写下了无数句扣人心扉的诗行，不仅因为她是一位才华横溢的女诗人，更是一位伟大的建筑学家，她的一生，都奉献给了她的事业。所以，我们所爱的，是那个既一身诗意又不只是沉浸于书斋里的小家碧玉，更是那个有梦想、有追求的女子。</p><p>　　在林徽因逝世时，金岳霖为她写了一句挽联一身诗意千寻瀑，万古人间四月天。林徽因，令江南风流才子徐志摩怀想了一生，令梁思成宠爱了一生，令金岳霖默默地记挂了一生，更令世间无数形形色色的男子仰慕了一生。林徽因，是多少人梦中的那朵白莲，那朵清净之莲，她既没有张爱玲的凌厉，没有陆小曼的决绝，亦没有三毛的放逐，她活得理智又清醒，坚定又清脆，柔婉又坚韧，诗意又真实。于纷扰红尘中，多少人都曾企盼能得一位这样的红颜知己，不求浓烈相守，但求淡淡相依。</p><p>　　不去管这世人是如何地评价林徽因，只知道，在众多的民国才女中，我只钟爱于林徽因。不仅是她在事业上有所一番作为，论才华论成就，她都可谓是巾帼不让须眉，在爱情婚姻上的选择，她更是理智又清醒，她不选择风花雪月的徐志摩，而选择了与她志同道合梁思成，只因她知道，她所想要过的生活，不是风花雪月的浪漫，而是平淡的相守一生。而面对金岳霖对她的感情，她亦是能够处理得当，与金岳霖成为了一生的知音。无论是徐志摩、梁思成，还是金岳霖，我们都该尊重林徽因的选择，也许我们都无法评说到底是谁更爱徽因多一些，或是谁更能给予林徽因更好的爱情，只能说，林徽因的爱情，亦如她的心，乐观而执着，柔婉又坚韧，只求得能有一人，与她在红尘中淡淡相依，简单而又平淡地厮守一生。</p><p>　　而我亦是认为，这世间最美的，一是文字，二是女子，曾有这么一句话说若有诗词藏于心，岁月从不败美人，真正美丽的女子，静雅嫣然，历久弥香，如淡雅芬芳的花朵，亦如同一盏淡淡的清茶，素净清淡，更令人回味无穷。真正美丽的女子，不是用任何的胭脂香粉来装扮自己的容颜，而是由心而发的气质美，所从骨子里渗透出来的美，她们的心，当是如人饮水，冷暖自知，当是如林徽因一般的。无论什么时候，他们都能保持着一种遗世的优雅与从容，无论面对事业、爱情还是人生，她们都能理智而又清醒，且坚定而又从容地做出抉择。他们看似外表柔弱，实则柔婉而坚强，从不为世情所转变。</p><p>　　尽管我知道，世间万千女子，每个人都只是一种颜色，一株花木，都是凡尘里的唯一，亦只是时光罅隙里遗落的细碎美丽，转瞬成尘，也许终其一生的努力，都无法做到向林徽因一样的优秀，都无法向林徽因活得那般的素净芬芳，优雅美丽。但我也愿，怀着温婉坚定的心，来面对尘世的风雨的洗礼，用诗词文墨来装点自己的心扉，即便无法做到才华横溢，满腹经纶，亦是可以让自己的心灵更加充盈美好。在事业上，也许做不到有所一番大成就，但也愿兢兢业业、勤勤恳恳，全力以赴，在文学写作上，也愿怀着最为真诚的心来创作，写下最具真善美的文字。</p><p>　　女子温婉，一世芳华。惟愿尘世中的女子，都能有如林徽因一般的优雅与从容，柔婉而坚忍，都能活得乐观而执着。不是不识人间烟火的清冷孤高，而是在凡尘烟火中修炼得更为质朴天然。任凭历经世事浮沉起落，尝尽人情百味，依旧如淡雅清茶，素净芬芳，历久弥香。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '轻轻地同阳春三月挥手道别，作别过往深深浅浅的悲欢，再深情地同人间四月招手，迎接这春雨煮茗，桃柳抽芽的人间四月天。芳菲四月天，有一种轻灵鲜艳的美丽，亦有一种如亭亭少女般的活泼与灵动。在这样的人间四月天，总会让人在不经意间，想起那个集美貌与才华一身的女子，林徽因，想起她的那句诗你是一树一树的开花，是燕在......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('50', '想和春天，来一场盛大的约会', '<div id=\"main_content\">\n<p>　　三月的春风。左手携一篮阳光，右手提一兜花儿香，绕过季节的栏栅，柔软的落在心房。</p><p>　　柔软，多好!一个清美的词藻，像婴儿的小手，娇嫩又美好。譬如三月的阳光和雨露，晨曦中的暖风和鸟鸣，以及藤蔓上的青芽和花苞，那柔软，像极了初恋的味道。</p><p>　　此刻，晨曦微露，朝霞晕染，我听见窗外的花儿，啪又开了半朵，真好!新的一天开始了，去热爱这美好的所有吧!</p><p>　　听，清风与草木正在悄悄约会;看，一滴清露正轻轻吻醒花蕾;阳光正与桃花缠绵暧昧;一群麻雀把春意闹的沸沸扬扬。</p><p>　　一切都是那么的美!勃勃生机美好的不可思议。</p><p>　　此后，许自己做一个看花闲人，低温行走，拾花酿春。像花儿一样，与天地光阴爱过一回又一回，用大朵大朵的美好热爱生活，用整个春天的情怀，深情深情的活着。爱每一缕新鲜的空气，和一片片刚刚飘来的云朵，还有一滴新新的露珠，一枚新生的绿意，一粒含苞的骨朵，一串脆亮亮的鸟啼，亦或，更有三品男士这颗被春色浸染的初心。</p><p>　　常常欣然于这样的时光于闲散的光阴里养花泼墨，看花影摇窗，看春风拂过青绿绿的诗行。看花，为我而绽放;看云，为我而讨好夕阳。煮一壶春色，斟一盏明媚，将光阴里的纯粹慢慢啜饮。相信，有清风和花朵的地方，也一定会有诗和远方。</p><p>　　你看，是谁?种下满庭春光，又是谁?恰好，撷一朵桃花来叩门。于是，我看见，春风到达的地方，所有的花儿都恋爱了，整个春天都微醺着爱的况味。</p><p>　　好吧!就许我三品男士于百花深处，寄语酿花，与春光，与桃红，与梨白，与美丽，来一场盛大的约会。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '三月的春风。左手携一篮阳光，右手提一兜花儿香，绕过季节的栏栅，柔软的落在心房。柔软，多好!一个清美的词藻，像婴儿的小手，娇嫩又美好。譬如三月的阳光和雨露，晨曦中的暖风和鸟鸣，以及藤蔓上的青芽和花苞，那柔软，像极了初恋的味道。此刻，晨曦微露，朝霞晕染，我听见窗外的花儿，啪又开了半朵，真好!新的一天开始......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('52', '看，那一瞬的绚烂！', '<div id=\"main_content\">\n<p>　　大海在努力翻腾着，终于涌出几朵浪花;小鱼儿在努力跳跃着，终于一跃成龙;小树苗在努力生长着，终于成为参天大树;为了让自己变得更好，它们都辛勤的努力着。那么，我呢?我们呢?</p><p>　　有这样一篇短文，内容以一种花的</p><p>　　生长为主，开头写道 在一个峭壁上，</p><p>　　那是一个很高又很危险的地方，但却受到大自然地偏爱，赋予它异样美丽的风景颇有一 番会当凌绝顶，一览众山小的气势。在这个人迹军至，几乎无人涉足的地方，一棵花的种子正在倔地生长着。它身 边芬 芳 的 泥土 不 解地问在这样的地方扎根，你就算长得再好又有什么用呢?我们没有阳光的充分滋养，没有雨露的无声爱抚，恐怕连生命也会短暂的结束，你又何必这么拼呢?它竭力伸了伸脖子，审视了一下周围，继续骄傲地咬着牙，摇头道我不信，就算没有阳光雨露又怎样呢?生命短暂又有何惧?如果不能更好的展现自己，生亦何欢?我不会放弃的!</p><p>　　就这样，在日复一日的消磨中，泥土放弃了规劝就由着它吧，真是个倔强的让人心疼的孩子可它呢?还是一如既往地努力，一次又一次的尝试着破土而出，得到渴慕已久的风雨，阳光。即使它是那么的渺小而又脆弱，也依旧咬牙坚持。</p><p>　　一个多月后，它终于受到了它突破的一点缝隙中透出来的几缕阳光的照耀，它无比的喜悦，同时迫不及待的叫泥土过来看我成功了，我成功了!</p><p>　　它又卯足了全身的劲，用力顶开头顶的地皮，像一个新生的宝宝一样，好奇的探索着周围的一切，一望无垠翠绿的嫩草，还有晶莹剔透的露珠在休息，这是多么富饶，美丽的一片国土啊!</p><p>　　又经受了几个月光和雨的滋养，它终于要开花了，而开花的时间是每年的月圆之夜，十二点开放，只有半个小时的时间，然后便枯萎，等待下一年的盛开。</p><p>　　人们不知哪里得来的消息，都在这一天长途跋涉、不辞劳苦、翻山越岭地来到这，来等待那一刻的来临。</p><p>　　滴，答。雪白的花瓣在皎洁的月光下绽放，它任性的泼洒着自己身上的银色光辉，照亮了人们的好奇心，似一颗夜明珠或是一个尤物般散发着纯净的白色光芒，是那么地美丽，那么地令人神往，总是贪恋这片刻的温婉......</p><p>　　它骄傲地注视着这一切，不觉润湿了眼眶，总算那么多地努力没有付之流水，它做到了，而且是以这样绚烂的姿态绽放，也终将在这华美的帷幕下，结束自己的生命。</p><p>　　它笑着哭了，在最后一分钟时，说我得到了我想得到的，即使我的生命即将结束，但至少我努力过了，我不后悔!</p><p>　　第三十一分钟，它的花瓣一层层陨落，在地上铺成了两个字昙花，那是它的名字，是人们心中最永恒的记忆。</p><p>　　这样执着的一株植物，这样靓丽的一道风景，一颗幼苗的破土而出，它小小的身躯里，蕴藏了多么大的力量啊!</p><p>　　它用它的不懈努力，谱出了一曲生命的赞歌</p><p>　　昙花</p><p>　　即使生命短暂</p><p>　　也只为短暂的存在而绚烂</p><p>　　因为</p><p>　　努力过，不后悔!</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '大海在努力翻腾着，终于涌出几朵浪花;小鱼儿在努力跳跃着，终于一跃成龙;小树苗在努力生长着，终于成为参天大树;为了让自己变得更好，它们都辛勤的努力着。那么，我呢?我们呢?有这样一篇短文，内容以一种花的生长为主，开头写道在一个峭壁上，那是一个很高又很危险的地方，但却受到大自然地偏爱，赋予它异样美丽的风景......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('54', '春雨来了', '<div id=\"main_content\">\n<p>　　春雨来了</p><p>　　今年的春雨似乎来的比往年早很多，阴雨绵绵，微风栩栩，气温渐升，大街小巷处处都笼罩着春天的气息。刚刚退却了冬日，春雨中还夹杂着丝丝寒冷，都市的人群里好像刚刚从被窝里走出来，许多人还在包裹着厚厚的衣服，街道旁冷冷清清的几个人，这和春暖花开显得那么格格不入。</p><p>　　都说春雨贵如油，可是这接连几天的雨打破了我对\"春雨贵如油\"的看法。可能是世风日下，也可能是气候变化，让这原本春雨贵如油的定律瞬间打破。寻着这春雨，走在都市的街道上，街道逐渐变得热闹起来，小贩的叫卖声，三三两两的游人来来去去，我穿梭在时光的小巷子里，许多曾经的东西已经物是人非，不复存在，那些年少的记忆已经慢慢变得模糊不清。</p><p>　　北方的春雨不同南方的春雨，北方的春雨细细碎碎，来的焦灼，快如麻，并且处处是春暖花开，洋溢着春的气息，始终让我流连忘返。而南方的故乡且是来的那么地慢，如果不去细看你根本不知道春雨来了，根本体会不到春的足迹。</p><p>　　我在北方居住过四年之久，每当春雨来临之时我都会去淋一场雨或者用目光注视一下春雨，感受一下春的气息，让春雨洗涤我过去的烦恼、忧愁、郁闷，好让我在来年有一个足够的心情去新街新的人、新的事、新的……。而每次看春雨的时候我都会和同伴们一起在花间拍照，以此祈求留下最美的自己，让春天包裹内心深处的美，留下一段美好的回忆。可是，时光匆匆春的脚步已经快慢慢远去，彼时拍照的人已经不知在何方？说明年这个地方又一起看雨的人已经远去？……</p><p>　　花有归期，人有别离之苦。春雨贵如油，就如同人生之中难得遇见的人一样，慢慢的随着岁月冲击，忘记了曾经的许下的誓言，曾经一起走过的美好岁月。其实，有的人注定是过客，有的人注定是一辈子的知己，只不过过客会教会你明白一些东西，而知己却是时刻伴你左右，一直到离去。</p><p>　　此时此刻的春雨越来越大，好比北方许多地方夏季的雨来的粗猛，彪悍，让我抵挡不住雨点的冲击，只能打道回府。可是，街道两侧买菜的、买吃的、买衣服的等人依旧还在坚守着阵地，临危不惧，等待着春雨的消失，然后开始繁忙的一天。</p><p>　　还记得一次凌晨4点的时候，我一个人睡不着爬起来散步，听到不远处喧闹的声音，我走了过去才发现原来是一群可爱的人在这里摆放一天要买的东西。我从街头走到街尾，发现大多数都是本地一些离城比较近的乡村人来到这里买蔬菜，然而这些蔬菜可都是土生土长的地方菜，并且特别便宜，没有什么添加剂、色素和特别加工的地方，全部都是乡村人用自己种的，供给城里上班的人吃。只不过这些菜没有商业贩买的那种菜不好看以外，其他地方没什么区别，可是许多城里人还是不喜欢这些菜，而选择经过过滤过得菜。这或许就是一些城市人注重外表的华丽，而忘记内在的美，吃出了许多的毛病出来。</p><p>　　早起的鸟儿有虫吃，这些朴素、憨厚、善良的乡村人用这些地道的小菜换来一点钱，这些钱大多数给孩子读书或者其他一些家用。</p><p>　　这些乡村人时常在淋春雨，因为\"一日之计在于晨，一年之计在于春\"。春天播种种子，夏天除草、施肥，秋天收获。其实，对于故乡人来说，已经不分春夏秋冬了，我觉得只有夏天，因为他们大多数时间都在地里劳作。</p><p>　　春雨来的急忙，可是这些雨点还不够种地的大伯浇水；来的仓促，可是还是洗涤不了这些垃圾成堆的城市；来的悠长，可是还是不能淋去我内心的空……</p><p>　　曲靖故乡</p><p>　　笔名，莫然，刘云宏。系中国现代作家协会会员，中国西部<a href=\"//sanwen.chazidian.com/sanwen/\" target=\"_blank\">散文</a>协会会员，百姓文学主编，短文学签约作家，作家文学网络部主任，常驻网站执手文学、中国散文馆、中国散文网、莫然文学、短文学网等。文学爱好者，连续两届荣获短文学奖，作品在多家杂志发表，上万字的散文在荔枝平台被知名主播诵读。曾担任过仓央嘉措诗社散文诗社副主编兼副社长，著有散文集那年，风起云涌。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '春雨来了今年的春雨似乎来的比往年早很多，阴雨绵绵，微风栩栩，气温渐升，大街小巷处处都笼罩着春天的气息。刚刚退却了冬日，春雨中还夹杂着丝丝寒冷，都市的人群里好像刚刚从被窝里走出来，许多人还在包裹着厚厚的衣服，街道旁冷冷清清的几个人，这和春暖花开显得那么格格不入。都说春雨贵如油，可是这接连几天的雨打破了......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('56', '行囊', '<div id=\"main_content\">\n<p>　　人生，其实就是我们背着行囊前行，并不断往自己的行囊中放进东西和拿出东西的过程。</p><p>　　小的时候，行囊里的东西很少。犹记得那时，外公的院子里面有一小簇的迷迭香，散发着让人心醉的味道，拨开那外面的花丛，能看到几只金黄色的蜜蜂，在花丛中穿梭，而那薄薄的双翼，则是覆盖上了一股迷迭花的清香。而外公都会坐在门前的木藤凉椅上面，笑眯眯地看着在花丛玩闹的我。直到某天，我玩累了，倚在墙上，看着那蜜蜂在花丛中窜动，便痴痴地对外公说要是能吃到蜂蜜就好了!于是，外公的家里养起了蜂，十天后，我吃到了人生中第一口的蜜，嗯，是甜的。于是，第一次往行囊装东西，是亲情。</p><p>　　渐渐地，长大了，行囊里面的东西也渐渐多了。夕阳西下，知了仍旧在树上不停地叫着，人们在树下拿着蒲扇扇着风，聊着家常。阳光照在河边的柳树旁，落在了我们在河里打水仗的身影，嬉闹的声音随着清风，飘向了很远的地方......这次装进行囊的，是友情。</p><p>　　只是，我不知道，我现在仍旧记得的那些儿时的伙伴，又有多少，还记得我?</p><p>　　回家，转车城北，换自行车。车轮滚滚，已至黄昏。到了十字路口时，夕阳也终于是夕阳了，就像烧红了的煤炭一般。夕阳透过空气，躲过层层高楼的阻碍，穿过树叶的缝隙，照在脸上，仿佛镀上了一层红霜;射在地上的一滩滩水渍上，水渍就浮光跃金，似乎是一颗颗闪烁的小星星;落在人行道旁的成双成对的树上，绿树就好像擦上了一层油，显得更加翠绿了。红阳盖在我的自行车上，笼罩在我一个人身上，眼睛看着这夕阳，不禁想，这，是孤独吗?这次，把那黯然的友谊拿走，而装进行囊的，是孤独，</p><p>　　走在路上，装进了很多，有友情，有亲人的期待，有自己的信仰，它们让我步伐更加坚定;我也拿走了很多，有一部分的友谊，有很多的乐趣，有一些别样的情感，拿走它们，让我走得更加轻松。</p><p>　　人生漫漫，背上行囊，慢慢走，好好走，别回头，往前走。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '人生，其实就是我们背着行囊前行，并不断往自己的行囊中放进东西和拿出东西的过程。小的时候，行囊里的东西很少。犹记得那时，外公的院子里面有一小簇的迷迭香，散发着让人心醉的味道，拨开那外面的花丛，能看到几只金黄色的蜜蜂，在花丛中穿梭，而那薄薄的双翼，则是覆盖上了一股迷迭花的清香。而外公都会坐在门前的木藤凉......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('58', '四月，盛一场繁花似锦', '<div id=\"main_content\">\n<p>　　一年四季中，春、夏、秋、冬交替着，而四季中的景却是人生中最美的那道风景线。</p><p>　　四月，携一缕盛开的繁花，好似清风徐来，水波荡漾，听一曲风筝误，看一场繁花似锦，悠哉，美哉!</p><p>　　周末，独自在小园散步，品一壶老茶，弹一曲古筝，看繁花盛世。人生中最美不过风筝误，赏樱不过匆匆，梦中的那份世界又重回眼前。于是，我开始独自在园中想起在梦中执笔画下的风景，当我画下那幅画面时，觉得那不是普通的风景，而是墨的山痕。</p><p>　　大自然中的美景千姿百态，四月，开一场繁花似锦，品味茶园中的虫鸟相鸣，幽幽清风，好似一场梦境般的画面，世界之大，寻一缕芳菲流年，就这样把生活过下去，真乃幸甚之乐.....</p><p>　　不禁吟诗一首</p><p>　　禅园幽幽霜满天，</p><p>　　花落曲中遇知音。</p><p>　　繁花似锦风飘絮，</p><p>　　晓梦云雾染墨色。</p><p>　　风筝误，误了梨花花又开，风筝误，捂了金钗雪里埋，人生，若不品味一场自然之旅，怎能知道其中的意境，明月几时有，把酒问青天，四月之景，触动心扉，四月之景，清风徐来，盈一抹芳菲四月，最美不过四月天，细细品味自然，泉水滴答，泠泠作响，四月，你好!</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '一年四季中，春、夏、秋、冬交替着，而四季中的景却是人生中最美的那道风景线。四月，携一缕盛开的繁花，好似清风徐来，水波荡漾，听一曲风筝误，看一场繁花似锦，悠哉，美哉!周末，独自在小园散步，品一壶老茶，弹一曲古筝，看繁花盛世。人生中最美不过风筝误，赏樱不过匆匆，梦中的那份世界又重回眼前。于是，我开始独自......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('60', '我怀念的，终是那一场忧伤', '<div id=\"main_content\">\n<p>　　从你的世界走过，没有落尽秋风之美，也没有等待浓春之艳，各自冷漠，陌生成一处两人的无人区，便也都弃了交融的红尘。剩一梦悠长，留一曲空荡，存一本故事里的柔情，在游动的笔尖上起舞，刻着眷恋，扉页翻动，又是一场完结的故事。</p><p>　　用情至深也不过一场争吵便将所有都弃之不顾，那一头乌黑的长发随着微风飘动的柔美，也不过是欣赏久后烦厌了眼睛，倔强的性格是如此的豪情，也不过是一首歌便取缔了那独特的美丽。心不再安慰，一个人任精神无限的折磨，让身体无时无刻的颓废。桌子落尘已久，地板脚印各处斑点，衣服凌乱扔在大床上，被罩被卷缩的身体分离出一角，孤零零的躺在地上，也就任它沾满灰尘，几经酒醉，疼痛的肠胃恨不得流进眼里的忍耐，也就放任它一静一动的悠闲。痛的双手不停的捶打自己，却总是打错了地方，想先把心通畅，一个劲的疯狂，最后无力的瘫在自己的嘲笑中。时光再也不动神色，反反复复重复同样的疼痛，是跨不过去了。傻傻的等着自己的审判，轻了心过不去，那么爱不该如此惩罚，重了思想过不过，还有亲人、朋友，还有余下的人生，何必执着，又何必折磨。无限的矛盾，在每一个黑夜即将来临时分，它载着厚重的情感附加在思想之上，无暇多想，就已开始自我的救赎。</p><p>　　人生就是这样，幸福的日子多过悲伤，可悲伤的时候却总看不到幸福的样子。你想逃脱它的束缚，又感觉力不从心，自己不该前进笑了他人。不管不顾又骗自己该了结了情愫，也是说不服自己行动起来。在自我战斗的时刻，人总是懦弱的，再坚强的肩膀也躺不下柔情的抚慰，心要走远，留下的躯体能承载几份重量，让它去依偎着未来的希望，凝聚力量，起身拉开窗帘，走出自己强固的心房，去闻一闻新的味道，来驱走心中埋怨，留下青春正好。</p><p>　　我们都不是圣人，七情六欲是活着，无欲无求是活着，然每个人都有自己的活法，谁也无法改变谁。曾以为为谁而改变，到了最后还是因为无法包容彼此，而伤感至此。也许正因为我们都是凡人，便也就随着凡人的性子走过一生。生活如此，情感如此，一切皆是如此。也就不要劝慰自己做一个什么样的人，自在如风而来而去，潇洒如尘而动而生。去怨恨也好，要知道怨恨什么，去原谅也罢，原谅何谈缘由!最后也不过是两个人的一场痴念，彼此伤心，让岁月来疗伤。其实不是不能继续，而是彼此不快乐了，爱情的样子就模糊了，远了是彼此的心，也就放手让它走吧!</p><p>　　我庆幸自己在正当青春的年纪遇到，也感谢如诗如幻的那段时光带了一场幽梦。遇到你后，我的世界处处惊喜，多了色彩。你离开后，我的世界平静了，却也早已成了支离破碎的模样。我想该去着手修补了，下雨的时候不想因心田无法成一条溪流去滋润沃土，不再任它再滴透心间。</p><p>　　也许有一天它再无情的滴落，想必是那泛黄的相片，老去的诗文，还有那一堆纪念的礼物，让我格外想你，如这春风炙热里的艳阳，浓厚的情感只因思念愁绪萌动，春风还劲，却吹不散眉弯处的深情，亲爱的，你尚安心?</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '从你的世界走过，没有落尽秋风之美，也没有等待浓春之艳，各自冷漠，陌生成一处两人的无人区，便也都弃了交融的红尘。剩一梦悠长，留一曲空荡，存一本故事里的柔情，在游动的笔尖上起舞，刻着眷恋，扉页翻动，又是一场完结的故事。用情至深也不过一场争吵便将所有都弃之不顾，那一头乌黑的长发随着微风飘动的柔美，也不过是......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('62', '淡云春睡', '<div id=\"main_content\">\n<p>　　柳拂清风丝袅袅，淡云春绿蓝绵软，翩红吹皱了湖面，莺黄啼笑了桃晕，白灵灵的蝴蝶轻轻地吻在了青青草蔓海上，温柔的春光醺醺暖暖的笼醉了扶岸的思梦人。</p><p>　　三月的春天，是一倾含着烟水的婀娜春画，波波粼粼晕染着迷丝的绿光，飘旎着鹅黄色的轻羽，朦胧地，袅柔地拂过你的眼眸，落在你的身边。</p><p>　　正是春风三月迷人意，赏花游湖丽春光。微风轻，莲步轻移，裙旎飘曳，走过楼阑小巷清河桥畔，走过两岸绿柳荚道，六分绿白花飞一红，三两闲梦望春人。笼抱在这淡淡春风醉光中，缱绻在轻浅浅的柳条绿里，飘飘如风柳，柔柔似腰柳，恰似一细微光中的黄金缕，恰如古典仕女图中的一倾卷云青发，旖旎婀娜温柔，就是它的美，春的意。</p><p>　　古今而来，谁又当是解语凭栏人，遥望一波春湖水，愁肠爱意梦里来。凉风三月春天里的湖水，宛如一片晕湿了云水的绿纱,轻然然的漫开了满湖，和着绿绿柔柔的春风轻轻地推送着，波澜轻起，层层漫层层，碧波洇又深。温吞如碧玉，刹那暖心凉，三月的春水舀起了一盛安宁的温柔汤，覆入静之谧意，雅之芳意，我独在水中央。</p><p>　　闭眸闻息抬头间，春风漫过红粉生，飘入湖中浮漪荡，青萍碎碎瓣花点点，缱绻了湖水的清澈，妩媚了春水的温柔。醉是香风引蝶恋，衣裙飘飘影蹁跹，折来一青柳枝儿，戏舞着湖水画浮痕，慢沿河桥悠然走，便见一座弯月洞桥下的红鲤石白鱼，团团喁喁争相戏，泛起水花朵朵涟漪圈又圈，煞是一番春之妙趣游连，莫是这春天的鱼儿也在欢喜怡然，歌颂着春之美，呼吸着春之光。</p><p>　　可不是这般么，你看呀，春草们在轻轻的絮语，蝴蝶在相依偎着爱梦情情，春风也在温柔欢笑，柳条儿都在舞蹈呢喃，哪里都是春意盎然的一片，哪里都是春的颜色，我的心开成了满树的花，摇曳出铃香歌芳的味道。</p><p>　　踏上木舟渡春游，茶香酒芳笛声遥，游过柳岸月弯桥，眼去小城楼瓦楼，缓缓隐入薄雾人不见。渺渺的春雾轻轻地环缭在水面上，一线线，一圈圈，似散未散，仿若袅袅盘旋升起的氤氲烟香，迷朦朦的白，令人欲起顿念，心寂而思。它又仿佛是一缕天仙女腕间的白纱，轻然然地落在了人间，等到日光初起，清风浮动，这薄薄的、隐约的、朦胧的春雾便淡无声息的消散了，徒留一种浩渺空境的美散在了心中。</p><p>　　雾生起时，我一人。待到雾漫散去，万空晴云独我影，若问君家何处去，我寻一处春山去，看那春花争艳的梦去，看我心中的希望去。</p><p>　　春水慢慢的吞去了雾，朦胧的春山藏在了云息的后面，远远望去，恰似一痕淡淡的眉山青黛，一笔风清水墨的晕染泼迹，潇洒旷逸的映在了山广天地间，映在了思梦人的眼中。</p><p>　　游到芳草水岸边，踏着湿润的苔痕石路漫入了云朵脚下的春山野林中，一路哼歌雀跃，闻着青枝露光的味道，染着绿叶山泥的颜色，我来到了心梦里的春山。一切都还未将到叶枝繁茂的时节，初春的三月山里，一眼所望的是一簇簇芽青嫩绿色的瓣叶尖儿，一团团淡粉白玉的玲珑香花苞儿，还有早春时里盛开满树的桃花美人和明艳艳的黄桐花瓣串儿，一片片一簇簇像夕阳空中的彩云朵般盛开了满春，缀点着脆生生的青绿，褐棕色的枝条儿，煞是清新一派惹人欣爱。我喜欢这三月天里暖暖凉凉和柔的春色，不过分美丽，不肆意张扬，一切都是恰到安然的温柔，宛如平和宁静的宝玉书简。</p><p>　　走过山花绿丛，偶见三两枯枝沙砾的灰石板小道上，残落飘至了点点零星碎花儿，淡紫的、鹅黄的、嫣粉的花朵儿，它们静静地飘落在溪水边，浅卧在石苔草痕中，挂在枝叶横木间，一片残败寂静景象却还就了一息人间的禅意味道，人生何不似这浮萍落花儿，飘游无的，花开花落梦成空，人生人逝终归土。我们人，从哪儿来，终归还是要回到哪里去的，终归于这天地，归于世间的气，归于这世态的轮转，恰如这满春生落花一般，它走向了最终的圆满，化作春泥更护花。</p><p>　　时至午后时分，曼妙的春山里轻轻地下起了春雨，绵软软地落进了山林里，落在了屋山岗麦田杆中，落在了阳光的余辉里，我伸出手去捧接着这绵绵的春雨丝儿，雨丝轻轻洒在掌心里，却未见那晶晶的雨珠儿，只有那凉凉的、迷迷的、薄薄的细细湿意，纤纤的温润姿态，无骨的袅娜身影，娇羞的含朦眼睛，它微张着凉凉的湿唇轻轻地吻着你，轻轻地爱抚着你，绵软的春雨化作了一个美丽的春情姑娘，它飘在绿溶树上，飘在青青的芽尖上，飘在含苞的花骨朵里，飘在了蝴蝶的薄翼上，它来到了我的怀里。</p><p>　　曾闻春雨飘落万物生的善德，这一场春雨落下，又会赋予世间多少生灵物美的希望和生命，而我，此刻也在你的沐浴下，生长。春风拂过江南绿，春雨一夜万竹开，春天的命意，赋梦了世间少年少女新的希冀，梦的翅膀，愿汝如春天般明媚，如花盛放，蓬勃飞扬。</p><p>　　走罢春山游回舟，两岸游人渐水流，此时正到午日阳光最是暖融时候，风习香香动，人醺春困梦，春花飘红燕雀相啼，惹落一袭春思梦，拂被懒溶水沉浓。</p><p>　　春有春光春景春水春山一美事，亦有春困春梦春思一绻事。</p><p>　　旧事里，望见春之光美景，日和暖绒绵，闺中少女便不禁犯了春困，一梦眠到日光高头鸟啼声，醒罢春恼忆梦人，思起故往的前事，思慕起旧日的耳语，幻梦着这满春光下能与心中卿卿同游木舟戏鲤鱼，浅连花下话衷肠，这芳香的春分带就了心的春芬，叹是春心春景美，幻作春光美景梦中休，女儿相思情梦入水流，流到花红梢头望江楼，江楼高处何许人也，兀笑道赏春人矣。</p><p>　　赏春人矣赏春人，赏春人来赏春人，人赏春来人入景，叹是谁人春中景。</p><p>　　临了夜晚寂静时候，蓝墨的天空黑云里升起了一轮淡渺渺的春月，澈莹莹的光，玉白的圆亮，散发着一圈圈温柔明润的珠华，乘着夜凉风轻轻地洒落人间，洒落在香庭院的樟柏树上，流光清萧，影姿绰落枝叶摇。</p><p>　　望月，是要思家的，望月，是要思梦的，望月是要怀旧的，而我，便是那个静静的望月人，思念着故乡的母亲，思念着心梦里的三月春。</p><p>　　月，如水，好凉风。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '柳拂清风丝袅袅，淡云春绿蓝绵软，翩红吹皱了湖面，莺黄啼笑了桃晕，白灵灵的蝴蝶轻轻地吻在了青青草蔓海上，温柔的春光醺醺暖暖的笼醉了扶岸的思梦人。三月的春天，是一倾含着烟水的婀娜春画，波波粼粼晕染着迷丝的绿光，飘旎着鹅黄色的轻羽，朦胧地，袅柔地拂过你的眼眸，落在你的身边。正是春风三月迷人意，赏花游湖丽春......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('64', '那场与时光的约定(1)', '<div id=\"main_content\">\n<p>　　画面总是这样，你在流淌，我在追;你喜飞翔，我爱丈量，从不停泊，经历光影轮回，人世沧桑。然，经世最怕，蓦然回首，回首却是，烟雨如岚，情如浩，心似烟波。</p><p>　　不知那场约定，可曾随风散去?</p><p>　　曾记否?那时你我，都是光阴里的飞蛾，我们有着不老的名字，你的眼神在我心里，我的心住在不朽的春天，我们用最有力的手指拉勾，无论明天与意外如何打睹，谁都不许失言。</p><p>　　我们朝同一个方向出发，那时，你如桃花，我像三月，你风景如画，我是画里的鸟鸣，日子如一只蝴蝶，在光阴里缱绻，从不吁叹，也不介意红尘里来来去去。每一次相逢都是惊喜，每一场经历，用无声作彼此的欢言。任由穿越，彼此从不相信流言，我们把光阴打结，放在各自的底片，从不相信，以后的预言，你变得越来越长，而我却一天一天，慢慢变短。</p><p>　　其实，我是你心眉上的红帆，你是我一生的眷恋，从出发那天，我就借着你的波影，在世俗里浪迹人寰。</p><p>　　佛说你我注定相遇，彼此不能分离，本是机缘，热烈却又如此短暂，不愿走出你的光影，又怕轻易伤别，怕独对空镜，蹉跎了红尘相爱的箴言。</p><p>　　我们相约不要走得太急，遇到最美的风景就停下，人生是一场发现，风景无处不在，发现彼此，发现生命中那一树花开，发现年轮荡开的波心。如果不小心忘记，你就拉长一个人的视线，相约轻踱一轮半弯，或静坐在岁月河边，让他有机会沉浸在怀恋。</p><p>　　我们相约留下那一道门缝，让天眼常开，不论夜有多长，行走中漫延着多少黑暗，那里永久透着光亮，让世界窥见星星，也让我发现世界，即便黑暗像大漠遮住了前方，云霓间也会飞出一道闪电，让我接受你的馈赠，绝不用悲伤淹没最初的光线。</p><p>　　我们相约孤独时，你会用光的羽翼拍拍我的肩，用诗和远方推开身后的窗，如果有愤怒忧伤彷徨，就把时光拉长放慢，也可以停滞不前，你不走，我不怨，像水，像海，像空气，慢慢稀释，消散曾经和过往，或者，用一次长长的远行弥合，把伤痛、不能释怀，从生命的行程轻轻吹去。</p><p>　　我们相约永不相忘，即便等待再漫长，只剩下一颗星辰，一份念想，相信一切的一切都可以改变。任凭四季轮回，春夏流转，彼此都会把对方刻进心里，不让身影衰老，即便你我改变了模样，也绝不目送彼此远去的背影。我们相信，岁月不过是把正面和背面，时不时转了一转，我们只看见开始，又怎能断定结局。</p><p>　　我们相约永不言弃，叹人间，生生死死，再见何其容易，相见却总这般艰难。一世寻找，消散了毕生，错过了就不能重现，丢失的，渐渐落入尘寰。每天你在晨曦里等候，黄昏我目送你归去，我们不停擦肩，每一次都是会心一笑，除了十指相扣的执着，从不把短暂的离别当作再见。你我相挽，才是经世的美妙，在岁月剥落中，被风华颂歌，成了绝世经典。</p><p>　　也许后来的流转，彼此落寞，你默默无言，我寂静无声，我们相约留住那一份感动，哪怕只是一舜，就像露水沾在叶尖，就像阳光从肩头掠过，或者流水潮湿了唇线，我们也用歌声把它点滴写进你的足痕，印在你的眼帘。</p><p>　　踏风而过，总是万水千山，你步履无间，让我的年轮飞起就不能停歇。春去春回，一别经年，繁花盛景，如梦如嗔，想回去看看，那时的你我，经世的约定，还有没有在风雨中腿去容颜。</p><p>　　花谢了再开，四季过去又重来，你我的择总是一次，不再回来。</p><p>　　好吧，水漫痕深，即便人生可以重来，我也不再改变。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '画面总是这样，你在流淌，我在追;你喜飞翔，我爱丈量，从不停泊，经历光影轮回，人世沧桑。然，经世最怕，蓦然回首，回首却是，烟雨如岚，情如浩，心似烟波。不知那场约定，可曾随风散去?曾记否?那时你我，都是光阴里的飞蛾，我们有着不老的名字，你的眼神在我心里，我的心住在不朽的春天，我们用最有力的手指拉勾，无论......', '0', '0', '0', '8', '1', '1', '0');
INSERT INTO `p_article` VALUES ('66', '命中注定，我爱你', '<div id=\"main_content\">\n<p>　　两情若是长久时，又岂在朝朝暮暮。我们相信了大话西游里的经典对白我的意中人是个盖世英雄，有一天，他会脚踏七色云彩来娶我。可往往是猜中了故事的前头，却无论如何也猜不中结尾的结局。</p><p>　　就像周星驰的一句爱你一万年，在曾经那个无声的年代里，我相信会有许多朋友与我一样，得俘获了多少少女青年朋友们情窦初开的芳心。</p><p>　　时至今日，随着时代越发的开放，人心性心理的越发明朗与豁然开朗，却也依旧成为，许多年轻朋友们的难以言语，无法言尽诠释完的爱慕。也是关于感情上永远都无法逾越的，一道人性心理，在面对自己真正心生爱慕，喜欢的人或物面前，最为经典且直白的陈述了把我想。</p><p>　　相见恨晚，相逢何必曾相识!不管是男生还是女生，在爱情的界限与国度里，关于走向最终婚姻的殿堂，其实我们都一样，会像个腼腆又羞涩的孩童般。</p><p>　　因而尊重，所以神圣。因为贵在，所以心知。因而等走到了这步入幸福婚姻殿堂里的庄严神圣，这一时刻;就连天上的神仙月老，也都会感激涕零。</p><p>　　在经典的爱情<a href=\"//mingyan.chazidian.com/taici/\" target=\"_blank\">台词</a>中，其实还有一句，山无陵，天地合，乃敢与君绝!。　我欲与君相知，长命无绝衰。江水为竭，冬雷震震，夏雨雪。这是出自汉代的上邪，饶歌，中的一首著名情歌，以至流传至今。也是许多古装剧里不可或缺，广为传唱的男女经典爱情对白。</p><p>　　我欲乘风归去，又恐琼楼玉宇，但愿人长久，千里共婵娟。水调歌头，明月几时有，宋苏轼。倘若有一天;我就这样凭空消失不见了，也像一首首诗句一样，或一篇篇精美的文集，诗人会有着诗人的一腔风韵，文人也会有着文人的满腔热血，与附庸风雅。也请你能不要难过沮丧，更不要悲伤不开心。</p><p>　　人生路上路漫漫兮，其修远兮也，肯定也是我，找到了一个自身最后可归宿栖息的地方。或手艺的发挥，或幸福家庭，美满姻缘，字里行间;以文为友，以心为画，以图为美，以静为安。安康如意，愿你我、都能吉祥。</p><p>　　人世间若还有问情为何物，又归于何处;愿你归来，便是最珍贵的。执之之手，与之偕老。就像你永远都无法知晓，与猜透一个人，心中到底会履行些什么，又诚若些什么。更无法看透一个人，到底秉性是否良善，善恶是否有分。</p><p>　　前人种树，后人乘凉。时间教会我们的，实在是太多太多了!莫道前路无己知，都别等到失去，方才后悔莫及。若真正喜欢一个人，爱上了一个人，那么就敢于去让心中，泛起对她爱慕的涟漪。今生今世，凭栏处，潇潇雨歇，为红颜。</p><p>　　而你。就像一缕芬芳时迷人的优雅，柔和的沁入了我心脾。你就是我前世，苦苦在佛前求了五百年之久的命中注定，我爱你。不求今生大富大贵，更不求三生三世十里又桃花，只求缘定今生，相濡以沫。</p><p>　　远看山有色，近听水无声。春去花还在，人来鸟不惊。这是出自王维，唐代诗人的一首山水诗。山水怡情，人文养心，爱情与婚姻，的的确确是，庄严肃穆且又神圣的。</p><p>　　在你毫无保留的相信了你的另一半，在你愿意将你余生，终生的幸福交付给你另一半的的同时;荣辱与共。</p><p>　　江湖和为贵，义为尊;百善孝为先。生死两生契，三生劫，陌上开花，寸缕，只为伊人。所谓伊人，在水一方。</p>\n</div>', '2018-04-09 15:40:10.000000', '/media/default02.jpg', '2018-04-09 15:40:10.000000', '1', '两情若是长久时，又岂在朝朝暮暮。我们相信了大话西游里的经典对白我的意中人是个盖世英雄，有一天，他会脚踏七色云彩来娶我。可往往是猜中了故事的前头，却无论如何也猜不中结尾的结局。就像周星驰的一句爱你一万年，在曾经那个无声的年代里，我相信会有许多朋友与我一样，得俘获了多少少女青年朋友们情窦初开的芳心。时至......', '0', '0', '0', '8', '1', '1', '0');

-- ----------------------------
-- Table structure for p_article_category
-- ----------------------------
DROP TABLE IF EXISTS `p_article_category`;
CREATE TABLE `p_article_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) NOT NULL,
  `parent_category_id` int(10) unsigned NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `last_modified_time` datetime(6) NOT NULL,
  `is_delete` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_article_category
-- ----------------------------
INSERT INTO `p_article_category` VALUES ('2', '编程语言', '0', '2018-03-29 09:03:02.106516', '2018-03-29 09:03:02.106516', '0');
INSERT INTO `p_article_category` VALUES ('4', '编程语言', '0', '2018-03-29 09:03:08.218840', '2018-03-29 09:03:27.725532', '1');
INSERT INTO `p_article_category` VALUES ('6', 'PHP', '2', '2018-03-29 09:03:55.135356', '2018-03-29 09:19:13.158581', '0');
INSERT INTO `p_article_category` VALUES ('8', 'Python', '2', '2018-03-29 09:04:39.753479', '2018-03-29 09:04:39.753479', '0');
INSERT INTO `p_article_category` VALUES ('10', 'ces', '0', '2018-03-29 09:19:30.155889', '2018-03-29 09:21:17.468540', '1');
INSERT INTO `p_article_category` VALUES ('12', '数据库', '0', '2018-04-04 01:43:30.391681', '2018-04-04 01:43:30.391681', '0');
INSERT INTO `p_article_category` VALUES ('14', 'MySql', '12', '2018-04-04 01:43:49.384534', '2018-04-04 01:43:49.384534', '0');
INSERT INTO `p_article_category` VALUES ('16', '其他', '6', '2018-04-04 01:52:25.935696', '2018-04-04 07:51:46.286419', '0');
INSERT INTO `p_article_category` VALUES ('18', '其他', '16', '2018-04-04 01:52:34.528674', '2018-04-04 01:52:34.529698', '0');

-- ----------------------------
-- Table structure for p_article_comment
-- ----------------------------
DROP TABLE IF EXISTS `p_article_comment`;
CREATE TABLE `p_article_comment` (
  `article_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `user_type` smallint(5) unsigned NOT NULL,
  `comment_content` longtext NOT NULL,
  `reply_comment_id` int(10) unsigned NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `is_delete` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`article_comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_article_comment
-- ----------------------------
INSERT INTO `p_article_comment` VALUES ('2', '2', '72', '1', '一个评论', '0', '2018-03-22 14:11:04.000000', '0');
INSERT INTO `p_article_comment` VALUES ('4', '2', '72', '1', '回复一个评论', '2', '2018-03-23 03:24:03.092041', '0');
INSERT INTO `p_article_comment` VALUES ('6', '4', '72', '1', '再回复', '4', '2018-03-23 03:24:23.446373', '0');
INSERT INTO `p_article_comment` VALUES ('8', '2', '72', '1', 'huifu', '4', '2018-03-23 08:10:29.465709', '0');
INSERT INTO `p_article_comment` VALUES ('10', '4', '106', '2', '和热爱和任何体弱多病', '0', '2018-04-03 07:12:37.887963', '0');
INSERT INTO `p_article_comment` VALUES ('12', '4', '106', '2', '和热爱和任何体弱多病', '0', '2018-04-03 07:12:37.960028', '0');
INSERT INTO `p_article_comment` VALUES ('14', '4', '106', '2', '然后突然', '0', '2018-04-03 07:14:07.703921', '0');
INSERT INTO `p_article_comment` VALUES ('16', '4', '106', '2', '然后突然', '0', '2018-04-03 07:14:07.775987', '0');
INSERT INTO `p_article_comment` VALUES ('18', '4', '106', '2', '和人', '0', '2018-04-03 07:16:45.474015', '0');
INSERT INTO `p_article_comment` VALUES ('20', '4', '106', '2', 'won故意你的官邸', '10', '2018-04-04 02:47:27.166302', '0');
INSERT INTO `p_article_comment` VALUES ('22', '2', '86', '2', '额电饭锅 奋斗 ', '0', '2018-04-04 06:19:13.490885', '0');
INSERT INTO `p_article_comment` VALUES ('24', '2', '86', '2', '地方', '22', '2018-04-04 06:19:25.684615', '0');

-- ----------------------------
-- Table structure for p_download_record
-- ----------------------------
DROP TABLE IF EXISTS `p_download_record`;
CREATE TABLE `p_download_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `version` varchar(200) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_download_record
-- ----------------------------
INSERT INTO `p_download_record` VALUES ('2', '82', '1.0.0', '2018-04-03 09:36:35.844892');
INSERT INTO `p_download_record` VALUES ('4', '82', '1.0.0', '2018-04-03 09:37:56.380042');
INSERT INTO `p_download_record` VALUES ('6', '86', '1.0.0', '2018-04-03 09:40:23.559875');
INSERT INTO `p_download_record` VALUES ('8', '82', '1.0.1', '2018-04-03 09:59:06.545170');
INSERT INTO `p_download_record` VALUES ('10', '82', '1.0.0', '2018-04-03 09:59:09.751799');

-- ----------------------------
-- Table structure for p_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `p_friend_link`;
CREATE TABLE `p_friend_link` (
  `link_id` int(11) NOT NULL AUTO_INCREMENT,
  `link_name` varchar(50) NOT NULL,
  `link_url` varchar(200) NOT NULL,
  `link_icon` varchar(200) NOT NULL,
  `link_describe` varchar(200) NOT NULL,
  `is_delete` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `open_mode` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`link_id`),
  UNIQUE KEY `link_name` (`link_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_friend_link
-- ----------------------------
INSERT INTO `p_friend_link` VALUES ('2', 'ffffffffff', 'fasfsfsfsf', '/media/20180328/blue_20180328084909_730.png', 'fasfsfsafsa', '1', '0', '0', '2018-03-28 08:49:12.978088', '2018-03-28 08:49:12.978152');
INSERT INTO `p_friend_link` VALUES ('4', 'fsafafsdfs', 'fsafsfsafasfs', '/media/20180328/2FD1EA57E069526BC986960DF99AF371_20180328090243_934.png', 'fasfasfadsfsfsafsafsda', '1', '0', '0', '2018-03-28 09:02:46.859406', '2018-03-28 09:02:46.859525');
INSERT INTO `p_friend_link` VALUES ('6', '777', '7777', '/media/20180328/2FD1EA57E069526BC986960DF99AF371_20180328092502_536.png', '777', '1', '0', '1', '2018-03-28 09:25:05.180293', '2018-03-28 09:25:05.180391');
INSERT INTO `p_friend_link` VALUES ('8', 'eee', 'er', '/media/20180328/2FD1EA57E069526BC986960DF99AF371_20180328092730_430.png', 're', '1', '0', '1', '2018-03-28 09:27:36.551269', '2018-03-28 09:27:36.551361');
INSERT INTO `p_friend_link` VALUES ('10', 'fasdfsaf', 'sadfsfasfs', '/media/20180328/2FD1EA57E069526BC986960DF99AF371_20180328093341_562.png', 'fasdfsafsaf', '1', '0', '1', '2018-03-28 09:33:48.077500', '2018-03-28 09:33:48.077593');
INSERT INTO `p_friend_link` VALUES ('12', '111111', '11111', '/media/20180328/2FD1EA57E069526BC986960DF99AF371_20180328093416_343.png', '1231312412343124214', '1', '0', '1', '2018-03-28 09:34:22.728769', '2018-03-28 09:34:22.728862');
INSERT INTO `p_friend_link` VALUES ('14', '444', '4444', '', '456465', '1', '1', '1', '2018-03-28 10:02:03.949929', '2018-03-28 10:02:03.950015');
INSERT INTO `p_friend_link` VALUES ('16', '百度', 'http://www.baidu.com', '', 'baidu', '0', '0', '0', '2018-04-03 01:41:25.446711', '2018-04-03 01:41:25.446711');
INSERT INTO `p_friend_link` VALUES ('18', '新浪', 'http://www.sina.com.cn', '', '新浪', '0', '0', '1', '2018-04-03 01:42:28.089206', '2018-04-03 01:42:28.089206');
INSERT INTO `p_friend_link` VALUES ('20', '阿里', 'http://www.alibaba.com', '', '阿里', '0', '0', '1', '2018-04-04 01:42:19.429269', '2018-04-04 01:42:19.430270');

-- ----------------------------
-- Table structure for p_mail_record
-- ----------------------------
DROP TABLE IF EXISTS `p_mail_record`;
CREATE TABLE `p_mail_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(1000) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `content` varchar(5000) NOT NULL,
  `message` varchar(500) NOT NULL,
  `status` int(11) NOT NULL,
  `is_delete` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_mail_record
-- ----------------------------
INSERT INTO `p_mail_record` VALUES ('2', '669489469@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：149748', '', '1', '0', '2018-03-29 09:23:04.839095', '2018-03-29 09:23:04.839145');
INSERT INTO `p_mail_record` VALUES ('4', '568894449@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：505741', '', '1', '0', '2018-03-30 01:35:04.916754', '2018-03-30 01:35:04.916754');
INSERT INTO `p_mail_record` VALUES ('6', '429353924@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：193528', '', '1', '0', '2018-03-30 06:37:31.769455', '2018-03-30 06:37:31.769455');
INSERT INTO `p_mail_record` VALUES ('8', '429353924@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：351447', '', '1', '0', '2018-03-30 06:38:30.212832', '2018-03-30 06:38:30.212832');
INSERT INTO `p_mail_record` VALUES ('10', '263699065@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：609757', '', '1', '0', '2018-03-30 06:39:31.927433', '2018-03-30 06:39:31.927433');
INSERT INTO `p_mail_record` VALUES ('12', 'heyuanhua321@163.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：606923', '', '1', '0', '2018-04-02 01:27:00.794491', '2018-04-02 01:27:00.794647');
INSERT INTO `p_mail_record` VALUES ('14', '4239353924@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：705811', '', '2', '0', '2018-04-02 07:41:16.702127', '2018-04-02 07:41:16.702127');
INSERT INTO `p_mail_record` VALUES ('16', '4293353924@qq.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：928030', '', '2', '0', '2018-04-02 07:41:27.330456', '2018-04-02 07:41:27.330456');
INSERT INTO `p_mail_record` VALUES ('18', 'sclzzhanghaijun@163.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：894943', '', '1', '0', '2018-04-02 07:45:33.782031', '2018-04-02 07:45:33.782031');
INSERT INTO `p_mail_record` VALUES ('20', 'sclzzhanghaijun@163.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：545270', '', '1', '0', '2018-04-02 07:47:38.520159', '2018-04-02 07:47:38.520159');
INSERT INTO `p_mail_record` VALUES ('22', 'zhangtao_who@163.com', '邮箱用户注册验证码', '尊敬的用户您好，感谢您使用本网站，注册的验证码为：979461', '', '1', '0', '2018-04-03 01:17:13.566979', '2018-04-03 01:17:13.566979');

-- ----------------------------
-- Table structure for p_slide_category
-- ----------------------------
DROP TABLE IF EXISTS `p_slide_category`;
CREATE TABLE `p_slide_category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) NOT NULL,
  `category_identify` varchar(50) NOT NULL,
  `category_remark` varchar(200) NOT NULL,
  `is_delete` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_name` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_slide_category
-- ----------------------------
INSERT INTO `p_slide_category` VALUES ('30', '分', '1', '啊', '1', '2018-03-22 03:35:59.984541', '2018-03-28 06:00:01.031532');
INSERT INTO `p_slide_category` VALUES ('32', 'wankehui ', 'vank', 'justion', '0', '2018-03-22 03:48:30.832725', '2018-03-22 03:48:30.832783');
INSERT INTO `p_slide_category` VALUES ('34', '广告', 'advertising', '广告位', '0', '2018-03-26 01:59:13.164736', '2018-03-26 01:59:13.164835');
INSERT INTO `p_slide_category` VALUES ('36', '博迪', 'body', '比滴', '0', '2018-03-26 02:00:46.965051', '2018-03-26 02:00:46.965141');
INSERT INTO `p_slide_category` VALUES ('38', '情不禁', 'zxy', 'hongkong', '0', '2018-03-26 02:05:54.360936', '2018-03-26 02:05:54.361029');
INSERT INTO `p_slide_category` VALUES ('40', 'fasdfasfsa12321', '1fsafdsafsa11212', '31231fdsafsafsa1213', '1', '2018-03-28 02:22:19.434875', '2018-03-28 06:37:07.233377');
INSERT INTO `p_slide_category` VALUES ('42', 'fasfasfsfsdafsfsfasfdsaf', 'fsafsafsafafsafsafsaf', 'safsafsafsafsafsfasfdsafsafsaf', '1', '2018-03-28 02:32:12.600053', '2018-03-28 06:00:49.113623');
INSERT INTO `p_slide_category` VALUES ('44', '真情流露', 'zqll', 'zxy专辑', '1', '2018-03-28 06:38:57.327132', '2018-03-28 06:39:17.394273');
INSERT INTO `p_slide_category` VALUES ('46', '首页轮播', '首页轮播', '首页轮播', '0', '2018-04-04 01:39:30.257495', '2018-04-04 01:39:30.257495');

-- ----------------------------
-- Table structure for p_slide_manage
-- ----------------------------
DROP TABLE IF EXISTS `p_slide_manage`;
CREATE TABLE `p_slide_manage` (
  `slide_id` int(11) NOT NULL AUTO_INCREMENT,
  `slide_title` varchar(50) NOT NULL,
  `describe` varchar(200) NOT NULL,
  `is_delete` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `content` varchar(200) NOT NULL,
  `href_url` varchar(200) NOT NULL,
  `picture_url` varchar(200) NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`slide_id`),
  UNIQUE KEY `manage_title` (`slide_title`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_slide_manage
-- ----------------------------
INSERT INTO `p_slide_manage` VALUES ('2', 'fasfsaf', 'fasfsadfadsf', '1', '0', '2018-03-22 08:45:50.939845', '2018-03-22 08:45:50.940586', 'fasfsadfsafsf', '', '', '32');
INSERT INTO `p_slide_manage` VALUES ('16', '反反复复', 'fasfasfas', '1', '1', '2018-03-23 07:30:30.682805', '2018-03-26 01:23:19.000000', 'fsafsafsafsdf发发fasfsdfas', '', '/media/WechatIMG643_20180326012317_353.jpeg', '30');
INSERT INTO `p_slide_manage` VALUES ('18', '万客会11111', 'dog111', '0', '1', '2018-03-23 07:31:23.240322', '2018-03-26 01:31:56.000000', '狗111', 'http://www.baidu.com', '/media/2FD1EA57E069526BC986960DF99AF371_20180326013132_490.png', '32');
INSERT INTO `p_slide_manage` VALUES ('22', '呵呵哒111', 'made111', '1', '1', '2018-03-23 07:37:43.915329', '2018-03-26 01:06:25.000000', 'fafsad111', '', '/media/timg_20180326010615_960.jpeg', '30');
INSERT INTO `p_slide_manage` VALUES ('24', '一修哥110', '1', '1', '1', '2018-03-23 07:49:55.551676', '2018-03-26 01:20:21.000000', '坦', 'www.mamase.com1', '/media/hui_20180326011856_467.png', '32');
INSERT INTO `p_slide_manage` VALUES ('26', '草榴', '乌鸦', '1', '0', '2018-03-28 06:09:38.574452', '2018-03-28 06:09:38.574528', '枯藤老树昏鸦', '', '/media/u=378000905,1229646585&fm=170&s=AAB14C81020407530C147DB703001002&w=344&h=183&img_20180328060922_992.GIF', '34');
INSERT INTO `p_slide_manage` VALUES ('34', 'zxy', 'jackey', '0', '0', '2018-03-28 06:11:10.748938', '2018-03-28 06:11:10.748994', 'zxy', 'http://www.baidu.com', '/media/b21c8701a18b87d6352b9dda070828381e30fd8d.jpg_20180328061051_200.gif', '38');
INSERT INTO `p_slide_manage` VALUES ('36', 'body', 'swift', '0', '0', '2018-03-28 06:17:32.297230', '2018-03-28 06:17:32.297336', 'swift study', 'http://www.youku.com', '/media/Demo_20180328061710_194.gif', '36');
INSERT INTO `p_slide_manage` VALUES ('40', '任何人不得靠近桌子', '任何人不得靠近桌子,更不能动桌上的牌', '0', '0', '2018-03-28 06:33:29.917798', '2018-03-28 06:33:29.917879', '后果不堪设想', 'http://www.renheren', '/media/1522206883_305321_20180328063246_121.png', '32');
INSERT INTO `p_slide_manage` VALUES ('42', '大渣好，我是焦皮', 'xfdsfa', '0', '0', '2018-04-04 01:40:40.945460', '2018-04-04 01:40:40.945460', 'fdsafsdf', 'https://v.qq.com/x/page/g03683lwiqy.html', '/media/20180409/cf1b9d16fdfaaf519528abf5875494eef11f7ab4_20180409064604_436.jpg', '32');

-- ----------------------------
-- Table structure for p_system_menu
-- ----------------------------
DROP TABLE IF EXISTS `p_system_menu`;
CREATE TABLE `p_system_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(50) NOT NULL,
  `m_pid` int(11) NOT NULL,
  `menu_type` int(11) unsigned DEFAULT '0',
  `menu_status` int(11) NOT NULL,
  `is_delete` int(11) unsigned DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `default_route` varchar(10) NOT NULL,
  `permission_route` varchar(1000) NOT NULL,
  `menu_description` varchar(1000) NOT NULL,
  `menu_icon` varchar(20) NOT NULL,
  `sort` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_system_menu
-- ----------------------------
INSERT INTO `p_system_menu` VALUES ('2', '全站统计', '0', '2', '0', '0', '2018-03-20 07:42:32', '2018-03-28 16:23:30', '6', '6', '版本备注主要记录本系统版本的日志信息', 'icon-list', '0');
INSERT INTO `p_system_menu` VALUES ('4', '系统管理', '0', '1', '0', '0', '2018-03-20 07:44:33', '2018-03-28 16:23:31', '', '', '系统管理主要是对数据系统菜单和路由等进行管理', 'icon-cog', '0');
INSERT INTO `p_system_menu` VALUES ('6', '系统配置', '4', '2', '0', '0', '2018-03-20 07:45:04', '2018-03-27 03:36:03', '14', '14', '系统配置', '', '0');
INSERT INTO `p_system_menu` VALUES ('8', '菜单管理', '4', '2', '0', '0', '2018-03-20 07:45:35', '2018-03-28 16:23:34', '10', '10|12|28|30', '菜单管理', '', '0');
INSERT INTO `p_system_menu` VALUES ('10', '路由管理', '4', '2', '0', '0', '2018-03-20 07:46:06', '2018-03-27 03:36:10', '16', '16|18', '路由管理', '', '0');
INSERT INTO `p_system_menu` VALUES ('12', '用户管理', '0', '1', '0', '0', '2018-03-20 08:47:28', '2018-03-20 08:47:28', '', '', '用户管理', 'icon-user', '0');
INSERT INTO `p_system_menu` VALUES ('14', '文章管理', '0', '1', '0', '0', '2018-03-20 08:56:50', '2018-03-27 03:36:34', '', '', '文章相关管理', 'icon-embed2', '0');
INSERT INTO `p_system_menu` VALUES ('16', '文章分类', '14', '2', '0', '0', '2018-03-20 08:57:20', '2018-03-27 03:36:37', '32', '32', '文章分类', '', '0');
INSERT INTO `p_system_menu` VALUES ('18', '文章管理', '14', '2', '0', '0', '2018-03-20 08:57:44', '2018-03-27 03:36:40', '22', '22|24|130', '文章管理', '', '0');
INSERT INTO `p_system_menu` VALUES ('20', '扩展管理', '0', '1', '0', '0', '2018-03-20 08:58:42', '2018-03-27 03:36:44', '', '', '扩展管理', 'icon-power-cord', '0');
INSERT INTO `p_system_menu` VALUES ('22', '轮播分类', '20', '2', '0', '0', '2018-03-20 08:59:15', '2018-03-27 03:36:17', '38', '38|40', '轮播分类', '', '0');
INSERT INTO `p_system_menu` VALUES ('24', '管理用户', '12', '2', '0', '0', '2018-03-20 09:06:20', '2018-03-27 03:36:25', '96', '96', '管理用户', '', '0');
INSERT INTO `p_system_menu` VALUES ('26', '管理人员', '12', '2', '0', '0', '2018-03-20 09:38:38', '2018-03-27 03:36:28', '8', '8', '管理人员', '', '0');
INSERT INTO `p_system_menu` VALUES ('28', '管理组', '12', '2', '0', '0', '2018-03-22 09:13:46', '2018-03-27 03:36:31', '98', '98|108', '后台用户管理组', '', '0');
INSERT INTO `p_system_menu` VALUES ('30', '轮播管理', '20', '2', '0', '0', '2018-03-22 01:20:36', '2018-03-27 03:36:20', '110', '110', '轮播管理', '', '0');
INSERT INTO `p_system_menu` VALUES ('32', '其他设置', '36', '2', '0', '1', '2018-03-27 01:36:39', '2018-03-27 07:37:50', '14', '2|6|10|14', '其他设置', '', '0');
INSERT INTO `p_system_menu` VALUES ('34', '幅度萨芬', '4', '2', '0', '1', '2018-03-27 01:45:50', '2018-03-27 10:17:45', '108', '98|108', '发士大夫撒', '', '0');
INSERT INTO `p_system_menu` VALUES ('36', '其他信息', '0', '1', '0', '1', '2018-03-27 02:48:47', '2018-03-27 07:37:53', '', '', '房贷发放', '', '0');
INSERT INTO `p_system_menu` VALUES ('38', '地方', '36', '2', '0', '1', '2018-03-27 02:49:32', '2018-03-27 07:37:47', '', '', '幅度萨芬', '', '0');
INSERT INTO `p_system_menu` VALUES ('40', 'fdsf', '36', '2', '0', '1', '2018-03-27 03:22:57', '2018-03-27 07:37:34', '30', '26|30|34|38', 'fdsafdsafsa', '', '10');
INSERT INTO `p_system_menu` VALUES ('42', 'fdsaf', '36', '2', '0', '1', '2018-03-27 03:24:31', '2018-03-27 07:37:12', '24', '18|24|28|32', 'fdsafsdaf', '', '20');
INSERT INTO `p_system_menu` VALUES ('44', 'rewrf', '36', '2', '0', '1', '2018-03-27 03:25:22', '2018-03-27 07:37:42', '', '', 'fdsafdsaf', '', '0');
INSERT INTO `p_system_menu` VALUES ('46', 'fdsaf', '36', '2', '0', '1', '2018-03-27 03:26:08', '2018-03-27 07:37:39', '24', '18|24|28|32', 'ewrqewrff', '', '0');
INSERT INTO `p_system_menu` VALUES ('48', 'rewrefds', '36', '2', '0', '1', '2018-03-27 03:26:31', '2018-03-27 07:37:36', '26', '22|26', 'fdsfdsa', '', '0');
INSERT INTO `p_system_menu` VALUES ('50', '阿凡达', '0', '1', '0', '1', '2018-03-27 09:33:21', '2018-03-28 00:30:41', '', '', '啊幅度萨芬范德萨分', '', '0');
INSERT INTO `p_system_menu` VALUES ('52', '友情链接', '20', '2', '0', '0', '2018-03-28 06:44:28', '2018-03-28 06:44:28', '156', '156', '友情链接', '', '0');
INSERT INTO `p_system_menu` VALUES ('54', '话题管理', '20', '2', '0', '0', '2018-03-29 03:08:53', '2018-03-29 03:08:53', '166', '166|170|168|172', '话题管理', '', '0');

-- ----------------------------
-- Table structure for p_system_route
-- ----------------------------
DROP TABLE IF EXISTS `p_system_route`;
CREATE TABLE `p_system_route` (
  `route_id` int(11) NOT NULL AUTO_INCREMENT,
  `route_name` varchar(50) NOT NULL,
  `route_alias_name` varchar(50) NOT NULL,
  `is_delete` int(11) unsigned DEFAULT '0' COMMENT '是否删除 0：否  1：是',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`route_id`),
  UNIQUE KEY `route_name` (`route_name`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_system_route
-- ----------------------------
INSERT INTO `p_system_route` VALUES ('2', 'admin_index', '后台首页', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('4', 'admin_main', '后台主页', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('6', 'admin_info', '帮助信息', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('8', 'user_list', '用户列表', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('10', 'menu_list', '菜单列表', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('12', 'menu_add', '添加菜单', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('14', 'set_config', '设置配置', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('16', 'route_set', '路由配置', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('18', 'merge_route', '路由合并', '0', '2018-03-19 09:13:49', '2018-03-19 09:13:49');
INSERT INTO `p_system_route` VALUES ('20', 'article_lists', '文章管理', '1', '2018-03-19 09:45:48', '2018-03-20 06:26:14');
INSERT INTO `p_system_route` VALUES ('22', 'article_list', '文章管理', '0', '2018-03-20 06:26:14', '2018-03-20 06:26:14');
INSERT INTO `p_system_route` VALUES ('24', 'article_add', '文章添加', '0', '2018-03-20 06:26:14', '2018-03-20 06:26:14');
INSERT INTO `p_system_route` VALUES ('26', 'slide_category', '轮播分类', '0', '2018-03-20 06:26:14', '2018-03-20 09:15:56');
INSERT INTO `p_system_route` VALUES ('28', 'menu_delete', '删除菜单', '0', '2018-03-20 08:45:19', '2018-03-20 08:45:19');
INSERT INTO `p_system_route` VALUES ('30', 'menu_edit', '修改菜单', '0', '2018-03-20 08:45:19', '2018-03-20 08:45:19');
INSERT INTO `p_system_route` VALUES ('32', 'article_category', '文章分类', '0', '2018-03-20 08:45:19', '2018-03-20 08:45:19');
INSERT INTO `p_system_route` VALUES ('34', 'register_user', '添加用户', '0', '2018-03-20 09:05:25', '2018-03-20 10:01:08');
INSERT INTO `p_system_route` VALUES ('36', 'add_article_category', '添加分类', '0', '2018-03-20 09:05:25', '2018-03-20 09:05:25');
INSERT INTO `p_system_route` VALUES ('38', 'slide_category_list', '轮播分类列表', '0', '2018-03-20 09:15:56', '2018-03-20 10:01:08');
INSERT INTO `p_system_route` VALUES ('40', 'slide_add_category', '添加轮播分类', '0', '2018-03-20 09:15:56', '2018-03-20 10:01:08');
INSERT INTO `p_system_route` VALUES ('86', 'admin_user_edit', '编辑后台用户', '0', '2018-03-20 09:37:09', '2018-03-20 09:37:09');
INSERT INTO `p_system_route` VALUES ('88', 'admin_user_add', '添加后台用户', '0', '2018-03-20 09:37:09', '2018-03-20 09:37:09');
INSERT INTO `p_system_route` VALUES ('90', 'admin_user_delete', '删除后台用户', '0', '2018-03-20 09:37:09', '2018-03-20 09:37:09');
INSERT INTO `p_system_route` VALUES ('92', 'admin_user_change_password', '修改后台用户密码', '0', '2018-03-20 09:37:09', '2018-03-20 09:37:09');
INSERT INTO `p_system_route` VALUES ('94', 'user_manager', '用户管理', '0', '2018-03-21 01:56:12', '2018-03-21 01:56:12');
INSERT INTO `p_system_route` VALUES ('96', 'manager_user', '管理用户', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('98', 'admin_group_list', '管理员组列表', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('100', 'add_category', '添加分类', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('102', 'category_delete', '删除分类', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('104', 'slide_delete_category', '删除轮播分类', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('106', 'slide_edit_category', '编辑轮播分类', '0', '2018-03-21 02:02:07', '2018-03-21 02:02:07');
INSERT INTO `p_system_route` VALUES ('108', 'admin_group_add', '管理员组添加', '0', '2018-03-21 13:57:01', '2018-03-21 13:57:01');
INSERT INTO `p_system_route` VALUES ('110', 'slide_manage_list', '轮播管理列表', '0', '2018-03-22 09:25:19', '2018-03-22 09:25:19');
INSERT INTO `p_system_route` VALUES ('114', 'admin_group_edit', '管理员组修改', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('116', 'admin_group_del', '管理员组删除', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('118', 'user_detail', '用户详情', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('120', 'user_reset_pwd', '重置用户密码', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('122', 'user_state_change', '设置用户状态', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('124', 'user_delete', '删除用户', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('126', 'article_edit', '编辑文章', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('128', 'article_delete', '删除文章', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('130', 'article_lists_data', '文章列表', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('132', 'article_comment_list', '评论列表', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('134', 'article_comment_list_data', '评论列表数据', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('136', 'article_comment_delete', '删除评论', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('138', 'slide_manage_add', '轮播管理添加', '0', '2018-03-23 01:28:31', '2018-03-23 01:28:31');
INSERT INTO `p_system_route` VALUES ('140', 'admin_user_detail', '查看后台用户', '0', '2018-03-23 01:30:54', '2018-03-23 01:30:54');
INSERT INTO `p_system_route` VALUES ('142', 'user_list_data', '用户列表', '0', '2018-03-23 06:13:46', '2018-03-23 06:13:46');
INSERT INTO `p_system_route` VALUES ('144', 'admin_user_list', '获取用户列表', '0', '2018-03-23 08:01:30', '2018-03-23 08:01:30');
INSERT INTO `p_system_route` VALUES ('146', 'admin_group_permission', '管理员组权限', '0', '2018-03-27 06:10:55', '2018-03-27 06:10:55');
INSERT INTO `p_system_route` VALUES ('148', 'add_comment', '回复评论', '0', '2018-03-27 06:10:55', '2018-03-27 06:10:55');
INSERT INTO `p_system_route` VALUES ('150', 'slide_manage_delete', '轮播管理删除', '0', '2018-03-27 06:10:55', '2018-03-27 06:10:55');
INSERT INTO `p_system_route` VALUES ('152', 'slide_manage_edit', '轮播管理删除', '0', '2018-03-27 06:10:55', '2018-03-27 06:10:55');
INSERT INTO `p_system_route` VALUES ('154', 'slide_manage_status', '轮播管理状态', '0', '2018-03-27 06:10:55', '2018-03-27 06:10:55');
INSERT INTO `p_system_route` VALUES ('156', 'friend_link_list', '友情链接列表', '0', '2018-03-28 06:43:57', '2018-03-28 06:43:57');
INSERT INTO `p_system_route` VALUES ('158', 'friend_link_add', '友情链接添加', '0', '2018-03-29 03:08:25', '2018-03-29 03:08:25');
INSERT INTO `p_system_route` VALUES ('160', 'friend_link_delete', '友情链接删除', '0', '2018-03-29 03:08:25', '2018-03-29 03:08:25');
INSERT INTO `p_system_route` VALUES ('162', 'friend_link_edit', '友情链接编辑', '0', '2018-03-29 03:08:25', '2018-03-29 03:08:25');
INSERT INTO `p_system_route` VALUES ('164', 'friend_link_status', '友情链接状态', '0', '2018-03-29 03:08:25', '2018-03-29 03:08:25');
INSERT INTO `p_system_route` VALUES ('166', 'topic_manage_list', '话题列表', '0', '2018-03-29 13:54:03', '2018-03-29 13:54:03');
INSERT INTO `p_system_route` VALUES ('168', 'topic_manage_add', '话题添加', '0', '2018-03-29 13:54:06', '2018-03-29 13:54:06');
INSERT INTO `p_system_route` VALUES ('170', 'topic_manage_delete', '话题删除', '0', '2018-03-29 13:54:09', '2018-03-29 13:54:09');
INSERT INTO `p_system_route` VALUES ('172', 'topic_manage_edit', '话题编辑', '0', '2018-03-29 13:54:15', '2018-03-29 13:54:15');

-- ----------------------------
-- Table structure for p_topic
-- ----------------------------
DROP TABLE IF EXISTS `p_topic`;
CREATE TABLE `p_topic` (
  `topic_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `topic_title` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `view_num` int(10) unsigned NOT NULL,
  `comment_num` int(10) unsigned NOT NULL,
  `is_delete` int(11) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `user_type` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`topic_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_topic
-- ----------------------------
INSERT INTO `p_topic` VALUES ('2', '1', '发送', '<p>发发发顺丰</p>', '0', '0', '0', '2018-03-29 08:47:10.337572', '2018-03-29 08:47:10.337691', '1');
INSERT INTO `p_topic` VALUES ('4', '1', '乌鸦哥请我去吃饭，我该怎么办，在线等。。。。。。', '<p style=\"text-align:center\"><br/></p><p style=\"text-align:center\"><img src=\"/media/20180404/u=1411556780,2847772026&fm=27&gp=0_20180404054252_340.jpg\" title=\"u=1411556780,2847772026&amp;fm=27&amp;gp=0.jpg\" alt=\"u=1411556780,2847772026&amp;fm=27&amp;gp=0.jpg\" width=\"257\" height=\"211\"/></p><p style=\"text-align: center;\"><span style=\"text-decoration: underline; font-family: &quot;comic sans ms&quot;; color: rgb(0, 112, 192);\">乌鸦哥约我这周末去吃饭，他请客，TMD关键是吃不饱哇。。。</span></p><p style=\"text-align: center;\"><span style=\"text-decoration: underline; text-align: center; font-family: &quot;comic sans ms&quot;; color: rgb(0, 112, 192);\">乌鸦哥约我这周末去吃饭，他请客，TMD关键是吃不饱哇。。。</span></p><p style=\"text-align: center;\"><span style=\"text-align: center; text-decoration: underline; font-family: &quot;comic sans ms&quot;; color: rgb(0, 112, 192);\">乌鸦哥约我这周末去吃饭，他请客，TMD关键是吃不饱哇。。。</span></p><p style=\"text-align: center;\"><span style=\"text-align: center; text-decoration: underline; font-family: &quot;comic sans ms&quot;; color: rgb(0, 112, 192);\">乌鸦哥约我这周末去吃饭，他请客，TMD关键是吃不饱哇。。。</span></p><p style=\"text-align: center;\"><span style=\"text-align: center; text-decoration: underline; font-family: &quot;comic sans ms&quot;; color: rgb(0, 112, 192);\">乌鸦哥约我这周末去吃饭，他请客，TMD关键是吃不饱哇。。。</span></p><p><br/></p><p style=\"text-align: center;\"><br/></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; 别说我冤枉他，我录了DV的，后来被拍成电影了。。。。。。<br/></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style=\"color: rgb(255, 0, 0);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-----------------------太狠了-------------------</span><br/></p><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br/></p><p><br/></p><p><br/></p>', '0', '0', '0', '2018-03-29 08:53:49.367181', '2018-03-29 08:53:49.367272', '1');
INSERT INTO `p_topic` VALUES ('6', '100', '床前明月光，\n疑是地上霜。\n举头望明月，\n低头思故乡。', '<p>fafadsdffdasfsafasfasfasf</p>', '0', '0', '0', '2018-04-04 11:47:37.000000', '2018-04-04 11:47:39.000000', '2');
INSERT INTO `p_topic` VALUES ('8', '0', '第二次世界大战', '<p>生灵涂炭，民不聊生</p>', '0', '0', '1', '2018-04-04 07:18:19.267700', '2018-04-04 07:25:53.040321', '1');
INSERT INTO `p_topic` VALUES ('10', '0', '1111', '<p>1111</p>', '0', '0', '1', '2018-04-04 07:22:12.424413', '2018-04-04 07:22:30.347573', '1');
INSERT INTO `p_topic` VALUES ('12', '1', '发生的发顺丰倒萨', '<p>发送法萨芬撒飞洒的</p>', '0', '0', '0', '2018-04-04 07:26:04.120884', '2018-04-04 07:26:04.120946', '1');
INSERT INTO `p_topic` VALUES ('14', '1', '发送方大师发多少', '<p>法法师法是飞洒</p>', '0', '0', '0', '2018-04-04 07:27:50.974989', '2018-04-04 07:27:50.975084', '1');
INSERT INTO `p_topic` VALUES ('16', '102', 'xxoo', '<p>xxooooo</p>', '0', '0', '0', '2018-04-08 01:59:46.741783', '2018-04-08 01:59:46.741838', '2');

-- ----------------------------
-- Table structure for p_topic_comment
-- ----------------------------
DROP TABLE IF EXISTS `p_topic_comment`;
CREATE TABLE `p_topic_comment` (
  `topic_comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `topic_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `comment_content` longtext NOT NULL,
  `reply_comment_id` int(10) unsigned NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` smallint(5) unsigned NOT NULL,
  `user_type` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`topic_comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_topic_comment
-- ----------------------------
INSERT INTO `p_topic_comment` VALUES ('2', '2', '88', 'fuck you ', '0', '2018-03-22 15:14:15.000000', '2018-03-30 08:23:28.395089', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('4', '4', '1', 'caocao', '0', '2018-03-23 15:26:00.000000', '2018-03-23 15:26:04.000000', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('6', '4', '84', 'nb', '0', '2018-03-23 16:24:41.000000', '2018-03-30 08:25:55.833619', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('8', '2', '1', 'DAFFSDFAS', '0', '2018-03-30 09:29:24.711175', '2018-03-30 09:29:24.711344', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('10', '2', '1', 'FASFASFAS', '0', '2018-03-30 17:37:03.000000', '2018-03-30 17:37:06.000000', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('12', '4', '72', 'fddasff234234', '0', '2018-03-30 17:38:30.000000', '2018-03-30 17:38:33.000000', '1', '2');
INSERT INTO `p_topic_comment` VALUES ('14', '4', '100', '我是铜锣湾的扛把子，死乌鸦！！！', '0', '2018-04-02 09:31:05.000000', '2018-04-02 09:31:09.000000', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('16', '4', '1', '陈浩南，给老子跪下，老子是你老大，蒋天生', '0', '2018-04-01 09:34:23.000000', '2018-04-01 09:34:32.000000', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('28', '4', '1', '乌鸦', '16', '2018-04-02 02:21:30.019549', '2018-04-02 02:21:52.827871', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('30', '4', '1', '妈的fucker', '4', '2018-04-02 06:41:13.765014', '2018-04-02 06:41:13.765312', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('34', '4', '1', '安抚范德萨发', '4', '2018-04-02 06:48:40.819320', '2018-04-02 06:48:40.819417', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('36', '4', '1', '发送发送法萨芬撒飞洒发||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||', '6', '2018-04-02 06:49:57.826879', '2018-04-02 06:49:57.826976', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('38', '4', '1', '我命由我不由天！！！！---张君宝', '6', '2018-04-02 06:53:12.493289', '2018-04-02 06:53:12.493386', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('40', '4', '102', '跟着乌鸦哥从来没有吃过饱饭', '0', '2018-04-01 14:56:02.000000', '2018-04-01 14:56:07.000000', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('42', '4', '1', '所以说下次乌鸦哥请吃饭一定要提前吃饱', '40', '2018-04-02 06:57:52.262613', '2018-04-02 06:57:52.262713', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('44', '2', '1', 'what fuck are you say???', '2', '2018-04-02 07:18:18.633076', '2018-04-02 07:18:18.633182', '0', '1');
INSERT INTO `p_topic_comment` VALUES ('46', '2', '1', '<p>fasdffdsafasdfdasfasdf</p>', '0', '2018-04-04 01:07:33.753552', '2018-04-04 01:07:33.754456', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('48', '2', '1', '<p>fasffsafafasfasfasdfa</p>', '0', '2018-04-04 01:09:45.137516', '2018-04-04 01:09:45.138461', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('50', '2', '102', '<p>fafaf</p>', '0', '2018-04-04 01:18:02.774726', '2018-04-04 01:18:02.774782', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('52', '6', '102', '<p>fasfasdsafsafdsfdsa</p>', '0', '2018-04-04 01:40:28.684852', '2018-04-04 01:40:28.684909', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('54', '6', '102', '<p>fasfafasfd</p>', '0', '2018-04-04 01:46:53.368417', '2018-04-04 01:46:53.368469', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('56', '6', '102', '<p><img src=\"/media/20180404/2FD1EA57E069526BC986960DF99AF371_20180404014706_810.png\" title=\"\" alt=\"2FD1EA57E069526BC986960DF99AF371.png\"/></p>', '0', '2018-04-04 01:47:07.104404', '2018-04-04 01:47:07.104455', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('58', '6', '102', '<p>fasfasfasfas</p>', '0', '2018-04-04 01:52:14.906372', '2018-04-04 01:52:14.906470', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('60', '6', '102', '', '0', '2018-04-04 01:55:24.317395', '2018-04-04 01:55:24.317452', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('62', '6', '102', '<p>AFDSAF</p>', '0', '2018-04-04 01:57:46.613223', '2018-04-04 01:57:46.613289', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('64', '6', '102', '<p>FGASFSAFSDAF</p>', '0', '2018-04-04 01:58:15.056657', '2018-04-04 01:58:15.056745', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('66', '6', '102', '<p style=\"white-space: normal;\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 静夜思<br/></p><blockquote style=\"white-space: normal;\"><ol class=\" list-paddingleft-2\" style=\"width: 816.047px;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-alpha;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-roman;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: upper-alpha;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: upper-roman;\"><ol class=\"custom_num list-paddingleft-1\" style=\"list-style-type: upper-roman;\"><ol class=\" list-paddingleft-3\" style=\"width: 599.844px;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-alpha;\"><ol class=\" list-paddingleft-2\" style=\"width: 541.344px;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-alpha;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-roman;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: upper-alpha;\"><li><p><span style=\"color: rgb(227, 108, 9);\"><em>床前明月光，</em></span></p></li></ol></ol><ol class=\" list-paddingleft-2\" style=\"width: 488.547px;\"><ol class=\" list-paddingleft-2\" style=\"list-style-type: lower-alpha;\"><li><p><span style=\"color: rgb(227, 108, 9);\"><em>疑是地上霜</em></span></p></li><li><p><span style=\"color: rgb(227, 108, 9);\"><em>举头望明月</em></span></p></li><li><p><span style=\"color: rgb(227, 108, 9);\"><em>低头思故乡。，。</em></span></p></li></ol></ol></ol></ol></ol></ol></ol></ol></ol></ol></ol></ol></blockquote><p style=\"white-space: normal; text-align: center;\"><em><span style=\"color: rgb(227, 108, 9);\"><img src=\"http://127.0.0.1:8000/media/20180404/b21c8701a18b87d6352b9dda070828381e30fd8d.jpg_20180404020031_320.gif\" title=\"\" alt=\"b21c8701a18b87d6352b9dda070828381e30fd8d.jpg.gif\" width=\"184\" height=\"96\"/></span></em></p><p><br/></p>', '0', '2018-04-04 02:02:24.954771', '2018-04-04 02:02:24.954856', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('68', '6', '102', 'fafasffasfads', '58', '2018-04-04 03:34:58.307252', '2018-04-04 03:34:58.307369', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('70', '4', '102', '不把我蒋天养放在眼里，你他妈的找死！！！！！！', '14', '2018-04-04 03:36:09.419933', '2018-04-04 03:36:09.420020', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('72', '4', '102', '我是郑浩南。。。', '14', '2018-04-04 05:29:52.661486', '2018-04-04 05:29:52.661538', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('74', '4', '102', '上次乌鸦哥请吃饭，还没开始动筷子，就掀桌子。。。不说了，吃饭去了', '40', '2018-04-04 05:33:53.152694', '2018-04-04 05:33:53.152787', '0', '2');
INSERT INTO `p_topic_comment` VALUES ('78', '4', '102', '<p style=\"text-align: left;\"><span style=\"background-color: rgb(227, 108, 9);\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我山鸡不是吃素的&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<sub><span style=\"background-color: rgb(227, 108, 9); color: rgb(253, 234, 218);\"></span></sub></span></p>', '0', '2018-04-04 06:25:05.747363', '2018-04-04 06:25:05.747410', '0', '2');

-- ----------------------------
-- Table structure for p_users
-- ----------------------------
DROP TABLE IF EXISTS `p_users`;
CREATE TABLE `p_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(120) NOT NULL,
  `password` varchar(128) NOT NULL,
  `nickname` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `phone` varchar(11) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `login_ip` varchar(50) DEFAULT NULL,
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) DEFAULT '0',
  `is_active` smallint(5) unsigned NOT NULL,
  `avatar` varchar(128) DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of p_users
-- ----------------------------
INSERT INTO `p_users` VALUES ('72', 'yuanhao', 'pbkdf2_sha256$100000$FMFem7okmbzX$medxXsuGYG6iOMCD1wxEXy1UoxtiHYv0+UPM3XcKGZk=', '袁浩', 'male', '15100000000', '1qq@163.com', '2018-03-27 07:56:37.084052', '0.0.0.0', '2018-03-27 07:56:37', '0', '0', '');
INSERT INTO `p_users` VALUES ('74', 'yuanhao1', 'pbkdf2_sha256$100000$L0vd8syvH8nk$T3M4TryA3+uzWwz2Jsay40I9P0AKIwssgU/xkJ3nOm0=', '袁浩', 'female', '15111111112', '2qq@163.com', '2018-03-27 09:12:54.416739', '0.0.0.0', '2018-03-27 09:12:54', '0', '0', '');
INSERT INTO `p_users` VALUES ('76', 'yuanhao2', 'pbkdf2_sha256$100000$teWVEL1IjHj5$MKTijBsyrW+TBtSZS97MaQcQ0lVfx9hIBalCPfCiuvg=', '袁浩', 'female', '15111111112', '3qq@163.com', '2018-03-27 09:13:29.682539', '0.0.0.0', '2018-03-27 09:13:30', '0', '0', '');
INSERT INTO `p_users` VALUES ('78', 'yuanhao3', 'pbkdf2_sha256$100000$wNGwj4wDGLH8$G3NfmV0BEOeJsDEFEYNQbNki5oTP4GlDaUKvzuKRYeQ=', '袁浩', 'female', '15111111111', '4qq@163.com', '2018-03-27 09:13:57.648306', '0.0.0.0', '2018-03-27 09:13:58', '0', '0', '');
INSERT INTO `p_users` VALUES ('80', 'yuanhao4', 'pbkdf2_sha256$100000$zewL5faMhhAO$uz0ELjq/OlB0joJHw9qUFLuC2+4irjyh1fTj/rqtoz8=', '袁浩', 'female', '15111111111', '5qq@163.com', '2018-03-27 09:19:13.156351', '0.0.0.0', '2018-03-27 09:19:13', '0', '0', '');
INSERT INTO `p_users` VALUES ('82', '429353924@qq.com', 'pbkdf2_sha256$100000$123456$Z2Qb/QzAMpvNVmXc8A8GFiSDcPWodgaKGBRMlrw6X4g=', '我是小白', 'female', 'None', '429353924@qq.com', '2018-03-30 09:22:09.024071', '0.0.0.0', '2018-03-29 07:30:10', '0', '0', '');
INSERT INTO `p_users` VALUES ('84', '669489469@qq.com', 'pbkdf2_sha256$100000$5gAHFpc4BmoG$/dAmVoKxBZcfTpDQzUw5bkYArv+1BvBuqOdyo58j6Q8=', '我是小白', 'female', null, '669489469@qq.com', '2018-03-29 09:23:29.937603', '0.0.0.0', '2018-03-29 09:23:30', '0', '0', '');
INSERT INTO `p_users` VALUES ('86', '568894449@qq.com', 'pbkdf2_sha256$100000$FaMyz8mevwfZ$UyETQ7OJtp5KNU5U5QZ52xChzTHBOSqRzDXgFrQTKxc=', '我是小白', 'female', null, '568894449@qq.com', '2018-03-30 01:35:23.586365', '0.0.0.0', '2018-03-30 01:35:24', '0', '0', '');
INSERT INTO `p_users` VALUES ('88', '263699065@qq.com', 'pbkdf2_sha256$100000$m6FwlVQ2wiw4$sEObaYiDxsvCheTSZEApnm+d8P0SVchkn2/srwrtjaA=', '我是小白', 'female', null, '263699065@qq.com', '2018-03-30 06:40:11.452502', '0.0.0.0', '2018-03-30 06:40:11', '0', '0', '');
INSERT INTO `p_users` VALUES ('90', 'heyuanhua321@163.com', 'pbkdf2_sha256$100000$h0w4Jhj8M9dX$JAwvSJ8ZR5Wa4Im9p+a9kDFAeEVMJcP2YXd0mNaYkwc=', '我是小白', 'female', null, 'heyuanhua321@163.com', '2018-04-02 01:27:57.989943', '0.0.0.0', '2018-04-02 01:27:58', '0', '0', '');
INSERT INTO `p_users` VALUES ('92', '陈浩南', 'pbkdf2_sha256$100000$N91p2ED4pHnT$ZjVCNrwHiNFhLCJRhWVGSj8tq9Tec2HGmOUWbjA0rvY=', '扛把子', 'male', '15198000000', 'chenhaonan@hongkong.com', '2018-04-02 01:29:34.591287', '0.0.0.0', '2018-04-02 01:29:35', '0', '0', '');
INSERT INTO `p_users` VALUES ('94', '陈浩南', 'pbkdf2_sha256$100000$jAq4Tzu21j7g$ZhV734ouqEg1xNTDzAVAuINMytUPbP16SSJ7OroseK4=', '扛把子', 'male', '15198000000', 'chenhaonan@hongkong.com', '2018-04-02 01:29:38.881625', '0.0.0.0', '2018-04-02 01:29:39', '0', '0', '');
INSERT INTO `p_users` VALUES ('96', '陈浩南', 'pbkdf2_sha256$100000$LpCdh4rxawTF$KSbhRZURRS6iupXQtr7t7L1E+L7PJ5OmmFnXJNnOptc=', '扛把子', 'male', '15198000000', 'chenhaonan@hongkong.com', '2018-04-02 01:29:41.379260', '0.0.0.0', '2018-04-02 01:29:41', '0', '0', '');
INSERT INTO `p_users` VALUES ('98', '陈浩南', 'pbkdf2_sha256$100000$tl1FZQBq1SXi$AgV+WaHgyHSmhbRZgw6u+CM9mJsS2jeq96Wvr3hUAno=', '扛把子', 'male', '15198000000', 'chenhaonan@hongkong.com', '2018-04-02 01:29:41.515663', '0.0.0.0', '2018-04-02 01:29:42', '0', '0', '');
INSERT INTO `p_users` VALUES ('100', '陈浩南', 'pbkdf2_sha256$100000$pzwS6iOawqjU$P6vvBoAusWyj8bHR416miLdtdNdA3ECMBnvplHazwHc=', '扛把子', 'male', '15198000000', 'chenhaonan@hongkong.com', '2018-04-02 01:29:45.614866', '0.0.0.0', '2018-04-02 01:29:46', '0', '0', '');
INSERT INTO `p_users` VALUES ('102', 'a123456', 'pbkdf2_sha256$100000$Ef3gMAmjPNDJ$4FCOnXosL1+p+vq6EXz2ocJCHgiLxOnNP2gCTEvjSko=', 'a123456', 'female', '15111111111', 'qq@163.com', '2018-04-02 01:54:12.640827', '0.0.0.0', '2018-04-02 01:54:13', '0', '0', '');
INSERT INTO `p_users` VALUES ('104', 'sclzzhanghaijun@163.com', 'pbkdf2_sha256$100000$ap1uZo0DREk1$2xN+cJYGHGeGNKNOP1LazVY50YDD/Cl9MUI4+ZZwHS4=', 'pd-cms用户', 'female', null, 'sclzzhanghaijun@163.com', '2018-04-04 02:42:38.899592', '0.0.0.0', '2018-04-02 07:48:29', '0', '0', '');
INSERT INTO `p_users` VALUES ('106', 'zhangtao_who@163.com', 'pbkdf2_sha256$100000$PcjmANzNODgX$5PRamdgbVN7I1y/NiGuyD0SyBWpuag8aKjg/nUsw47w=', 'pd-cms用户', 'female', null, 'zhangtao_who@163.com', '2018-04-04 01:50:07.291880', '0.0.0.0', '2018-04-03 01:17:27', '0', '0', '');
