-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla bd_proyecto.carnets
CREATE TABLE IF NOT EXISTS `carnets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_tarjeta` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `codigo_universitario` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zonas` json DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `carnets_id_tarjeta_unique` (`id_tarjeta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.carnets: ~0 rows (aproximadamente)
DELETE FROM `carnets`;
/*!40000 ALTER TABLE `carnets` DISABLE KEYS */;
/*!40000 ALTER TABLE `carnets` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.estados
CREATE TABLE IF NOT EXISTS `estados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `estado` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.estados: ~5 rows (aproximadamente)
DELETE FROM `estados`;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` (`id`, `estado`, `created_at`, `updated_at`) VALUES
	(1, 'HABILITADO', NULL, NULL),
	(2, 'DESHABILITADO', NULL, NULL),
	(3, 'CREADO', NULL, NULL),
	(4, 'CANCELADO', NULL, NULL),
	(5, 'FINALIZADO', NULL, NULL);
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.eventos
CREATE TABLE IF NOT EXISTS `eventos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `creador_evento` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `nombre_evento` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `visibilidad` varchar(13) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `horario` json DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `usuarios_externos_invitados` json DEFAULT NULL,
  `usuarios_registrados_invitados` json DEFAULT NULL,
  `asistentes` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.eventos: ~3 rows (aproximadamente)
DELETE FROM `eventos`;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` (`id`, `creador_evento`, `id_zona`, `nombre_evento`, `descripcion`, `visibilidad`, `horario`, `estado`, `usuarios_externos_invitados`, `usuarios_registrados_invitados`, `asistentes`, `created_at`, `updated_at`) VALUES
	(25, 5, 1, 'pruebaa', 'prueba prueba prueba prueba prueba pruebaqwqw', 'PUBLICA', '["2020-10-01 14:00:00", "2020-10-01 16:00:00", "2020-10-01 19:00:00", "2020-10-01 21:00:00"]', 1, NULL, NULL, NULL, '2020-08-02 17:33:23', '2020-08-02 17:35:44'),
	(26, 5, 1, 'ejemplo', 'ejemplo', 'PUBLICA', '["2020-10-01 14:00:00", "2020-10-01 16:00:00", "2020-10-01 19:00:00", "2020-10-01 21:00:00"]', 3, NULL, NULL, NULL, '2020-08-02 20:18:32', '2020-08-02 20:18:32'),
	(29, 5, 1, 'ejemplo 4', 'ejemplo 4', 'PUBLICA', '["2020-10-01 14:00:00", "2020-10-01 14:00:00", "2020-10-01 19:00:00", "2020-10-01 21:00:00"]', 3, NULL, NULL, NULL, '2020-08-02 20:28:06', '2020-08-02 20:28:06');
/*!40000 ALTER TABLE `eventos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.formato_eventos
CREATE TABLE IF NOT EXISTS `formato_eventos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `documento_plantilla` blob NOT NULL,
  `id_evento` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.formato_eventos: ~0 rows (aproximadamente)
DELETE FROM `formato_eventos`;
/*!40000 ALTER TABLE `formato_eventos` DISABLE KEYS */;
/*!40000 ALTER TABLE `formato_eventos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.horarios_eventos
CREATE TABLE IF NOT EXISTS `horarios_eventos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_evento` int(11) NOT NULL,
  `fecha` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.horarios_eventos: ~1 rows (aproximadamente)
DELETE FROM `horarios_eventos`;
/*!40000 ALTER TABLE `horarios_eventos` DISABLE KEYS */;
INSERT INTO `horarios_eventos` (`id`, `id_evento`, `fecha`, `created_at`, `updated_at`) VALUES
	(1, 25, '2012-01-01 00:00:00', NULL, NULL);
