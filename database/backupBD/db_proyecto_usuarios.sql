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
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `apellidos` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombres` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `foto` blob,
  `id_rol` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuarios_identificacion_unique` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (38,42,'PEREZ PEREZ','JOSE EDUARDO','eyJpdiI6ImZESWh0eG55RTV0NlN4YU5RZFwvbmF3PT0iLCJ2YWx1ZSI6InZyVEZpTENpV3FqUU5ic1FWWHJVeFE9PSIsIm1hYyI6Ijc4YTJhYmZiYzc0Y2UyNTk5ZmE3Yzk2ODEzNzIyZjU2NzZkNDBhNTE5Mzc4ZjJiNWQ2NTM3ZjZhODUxMGIwMjMifQ==',1,NULL,2,'2021-03-10 02:25:06','2021-03-10 02:25:33'),(39,43,'MARTINEZ','ANDREA','eyJpdiI6IklcL3NwZDYwcFZKKzNtTWNzSGx2Q3hRPT0iLCJ2YWx1ZSI6IkVjVDZYQXV5QlFMNjVSTHlmZitZMGc9PSIsIm1hYyI6IjRhY2EzMTExYzVjYzIwZmY3NDljZjYxNTkwYjg5NmVkYTJkMjIxNjI4MzNmNjAwNzc3NWE1YWRmZmE2ODI3ZTcifQ==',1,NULL,4,'2021-03-10 02:55:44','2021-03-10 02:56:18'),(40,44,'BULLA','JUAN CARLOS','eyJpdiI6ImpDUTlWa0U5YmxIcERMRGMzbVRRckE9PSIsInZhbHVlIjoiblhzamlDbFBwVWwyOFhUTkJ3V01EQ2V3TE5nYzdGd0ViTnh4eEMySDhraz0iLCJtYWMiOiJhNjlhYmE1MGFmZWM5MTlmZDYwN2U0MWQ4YTY3OGQzNzFkZjFkNTM5MTk1NGQ0ODE4MTBjMGUxZGNmNmEwOWE5In0=',1,NULL,3,'2021-03-10 03:00:09','2021-03-10 03:01:03'),(41,45,'CARDENAS','MICHAEL','eyJpdiI6Ik1nSWtTc3V3TUMxS0RoVmE0NWdsXC9nPT0iLCJ2YWx1ZSI6Ild6NmswQ3dUWHcyamZ0YUJqc2xidGJNNFpORWRrODllbkVuREI1dVhFTzQ9IiwibWFjIjoiZTRiODNjNTYyNTViYzU0YmFhMTE4NTdhZWJiYzkyYTBhNWNiY2Q1ODYyMzM0ZDUyMTZkM2EzNDM4ODIyNWZkMSJ9',1,NULL,1,'2021-03-10 03:04:04','2021-03-10 03:05:10');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-12 16:27:12