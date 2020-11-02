-- MySQL dump 10.13  Distrib 5.7.30, for Win64 (x86_64)
--
-- Host: localhost    Database: qxgl
-- ------------------------------------------------------
-- Server version	5.7.30-log

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
-- Table structure for table `t_fn`
--

DROP TABLE IF EXISTS `t_fn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_fn` (
  `fno` int(4) NOT NULL AUTO_INCREMENT,
  `fname` varchar(16) DEFAULT NULL,
  `fhref` varchar(16) DEFAULT NULL,
  `ftarget` varchar(16) DEFAULT NULL,
  `flag` int(1) DEFAULT NULL,
  `pno` int(4) DEFAULT NULL,
  `del` int(1) DEFAULT NULL,
  `createtime` varchar(32) DEFAULT NULL,
  `yl1` varchar(16) DEFAULT NULL,
  `yl2` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`fno`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_fn`
--

LOCK TABLES `t_fn` WRITE;
/*!40000 ALTER TABLE `t_fn` DISABLE KEYS */;
INSERT INTO `t_fn` VALUES (100,'权限管理','','',1,-1,1,'2020-08-06 15:43:05',NULL,NULL),(101,'用户管理','userList.do','right',1,100,1,'2020-08-06 15:54:31',NULL,NULL),(102,'角色管理','roleList.jsp','right',1,100,1,'2020-08-06 15:54:31',NULL,NULL),(103,'功能管理','FnList.jsp','right',1,100,1,'2020-08-06 15:54:31',NULL,NULL),(104,'基本信息管理','','',1,-1,1,'2020-08-06 15:54:31',NULL,NULL),(105,'商品管理','product.do','right',1,104,1,'2020-08-06 15:54:31',NULL,NULL),(106,'供应商管理','supplier.do','',1,104,1,'2020-08-06 15:54:31',NULL,NULL),(107,'仓库管理','room.do','right',1,104,1,'2020-08-06 15:54:31',NULL,NULL),(108,'新建','userAdd.jsp',NULL,2,101,1,'2020-08-06 15:54:31',NULL,NULL),(109,'删除','userDelete.do',NULL,2,101,1,'2020-08-06 15:54:31',NULL,NULL),(110,'编辑','userEdit.do',NULL,2,101,1,'2020-08-06 15:54:40',NULL,NULL),(113,'经营管理',NULL,NULL,1,-1,1,'2020-10-30 11:15:51',NULL,NULL),(114,'用户批量删除','11',NULL,1,101,2,'2020-10-30 17:37:30',NULL,NULL),(116,'进货管理',NULL,NULL,1,113,1,'2020-11-01 23:21:43',NULL,NULL),(117,'退货管理',NULL,NULL,1,113,1,'2020-11-01 23:21:57',NULL,NULL),(118,'库存管理',NULL,NULL,1,-1,1,'2020-11-01 23:22:07',NULL,NULL),(119,'财务管理',NULL,NULL,1,-1,1,'2020-11-01 23:22:14',NULL,NULL),(120,'删除','menuDelete.do',NULL,2,103,1,'2020-11-01 23:45:11',NULL,NULL);
/*!40000 ALTER TABLE `t_fn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role` (
  `rno` int(4) NOT NULL AUTO_INCREMENT,
  `rname` varchar(16) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  `del` int(1) DEFAULT NULL,
  `createtime` varchar(32) DEFAULT NULL,
  `yl1` varchar(16) DEFAULT NULL,
  `yl2` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`rno`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (10,'管理员','很牛',1,'2020-08-06 15:34:22',NULL,NULL),(11,'经理','有点牛',1,'2020-08-06 15:34:22',NULL,NULL),(12,'销售','一般牛',1,'2020-08-06 15:34:22',NULL,NULL),(13,'员工','一般',1,'2020-08-06 15:34:25',NULL,NULL),(14,'员工1','一般',1,'2020-08-12 09:29:28',NULL,NULL),(15,'员工2','一般',1,'2020-08-12 09:29:36',NULL,NULL),(16,'员工3','一般',1,'2020-08-12 09:29:42',NULL,NULL),(17,'员工4','一般',1,'2020-08-12 09:29:48',NULL,NULL),(18,'员工5','一般',1,'2020-08-12 09:29:56',NULL,NULL),(19,'员工6','一般',1,'2020-08-12 09:30:02',NULL,NULL);
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role_fn`
--

DROP TABLE IF EXISTS `t_role_fn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_role_fn` (
  `rno` int(4) NOT NULL,
  `fno` int(4) NOT NULL,
  PRIMARY KEY (`rno`,`fno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role_fn`
--

LOCK TABLES `t_role_fn` WRITE;
/*!40000 ALTER TABLE `t_role_fn` DISABLE KEYS */;
INSERT INTO `t_role_fn` VALUES (10,100),(10,101),(10,102),(10,103),(10,104),(10,105),(10,106),(10,107),(10,108),(10,109),(10,110),(10,113),(10,116),(10,117),(10,118),(10,119),(10,120),(11,100),(11,101),(11,102),(11,103),(11,108),(11,113),(11,116),(11,117),(11,118),(11,119),(13,100),(13,103),(13,104),(13,105),(13,106),(13,107),(13,113),(13,116),(13,117),(13,118),(13,120);
/*!40000 ALTER TABLE `t_role_fn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user` (
  `uno` int(4) NOT NULL AUTO_INCREMENT,
  `uname` varchar(16) DEFAULT NULL,
  `upass` varchar(16) DEFAULT NULL,
  `truename` varchar(16) DEFAULT NULL,
  `sex` varchar(2) DEFAULT NULL,
  `age` int(3) DEFAULT NULL,
  `del` int(1) DEFAULT NULL,
  `createtime` varchar(32) DEFAULT NULL,
  `yl1` varchar(16) DEFAULT NULL,
  `yl2` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'zyy','zyy','赵一一','女',18,1,'2020-08-06 15:18:02',NULL,NULL),(2,'qee','qee','钱二二','男',18,1,'2020-08-06 15:24:34',NULL,NULL),(3,'sss','sss','孙珊珊','女',17,2,'2020-08-06 15:24:34',NULL,NULL),(4,'lss','lss','李思思','女',19,2,'2020-08-06 15:24:34',NULL,NULL),(5,'zww','zww','周五五','男',17,2,'2020-08-06 15:24:34',NULL,NULL),(6,'wll','wll','吴六六','男',18,2,'2020-08-06 15:24:34',NULL,NULL),(7,'zqq','zqq','郑七七','女',16,2,'2020-08-06 15:24:34',NULL,NULL),(8,'wbb','wbb','王baba','男',19,2,'2020-08-06 15:24:35',NULL,NULL),(9,'zhangsan','123','张三','男',18,2,'2020-08-09 14:11:29',NULL,NULL),(10,'zs1','123456','张三1','男',15,2,'2020-08-10 20:08:32',NULL,NULL),(11,'zs2','123','张三2','女',16,2,'2020-08-10 20:08:32',NULL,NULL),(12,'zs3','123','张三','女',17,1,'2020-08-10 20:08:32',NULL,NULL),(13,'zs4','123','张三4','女',18,2,'2020-08-10 20:08:32',NULL,NULL),(14,'zs5','123','张三5','男',19,1,'2020-08-10 20:08:32',NULL,NULL),(15,'zs6','123','张三6','女',20,1,'2020-08-10 20:08:32',NULL,NULL),(16,'zs7','123','张三7','男',21,1,'2020-08-10 20:08:32',NULL,NULL),(17,'zs8','123','张三8','女',22,1,'2020-08-10 20:08:32',NULL,NULL),(18,'zs9','123','张三9','男',23,1,'2020-08-10 20:08:32',NULL,NULL),(19,'zs10','123','张三10','女',24,1,'2020-08-10 20:08:32',NULL,NULL),(20,'zs11','123','张三11','男',25,1,'2020-08-10 20:08:32',NULL,NULL),(21,'zs12','123','张三12','女',26,1,'2020-08-10 20:08:32',NULL,NULL),(22,'zs13','123','张三13','男',27,1,'2020-08-10 20:08:32',NULL,NULL),(23,'zs14','123','张三14','女',28,1,'2020-08-10 20:08:32',NULL,NULL),(24,'zs15','123','张三15','男',29,1,'2020-08-10 20:08:32',NULL,NULL),(25,'zs16','123','张三16','女',30,1,'2020-08-10 20:08:32',NULL,NULL),(26,'zs17','123','张三17','男',31,1,'2020-08-10 20:08:32',NULL,NULL),(27,'zs18','123','张三18','女',32,1,'2020-08-10 20:08:32',NULL,NULL),(28,'zs19','123','张三19','男',33,1,'2020-08-10 20:08:32',NULL,NULL),(29,'zs20','123','张三20','女',34,1,'2020-08-10 20:08:32',NULL,NULL),(30,'zs21','123','张三21','男',35,1,'2020-08-10 20:08:32',NULL,NULL),(31,'zs22','123','张三22','女',36,1,'2020-08-10 20:08:32',NULL,NULL),(32,'zs23','123','张三23','男',37,1,'2020-08-10 20:08:32',NULL,NULL),(33,'zs24','123','张三24','女',38,1,'2020-08-10 20:08:32',NULL,NULL),(34,'zs25','123','张三25','男',39,1,'2020-08-10 20:08:32',NULL,NULL),(35,'zs26','123','张三26','女',40,1,'2020-08-10 20:08:32',NULL,NULL),(36,'zs27','123','张三27','男',41,1,'2020-08-10 20:08:32',NULL,NULL),(37,'zs28','123','张三28','女',42,1,'2020-08-10 20:08:32',NULL,NULL),(38,'zs29','123','张三29','男',43,1,'2020-08-10 20:08:32',NULL,NULL),(39,'zs30','123','张三30','女',44,1,'2020-08-10 20:08:32',NULL,NULL),(40,'zs31','123','张三31','男',45,1,'2020-08-10 20:08:32',NULL,NULL),(41,'zs32','123','张三32','女',46,1,'2020-08-10 20:08:32',NULL,NULL),(42,'zs33','123','张三33','男',47,1,'2020-08-10 20:08:32',NULL,NULL),(43,'zs34','123','张三34','女',48,1,'2020-08-10 20:08:32',NULL,NULL),(44,'zs35','123','张三35','男',49,1,'2020-08-10 20:08:32',NULL,NULL),(45,'zs36','123','张三36','女',50,1,'2020-08-10 20:08:32',NULL,NULL),(46,'zs37','123','张三37','男',51,1,'2020-08-10 20:08:32',NULL,NULL),(47,'zs38','123','张三38','女',52,1,'2020-08-10 20:08:32',NULL,NULL),(48,'zs39','123','张三39','男',53,1,'2020-08-10 20:08:32',NULL,NULL),(49,'zs40','123','张三40','女',54,1,'2020-08-10 20:08:32',NULL,NULL),(50,'zs41','123','张三41','男',55,1,'2020-08-10 20:08:32',NULL,NULL),(51,'zs42','123','张三42','女',56,1,'2020-08-10 20:08:32',NULL,NULL),(52,'zs43','123','张三43','男',57,1,'2020-08-10 20:08:32',NULL,NULL),(53,'zs44','123','张三44','女',58,1,'2020-08-10 20:08:32',NULL,NULL),(54,'zs45','123','张三45','男',59,1,'2020-08-10 20:08:32',NULL,NULL),(55,'zs46','123','张三46','女',60,1,'2020-08-10 20:08:32',NULL,NULL),(56,'zs47','123','张三47','男',61,1,'2020-08-10 20:08:32',NULL,NULL),(57,'zs48','123','张三48','女',62,2,'2020-08-10 20:08:32',NULL,NULL),(58,'zs49','123','张三49','男',63,2,'2020-08-10 20:08:32',NULL,NULL),(59,'zs50','123','张三50','女',64,2,'2020-08-10 20:08:32',NULL,NULL),(60,'zs51','123','张三51','男',65,2,'2020-08-10 20:08:32',NULL,NULL),(61,'zs52','123','张三52','女',66,2,'2020-08-10 20:08:32',NULL,NULL),(62,'zs53','123','张三53','男',67,2,'2020-08-10 20:08:32',NULL,NULL),(63,'dp1','111','大潘1','男',18,1,'2020-10-28 10:07:53',NULL,NULL),(64,'ls1','123','李四1','男',17,1,'2020-10-28 15:27:32',NULL,NULL),(65,'ls2','123','李四2','女',18,1,'2020-10-28 15:27:32',NULL,NULL),(66,'ls3','123','李四3','男',19,1,'2020-10-28 15:27:32',NULL,NULL),(67,'ls4','123','李四4','女',20,1,'2020-10-28 15:27:32',NULL,NULL),(68,'ls5','123','李四5','男',21,1,'2020-10-28 15:27:32',NULL,NULL),(69,'ls6','123','李四6','女',22,1,'2020-10-28 15:27:32',NULL,NULL),(70,'ls7','123','李四7','男',23,1,'2020-10-28 15:27:32',NULL,NULL),(71,'ls8','123','李四8','女',24,1,'2020-10-28 15:27:32',NULL,NULL),(72,'ls9','123','李四9','男',25,1,'2020-10-28 15:27:32',NULL,NULL),(73,'ls10','123','李四10','女',26,1,'2020-10-28 15:27:32',NULL,NULL),(74,'ls11','123','李四11','男',27,1,'2020-10-28 15:27:32',NULL,NULL),(75,'ls12','123','李四12','女',28,1,'2020-10-28 15:27:32',NULL,NULL),(76,'ls13','123','李四13','男',29,1,'2020-10-28 15:27:32',NULL,NULL),(77,'ls14','123','李四14','女',30,1,'2020-10-28 15:27:32',NULL,NULL),(78,'ls15','123','李四15','男',31,1,'2020-10-28 15:27:32',NULL,NULL),(79,'ls16','123','李四16','女',32,1,'2020-10-28 15:27:32',NULL,NULL),(80,'ls17','123','李四17','男',33,1,'2020-10-28 15:27:32',NULL,NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_role`
--

DROP TABLE IF EXISTS `t_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_user_role` (
  `uno` int(4) NOT NULL,
  `rno` int(4) NOT NULL,
  PRIMARY KEY (`uno`,`rno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_role`
--

LOCK TABLES `t_user_role` WRITE;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` VALUES (1,10),(1,14),(2,11),(12,13),(14,10),(14,11),(14,14),(14,15),(14,16),(14,17),(14,18),(14,19);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-02 11:48:16
