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

-- Volcando datos para la tabla bd_proyecto.estados: ~4 rows (aproximadamente)
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.eventos: ~0 rows (aproximadamente)
DELETE FROM `eventos`;
/*!40000 ALTER TABLE `eventos` DISABLE KEYS */;
INSERT INTO `eventos` (`id`, `creador_evento`, `id_zona`, `nombre_evento`, `descripcion`, `visibilidad`, `horario`, `estado`, `usuarios_externos_invitados`, `usuarios_registrados_invitados`, `asistentes`, `created_at`, `updated_at`) VALUES
	(1, 5, 1, 'ejemplo 4', 'ejemplo 4', 'PUBLICA', '["2020-10-01 14:00:00", "2020-10-01 16:00:00"]', 1, NULL, NULL, NULL, '2020-08-24 23:12:50', '2020-08-24 23:12:50');
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

-- Volcando datos para la tabla bd_proyecto.horarios_eventos: ~0 rows (aproximadamente)
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

-- Volcando datos para la tabla bd_proyecto.migrations: ~17 rows (aproximadamente)
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

-- Volcando datos para la tabla bd_proyecto.oauth_access_tokens: ~28 rows (aproximadamente)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('0c760ba8670cd0871852dc169ac4a48838e4f30cfd79db694611d52bdeae9aa26ef039bd1bb6983c', 7, 1, 'MyApp', '[]', 0, '2020-08-21 22:43:12', '2020-08-21 22:43:12', '2021-08-21 22:43:12'),
	('1c425a4fac8d64160e6bede26910d7b6a177deecdd60a420a86356bc09e79a46340f25708dafe3e8', 22, 1, 'MyApp', '[]', 0, '2020-08-22 23:56:47', '2020-08-22 23:56:47', '2021-08-22 23:56:47'),
	('209848251ff72604fc7997d7087678ad527afab56777be1232e5635de5aea99b79894ac9a820066b', 3, 1, 'MyApp', '[]', 0, '2020-08-21 22:25:11', '2020-08-21 22:25:11', '2021-08-21 22:25:11'),
	('275b921de751bf25f9a2fa8919017685595c82259b0e4aab6d82b5f77a7b54ea1e8b90bc963acd29', 2, 1, 'MyApp', '[]', 0, '2020-08-21 22:09:49', '2020-08-21 22:09:49', '2021-08-21 22:09:49'),
	('38cc41758822942465ae81df5d019f82de6fe8b01c33738a6803deb1f8f7ab63dfdac0f526ec78f5', 11, 1, 'MyApp', '[]', 0, '2020-08-21 23:25:26', '2020-08-21 23:25:26', '2021-08-21 23:25:26'),
	('3a121eae6f98c2ee96abe6566d4ac84602d6df5e0aa45c4bd540fba6ec173cf54f7ad2f7fefc4a86', 2, 1, 'MyApp', '[]', 0, '2020-08-25 17:33:35', '2020-08-25 17:33:35', '2021-08-25 17:33:35'),
	('4527dc85daa6ac9ee6039e2abadb654b3c1d72949a0ab1f458658fbc29b1d9e8ad44a726b0d63b95', 1, 1, 'MyApp', '[]', 0, '2020-08-25 17:31:03', '2020-08-25 17:31:03', '2021-08-25 17:31:03'),
	('4710397d6a1d68ec8b56dd3baf6513091302f149e53188c1f16cc7a975c7aa82a1fcf67069b9cf47', 9, 1, 'MyApp', '[]', 0, '2020-08-21 22:47:45', '2020-08-21 22:47:45', '2021-08-21 22:47:45'),
	('6801c93a64aceda47230c25ccf373d11e2c0a004a8495c4860f0e47f0f56eca753cdefb61d6d4f8b', 4, 1, 'MyApp', '[]', 0, '2020-08-25 21:34:03', '2020-08-25 21:34:03', '2021-08-25 21:34:03'),
	('6bb45cb2ffdf391bf50896a9b79eea6e49bfdc68ad5836b34f48fb8a2216b398c0210ae90b6c3e94', 10, 1, 'MyApp', '[]', 0, '2020-08-21 23:03:40', '2020-08-21 23:03:40', '2021-08-21 23:03:40'),
	('7d10aa3c413bce4e2644fe38c92cbd5ef786871dd5040e1e23bf1e5273499bc3529073e13b72aec1', 18, 1, 'MyApp', '[]', 0, '2020-08-22 23:05:54', '2020-08-22 23:05:54', '2021-08-22 23:05:54'),
	('9341353b00e3dc4d46b326a573683e865c32a0840f89fb965e3d28c26d5e5aa8bdd66c0327e223f3', 6, 1, 'MyApp', '[]', 0, '2020-08-21 22:40:35', '2020-08-21 22:40:35', '2021-08-21 22:40:35'),
	('93414731e4922e035d79cdec1be4c6f83c2b7f8a4461e3e7ca3c4dbcb20a257493a5dbdcfa337482', 6, 1, 'MyApp', '[]', 0, '2020-08-27 19:22:15', '2020-08-27 19:22:15', '2021-08-27 19:22:15'),
	('9b5aef6f1e205df5a9141519cb12926271ccf95ed83fc850816f2154c3e18ba5203d5f0ca6de6786', 5, 1, 'MyApp', '[]', 0, '2020-08-21 22:35:27', '2020-08-21 22:35:27', '2021-08-21 22:35:27'),
	('9bd68e318376ab2adb049b2da869eeb3bac216b97de7bb48c7258505134744c78cd528f4a16de7be', 13, 1, 'MyApp', '[]', 0, '2020-08-21 23:41:09', '2020-08-21 23:41:09', '2021-08-21 23:41:09'),
	('a914d3f05b6a3c7389f1a4ef3031bfc36fe2d8683898f7fed2feea827e0f7491c3c09786496cde59', 19, 1, 'MyApp', '[]', 0, '2020-08-22 23:13:46', '2020-08-22 23:13:46', '2021-08-22 23:13:46'),
	('aa645f7012bc6c8c8395dffae296280715833a260c7c61ca3ae3e9d4ff4919a991b7266c0b14c0e2', 20, 1, 'MyApp', '[]', 0, '2020-08-22 23:24:31', '2020-08-22 23:24:31', '2021-08-22 23:24:31'),
	('abcc59e25ac87fc06a6538f0391b28283193a8e99804278e587c4e54cc5c35c4b4b9836b39be62bf', 8, 1, 'MyApp', '[]', 0, '2020-08-21 22:44:59', '2020-08-21 22:44:59', '2021-08-21 22:44:59'),
	('ad50661320539109faf29b631e148433c396888eb17aa1b63e55d0eccf5b2c1b59d99c819b7a4bb7', 14, 1, 'MyApp', '[]', 0, '2020-08-21 23:42:31', '2020-08-21 23:42:31', '2021-08-21 23:42:31'),
	('b31572ce05c6b45769641270007ef3045e9c58787e1dba118529066003807a897f84accaf2de54e0', 12, 1, 'MyApp', '[]', 0, '2020-08-21 23:40:34', '2020-08-21 23:40:34', '2021-08-21 23:40:34'),
	('bb9de9937e183ea60878ec6c8ad4bf5008c39ad4d791e6574232385d2183c4fc8f5017fd7acdd42f', 17, 1, 'MyApp', '[]', 0, '2020-08-22 23:02:45', '2020-08-22 23:02:45', '2021-08-22 23:02:45'),
	('c6136f4fa2c8be40dcfa9d444e3394f06675814bb58e94cc7111255f42f033d0e6493fa6f0dd22b3', 5, 1, 'MyApp', '[]', 0, '2020-08-25 02:14:20', '2020-08-25 02:14:20', '2021-08-25 02:14:20'),
	('cd32dcb14f1cb4ef71e1af30ab0d2bd826918ecc76337cb5c6f78bbb71c97977df6c98a1da585854', 3, 1, 'MyApp', '[]', 0, '2020-08-25 00:13:43', '2020-08-25 00:13:43', '2021-08-25 00:13:43'),
	('cf2e7114b2ef0aab3ff4d5520411bbc544da8c058f4cb4d093ffdb001e2e39ec936cf59d1e135c68', 1, 1, 'MyApp', '[]', 0, '2020-08-21 21:59:32', '2020-08-21 21:59:32', '2021-08-21 21:59:32'),
	('d48cc8ebf655563837aca7febf5587653e9a546eae40e650341bfec91a9e0d892fc9d2fd0d4cd670', 15, 1, 'MyApp', '[]', 0, '2020-08-22 22:50:07', '2020-08-22 22:50:07', '2021-08-22 22:50:07'),
	('d6e8428cc4e67e75a05da7a091ae95b099fc8215cfadee12166d5cd561738c86758649de225dffcb', 16, 1, 'MyApp', '[]', 0, '2020-08-22 22:58:38', '2020-08-22 22:58:38', '2021-08-22 22:58:38'),
	('dc08523d11e61a296c332cfdd3868a3c65cd5a7c77879f55528c4014851699e2ffd8fd5c4a628a80', 1, 1, 'MyApp', '[]', 0, '2020-08-23 16:48:41', '2020-08-23 16:48:41', '2021-08-23 16:48:41'),
	('e0d3f3332e00c2b7b0e57078fd1f906b642e60b6458edb17bd6567ff8446649c2c58a360728798a9', 6, 1, 'MyApp', '[]', 0, '2020-08-21 21:04:32', '2020-08-21 21:04:32', '2021-08-21 21:04:32'),
	('e15b20f7235731ef075bef772426eabb695b26bef78f3ae316639cd6809e72395df93ab4349b2061', 3, 1, 'MyApp', '[]', 0, '2020-08-25 17:34:35', '2020-08-25 17:34:35', '2021-08-25 17:34:35'),
	('e3cd3f44e7b19e4517e581013715240c61db1facc61ea0b71696534f952227297c577d39befcad29', 6, 2, NULL, '[]', 0, '2020-08-27 19:25:38', '2020-08-27 19:25:38', '2020-08-27 19:40:38'),
	('ecc0be9858d9bff12aecf94119a9fa8ceca261a77912b1b3feedc0ab523b965fc363e5ab3b30d571', 4, 1, 'MyApp', '[]', 0, '2020-08-21 22:34:14', '2020-08-21 22:34:14', '2021-08-21 22:34:14'),
	('efea79e82f5dea78664b053e7b4f8d3ec19aff3c31a1000376cb4f1d718c8377cd7ede69ca3dc983', 4, 1, 'MyApp', '[]', 0, '2020-08-25 01:48:07', '2020-08-25 01:48:07', '2021-08-25 01:48:07'),
	('f342cf44d3af66d66ebcd7a4864b936a6c87d0237d2f96f72ca3e1f31a7d666ab10152507102f38d', 21, 1, 'MyApp', '[]', 0, '2020-08-22 23:28:48', '2020-08-22 23:28:48', '2021-08-22 23:28:48'),
	('f8da6b1f5eca727bbfb866f3361ffc22946946fda07e43aaf56a276545789e83db15732bf8a09e70', 2, 1, 'MyApp', '[]', 0, '2020-08-24 22:28:56', '2020-08-24 22:28:56', '2021-08-24 22:28:56'),
	('faf4a1547a45f99e42a5b2999c6455e57c94ed9333202dbce8ae50696f89d388d3c09f85d7017476', 5, 1, 'MyApp', '[]', 0, '2020-08-27 19:21:27', '2020-08-27 19:21:27', '2021-08-27 19:21:27');
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