/*!40000 ALTER TABLE `horarios_eventos` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.invitados
CREATE TABLE IF NOT EXISTS `invitados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cedula` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `procedencia` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitados_cedula_unique` (`cedula`),
  UNIQUE KEY `invitados_correo_unique` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.invitados: ~0 rows (aproximadamente)
DELETE FROM `invitados`;
/*!40000 ALTER TABLE `invitados` DISABLE KEYS */;
/*!40000 ALTER TABLE `invitados` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.migrations: ~20 rows (aproximadamente)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
	(2, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
	(3, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
	(4, '2016_06_01_000004_create_oauth_clients_table', 1),
	(5, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
	(6, '2020_06_23_181335_create_zonas_table', 1),
	(7, '2020_06_23_184223_create_invitados_table', 1),
	(8, '2020_06_23_184339_create_eventos_table', 1),
	(9, '2020_07_18_142132_create_horarios_eventos_table', 1),
	(10, '2020_07_18_151319_create_usuarios_table', 1),
	(11, '2020_07_18_152237_create_roles_table', 1),
	(12, '2020_07_18_152515_create_carnets_table', 1),
	(13, '2020_07_18_153439_create_trazabilidades_table', 1),
	(14, '2020_07_18_163049_create_tipo_peticions_table', 1),
	(15, '2020_07_18_164558_create_peticiones_table', 1),
	(16, '2020_07_18_165129_create_peticiones_certificados_table', 1),
	(17, '2020_07_18_165825_create_formato_eventos_table', 1),
	(18, '2020_07_19_171029_create_users_table', 2),
	(19, '2020_07_26_203607_create_estados_table', 3),
	(20, '2020_07_26_215036_create_estados_table', 4);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
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

-- Volcando datos para la tabla bd_proyecto.oauth_access_tokens: ~14 rows (aproximadamente)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('0f7e6e4f5cba41439cddd78e168d04ee5c8c01fd10adf3616490abd4f49af68aa4ccdc181e138311', 3, 1, 'MyApp', '[]', 0, '2020-07-27 16:39:08', '2020-07-27 16:39:08', '2021-07-27 16:39:08'),
	('1c680bf9500f95a3d644349a62804f905d9e821252733b528a03d8c2f49a561c8eb64cebead833fc', 4, 1, 'MyApp', '[]', 0, '2020-07-27 17:01:27', '2020-07-27 17:01:27', '2021-07-27 17:01:27'),
	('1d2faad8f5e51ade89156a3d249b472bad945885c59e88e9b8ee479cf129a6cdaeba7f241038d7e5', 5, 2, NULL, '[]', 0, '2020-07-28 16:42:39', '2020-07-28 16:42:39', '2020-07-28 16:57:37'),
	('2d7e7f17889efd1265e68fff94b238e192c7725737306578e0bc997db0c2a55b0bc6fbaf93603d48', 5, 2, NULL, '[]', 0, '2020-08-02 04:09:44', '2020-08-02 04:09:44', '2020-08-02 04:24:44'),
	('459c5bb4809864f5ffc82e380bb176c7c8daa1d8498bc1f67b036e3a0e1ccb7b1d3bd0694816855f', 5, 2, NULL, '[]', 1, '2020-07-28 17:05:23', '2020-07-28 17:05:23', '2020-07-28 17:20:23'),
	('5838ef374e1a2e2887bc9f72143b8295e9ba24426071cd8b8176d78b2f63aa30b561f359443dd9ed', 5, 2, NULL, '[]', 0, '2020-08-02 04:31:34', '2020-08-02 04:31:34', '2020-08-02 04:46:34'),
	('8c090bff75f5a71d40ba44fd3997567f7784509d18a4418791974d691248af85f5fec4ff628dabc8', 5, 2, NULL, '[]', 0, '2020-08-02 20:17:11', '2020-08-02 20:17:11', '2020-08-02 20:32:10'),
	('a7c77b474cde0687f4e76c90bdfb7f33200cf7097988651f8a99a7dcac42a71f7989bcfeab8850cf', 5, 2, NULL, '[]', 0, '2020-07-28 23:12:30', '2020-07-28 23:12:30', '2020-07-28 23:27:27'),
	('a86263f107cc5ed97d414f22f46729415628edbc0df493940167e20b04fe7154cc73d566175116e3', 5, 2, NULL, '[]', 0, '2020-08-02 03:52:16', '2020-08-02 03:52:16', '2020-08-02 04:07:14'),
	('c8f60ecd6040ba764947b41ba7a78959d944c0a9ac073405991694c803b20bdb6d411911f8061ad4', 5, 2, NULL, '[]', 0, '2020-07-28 17:23:22', '2020-07-28 17:23:22', '2020-07-28 17:38:22'),
	('d33a69f728dd8b505efc40fd097420d26796b9fe838e18b338e1da9c489ad49d25089e139776e9df', 5, 2, NULL, '[]', 0, '2020-07-28 17:39:41', '2020-07-28 17:39:41', '2020-07-28 17:54:41'),
	('d3dc67e097c0c896d6e5441776efca01ef9e583d143fa6cc93b82f5b42c7f4fa5e50531c58409023', 5, 2, NULL, '[]', 0, '2020-08-02 17:32:44', '2020-08-02 17:32:44', '2020-08-02 17:47:44'),
	('e17ab5a2b08a65fbf71159d152b498f94e21d64e5ff438e0f6f2fd005b9ce68c65fed625e450e706', 5, 1, 'MyApp', '[]', 0, '2020-07-27 17:09:37', '2020-07-27 17:09:37', '2021-07-27 17:09:37'),
	('fceaeb6493e8704284255ae8a07755b005dc1cbbff7748d2ab9ff948689078a436457bd64b749175', 5, 2, NULL, '[]', 0, '2020-07-28 19:21:45', '2020-07-28 19:21:45', '2020-07-28 19:36:43');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.oauth_auth_codes: ~0 rows (aproximadamente)
DELETE FROM `oauth_auth_codes`;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.oauth_clients: ~2 rows (aproximadamente)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', '2Emjy4alv5MrBw4hrt15FmPTqRis3cLdmnzmZsq5', 'http://localhost', 1, 0, 0, '2020-07-19 17:00:44', '2020-07-19 17:00:44'),
	(2, NULL, 'Laravel Password Grant Client', 'VT3KzMIQFxt4DBPX5HbKxAnvfT4BQStBY64XsKRh', 'http://localhost', 0, 1, 0, '2020-07-19 17:00:44', '2020-07-19 17:00:44');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.oauth_personal_access_clients: ~1 rows (aproximadamente)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2020-07-19 17:00:44', '2020-07-19 17:00:44');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.oauth_refresh_tokens: ~11 rows (aproximadamente)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('190308111465936c59fd4de43eb830890d94b63988a6ae2fb7219d32f2fe8146732bcd2592456218', 'fceaeb6493e8704284255ae8a07755b005dc1cbbff7748d2ab9ff948689078a436457bd64b749175', 0, '2020-08-12 19:21:44'),
	('21d8086c50dd01a9b070f8a0c5caa1c4fda03fd20b9384a2b95350bb40798d7349884e072177ca16', '1d2faad8f5e51ade89156a3d249b472bad945885c59e88e9b8ee479cf129a6cdaeba7f241038d7e5', 0, '2020-08-12 16:42:38'),
	('48d3360080f198c9f3b0ed8bbf6b899926f866cea3843ee6271445b05d1bcc18837f2908a02269e6', 'd33a69f728dd8b505efc40fd097420d26796b9fe838e18b338e1da9c489ad49d25089e139776e9df', 0, '2020-08-12 17:39:41'),
	('6f002c626169106018fc27a9ddf374d8a3987840945d806e07cea166a0570a249bc7ff4d36fe587e', 'c8f60ecd6040ba764947b41ba7a78959d944c0a9ac073405991694c803b20bdb6d411911f8061ad4', 0, '2020-08-12 17:23:22'),
	('9ca85ee8439109ba70812234f5980c5c0c0d8cc29696030f07d54662276b62919684e6c2dcf7f4c2', 'd3dc67e097c0c896d6e5441776efca01ef9e583d143fa6cc93b82f5b42c7f4fa5e50531c58409023', 0, '2020-08-17 17:32:44'),
	('a3c8e3c824779bacb864586116f12e27f9e7003593794f10bc9ff2ad8a7bf9b82238fb00dd937c89', '2d7e7f17889efd1265e68fff94b238e192c7725737306578e0bc997db0c2a55b0bc6fbaf93603d48', 0, '2020-08-17 04:09:44'),
	('a98c48b307f5fdaf803e791d3e5e0db2d2ec176295f2393a9d619184a9778c1c8c307aa704c4108c', 'a7c77b474cde0687f4e76c90bdfb7f33200cf7097988651f8a99a7dcac42a71f7989bcfeab8850cf', 0, '2020-08-12 23:12:28'),
	('be8e3df795e2ce502a04ea88bfd54eb422e92785e6c786139f2ff4f2f8d211233c59f06cd1313b98', '5838ef374e1a2e2887bc9f72143b8295e9ba24426071cd8b8176d78b2f63aa30b561f359443dd9ed', 0, '2020-08-17 04:31:34'),
	('d5844ebb9e31d03d6f899eab918922d6f96c8f6513541e98a6279650afe22d33a864b8eecace61cd', '459c5bb4809864f5ffc82e380bb176c7c8daa1d8498bc1f67b036e3a0e1ccb7b1d3bd0694816855f', 1, '2020-08-12 17:05:23'),
	('ea5f2306cf1e45986ccd06fac8cdb00853a951b724d8c15c0b94e2622cfa48b6e11ecea01f888e74', 'a86263f107cc5ed97d414f22f46729415628edbc0df493940167e20b04fe7154cc73d566175116e3', 0, '2020-08-17 03:52:14'),
	('eb5d67b0d0a9aa8d6f6de52dbb659e8d75ba68ca619710f56750bdecc999ca380b14b70bde12d63b', '8c090bff75f5a71d40ba44fd3997567f7784509d18a4418791974d691248af85f5fec4ff628dabc8', 0, '2020-08-17 20:17:10');
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.peticiones
CREATE TABLE IF NOT EXISTS `peticiones` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `fecha_radicacion` timestamp NOT NULL,
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  `tipo_peticion` int(11) NOT NULL,
  `documentos` json DEFAULT NULL,
  `respuesta` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.peticiones: ~0 rows (aproximadamente)
DELETE FROM `peticiones`;
/*!40000 ALTER TABLE `peticiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `peticiones` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.peticiones_certificados
CREATE TABLE IF NOT EXISTS `peticiones_certificados` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_formato` int(11) NOT NULL,
  `id_evento` int(11) NOT NULL,
  `fecha_radicado` timestamp NOT NULL,
  `fecha_respuesta` timestamp NULL DEFAULT NULL,
  `respuesta` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.peticiones_certificados: ~0 rows (aproximadamente)
DELETE FROM `peticiones_certificados`;
/*!40000 ALTER TABLE `peticiones_certificados` DISABLE KEYS */;
/*!40000 ALTER TABLE `peticiones_certificados` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_rol_unique` (`rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.roles: ~4 rows (aproximadamente)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `rol`, `created_at`, `updated_at`) VALUES
	(1, 'Administrador', NULL, NULL),
	(2, 'Administrativo', NULL, NULL),
	(3, 'Docente', NULL, NULL),
	(4, 'Estudiante', NULL, NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.tipo_peticions
CREATE TABLE IF NOT EXISTS `tipo_peticions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `peticion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.tipo_peticions: ~0 rows (aproximadamente)
DELETE FROM `tipo_peticions`;
/*!40000 ALTER TABLE `tipo_peticions` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipo_peticions` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.trazabilidades
CREATE TABLE IF NOT EXISTS `trazabilidades` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_carnet` int(11) NOT NULL,
  `id_zona` int(11) NOT NULL,
  `fecha_ingreso` timestamp NULL DEFAULT NULL,
  `fecha_salida` timestamp NULL DEFAULT NULL,
  `resultado` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.trazabilidades: ~0 rows (aproximadamente)
DELETE FROM `trazabilidades`;
/*!40000 ALTER TABLE `trazabilidades` DISABLE KEYS */;
/*!40000 ALTER TABLE `trazabilidades` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.users: ~1 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
	(5, 'mleandrocardenas@ucundinamarca.edu.co', '$2y$10$FvXahC7CE8rAdG9aG/2PGunEGlrtx8x/PH/6FDA5bs99vsxtYs8M.', NULL, '2020-07-27 17:09:37', '2020-07-27 17:09:37');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) DEFAULT NULL,
  `apellidos` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombres` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identificacion` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `foto` blob NOT NULL,
  `id_rol` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.usuarios: ~1 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `id_user`, `apellidos`, `nombres`, `identificacion`, `estado`, `foto`, `id_rol`, `created_at`, `updated_at`) VALUES
	(3, 5, 'Perezz', 'Michael', '1070000', 1, _binary 0x757365722F666F746F342E6A7067, 1, '2020-07-27 17:09:37', '2020-07-27 17:09:37');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.zonas
CREATE TABLE IF NOT EXISTS `zonas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_zona` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_lector` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `sede` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `zonas_codigo_lector_unique` (`codigo_lector`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.zonas: ~1 rows (aproximadamente)
DELETE FROM `zonas`;
/*!40000 ALTER TABLE `zonas` DISABLE KEYS */;
INSERT INTO `zonas` (`id`, `nombre_zona`, `codigo_lector`, `estado`, `sede`, `created_at`, `updated_at`) VALUES
	(1, 'CIT', '2020_lector022555', 2, 'facatativa', '2020-07-19 19:29:34', '2020-07-30 19:18:23');
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
