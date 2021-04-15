-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: db_proyecto
-- ------------------------------------------------------
-- Server version	5.7.33-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth_access_tokens`
--

LOCK TABLES `oauth_access_tokens` WRITE;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` VALUES ('0f75d8a0be210573792406fd38ad5846f29f42f83573d46e398799642aede8b42f3be4adec78ea1c',3,1,'Personal Access Token','[]',0,'2021-04-12 04:48:10','2021-04-12 04:48:10','2022-04-11 23:48:10'),('109bebeb5933c72eccdfb28249a2cbc50bc0ec545e62ce5a29247cceafe0d97f6e814f38f31760e9',2,1,'Personal Access Token','[]',0,'2021-04-12 04:40:20','2021-04-12 04:40:20','2022-04-11 23:40:20'),('1a64051e4b8691bedbdf3f5bd4637c8b478d3acf3412f2202c368e6bb0a452684af1d41b3f98553c',2,1,'Personal Access Token','[]',0,'2021-04-15 08:02:29','2021-04-15 08:02:29','2022-04-15 03:02:29'),('1ee68e25566218f72ccfd3bcf516a8aad6ef15bf96ff8f502d2c99a1836ad23beff2a3cec3f5a101',3,1,'Personal Access Token','[]',0,'2021-04-12 04:46:27','2021-04-12 04:46:27','2022-04-11 23:46:27'),('485bdaaed1ec83203244fcc5c31779adc975bd83fd363d96ecd8f2e94bbc562a793ec87dc5048781',2,1,'Personal Access Token','[]',0,'2021-04-12 04:42:04','2021-04-12 04:42:04','2022-04-11 23:42:04'),('4ba4367aa02267e62698fd89a4122bc0bd1e3dbffe94bdf4c7e49eb65b1b8363f2c97659e17bb6aa',2,1,'Personal Access Token','[]',0,'2021-04-14 21:23:13','2021-04-14 21:23:13','2022-04-14 16:23:13'),('83cd5e133995e0a2cef5cfe54ca25f34962d4c089b3a018bdf87c22e0a3e960b9e7c1c675e994b91',2,1,'Personal Access Token','[]',0,'2021-04-12 05:38:56','2021-04-12 05:38:56','2022-04-12 00:38:56'),('8e909962a105bb6daf2c2e709fa666ea3507a785c856bcf77e8faf015ef926187ecaf873ce1ffecf',3,1,'Personal Access Token','[]',0,'2021-04-12 05:38:13','2021-04-12 05:38:13','2022-04-12 00:38:13'),('c08e8e09cd141ba9966697b2a8b1ec7469ec19a8ea8097e4a3300e41c960901a3df2b85e57a31b6e',3,1,'Personal Access Token','[]',0,'2021-04-12 04:46:48','2021-04-12 04:46:48','2022-04-11 23:46:48');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-14 22:55:33