-- Volcando datos para la tabla bd_proyecto.oauth_personal_access_clients: ~0 rows (aproximadamente)
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

-- Volcando datos para la tabla bd_proyecto.oauth_refresh_tokens: ~0 rows (aproximadamente)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('7bc61540a34e71ebbb2b4efa9ccdee636334671c4abe9ff8519feedc506747f6ce9635706a4ec1a0', 'e3cd3f44e7b19e4517e581013715240c61db1facc61ea0b71696534f952227297c577d39befcad29', 0, '2020-09-11 19:25:38');
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
  `confirmado` tinyint(4) NOT NULL DEFAULT '0',
  `codigo_confirmacion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.users: ~0 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Volcando estructura para tabla bd_proyecto.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_user` int(10) DEFAULT NULL,
  `apellidos` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombres` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `identificacion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `foto` blob,
  `id_rol` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.usuarios: ~0 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.zonas: ~0 rows (aproximadamente)
DELETE FROM `zonas`;
/*!40000 ALTER TABLE `zonas` DISABLE KEYS */;
INSERT INTO `zonas` (`id`, `nombre_zona`, `codigo_lector`, `estado`, `sede`, `created_at`, `updated_at`) VALUES
	(1, 'CIT', '2020_lector022555', 2, 'facatativa', '2020-07-19 19:29:34', '2020-07-30 19:18:23'),
	(4, 'CIT 2', '2020_lector022555asasas', 1, 'facatativa', '2020-08-27 19:31:52', '2020-08-27 19:31:52');
/*!40000 ALTER TABLE `zonas` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
