-- MySQL dump 10.13  Distrib 5.7.35, for Win64 (x86_64)
--
-- Host: localhost    Database: xzh_blog
-- ------------------------------------------------------
-- Server version	5.7.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_advert`
--

DROP TABLE IF EXISTS `app_advert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_advert` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) DEFAULT NULL,
  `href` varchar(200) NOT NULL,
  `img` varchar(100) DEFAULT NULL,
  `img_list` longtext,
  `is_show` tinyint(1) NOT NULL,
  `author` varchar(32) DEFAULT NULL,
  `abstract` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_advert`
--

LOCK TABLES `app_advert` WRITE;
/*!40000 ALTER TABLE `app_advert` DISABLE KEYS */;
INSERT INTO `app_advert` VALUES (1,'bibi','https://www.bilibili.com/','advert/6.jpg','',1,'哔哩哔哩','强的一批');
/*!40000 ALTER TABLE `app_advert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_articles`
--

DROP TABLE IF EXISTS `app_articles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_articles` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) DEFAULT NULL,
  `abstract` varchar(128) DEFAULT NULL,
  `content` longtext,
  `create_date` datetime(6) DEFAULT NULL,
  `change_date` datetime(6) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `recommend` tinyint(1) NOT NULL,
  `look_count` int(11) NOT NULL,
  `comment_count` int(11) NOT NULL,
  `digg_count` int(11) NOT NULL,
  `collects_count` int(11) NOT NULL,
  `category` int(11) DEFAULT NULL,
  `author` varchar(16) DEFAULT NULL,
  `source` varchar(32) DEFAULT NULL,
  `cover_id` int(11) DEFAULT NULL,
  `pwd` varchar(32) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `word` int(11) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `app_articles_cover_id_207033ec_fk_app_cover_nid` (`cover_id`),
  CONSTRAINT `app_articles_cover_id_207033ec_fk_app_cover_nid` FOREIGN KEY (`cover_id`) REFERENCES `app_cover` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_articles`
--

LOCK TABLES `app_articles` WRITE;
/*!40000 ALTER TABLE `app_articles` DISABLE KEYS */;
INSERT INTO `app_articles` VALUES (1,'密码学基础','密码学','adadasdsd','2022-05-05 11:58:11.852076','2022-05-15 07:10:29.635470',1,1,20,9,10,1,1,'xzh','blog',1,NULL,NULL,9),(2,'联邦学习','论文','联邦学习dsdsdsds','2022-05-05 11:59:15.394321','2022-05-15 07:10:29.634795',1,1,11,2,3,1,1,'xzh','blog',2,NULL,NULL,12),(3,'ES6语法一点通','语法','let const\r\nlet a = 23;  // 块级作用域变量\r\nconst b = 21;  // 只要赋值就不能被修改\r\n// b = 24;  // 不可修改\r\nconsole.log(a, b)\r\n面向对象\r\nclass Animal {\r\n    // 初始化方法\r\n    constructor(){\r\n        // this就是实例化对象\r\n        this.type = \'animal\'\r\n    }\r\n    // 实例方法\r\n    says(say){\r\n        console.log(this.type + \' says \' + say)\r\n    }\r\n}\r\nlet animal = new Animal()\r\nanimal.says(\'hello\') //animal says hello\r\n// 继承父类Animal\r\nclass Cat extends Animal {\r\n    constructor(){\r\n        // 调用父类的方法\r\n        super()\r\n        this.type = \'cat\'\r\n    }\r\n}\r\nlet cat = new Cat()\r\ncat.says(\'hello\') //cat says hello\r\n案例\r\n\r\nclass Student{\r\n    constructor(name, age) {\r\n        this.name = name\r\n        this.age = age\r\n    }\r\n    sayName(){\r\n        return \'我是\' + this.name + \', 今年\' + this.age\r\n    }\r\n}\r\nlet zhangsan = new Student(\'张三\', 32)\r\nconsole.log(zhangsan.sayName())\r\n这样一对比，是不是和python的面向对象很像\r\n\r\n箭头函数\r\n简单的说，就是省去了function\r\n\r\nfunction getName(){\r\n    return \'我是张三\'\r\n}\r\nlet get_name = ()=>{\r\n    return \'我是新张三\'\r\n}\r\nconsole.log(getName())\r\nconsole.log(get_name())\r\n对于回调函数，箭头函数是大大的方便\r\n\r\n箭头函数可以处理this指向的问题\r\n\r\nclass Student {\r\n    constructor(name, age) {\r\n        this.name = name\r\n        this.age = age\r\n    }\r\n    sayName() {\r\n        setTimeout(function () {\r\n            // 无法拿到实例化对象的那个this\r\n            console.log(\'function： 我是\' + this.name + \', 今年\' + this.age)\r\n        }, 1000)\r\n        setTimeout(() => {\r\n            // 可以拿到实例化对象的那个this\r\n            console.log(\'arrow function： 我是\' + this.name + \', 今年\' + this.age)\r\n        }, 1000)\r\n    }\r\n}\r\nlet zhangsan = new Student(\'张三\', 32)\r\nzhangsan.sayName()\r\n之前我们是如何解决this执行问题的呢？\r\n\r\n第一种是将this传给self,再用self来指代this\r\nsayName() {\r\n    let self = this\r\n    setTimeout(function () {\r\n        // 无法拿到实例化对象的那个this\r\n        console.log(\'function： 我是\' + self.name + \', 今年\' + self.age)\r\n    }, 1000)\r\n}\r\n第二种方法是用bind(this), 即\r\nsayName() {\r\n    setTimeout(function () {\r\n        // 无法拿到实例化对象的那个this\r\n        console.log(\'function： 我是\' + this.name + \', 今年\' + this.age)\r\n    }.bind(this), 1000)\r\n}\r\n模板字符串\r\n之前的字符串拼接输出都是这样的，非常不方便\r\n\r\nconsole.log(\'arrow function： 我是\' + this.name + \', 今年\' + this.age)\r\n现在，可以直接这样进行输出\r\n\r\nconsole.log(`function： 我是${this.name}，今年${this.age}岁了`)\r\n和python很像有木有，注意是反引号哈','2022-05-05 13:19:00.507207','2022-05-15 07:10:29.633445',1,1,6,0,3,1,1,'xuzhuoheng','blog',4,NULL,NULL,2190),(4,'ceph安装1','安装步骤 1234111','## 执行方法\n\n前进到各章节的文件夹，执行Python命令。\n\n```\n$ cd ch01\n$ python man.py\n\n$ cd ../ch05\n$ python train_nueralnet.py\n```\n\n\n哈哈哈111','2022-05-05 13:33:00.000503','2022-05-15 07:10:29.632111',1,1,20,17,59,0,1,'xuzhuoheng','zhuoheng个人博客',1,'123',NULL,117),(6,'hahah','ceshi','ceshi','2022-05-07 09:08:00.479461','2022-05-15 07:10:29.630764',1,1,0,0,0,0,NULL,NULL,NULL,2,NULL,NULL,5),(7,'zzz','asasa','asasa','2022-05-07 09:17:49.065564','2022-05-15 07:10:29.629413',1,1,0,0,0,0,NULL,NULL,NULL,3,NULL,NULL,5),(8,'zzz','asasa','asasa','2022-05-07 09:18:30.599042','2022-05-15 07:10:29.628739',1,1,0,0,0,0,NULL,NULL,NULL,3,NULL,NULL,5),(9,'ceshi','hahaha','#dsdsdsdsd','2022-05-07 11:31:18.023794','2022-05-15 07:10:29.627390',1,1,0,0,0,0,NULL,NULL,NULL,4,NULL,NULL,10),(10,'1','aaa','aaa','2022-05-08 07:47:14.813108','2022-05-15 07:10:29.626715',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',1,NULL,NULL,3),(11,'aaa','zzz','dasdas','2022-05-08 10:55:57.631687','2022-05-15 07:10:29.625366',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',1,'123',NULL,6),(12,'haha','我的博客','#12233\n`helloword\n`','2022-05-08 13:39:56.464243','2022-05-15 07:10:29.624692',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',4,'111',NULL,19),(13,'a','a','zzzz','2022-05-08 13:58:35.226821','2022-05-15 07:10:29.623343',1,1,0,0,0,0,1,'xuzhuoheng','卓恒个人博客',1,'222',NULL,4),(14,'x','fdkjfjkd','asdasd','2022-05-09 02:29:23.042593','2022-05-15 07:10:29.622667',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',4,NULL,NULL,6),(15,'x','vcvc','zzz','2022-05-09 02:32:57.965792','2022-05-15 07:10:29.621559',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',2,NULL,NULL,3),(16,'z','z','z','2022-05-09 02:36:21.142562','2022-05-15 07:10:29.620210',1,1,0,0,0,0,0,NULL,NULL,3,NULL,NULL,1),(17,'x','z','z','2022-05-09 02:50:50.551226','2022-05-15 07:10:29.619536',1,1,0,0,0,0,NULL,'xuzhuoheng','卓恒个人博客',3,NULL,NULL,1),(18,'f','ff','dsdsd','2022-05-09 02:54:37.580861','2022-05-15 07:10:29.618423',1,1,3,0,1,1,1,'xuzhuoheng','卓恒个人博客',4,NULL,NULL,5),(19,'zcxxzc','cxc','xccxcx','2022-05-09 02:55:31.469292','2022-05-15 07:10:29.617478',1,1,1,0,0,0,2,'xuzhuoheng','卓恒个人博客',3,NULL,NULL,6),(20,'test test','woshi zhu','ddskjdksdjfsfdfdf\nheiehi','2022-05-09 07:06:07.625046','2022-05-15 07:10:29.616360',1,0,3,0,0,1,2,'xuzhuoheng','zhuoheng个人博客',4,NULL,NULL,24),(21,'12','aaa','heiheie','2022-05-09 07:54:27.582515','2022-05-15 07:10:29.614876',1,1,0,0,0,0,2,'xuzhuoheng','卓恒个人博客',1,'111',NULL,7),(22,'122','11','sdsd111','2022-05-09 08:51:59.917984','2022-05-15 07:10:29.603428',1,0,7,0,0,1,2,'xuzhuoheng','zhuoheng个人博客',4,'1',NULL,7),(23,'深度学习','asasa','sasa','2022-05-20 14:49:58.246571','2022-05-20 14:49:58.246571',1,1,1,0,1,1,2,'xuzhuoheng','卓恒个人博客',8,NULL,NULL,0),(24,'KMP算法','dsadas','dsadsa','2022-05-20 14:51:19.742675','2022-05-20 14:51:19.742675',1,1,4,0,9,1,2,'xuzhuoheng','卓恒个人博客',1,NULL,NULL,0),(25,'隐私计算','大大是','dsds','2022-05-21 08:02:59.579245','2022-05-21 08:02:59.579245',1,1,1,0,0,0,2,'xuzhuoheng','卓恒个人博客',2,NULL,NULL,0),(26,'Transformer','dsds','dsds','2022-05-21 08:05:41.875515','2022-05-21 08:05:41.875515',1,1,1,0,0,0,2,'xuzhuoheng','卓恒个人博客',3,NULL,NULL,0);
/*!40000 ALTER TABLE `app_articles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_articles_tag`
--

DROP TABLE IF EXISTS `app_articles_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_articles_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `articles_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_articles_tag_articles_id_tags_id_7da3db2a_uniq` (`articles_id`,`tags_id`),
  KEY `app_articles_tag_tags_id_f841c971_fk_app_tags_nid` (`tags_id`),
  CONSTRAINT `app_articles_tag_articles_id_dbf27bad_fk_app_articles_nid` FOREIGN KEY (`articles_id`) REFERENCES `app_articles` (`nid`),
  CONSTRAINT `app_articles_tag_tags_id_f841c971_fk_app_tags_nid` FOREIGN KEY (`tags_id`) REFERENCES `app_tags` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_articles_tag`
--

LOCK TABLES `app_articles_tag` WRITE;
/*!40000 ALTER TABLE `app_articles_tag` DISABLE KEYS */;
INSERT INTO `app_articles_tag` VALUES (1,1,1),(2,2,1),(3,3,2),(4,3,3),(45,4,1),(46,4,2),(48,4,3),(49,4,4),(47,4,5),(7,6,1),(8,6,4),(9,7,2),(10,8,2),(11,9,5),(13,12,1),(12,12,5),(15,13,4),(14,13,5),(16,14,3),(17,15,2),(18,16,5),(19,17,1),(20,18,1),(21,19,5),(26,20,1),(27,20,5),(34,21,3),(37,22,1),(38,22,2),(50,23,6),(51,23,7),(53,24,8),(52,24,9),(54,25,10),(55,25,11),(56,26,12);
/*!40000 ALTER TABLE `app_articles_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_avatars`
--

DROP TABLE IF EXISTS `app_avatars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_avatars` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_avatars`
--

LOCK TABLES `app_avatars` WRITE;
/*!40000 ALTER TABLE `app_avatars` DISABLE KEYS */;
INSERT INTO `app_avatars` VALUES (1,'avatars/2.jpeg'),(2,'avatars/头像_0001_01.jpg'),(3,'avatars/头像_0002_19.jpg'),(4,'avatars/头像_0001_03.jpg'),(5,'avatars/头像_0001_02.jpg'),(6,'avatars/头像_0001_04.jpg'),(7,'avatars/头像_0001_05.jpg'),(8,'avatars/头像_0001_06.jpg');
/*!40000 ALTER TABLE `app_avatars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_comment`
--

DROP TABLE IF EXISTS `app_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_comment` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `digg_count` int(11) NOT NULL,
  `content` longtext NOT NULL,
  `comment_count` int(11) NOT NULL,
  `drawing` longtext,
  `create_time` datetime(6) NOT NULL,
  `article_id` int(11) NOT NULL,
  `parent_comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  KEY `app_comment_article_id_c87ecbda_fk_app_articles_nid` (`article_id`),
  KEY `app_comment_parent_comment_id_9ee1b5bf_fk_app_comment_nid` (`parent_comment_id`),
  KEY `app_comment_user_id_693f46cc_fk_app_userinfo_nid` (`user_id`),
  CONSTRAINT `app_comment_article_id_c87ecbda_fk_app_articles_nid` FOREIGN KEY (`article_id`) REFERENCES `app_articles` (`nid`),
  CONSTRAINT `app_comment_parent_comment_id_9ee1b5bf_fk_app_comment_nid` FOREIGN KEY (`parent_comment_id`) REFERENCES `app_comment` (`nid`),
  CONSTRAINT `app_comment_user_id_693f46cc_fk_app_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `app_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_comment`
--

LOCK TABLES `app_comment` WRITE;
/*!40000 ALTER TABLE `app_comment` DISABLE KEYS */;
INSERT INTO `app_comment` VALUES (1,0,'父评论1',0,'','2022-05-09 11:39:06.591237',4,NULL,1),(2,0,'父评论2',0,'','2022-05-09 11:39:53.406081',4,NULL,2),(3,0,'子评论1',0,'','2022-05-09 11:40:15.339909',4,1,1),(4,0,'子评论2',0,'','2022-05-09 11:40:36.305715',4,2,2),(5,0,'dsds',0,NULL,'2022-05-12 03:35:51.274691',4,NULL,2),(6,0,'dsds',0,NULL,'2022-05-12 03:49:39.383251',4,NULL,1),(7,0,'dsdsdsadas',0,NULL,'2022-05-12 03:51:21.567421',4,NULL,1),(8,0,'dsdsdsadas11',5,NULL,'2022-05-12 03:51:56.102706',4,NULL,1),(9,0,'1',2,NULL,'2022-05-12 04:01:34.852692',1,NULL,2),(10,0,'hahah',5,NULL,'2022-05-12 05:43:52.279227',1,NULL,1),(11,1,'dsds',0,NULL,'2022-05-12 05:44:36.590349',1,10,1),(12,0,'lll',0,NULL,'2022-05-12 05:44:59.805808',1,10,1),(13,0,'heihei',0,NULL,'2022-05-12 05:52:15.486436',1,10,4),(14,0,'haha',0,NULL,'2022-05-12 05:52:28.812261',1,9,4),(15,0,'111',0,NULL,'2022-05-12 06:19:29.453486',1,10,4),(16,0,'zz',0,NULL,'2022-05-12 06:19:49.790482',1,11,4),(17,0,'dsds',0,NULL,'2022-05-12 06:20:09.503138',1,14,4),(18,0,'1',0,NULL,'2022-05-12 06:20:41.791581',4,8,4),(19,0,'2',0,NULL,'2022-05-12 06:20:50.348912',4,18,4),(20,1,'big dan',0,NULL,'2022-05-12 06:21:32.585305',4,NULL,4),(21,1,'big dan',3,NULL,'2022-05-12 06:21:36.397633',4,NULL,4),(22,24,'aaa',2,NULL,'2022-05-12 06:21:53.513040',4,NULL,4),(26,8,'11',0,NULL,'2022-05-12 07:05:50.521764',4,21,1),(27,0,'dsds',0,NULL,'2022-05-12 07:06:42.041358',4,8,2),(28,0,'aa',0,NULL,'2022-05-12 07:06:59.528002',4,19,2),(39,0,'dsds',0,NULL,'2022-05-13 09:51:47.100990',4,26,1),(40,0,'dsds',0,NULL,'2022-05-13 09:52:05.958228',4,21,1),(41,0,'sasa',0,NULL,'2022-05-21 02:17:26.569322',2,NULL,1);
/*!40000 ALTER TABLE `app_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_cover`
--

DROP TABLE IF EXISTS `app_cover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_cover` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_cover`
--

LOCK TABLES `app_cover` WRITE;
/*!40000 ALTER TABLE `app_cover` DISABLE KEYS */;
INSERT INTO `app_cover` VALUES (1,'article_img/9.jpg'),(2,'article_img/8.jpg'),(3,'article_img/7.jpg'),(4,'article_img/4.jpg'),(5,'article_img/1.jpg'),(8,'article_img/22.jpg');
/*!40000 ALTER TABLE `app_cover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_feedback`
--

DROP TABLE IF EXISTS `app_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_feedback` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `content` longtext NOT NULL,
  `status` tinyint(1) NOT NULL,
  `processing_content` longtext,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_feedback`
--

LOCK TABLES `app_feedback` WRITE;
/*!40000 ALTER TABLE `app_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_history`
--

DROP TABLE IF EXISTS `app_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_history` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `content` longtext NOT NULL,
  `create_date` date DEFAULT NULL,
  `drawing` longtext,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_history`
--

LOCK TABLES `app_history` WRITE;
/*!40000 ALTER TABLE `app_history` DISABLE KEYS */;
INSERT INTO `app_history` VALUES (1,'aa','dsdsds','2022-05-20','http://python.fengfengzhidao.com/blog/1646567812.png'),(2,'测试','测试内容','2022-05-20','http://rc6m7e397.hn-bkt.clouddn.com/blog/1653052158.png\nhttp://rc6m7e397.hn-bkt.clouddn.com/blog/1653052235.png');
/*!40000 ALTER TABLE `app_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menu`
--

DROP TABLE IF EXISTS `app_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menu` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(16) DEFAULT NULL,
  `menu_title_en` varchar(32) DEFAULT NULL,
  `title` varchar(32) DEFAULT NULL,
  `abstract` longtext,
  `abstract_time` int(11) NOT NULL,
  `rotation` tinyint(1) NOT NULL,
  `menu_rotation` tinyint(1) NOT NULL,
  `menu_time` int(11) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menu`
--

LOCK TABLES `app_menu` WRITE;
/*!40000 ALTER TABLE `app_menu` DISABLE KEYS */;
INSERT INTO `app_menu` VALUES (1,'首页','index','卓恒blog','卓恒知道  更快更强！',8,1,0,3),(2,'新闻','news','今日热搜','关注国家大事',8,1,0,3),(3,'心情','moods','今日心情','不需要登录就可以发送哦~~',8,1,0,3),(4,'回忆录','history','学习回忆录','卓恒的回忆录',8,1,0,3);
/*!40000 ALTER TABLE `app_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menu_menu_url`
--

DROP TABLE IF EXISTS `app_menu_menu_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menu_menu_url` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) NOT NULL,
  `menuimg_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_menu_menu_url_menu_id_menuimg_id_b33223da_uniq` (`menu_id`,`menuimg_id`),
  KEY `app_menu_menu_url_menuimg_id_836c9a04_fk_app_menuimg_nid` (`menuimg_id`),
  CONSTRAINT `app_menu_menu_url_menu_id_587b0ac6_fk_app_menu_nid` FOREIGN KEY (`menu_id`) REFERENCES `app_menu` (`nid`),
  CONSTRAINT `app_menu_menu_url_menuimg_id_836c9a04_fk_app_menuimg_nid` FOREIGN KEY (`menuimg_id`) REFERENCES `app_menuimg` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menu_menu_url`
--

LOCK TABLES `app_menu_menu_url` WRITE;
/*!40000 ALTER TABLE `app_menu_menu_url` DISABLE KEYS */;
INSERT INTO `app_menu_menu_url` VALUES (8,1,8),(9,1,9),(10,1,10),(11,2,12),(12,2,13),(13,2,14),(14,3,7),(15,4,9),(16,4,11),(17,4,12);
/*!40000 ALTER TABLE `app_menu_menu_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_menuimg`
--

DROP TABLE IF EXISTS `app_menuimg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_menuimg` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_menuimg`
--

LOCK TABLES `app_menuimg` WRITE;
/*!40000 ALTER TABLE `app_menuimg` DISABLE KEYS */;
INSERT INTO `app_menuimg` VALUES (6,'site_bg/ice_princess.jpg'),(7,'site_bg/3.jpg'),(8,'site_bg/1.jpg'),(9,'site_bg/2.jpg'),(10,'site_bg/4.jpg'),(11,'site_bg/5.jpg'),(12,'site_bg/9.jpg'),(13,'site_bg/8.jpg'),(14,'site_bg/7.jpg');
/*!40000 ALTER TABLE `app_menuimg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_moodcomment`
--

DROP TABLE IF EXISTS `app_moodcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_moodcomment` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) DEFAULT NULL,
  `content` longtext NOT NULL,
  `digg_count` int(11) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `avatar_id` int(11) DEFAULT NULL,
  `mood_id` int(11) DEFAULT NULL,
  `addr` json DEFAULT NULL,
  `ip` char(39) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `app_moodcomment_avatar_id_28a10b24_fk_app_avatars_nid` (`avatar_id`),
  KEY `app_moodcomment_mood_id_e14bcc90_fk_app_moods_nid` (`mood_id`),
  CONSTRAINT `app_moodcomment_avatar_id_28a10b24_fk_app_avatars_nid` FOREIGN KEY (`avatar_id`) REFERENCES `app_avatars` (`nid`),
  CONSTRAINT `app_moodcomment_mood_id_e14bcc90_fk_app_moods_nid` FOREIGN KEY (`mood_id`) REFERENCES `app_moods` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_moodcomment`
--

LOCK TABLES `app_moodcomment` WRITE;
/*!40000 ALTER TABLE `app_moodcomment` DISABLE KEYS */;
INSERT INTO `app_moodcomment` VALUES (9,'1','1',6,'2022-05-18 11:55:44.346801',1,8,'{\"city\": \"内网\", \"prov\": \"中国\"}','127.0.0.1'),(10,'1','1',5,'2022-05-18 12:20:16.193468',1,10,'{\"city\": \"内网\", \"prov\": \"中国\"}','127.0.0.1');
/*!40000 ALTER TABLE `app_moodcomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_moods`
--

DROP TABLE IF EXISTS `app_moods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_moods` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `content` longtext NOT NULL,
  `drawing` longtext,
  `comment_count` int(11) NOT NULL,
  `digg_count` int(11) NOT NULL,
  `avatar_id` int(11) DEFAULT NULL,
  `addr` json DEFAULT NULL,
  `ip` char(39) NOT NULL,
  PRIMARY KEY (`nid`),
  KEY `app_moods_avatar_id_9e415b70_fk_app_avatars_nid` (`avatar_id`),
  CONSTRAINT `app_moods_avatar_id_9e415b70_fk_app_avatars_nid` FOREIGN KEY (`avatar_id`) REFERENCES `app_avatars` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_moods`
--

LOCK TABLES `app_moods` WRITE;
/*!40000 ALTER TABLE `app_moods` DISABLE KEYS */;
INSERT INTO `app_moods` VALUES (1,'1','2022-05-17 14:32:26.745136','1','',0,0,1,'{\"ct\": \"中国\", \"city\": \"天门市\", \"prov\": \"湖北省\", \"yunyin\": \"电信\"}','171.42.143.203'),(3,'zhangsan','2022-05-17 14:32:26.905330','heiheiehei','https://img2.baidu.com/it/u=1640278363,2250566731&fm=253&fmt=auto&app=138&f=JPEG?w=544&h=500',0,0,6,'{\"ct\": \"中国\", \"city\": \"南京市\", \"prov\": \"江苏省\", \"yunyin\": \"百度云\"}','106.13.185.190'),(4,'lisi','2022-05-17 14:32:27.053705','aa','http://www.fengfengzhidao.com/media/avatars/%E5%A4%B4%E5%83%8F_0007_22.jpg',0,0,3,'{\"ct\": \"中国\", \"area\": \"小店区\", \"city\": \"太原市\", \"prov\": \"山西省\", \"yunyin\": \"联通\"}','171.120.159.122'),(8,'测试','2022-05-18 08:16:55.050248','aaa','http://www.fengfengzhidao.com/media/article_img/4ea55573-dbf7-4271-9225-4883763a9ac1.jpg\nhttp://www.fengfengzhidao.com/media/article_img/4ea55573-dbf7-4271-9225-4883763a9ac1.jpg\nhttp://www.fengfengzhidao.com/media/article_img/4ea55573-dbf7-4271-9225-4883763a9ac1.jpg',1,6,5,'{\"city\": \"内网\", \"prov\": \"中国\"}','127.0.0.1'),(9,'xuzhuoheng','2022-05-18 12:00:18.411546','dsds','',0,1,2,'{\"city\": \"内网\", \"prov\": \"中国\"}','127.0.0.1'),(10,'zzz','2022-05-18 12:00:33.119855','hahahahaha','',1,7,4,'{\"city\": \"内网\", \"prov\": \"中国\"}','127.0.0.1');
/*!40000 ALTER TABLE `app_moods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_myinfo`
--

DROP TABLE IF EXISTS `app_myinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_myinfo` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `job` varchar(128) NOT NULL,
  `email` varchar(64) NOT NULL,
  `site_url` varchar(32) NOT NULL,
  `addr` varchar(16) NOT NULL,
  `bilibili_url` varchar(200) NOT NULL,
  `github_url` varchar(200) NOT NULL,
  `wechat_img` varchar(100) NOT NULL,
  `qq_img` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_myinfo`
--

LOCK TABLES `app_myinfo` WRITE;
/*!40000 ALTER TABLE `app_myinfo` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_myinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_navcategory`
--

DROP TABLE IF EXISTS `app_navcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_navcategory` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(16) NOT NULL,
  `icon` varchar(32) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_navcategory`
--

LOCK TABLES `app_navcategory` WRITE;
/*!40000 ALTER TABLE `app_navcategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_navcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_navs`
--

DROP TABLE IF EXISTS `app_navs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_navs` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `icon_href` varchar(200) DEFAULT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `title` varchar(32) NOT NULL,
  `abstract` varchar(128) DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `href` varchar(200) NOT NULL,
  `status` int(11) NOT NULL,
  `nav_category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  KEY `app_navs_nav_category_id_7b6775e6_fk_app_navcategory_nid` (`nav_category_id`),
  CONSTRAINT `app_navs_nav_category_id_7b6775e6_fk_app_navcategory_nid` FOREIGN KEY (`nav_category_id`) REFERENCES `app_navcategory` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_navs`
--

LOCK TABLES `app_navs` WRITE;
/*!40000 ALTER TABLE `app_navs` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_navs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_new`
--

DROP TABLE IF EXISTS `app_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_new` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `create_date` datetime(6) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_new`
--

LOCK TABLES `app_new` WRITE;
/*!40000 ALTER TABLE `app_new` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_new` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_site`
--

DROP TABLE IF EXISTS `app_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_site` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(32) NOT NULL,
  `abstract` varchar(128) NOT NULL,
  `key_words` varchar(128) NOT NULL,
  `record` varchar(32) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `version` varchar(16) NOT NULL,
  `icon` varchar(100) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_site`
--

LOCK TABLES `app_site` WRITE;
/*!40000 ALTER TABLE `app_site` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_tags`
--

DROP TABLE IF EXISTS `app_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_tags` (
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(16) NOT NULL,
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_tags`
--

LOCK TABLES `app_tags` WRITE;
/*!40000 ALTER TABLE `app_tags` DISABLE KEYS */;
INSERT INTO `app_tags` VALUES (1,'python'),(2,'vue'),(3,'javascript'),(4,'java'),(5,'密码学'),(6,'深度学习'),(7,'NLP'),(8,'联邦学习'),(9,'算法'),(10,'隐私计算'),(11,'安全多方计算'),(12,'Transformer');
/*!40000 ALTER TABLE `app_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_userinfo`
--

DROP TABLE IF EXISTS `app_userinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_userinfo` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `nid` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(16) NOT NULL,
  `sign_status` int(11) NOT NULL,
  `tel` varchar(12) DEFAULT NULL,
  `integral` int(11) NOT NULL,
  `token` varchar(64) DEFAULT NULL,
  `avatar_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`nid`),
  UNIQUE KEY `username` (`username`),
  KEY `app_userinfo_avatar_id_8f2951b3_fk_app_avatars_nid` (`avatar_id`),
  CONSTRAINT `app_userinfo_avatar_id_8f2951b3_fk_app_avatars_nid` FOREIGN KEY (`avatar_id`) REFERENCES `app_avatars` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_userinfo`
--

LOCK TABLES `app_userinfo` WRITE;
/*!40000 ALTER TABLE `app_userinfo` DISABLE KEYS */;
INSERT INTO `app_userinfo` VALUES ('pbkdf2_sha256$260000$bJAd9H8nqXkNtgNYfJb3zj$X8RvIAjmOyo5+9+vfzV8boXanlZStu+7DVXVm2yvaFc=','2022-05-21 02:36:43.976756',1,'xuzhuoheng','','','1097404502@qq.com',1,1,'2022-05-04 10:56:20.000000',1,'xuzhuoheng',0,NULL,20,NULL,2),('pbkdf2_sha256$260000$RBUGMRIfuOixGZ8Oeksju5$keCD6RWIIJvkXjR8q4A/fifG5IEcdKMFUalJovoXiiA=','2022-05-19 07:45:51.336041',0,'xzh','','','',0,1,'2022-05-04 13:36:17.000000',2,'xzh',0,NULL,20,NULL,1),('pbkdf2_sha256$260000$M53XuIMqe5q3TKg8uM3rOr$wsnDV/Jzvu0CJLep3XuUhek4RUD/ZKqUM5Uol6bwi/M=','2022-05-12 05:47:22.000000',0,'zhangsan','','','',0,1,'2022-05-12 05:47:22.000000',3,'zhangsan',0,NULL,20,NULL,3),('pbkdf2_sha256$260000$brQ6pv0l3S3ybb2fEDq0r6$8FjG6tCPfUlYSkFAlfn81Okyr4eQCWHWzuybgKsliZ4=','2022-05-12 05:51:49.876051',0,'lisi','','','',0,1,'2022-05-12 05:47:54.000000',4,'lisi',0,NULL,20,NULL,1);
/*!40000 ALTER TABLE `app_userinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_userinfo_collects`
--

DROP TABLE IF EXISTS `app_userinfo_collects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_userinfo_collects` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `articles_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_userinfo_collects_userinfo_id_articles_id_0deac66f_uniq` (`userinfo_id`,`articles_id`),
  KEY `app_userinfo_collects_articles_id_b746b4ce_fk_app_articles_nid` (`articles_id`),
  CONSTRAINT `app_userinfo_collects_articles_id_b746b4ce_fk_app_articles_nid` FOREIGN KEY (`articles_id`) REFERENCES `app_articles` (`nid`),
  CONSTRAINT `app_userinfo_collects_userinfo_id_55723683_fk_app_userinfo_nid` FOREIGN KEY (`userinfo_id`) REFERENCES `app_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_userinfo_collects`
--

LOCK TABLES `app_userinfo_collects` WRITE;
/*!40000 ALTER TABLE `app_userinfo_collects` DISABLE KEYS */;
INSERT INTO `app_userinfo_collects` VALUES (56,1,1),(89,1,2),(49,1,3),(83,1,4),(87,1,20),(88,1,22),(90,1,23),(92,1,24),(2,2,4),(3,3,1),(4,4,1);
/*!40000 ALTER TABLE `app_userinfo_collects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_userinfo_groups`
--

DROP TABLE IF EXISTS `app_userinfo_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_userinfo_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_userinfo_groups_userinfo_id_group_id_cfea9d11_uniq` (`userinfo_id`,`group_id`),
  KEY `app_userinfo_groups_group_id_ebf31c16_fk_auth_group_id` (`group_id`),
  CONSTRAINT `app_userinfo_groups_group_id_ebf31c16_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `app_userinfo_groups_userinfo_id_a5ded69d_fk_app_userinfo_nid` FOREIGN KEY (`userinfo_id`) REFERENCES `app_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_userinfo_groups`
--

LOCK TABLES `app_userinfo_groups` WRITE;
/*!40000 ALTER TABLE `app_userinfo_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_userinfo_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_userinfo_user_permissions`
--

DROP TABLE IF EXISTS `app_userinfo_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_userinfo_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userinfo_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_userinfo_user_permis_userinfo_id_permission_i_30ee8545_uniq` (`userinfo_id`,`permission_id`),
  KEY `app_userinfo_user_pe_permission_id_6facaba5_fk_auth_perm` (`permission_id`),
  CONSTRAINT `app_userinfo_user_pe_permission_id_6facaba5_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `app_userinfo_user_pe_userinfo_id_6ded8150_fk_app_useri` FOREIGN KEY (`userinfo_id`) REFERENCES `app_userinfo` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_userinfo_user_permissions`
--

LOCK TABLES `app_userinfo_user_permissions` WRITE;
/*!40000 ALTER TABLE `app_userinfo_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_userinfo_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user info',6,'add_userinfo'),(22,'Can change user info',6,'change_userinfo'),(23,'Can delete user info',6,'delete_userinfo'),(24,'Can view user info',6,'view_userinfo'),(25,'Can add advert',7,'add_advert'),(26,'Can change advert',7,'change_advert'),(27,'Can delete advert',7,'delete_advert'),(28,'Can view advert',7,'view_advert'),(29,'Can add articles',8,'add_articles'),(30,'Can change articles',8,'change_articles'),(31,'Can delete articles',8,'delete_articles'),(32,'Can view articles',8,'view_articles'),(33,'Can add avatars',9,'add_avatars'),(34,'Can change avatars',9,'change_avatars'),(35,'Can delete avatars',9,'delete_avatars'),(36,'Can view avatars',9,'view_avatars'),(37,'Can add cover',10,'add_cover'),(38,'Can change cover',10,'change_cover'),(39,'Can delete cover',10,'delete_cover'),(40,'Can view cover',10,'view_cover'),(41,'Can add feedback',11,'add_feedback'),(42,'Can change feedback',11,'change_feedback'),(43,'Can delete feedback',11,'delete_feedback'),(44,'Can view feedback',11,'view_feedback'),(45,'Can add history',12,'add_history'),(46,'Can change history',12,'change_history'),(47,'Can delete history',12,'delete_history'),(48,'Can view history',12,'view_history'),(49,'Can add menu img',13,'add_menuimg'),(50,'Can change menu img',13,'change_menuimg'),(51,'Can delete menu img',13,'delete_menuimg'),(52,'Can view menu img',13,'view_menuimg'),(53,'Can add my info',14,'add_myinfo'),(54,'Can change my info',14,'change_myinfo'),(55,'Can delete my info',14,'delete_myinfo'),(56,'Can view my info',14,'view_myinfo'),(57,'Can add nav category',15,'add_navcategory'),(58,'Can change nav category',15,'change_navcategory'),(59,'Can delete nav category',15,'delete_navcategory'),(60,'Can view nav category',15,'view_navcategory'),(61,'Can add new',16,'add_new'),(62,'Can change new',16,'change_new'),(63,'Can delete new',16,'delete_new'),(64,'Can view new',16,'view_new'),(65,'Can add site',17,'add_site'),(66,'Can change site',17,'change_site'),(67,'Can delete site',17,'delete_site'),(68,'Can view site',17,'view_site'),(69,'Can add tags',18,'add_tags'),(70,'Can change tags',18,'change_tags'),(71,'Can delete tags',18,'delete_tags'),(72,'Can view tags',18,'view_tags'),(73,'Can add navs',19,'add_navs'),(74,'Can change navs',19,'change_navs'),(75,'Can delete navs',19,'delete_navs'),(76,'Can view navs',19,'view_navs'),(77,'Can add moods',20,'add_moods'),(78,'Can change moods',20,'change_moods'),(79,'Can delete moods',20,'delete_moods'),(80,'Can view moods',20,'view_moods'),(81,'Can add mood comment',21,'add_moodcomment'),(82,'Can change mood comment',21,'change_moodcomment'),(83,'Can delete mood comment',21,'delete_moodcomment'),(84,'Can view mood comment',21,'view_moodcomment'),(85,'Can add menu',22,'add_menu'),(86,'Can change menu',22,'change_menu'),(87,'Can delete menu',22,'delete_menu'),(88,'Can view menu',22,'view_menu'),(89,'Can add comment',23,'add_comment'),(90,'Can change comment',23,'change_comment'),(91,'Can delete comment',23,'delete_comment'),(92,'Can view comment',23,'view_comment');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  KEY `django_admin_log_user_id_c564eba6_fk_app_userinfo_nid` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_app_userinfo_nid` FOREIGN KEY (`user_id`) REFERENCES `app_userinfo` (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2022-05-05 11:00:23.437986','1','python',1,'[{\"added\": {}}]',18,1),(2,'2022-05-05 11:00:39.052904','2','vue',1,'[{\"added\": {}}]',18,1),(3,'2022-05-05 11:00:50.427881','3','javascript',1,'[{\"added\": {}}]',18,1),(4,'2022-05-05 11:56:08.239743','1','article_img/9.jpg',1,'[{\"added\": {}}]',10,1),(5,'2022-05-05 11:56:17.187859','2','article_img/8.jpg',1,'[{\"added\": {}}]',10,1),(6,'2022-05-05 11:56:26.247111','3','article_img/7.jpg',1,'[{\"added\": {}}]',10,1),(7,'2022-05-05 11:56:36.013919','4','article_img/4.jpg',1,'[{\"added\": {}}]',10,1),(8,'2022-05-05 11:56:45.803770','5','article_img/1.jpg',1,'[{\"added\": {}}]',10,1),(9,'2022-05-05 11:58:11.858077','1','密码学基础',1,'[{\"added\": {}}]',8,1),(10,'2022-05-05 11:59:15.402322','2','联邦学习',1,'[{\"added\": {}}]',8,1),(11,'2022-05-05 13:19:00.510207','3','ES6语法一点通',1,'[{\"added\": {}}]',8,1),(12,'2022-05-05 13:33:00.005505','4','ceph安装',1,'[{\"added\": {}}]',8,1),(13,'2022-05-07 02:01:09.164236','4','java',1,'[{\"added\": {}}]',18,1),(14,'2022-05-07 02:01:23.361887','5','密码学',1,'[{\"added\": {}}]',18,1),(15,'2022-05-09 02:36:21.144563','16','z',1,'[{\"added\": {}}]',8,1),(16,'2022-05-09 02:57:01.256748','1','密码学基础',2,'[{\"changed\": {\"fields\": [\"\\u6587\\u7ae0\\u5206\\u7c7b\"]}}]',8,1),(17,'2022-05-09 02:57:20.216285','3','ES6语法一点通',2,'[{\"changed\": {\"fields\": [\"\\u6587\\u7ae0\\u5206\\u7c7b\"]}}]',8,1),(18,'2022-05-09 02:57:35.864355','4','ceph安装',2,'[{\"changed\": {\"fields\": [\"\\u6587\\u7ae0\\u5206\\u7c7b\"]}}]',8,1),(19,'2022-05-09 11:39:06.595238','1','父评论1',1,'[{\"added\": {}}]',23,1),(20,'2022-05-09 11:39:53.408082','2','父评论2',1,'[{\"added\": {}}]',23,1),(21,'2022-05-09 11:40:15.339909','3','子评论1',1,'[{\"added\": {}}]',23,1),(22,'2022-05-09 11:40:36.305715','4','子评论2',1,'[{\"added\": {}}]',23,1),(23,'2022-05-09 13:39:35.858799','1','avatars/2.jpeg',1,'[{\"added\": {}}]',9,1),(24,'2022-05-09 13:40:07.815601','2','avatars/头像_0001_01.jpg',1,'[{\"added\": {}}]',9,1),(25,'2022-05-09 13:40:16.270190','3','avatars/头像_0002_19.jpg',1,'[{\"added\": {}}]',9,1),(26,'2022-05-09 13:40:23.759791','4','avatars/头像_0001_03.jpg',1,'[{\"added\": {}}]',9,1),(27,'2022-05-09 13:40:29.109675','5','avatars/头像_0001_02.jpg',1,'[{\"added\": {}}]',9,1),(28,'2022-05-09 13:40:36.686175','6','avatars/头像_0001_04.jpg',1,'[{\"added\": {}}]',9,1),(29,'2022-05-09 13:43:18.330503','1','xuzhuoheng',2,'[{\"changed\": {\"fields\": [\"\\u6635\\u79f0\", \"\\u7528\\u6237\\u5934\\u50cf\", \"\\u6536\\u85cf\\u7684\\u6587\\u7ae0\"]}}]',6,1),(30,'2022-05-09 13:43:38.769136','2','xzh',2,'[{\"changed\": {\"fields\": [\"\\u6635\\u79f0\", \"\\u7528\\u6237\\u5934\\u50cf\", \"\\u6536\\u85cf\\u7684\\u6587\\u7ae0\"]}}]',6,1),(31,'2022-05-12 05:49:53.813941','3','zhangsan',2,'[{\"changed\": {\"fields\": [\"\\u6635\\u79f0\", \"\\u7528\\u6237\\u5934\\u50cf\", \"\\u6536\\u85cf\\u7684\\u6587\\u7ae0\"]}}]',6,1),(32,'2022-05-12 05:50:15.133086','4','lisi',2,'[{\"changed\": {\"fields\": [\"\\u6635\\u79f0\", \"\\u7528\\u6237\\u5934\\u50cf\", \"\\u6536\\u85cf\\u7684\\u6587\\u7ae0\"]}}]',6,1),(33,'2022-05-15 07:05:28.228588','5','222',3,'',8,1),(34,'2022-05-15 08:08:39.152095','1','Advert object (1)',1,'[{\"added\": {}}]',7,1),(35,'2022-05-15 08:35:35.627555','1','Advert object (1)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u5c55\\u793a\"]}}]',7,1),(36,'2022-05-15 08:36:31.220633','1','Advert object (1)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u5c55\\u793a\"]}}]',7,1),(37,'2022-05-17 14:10:58.258019','2','xzh',3,'',20,1),(38,'2022-05-20 06:51:28.539866','1','site_bg/1.png',1,'[{\"added\": {}}]',13,1),(39,'2022-05-20 06:51:35.142001','2','site_bg/2.png',1,'[{\"added\": {}}]',13,1),(40,'2022-05-20 06:51:41.005024','3','site_bg/3.png',1,'[{\"added\": {}}]',13,1),(41,'2022-05-20 06:51:50.341627','4','site_bg/4.png',1,'[{\"added\": {}}]',13,1),(42,'2022-05-20 06:51:59.457317','5','site_bg/5.png',1,'[{\"added\": {}}]',13,1),(43,'2022-05-20 06:52:06.817402','6','site_bg/ice_princess.jpg',1,'[{\"added\": {}}]',13,1),(44,'2022-05-20 06:52:20.935680','7','site_bg/3.jpg',1,'[{\"added\": {}}]',13,1),(45,'2022-05-20 06:54:28.662159','1','Menu object (1)',1,'[{\"added\": {}}]',22,1),(46,'2022-05-20 06:56:06.732485','2','Menu object (2)',1,'[{\"added\": {}}]',22,1),(47,'2022-05-20 06:57:12.225204','3','Menu object (3)',1,'[{\"added\": {}}]',22,1),(48,'2022-05-20 07:35:23.345184','5','site_bg/5.png',3,'',13,1),(49,'2022-05-20 07:35:23.347185','4','site_bg/4.png',3,'',13,1),(50,'2022-05-20 07:35:23.348185','3','site_bg/3.png',3,'',13,1),(51,'2022-05-20 07:35:23.349185','2','site_bg/2.png',3,'',13,1),(52,'2022-05-20 07:35:23.350185','1','site_bg/1.png',3,'',13,1),(53,'2022-05-20 07:35:48.590250','8','site_bg/1.jpg',1,'[{\"added\": {}}]',13,1),(54,'2022-05-20 07:35:55.132696','9','site_bg/2.jpg',1,'[{\"added\": {}}]',13,1),(55,'2022-05-20 07:36:01.707939','10','site_bg/4.jpg',1,'[{\"added\": {}}]',13,1),(56,'2022-05-20 07:36:07.450762','11','site_bg/5.jpg',1,'[{\"added\": {}}]',13,1),(57,'2022-05-20 07:36:13.846286','12','site_bg/9.jpg',1,'[{\"added\": {}}]',13,1),(58,'2022-05-20 07:36:20.742203','13','site_bg/8.jpg',1,'[{\"added\": {}}]',13,1),(59,'2022-05-20 07:36:26.591312','14','site_bg/7.jpg',1,'[{\"added\": {}}]',13,1),(60,'2022-05-20 07:36:57.433308','1','Menu object (1)',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\\u56fe\\u7247\"]}}]',22,1),(61,'2022-05-20 07:37:06.876071','2','Menu object (2)',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\\u56fe\\u7247\"]}}]',22,1),(62,'2022-05-20 07:37:51.264202','3','Menu object (3)',2,'[{\"changed\": {\"fields\": [\"\\u83dc\\u5355\\u56fe\\u7247\"]}}]',22,1),(63,'2022-05-20 07:39:33.277283','2','Menu object (2)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u8f6e\\u64adbanner\\u56fe\"]}}]',22,1),(64,'2022-05-20 07:39:38.876833','1','Menu object (1)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u8f6e\\u64adbanner\\u56fe\"]}}]',22,1),(65,'2022-05-20 07:40:49.437497','1','Menu object (1)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u8f6e\\u64adbanner\\u56fe\"]}}]',22,1),(66,'2022-05-20 08:15:13.157026','1','Menu object (1)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u8f6e\\u64adbanner\\u56fe\"]}}]',22,1),(67,'2022-05-20 10:10:25.285527','4','Menu object (4)',1,'[{\"added\": {}}]',22,1),(68,'2022-05-20 11:48:31.610610','1','History object (1)',1,'[{\"added\": {}}]',12,1),(69,'2022-05-20 11:58:01.854394','4','Menu object (4)',2,'[{\"changed\": {\"fields\": [\"\\u662f\\u5426\\u8f6e\\u64adbanner\\u56fe\"]}}]',22,1),(70,'2022-05-20 14:46:24.565872','6','深度学习',1,'[{\"added\": {}}]',18,1),(71,'2022-05-20 14:46:47.107830','7','NLP',1,'[{\"added\": {}}]',18,1),(72,'2022-05-20 14:47:12.029886','8','联邦学习',1,'[{\"added\": {}}]',18,1),(73,'2022-05-20 14:47:30.747857','9','算法',1,'[{\"added\": {}}]',18,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(7,'app','advert'),(8,'app','articles'),(9,'app','avatars'),(23,'app','comment'),(10,'app','cover'),(11,'app','feedback'),(12,'app','history'),(22,'app','menu'),(13,'app','menuimg'),(21,'app','moodcomment'),(20,'app','moods'),(14,'app','myinfo'),(15,'app','navcategory'),(19,'app','navs'),(16,'app','new'),(17,'app','site'),(18,'app','tags'),(6,'app','userinfo'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2022-04-15 14:16:23.149290'),(2,'contenttypes','0002_remove_content_type_name','2022-04-15 14:16:23.237806'),(3,'auth','0001_initial','2022-04-15 14:16:23.503352'),(4,'auth','0002_alter_permission_name_max_length','2022-04-15 14:16:23.554862'),(5,'auth','0003_alter_user_email_max_length','2022-04-15 14:16:23.561863'),(6,'auth','0004_alter_user_username_opts','2022-04-15 14:16:23.572865'),(7,'auth','0005_alter_user_last_login_null','2022-04-15 14:16:23.581368'),(8,'auth','0006_require_contenttypes_0002','2022-04-15 14:16:23.585867'),(9,'auth','0007_alter_validators_add_error_messages','2022-04-15 14:16:23.597370'),(10,'auth','0008_alter_user_username_max_length','2022-04-15 14:16:23.607872'),(11,'auth','0009_alter_user_last_name_max_length','2022-04-15 14:16:23.616873'),(12,'auth','0010_alter_group_name_max_length','2022-04-15 14:16:23.675884'),(13,'auth','0011_update_proxy_permissions','2022-04-15 14:16:23.686385'),(14,'auth','0012_alter_user_first_name_max_length','2022-04-15 14:16:23.695887'),(15,'app','0001_initial','2022-04-15 14:16:25.472701'),(16,'admin','0001_initial','2022-04-15 14:16:25.620727'),(17,'admin','0002_logentry_remove_auto_add','2022-04-15 14:16:25.639231'),(18,'admin','0003_logentry_add_action_flag_choices','2022-04-15 14:16:25.651732'),(19,'sessions','0001_initial','2022-04-15 14:16:25.706242'),(20,'app','0002_articles_pwd','2022-05-07 07:17:25.420599'),(21,'app','0003_articles_link','2022-05-08 07:43:26.721087'),(22,'app','0004_auto_20220515_1349','2022-05-15 05:50:03.902122'),(23,'app','0005_auto_20220517_2128','2022-05-17 13:28:26.202785'),(24,'app','0006_auto_20220518_1619','2022-05-18 08:19:10.474380');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('262lv8avy73c1g9we2k8mbkurb84egeh','.eJzFl02XmyAUhv9Kjut8ICjq7GY2XXXZVZ2TcwVM6ETJQZ1F5-S_F2I67VATDXOSrq5yX1-4D4j4Fqyha7frrhF6LXnwEITB_O-2AtiLqG2C_4B6o5ZM1a2WxdJKlqdss_yquNg9nbQfDLbQbM3ThIQM45RllIQQl5whIhhLIw44hRBSLKiIaUSogCyNYoIxZllCgYQ84lxE1rQSddcYr-9veVBDJfLgYZYHj_t9HszNhTRD65tK0LMSFkxqthN9srIDbGz649N53sUiKW2IIphg1Oldn1sBr2S9gv3eXL0K3a56AXD-7bzGZE-6QgvgTHdVMTCs8aIO85l_IYdnmxaS22yIEB5yKxkxgSIWe2KplOLNZSq95KZQJpfhQiEDbjROExMSEMh3rehWGsEIl3fVLdFML8ZFE424GewMhSaYVxh7gmLKvDCXKfWSeyG6pigXWDzqTVN0vCsS4Qmshc3Iqjoq7odrekkuLjrgncQ4taaYJJ6A7PdI1qW6DOlddUtQ04tx0SQjbmaVZiSyAbHSd496hRb02BZ1Et0L0zWFudDSIW_gmQ2osCFFjNmeKPWFZk8nIx87q7gpLs-SXFzZVd5mRmjpu2lZJrLajIOzov_DblJ9DsIQDXSRFiw6hsL3oMlUZViMnDR_i25Ja3opLpjQXWyha_9o_h3M-CWDVqp6BjWf2Sal5c9jy78dNrbDZivFji9g114-8X_Rqts3Z0zs5t8smNqcmQMzjtXGGlyYgj-aqTPw-YJdhlOLdGeHuA348BwcfgGsCWoI:1nrwfi:xraFXJT8zdravwowgspZeou76vYGT9TpZ_Up6s77UoE','2022-06-03 07:03:38.270453'),('2bligtpell2ivms7d3xwiuoea5ayyls1','.eJzFl8FymzAQhl_Fw9mxQQIBuaWXnnrsqWQ8iyRstQZ5BGSmzfjdqzVu2igEMBm7pwXtzy_tJyHEs7eBttlt2lqajRLevRd4y3_bcuA_ZIUJ8R2qrV5xXTVG5SuUrM7ZevVFC7n_dNa-MthBvbNPUxpwQhKeMhpAVAjuU8l5EgogCQSQEMlkxELKJKRJGFFCCE9jBjQQoRAyRNNSVm1tvb49Z14Fpcy8-0XmPRwOmbe0F8oOrWsqwCwKuOPK8L3skiUOsMb066ezrI2YkBgKzk4hiib4tWbf5dYgSlWt4XBY71TdaPNz3SlAiK8DIps-C3MjQXDTlnnP-MarOy4XH67o-IhpqQRmA98nfaYyLjCEIczkA-JJmmYYz1lzVTqTC3Gx0D63glMbmM_nLptSa1EPU-kkV4UyuQwXStjjxqIktiEG6c9dK6ZRVjDC5UV1TTTTi3HRRCNuFjv3AxvsTkdmguLavjDDlDrJrRBdUpQLjI16s8Q_3eWxnAmsge3IqjopbodrekkurrjHO45IgqaExjMB4WdbVYUehvSiuiao6cW4aJIRN7tKUxpi8Hkxd496ggbM2BZ1Ft0K0yWFudDSPm8QKQY_x5D4nGNPjM2Fhoe4kY8dKq6Ka2ZJDq7Av8gbj2XF3E0LmahyOw4ORf-H3aT6XIRBTxdJzsNTyOceNLkuLYuRk-Yf0TVpTS_FBUPcd_MNqQf7i2XHrzg0SlcLqMQCm7RRv04tbzusscN6p-Re3MG-Gf4x-mx0e6jfMcHNv77jevvOHNhxrLdoMDAFfzVTZ-DjBbsMpxbpzk7oNtDjo3f8Dfdcxm0:1ns3ur:k4h3qG7b6b_sTHCqtWaHbXQOeojqFVPLU5KoL81PzXg','2022-06-03 14:47:45.096748'),('3yoeep6qnnzrg5bhyt1rwxsi4mxrhmk5','.eJxVjLsOwjAMRf8lM4qInYaUkc4MTIyRaxtaqFKpDxbEv9NKXbqec-79mg91rSTuRc3ZVLd7bQ4m0Tw1aR51SK0s2O1ZTfzWvAp5UX72lvs8DW1t18RudrTX5bO7bO3uoKGxWdaIjgEilwEdFQ_hIypz9EIQyVEEDVoEj0GpjL5AAODyFAideBH15vcHUqA93w:1nngke:z0TBElqbR0Bhzqs-IEqp3XM8TdAQnTyF9yjeG4B5WgQ','2022-05-22 13:15:08.022486'),('44inxk6bs5u3ebrvqjmq264lexjsmtv9','.eJy9VU1zmzAQ_SsenW0DEh8it-SSSzs99VQynkUStlq-RgIfmvF_r2Q87Vh1gJCJT4Ldx9O-t2L1io5QSr5jDRfoAR3xty9ojXbQd4ddr4XaSW7CwXUsB_ZL1DbBf0K9b7asqTsl862FbC9Zvf1qOMunC_aK4AD6YL4mJGAYU5bGJICo4MwngjEacsAUAqBYxCKKQxILSGkYEYwxS5MYSMBDzkVoSStR99pw_XjNUA2VyNDDKkOPbZuhtXmQprQhVIBaFbBhUrFSDMnKFqht-vrrLOvjiCZmSUD4M4h6VQ45D3glaw_a1gPVSQPQ3gABzr-PoUz-gsyVAM5UX-U3SpsWdlqvlos5vdi0kNxmA9_HE2xZHzE_MItpC15oFGuOQo27NEDuZdF7RLmGkUnumPrntzwRCw3rYD9xqs6I-9k1X5JrV3iDO4kwtaSYJAsNsjNG1kUzbtJf1GcaNV-Ma000wWZOaUpCu_isWDqjjtCBmhpRF9C9bHqPMNe0-AY3zVl4XnJYPKEqc810UzNqAH2mTfOluMYkbiBw6R_N7Wzqlww62dQrqPnKhholf58j_2-o7Yb6IEXJN1B243fqs2r6Vr9BYn9FvWHN_o0emDq8vSUYacE_zNwOfFyw6-FckW4zUjdATy_o9AcbVADC:1nq8gp:i8hoEN6Dw-ivkvKG9uuUAXkru7tvMC-JQpIisRlvcvA','2022-05-29 07:29:19.024271'),('71zr58o53018wkgucj1mhztpl45ylpya','.eJxVjEsOwjAMBe-SNYqInYaUJRLsOEPk2oYUqkbqhw3i7rRSN93OzHtf86GulcRF1JzNtcs3czCJ5imnedQhtbJgt2cN8Vv7VciL-mexXPppaBu7Jnazo70vn91la3cHmca8rBEdA0SuAzqqHsJHVObohSCSowgatAoeg1IdfYUAwPUpEDrxIurN7w9fFz3x:1np4W2:G2oUkCBTFM3PAPgAFhxYMvZ9LW1JMdhQlMoLyj7gLos','2022-05-26 08:49:46.395902'),('7esvpebl5hyfjkz6v2eas0ivn3384i54','.eJxVjDsOwjAQBe_iGll41zE2JQUdDRewNrsLCUSxlA8N4u4kUpq0M_Pe13yoayVzETVnk67z3RxMpnlq8jzqkFtZsNuzmvit_SrkRf2zWC79NLS1XRO72dHels_usrW7g4bGZlkjOgaInAI6qh7CR1Tm6IUgkqMIGrQKHoNSir5CAOB0CoROvIh68_sDTc892A:1nsEOM:FapQQMG6i-BmYloarcK2WJ8bMcdYKY9w-fQ7KosMBp8','2022-06-04 01:58:54.896093'),('8td5ncuumfbsmtkkyegu6e3rrbby7ug9','.eJxVjMsKwjAQRf8lawlmJo2pS5cFf8BNmM6Mtloa6EME8d9toZtuzzn3fs2bulYSZ1FzNtWt_piDSTRPTZpHHVIrC3Z7VhO_tF-FPKl_ZMu5n4a2tmtiNzva6_LZXbZ2d9DQ2CxrRMcAkcuAjoq78BGVOXohiOQoggYtgsegVEZfIABweQqETryIevP7A3PvPhA:1nmvsT:PGOlykCg30cnX3ACQY7rhJ3zEs-5h3jlP6mTvbJQ2_g','2022-05-20 11:12:05.831963'),('ee5x0zvd4hrpeg6ykmzdzudljzksopto','.eJxVjLsOwjAMRf8lM4qInYaUkZ2NPXJtQwtVivpgQfw7jdSl6znn3q_5UN9J4kHUnI27vaM5mETL3KZl0jF1UvCeNcQvzUXIk_JjsDzkeewaWxK72cle18_-srW7g5amdl0jOgaIXAd0VN2Fj6jM0QtBJEcRNGgVPAalOvoKAYDrUyB04kXUm98fPOk9vw:1nrFfL:oe2o8lVs76xPTLCf9p7UJVqVR4ZAOXGrk6yQ6ICYAHI','2022-06-01 09:08:23.119841'),('f4y3ttuh2wj8h4ysrssm0xiscsqhm2aq','.eJxVjDEPgjAQRv9LZ9PYu1KLozuLi3FqjrtTUAIJBRfjfxcSFtb33vd9zYe6VhIPouZsrvF-MweTaJ6aNGcdUysLdntWE7-1X4W8qH8Olod-GtvarondbLbV8tldtnZ30FBuljWiY4DIZUBHxUP4iMocvRBEchRBgxbBY1Aqoy8QALg8BUInXkS9-f0BRcY9zA:1nnt7z:R8Vf4qPXg7_BntujxnPmszJm5GEJTgq2iwGothnAPEI','2022-05-23 02:28:03.868853'),('gf8zswdysn339phve3thxotv1ifa6aaq','.eJxVjDEOwjAMRe-SGUXETkLKyN4zRK5tSAE1UtNOiLtDpQ6w_vfef5lM61Ly2nTOo5izcebwuw3ED502IHeabtVynZZ5HOym2J0221fR52V3_w4KtfKtER0DJO4iOgpX4SMqc_JCkMhRAo0aoseo1CUfEAC4O0VCJ15EvXl_ANdLN5o:1no3Nz:flnn0zvEZduHuyn0jAEqFifm8d27SWDmF5drdob7U_c','2022-05-23 13:25:15.102588'),('hldswhmgjb1po6qfuhqwi7fof37k2ott','.eJy9lj2TmzAQhv-KR7U_hCRAdpVLkzQpkplU4cazSMLWBRDHh4t4_N8jGecyJrbhyNiVYPflRftIgt2jHaRaroWRCq3Q12_iM5qiNTT1dt1UqlxracPeeSwG8VPlLiFfIN-YuTB5Xep47iTzU7aaf7Ge6ceT9sxgC9XWPk2pJwjhYhlQD_xECkyVEJxJIBw84EQFyg8YDRQsOfMpIUQswwCoJ5mUijnTTOVNZb1-7COUQ6YitJpE6KkoIjS1F9pOrQ0lUE4SmAldilS1ycxNsHLp86ejqPFVmLiBMRhg1JRpm1uAzHS-gKKwVztV1otWAFJ-v66x2ZMuLhVIUTZZfGFa_UUdppPxhRyeXVpp6bIexuSSWyKoHQIs_JFYMmNkdZtKK7krlMFldKHQC26Bz0M7hKDw2L1S1toKeri8qe6JZngxXTSsx81iF9izgz3CZCQoYeyBuU2plTwK0XuK6gLze70Djo93cahGAqth07OrjorH4RpeUhdXcME79Al3poSGIwG5_5HOE3Mb0pvqnqCGF9NFE_a42V26pMwNWCRjv1E7qKHs-0SdRI_C9J7CutD4BW8eC3Yc4rG_fWEy25L0_Pf_iO6JaXgpXTDLbsDr2j_ZTs7OXwuotcknkMuJC5lS_zpG_n1h5V5YbbVK5QzS-nb_9ak0TVFdMXFHsZoJs7myBnYei40zuLEEfzVDV-D_C-4yHFpkZzE8rxvAh2fbCLdtvMpAp2sTv6DVHp16-tCnAeZWUutMrasasgKtvMCn2GMs4HNC7LXPp-j4sOv28TJkmPmYfHh9tb19hg6H35WZyEo:1nrscB:XD7pRDq-YwFfYoOnh_W9_R1j1Ie4G44XnvusykblCE4','2022-06-03 02:43:43.965002'),('mgelbtsbfs5r3oqnxvhn0jjtvl6853jx','.eJxVjLsOwjAMRf8lM4qInYaUkb0TYo5c29BC1aA-WBD_Tit16XrOufdrPtS1kjiLmrO5Xeu3OZhE89SkedQhtbJgt2c18Uv7VciT-ke2nPtpaGu7Jnazo62Wz-6ytbuDhsZmWSM6BohcBnRU3IWPqMzRC0EkRxE0aBE8BqUy-gIBgMtTIHTiRdSb3x9xTj4M:1nrb5t:TUev1ycFa2kJMgn5OGXDyMeJqwJyA_byB-yn64EsROg','2022-06-02 08:01:13.304224'),('o78h5eysni4otbxkfvuajt8dtujt62hm','.eJxVjDEOwjAMRe-SGUXETkLKyN4zRK5tSAE1UtNOiLtDpQ6w_vfef5lM61Ly2nTOo5izcebwuw3ED502IHeabtVynZZ5HOym2J0221fR52V3_w4KtfKtER0DJO4iOgpX4SMqc_JCkMhRAo0aoseo1CUfEAC4O0VCJ15EvXl_ANdLN5o:1nmZ8H:ePBnS7CVDPeJGA9jNs-8_xECklteq3Ep7_3EboTEFj8','2022-05-19 10:54:53.735891'),('t2g0b7y9j772phehye1xdb5tm2ksglb7','eyJ2YWxpZF9jb2RlIjoiSzBySyJ9:1nmW1o:GepSH69TWB7oaqSclcVkown9EDdOMimH1ojTcrsJzqA','2022-05-19 07:36:00.657451'),('u5ok6p9qalpy5vkskbsjnifq7geo6v3y','.eJzFl8uOmzAUhl8lYp0L2GDM7Npu-gLdTBlFh2MTULlEXCJVo7x7bUinGpcCoSVdncTn5yf_Z8eYV-sCWSqOWAppPVmfn5Nna2sdoW2SY1vL6pgKNey8H4sAv8lCN-B83ncGe93df2rrpsw_3trvrkmgTtQFlDpICMeAUQe8WKBNJSJ3BRAODnAimfSYS5mEgLseJYRg4DOgjnCFkK42zWXR1srr62toFZDL0HrahNaH8zm0tupDimXRD8VQbWLYYVphJvtmrnJmtW6_vzoMW48JqUuMrCueN8OvrbK-dwCRp8VBATkkqaJQfT_0ChDiy4hItW_CqJIgsGrzaOD3Tae7bjd_nej6otsyFbrr2DYZMpV-rIvrwkI-IC6yasbx3DSr0pkdxMRCh9xipKowG5cum7wsRT1OpZesCmV2DBOKO-DGPO6r4oO0l66VqkmVYILLm2pNNPPDmGi8CTeFHW1HFbXTkYWgsFR_mHFKveRRiO4JZQJjk96M2923yJcLgTVwmlhVneJxuOZHMnH5A96-R7g2JdRfCEg_ttMiLschvanWBDU_jImGT7ipVRpQVxcb46V71AUaqKa2qJvoUZjuCWZCC4a8QQS62JEu3EbUd2JsKTR9iJt42GnFqrgWRjJwOfZd3vpYFi_dtDSTND9Ng9Oi_8NuVj4ToTNwCx6h25Vo6UETy1yxmDhp_hStSWt-FBMMMf-bw6Sgt0enO9DybjIo7zYD36W_37PW96yTVGZiB1kz-W7kSxVg2EU_AOodlqc_zIN6AzycqrI9j0zDL83MWfg3oYfW9ayg5iy55gC9vljXH9kpxC0:1nsM2L:uGKeHxGEAxt6CzIEPfcUZsSICY55KTxeKF-47FhYNi0','2022-06-04 10:08:41.081220'),('udqlz0h2q19pjihdmwd8lswy09vl8oib','eyJ2YWxpZF9jb2RlIjoiaHZMYyJ9:1ngkNC:pcEraSfUIlTQulPueTtQQNptzxbFKgYlwvlnB7IAhGA','2022-05-03 09:42:14.810763'),('zmnq9xgw1ggcjlw9t3v1xh777dnswkk1','eyJ2YWxpZF9jb2RlIjoicXhJUiJ9:1nmAVk:s5CJB1DhihROGExfXS4kcBBBD_xu0EHDrBxID0B8Lcw','2022-05-18 08:37:28.350427');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-21 21:03:31
