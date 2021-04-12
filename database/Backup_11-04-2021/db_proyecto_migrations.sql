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
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (23,'2016_06_01_000001_create_oauth_auth_codes_table',1),(24,'2016_06_01_000002_create_oauth_access_tokens_table',1),(25,'2016_06_01_000003_create_oauth_refresh_tokens_table',1),(26,'2016_06_01_000004_create_oauth_clients_table',1),(27,'2016_06_01_000005_create_oauth_personal_access_clients_table',1),(28,'2021_02_01_180250_create_zonas_table',1),(29,'2021_02_01_182401_create_invitados_table',1),(30,'2021_02_01_182540_create_eventos_table',1),(31,'2021_02_01_184731_create_usuarios_table',1),(32,'2021_02_01_184925_create_roles_table',1),(33,'2021_02_01_185209_create_carnets_table',1),(34,'2021_02_01_185448_create_trazabilidades_table',1),(35,'2021_02_01_185739_create_tipo_peticiones_table',1),(36,'2021_02_01_190054_create_peticiones_table',1),(37,'2021_02_01_190417_create_peticiones_certificados_table',1),(38,'2021_02_03_030205_create_formato_eventos_table',1),(39,'2021_02_03_030422_create_users_table',1),(40,'2021_02_03_030543_create_estados_table',1),(41,'2021_02_03_030634_create_modulos_lectores_table',1),(42,'2021_02_03_030754_create_password_resets_table',1),(43,'2021_02_03_030904_create_rangos_horarios_table',1),(44,'2021_03_29_032642_add_certificado_to_eventos',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-11 23:52:21
