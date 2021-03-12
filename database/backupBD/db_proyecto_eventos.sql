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
-- Table structure for table `eventos`
--

DROP TABLE IF EXISTS `eventos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creador_evento` int(11) NOT NULL,
  `zona` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre_evento` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibilidad` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `horario` json DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventos`
--

LOCK TABLES `eventos` WRITE;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` VALUES (14,44,'2','Capacitacion docentes','Capacitacion docentes obligatoria','INSTITUCIONAL','\"[{\\\"fecha\\\":\\\"11/3/2021\\\",\\\"hora\\\":[\\\"10:00 a 11:00\\\",\\\"11:00 a 12:00\\\"]},{\\\"fecha\\\":\\\"12/3/2021\\\",\\\"hora\\\":[\\\"08:00 a 09:00\\\",\\\"09:00 a 10:00\\\",\\\"16:00 a 17:00\\\",\\\"17:00 a 18:00\\\"]}]\"',1,'2021-03-11 18:53:24','2021-03-13 01:55:11'),(15,44,'3','Capacitacion estudiantes','Capacitacion estudiantes obligatoria','INSTITUCIONAL','\"[{\\\"fecha\\\":\\\"11/3/2021\\\",\\\"hora\\\":[\\\"10:00 a 11:00\\\",\\\"11:00 a 12:00\\\",\\\"12:00 a 13:00\\\"]},{\\\"fecha\\\":\\\"13/3/2021\\\",\\\"hora\\\":[\\\"08:00 a 09:00\\\",\\\"09:00 a 10:00\\\",\\\"10:00 a 11:00\\\"]},{\\\"fecha\\\":\\\"1/4/2021\\\",\\\"hora\\\":[\\\"08:00 a 09:00\\\",\\\"09:00 a 10:00\\\"]}]\"',3,'2021-03-11 18:59:07','2021-03-13 01:54:47'),(16,44,'3','Capacitacion administratios','Capacitacion administratios obligaoria estara el señor decano','PRIVADA','\"[{\\\"fecha\\\":\\\"25/3/2021\\\",\\\"hora\\\":[\\\"09:00 a 10:00\\\",\\\"10:00 a 11:00\\\"]}]\"',3,'2021-03-11 19:13:07','2021-03-13 01:54:33'),(22,44,'3','EJEMPLO CRUCES','EJEMPLLO CRUCES','PRIVADA','\"[{\\\"fecha\\\":\\\"25/3/2021\\\",\\\"hora\\\":[\\\"10:00 a 11:00\\\",\\\"11:00 a 12:00\\\"]}]\"',1,'2021-03-12 02:48:21','2021-03-13 01:54:56'),(23,44,'3','Capacitacion dos','Capacitacion dos','PRIVADA','\"[{\\\"fecha\\\":\\\"13/3/2021\\\",\\\"hora\\\":[\\\"09:00 a 10:00\\\",\\\"10:00 a 11:00\\\",\\\"14:00 a 15:00\\\"]},{\\\"fecha\\\":\\\"1/4/2021\\\",\\\"hora\\\":[\\\"12:00 a 13:00\\\",\\\"13:00 a 14:00\\\"]}]\"',1,'2021-03-12 22:28:04','2021-03-13 01:54:52');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-12 16:27:08
