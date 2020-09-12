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

-- Volcando datos para la tabla bd_proyecto.oauth_access_tokens: ~21 rows (aproximadamente)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('0debb4b9522e8a481ed6f1a35d0d2d3bf7a9411bdb100efa447c9a2ec8c1f4f6799bdebaca12b04c', 4, 2, NULL, '[]', 0, '2020-09-11 23:54:35', '2020-09-11 23:54:35', '2020-09-12 00:09:35'),
	('177bfd8c2178e2d66490264c1de528f89dce4d6438686b76bdd43c6acffa8caba7581022cf02a503', 4, 2, NULL, '[]', 0, '2020-09-11 23:39:53', '2020-09-11 23:39:53', '2020-09-11 23:54:31'),
	('1921375516dfe8365d33b24916b6b9336c8b59d5355a4a5ed155d760109fd5e967afb4d3754a0f2e', 4, 2, NULL, '[]', 0, '2020-09-11 21:12:46', '2020-09-11 21:12:46', '2020-09-11 21:27:46'),
	('28189c2f0601035c857ad704adab2b739126e1e36bd7cb964ddf7d8170457bf75f85efb9c07bc47b', 4, 2, NULL, '[]', 0, '2020-09-11 21:13:18', '2020-09-11 21:13:18', '2020-09-11 21:28:18'),
	('30423c9f8dd952f33c416c9bb76c7b3fc148943c4da3cab742061519e54eba4df1da02e01187861a', 4, 2, NULL, '[]', 0, '2020-09-11 16:13:13', '2020-09-11 16:13:13', '2020-09-11 16:28:12'),
	('33ed5e87e2f356b9f276cfda339ca48f2865bc50925479e38b306867f99ed36ae14355ca568d4e45', 4, 2, NULL, '[]', 0, '2020-09-11 23:50:08', '2020-09-11 23:50:08', '2020-09-12 00:05:08'),
	('3598792bfa1b731d5148e29c1f7c300e6ef1cb50e56fa95296719425893a13677a8e1fcdad042f40', 4, 2, NULL, '[]', 0, '2020-09-11 23:40:56', '2020-09-11 23:40:56', '2020-09-11 23:55:56'),
	('35cb6b3b551a6e4aed3e46100d4ee3b0f96879f5e4c27dd261370a350e78fdc01005a6a6e8194735', 3, 2, NULL, '[]', 0, '2020-09-11 23:56:07', '2020-09-11 23:56:07', '2020-09-12 00:11:06'),
	('4757d533728195560b25c82e0497fa5943b0446d08e01a9714927e36ef9576efbb2b2c07bdad59e1', 4, 2, NULL, '[]', 0, '2020-09-12 17:03:45', '2020-09-12 17:03:45', '2020-09-12 17:04:45'),
	('475bb14214b4d69f1d33f7f771fe2d7b0a9802dc08c6cd125741c624abfb25d5fce5e7b001fab6c6', 4, 2, NULL, '[]', 0, '2020-09-11 19:12:37', '2020-09-11 19:12:37', '2020-09-11 19:27:36'),
	('5cba045916c8763f08932e3bd50b4e5df77e03e8fead8efc2a7407ff0270d246261fb6fa7de2cceb', 4, 2, NULL, '[]', 0, '2020-09-12 13:36:02', '2020-09-12 13:36:02', '2020-09-12 13:50:59'),
	('6422339cc552b9b513ebb92690d5233264947e13cdf63c7570ab1efc0ec3cde10e934b6a22f63ad2', 1, 2, NULL, '[]', 0, '2020-09-11 21:16:49', '2020-09-11 21:16:49', '2020-09-11 21:31:49'),
	('98f54c637bf6e67be91a9cb704b3a3531dd5c23d93e77f22920ac462971e43012bbcaeaa34883473', 4, 2, NULL, '[]', 0, '2020-09-11 21:13:04', '2020-09-11 21:13:04', '2020-09-11 21:28:04'),
	('aaec137d81b69c53f3569bb87ac7934dfc7ab5f4ed5274877cf95e838c25bb47310f174f77be07aa', 4, 2, NULL, '[]', 1, '2020-09-12 16:35:09', '2020-09-12 16:35:09', '2020-09-12 16:47:09'),
	('b01d6bbe5fba63f6db1d9d5898ae9deae007b3292f7fd6931b8ec06a955c08e90dd0901b581b3647', 4, 2, NULL, '[]', 0, '2020-09-11 21:13:26', '2020-09-11 21:13:26', '2020-09-11 21:28:26'),
	('b19d8df1e0976871bbf2ed5a17e63b3820a4b672c44f3dcabb63079140573b758c1e9c29f63852b4', 4, 2, NULL, '[]', 0, '2020-09-11 19:04:39', '2020-09-11 19:04:39', '2020-09-11 19:19:39'),
	('c098a223b11d3650275906dae0178c52ea2934635a029c7b45c062f2fcdcd40f35d6a69c344320fb', 4, 2, NULL, '[]', 0, '2020-09-11 21:14:43', '2020-09-11 21:14:43', '2020-09-11 21:29:43'),
	('c6627acd3d1ef9268b9e3668ce418beb364fe2954c36f80886f0d37061e1ee900ec76fb7043b7dad', 4, 2, NULL, '[]', 1, '2020-09-12 17:02:29', '2020-09-12 17:02:29', '2020-09-12 17:03:29'),
	('cecaaaf55b8c9fe6b0e9c1d21b44c249254049b268cb818a1fbf9e4fe4ea6de980faf2601ed33753', 1, 2, NULL, '[]', 0, '2020-09-11 21:17:00', '2020-09-11 21:17:00', '2020-09-11 21:32:00'),
	('e198e32fe4775ba7f37e02f141d41b51662a826f37bb6604ce8ecfe6a2b23a3dfea01ecf0ceaf67f', 4, 2, NULL, '[]', 0, '2020-09-11 21:15:00', '2020-09-11 21:15:00', '2020-09-11 21:30:00'),
	('e6fe9001d3608b9d346815555c50764522e747af4752c1d7443b0137780dd14b7ffb4590546acd5d', 4, 2, NULL, '[]', 0, '2020-09-12 15:55:12', '2020-09-12 15:55:12', '2020-09-12 16:10:12'),
	('e7095df942310d54d14502b76000b331c47e3a8dc8013f6abc9bfa4a1277aea3ba2107d159a86a84', 4, 2, NULL, '[]', 0, '2020-09-11 21:08:49', '2020-09-11 21:08:49', '2020-09-11 21:23:49'),
	('ee1e656feb3bbc381fd71bd505c1d2f24e3a4f81ea49b83f2df61c7dcc2e42d4569b7d2785cd4edb', 4, 2, NULL, '[]', 0, '2020-09-11 23:54:37', '2020-09-11 23:54:37', '2020-09-12 00:09:37'),
	('ee7dd985f8778798f897fd4a00ee7d99ec270003684a5348a1f6f595e945e920b116f1514c004d50', 4, 2, NULL, '[]', 0, '2020-09-11 21:14:34', '2020-09-11 21:14:34', '2020-09-11 21:29:34'),
	('ef8812ba66bb45ef194864213c0d025bf9c3b86e8380d76aad52ca702b75e045354b2b77d5f07ce4', 4, 2, NULL, '[]', 0, '2020-09-12 15:53:59', '2020-09-12 15:53:59', '2020-09-12 16:08:59'),
	('f02c39a6a2882e9720edddc80e57b0e0e9c029803b8ea01771de98d92870048e0625421429c52427', 4, 2, NULL, '[]', 1, '2020-09-12 17:00:32', '2020-09-12 17:00:32', '2020-09-12 17:01:32'),
	('f22e5cc42891dee01b34c6024974c6576d292784afc65420bfc0411c30bb57adee96a1886dcda76e', 4, 2, NULL, '[]', 1, '2020-09-11 20:51:13', '2020-09-11 20:51:13', '2020-09-11 21:06:12'),
	('f553eac15fd48c6d75b4b834e25f570e02af1f10176fb3111cc4a698002d498f308d99ca90a184a7', 4, 2, NULL, '[]', 0, '2020-09-11 16:14:14', '2020-09-11 16:14:14', '2020-09-11 16:29:14'),
	('f7ce4be32667073f515f656ef6d262b77d71171ed82fe6b6c43c92ee57a43b655d74aeadf00e3326', 4, 2, NULL, '[]', 0, '2020-09-12 16:49:51', '2020-09-12 16:49:51', '2020-09-12 17:01:51');
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

-- Volcando datos para la tabla bd_proyecto.oauth_refresh_tokens: ~18 rows (aproximadamente)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
INSERT INTO `oauth_refresh_tokens` (`id`, `access_token_id`, `revoked`, `expires_at`) VALUES
	('06682f3f2608e2d858c7928b0e91c08d929c3206c85daa33fbe452e27f382acd775c826f94ddb607', '5cba045916c8763f08932e3bd50b4e5df77e03e8fead8efc2a7407ff0270d246261fb6fa7de2cceb', 0, '2020-09-27 13:35:59'),
	('06a3dd4cb52009f388d6b2c013f92652d3ed9f882edc91d6ef8a576a1169c5ff620f1a83c5adbb30', 'cecaaaf55b8c9fe6b0e9c1d21b44c249254049b268cb818a1fbf9e4fe4ea6de980faf2601ed33753', 0, '2020-09-26 21:17:00'),
	('1f51dd8acadf87d3fbaee7c0df623c529ac61652c975a73174572ed7331bbae5db5e52dc7182e717', '28189c2f0601035c857ad704adab2b739126e1e36bd7cb964ddf7d8170457bf75f85efb9c07bc47b', 0, '2020-09-26 21:13:18'),
	('23919b926d746bca7030c1dcf232d1dd7e8c67a0a3f807de5901bff68978433de97838b6f6f03890', 'f7ce4be32667073f515f656ef6d262b77d71171ed82fe6b6c43c92ee57a43b655d74aeadf00e3326', 0, '2020-09-24 16:49:51'),
	('2a5d6d19c70c8865a7ee9c8392279372e2d87d47d7d1f024d9ca6b0f84db84e756bce850c68272ac', 'aaec137d81b69c53f3569bb87ac7934dfc7ab5f4ed5274877cf95e838c25bb47310f174f77be07aa', 1, '2020-09-24 16:35:09'),
	('30f7a73505f07142cc876364731cf6c93a493da0aead81fc2ac53d60e47443c3003e23e7fc26cfa1', '3598792bfa1b731d5148e29c1f7c300e6ef1cb50e56fa95296719425893a13677a8e1fcdad042f40', 0, '2020-09-26 23:40:56'),
	('4c06f564466e69f5b0be83ab46dd987f479ccacc004a03a57107bc58610c646724dc0d3395d2cf59', 'ee7dd985f8778798f897fd4a00ee7d99ec270003684a5348a1f6f595e945e920b116f1514c004d50', 0, '2020-09-26 21:14:34'),
	('4c09838835aad3b8e0894568cd935cf54421cd8e9c007c4c81271ba496c46af052a41149d2c07820', 'ee1e656feb3bbc381fd71bd505c1d2f24e3a4f81ea49b83f2df61c7dcc2e42d4569b7d2785cd4edb', 0, '2020-09-26 23:54:37'),
	('4d090fc2e80af023e7793587be35d5aee372e287b9e48851e4e5eecef3798363538fe664b34b8591', 'c098a223b11d3650275906dae0178c52ea2934635a029c7b45c062f2fcdcd40f35d6a69c344320fb', 0, '2020-09-26 21:14:43'),
	('4dd0ff6ee5f43c747c2eb1239b302e34b293c5c12ccade1f35068f79c7c3ee38d6423cce1825b481', 'b01d6bbe5fba63f6db1d9d5898ae9deae007b3292f7fd6931b8ec06a955c08e90dd0901b581b3647', 0, '2020-09-26 21:13:26'),
	('51dc118bcd5478ebfc8d5cef354c58212fb5cd7623f0e375f403f099d0b461d8fb73175e4a82ff64', 'f553eac15fd48c6d75b4b834e25f570e02af1f10176fb3111cc4a698002d498f308d99ca90a184a7', 0, '2020-09-26 16:14:14'),
	('571d1dca5f61a63cab21d2764ee0c04c58f6e364ab749e002a6c96914b407eb53c0ee1f79e413317', '177bfd8c2178e2d66490264c1de528f89dce4d6438686b76bdd43c6acffa8caba7581022cf02a503', 0, '2020-09-26 23:39:31'),
	('605e482d4550a75c811ad3afb8ce0664149b316f107023a91845806650b532d59ef5e637af4b7d52', 'ef8812ba66bb45ef194864213c0d025bf9c3b86e8380d76aad52ca702b75e045354b2b77d5f07ce4', 0, '2020-09-27 15:54:00'),
	('7836ebb904240e1f1aa022f1fd97546f7629505feb0eb987038668bb1281df74b55aa81189837ab9', 'e198e32fe4775ba7f37e02f141d41b51662a826f37bb6604ce8ecfe6a2b23a3dfea01ecf0ceaf67f', 0, '2020-09-26 21:15:00'),
	('7ba14641fe1114dd47da02d1ae6c6f90b9cf1ad29454ec0a10baa0c4572a8f0ef5baebb55c72aeba', 'e7095df942310d54d14502b76000b331c47e3a8dc8013f6abc9bfa4a1277aea3ba2107d159a86a84', 0, '2020-09-26 21:08:49'),
	('7de3c8f4527b9128c7c2f5cd5ba72a2c01b75c5c01de2b842e03a859263fae4078b727e6fdd502b1', '4757d533728195560b25c82e0497fa5943b0446d08e01a9714927e36ef9576efbb2b2c07bdad59e1', 0, '2020-09-24 17:03:45'),
	('836ab6f1cbd910718a03d850cf2ffb3ca082b038d5a32de69ce521bc38371c70b72cc856f48b9df8', '6422339cc552b9b513ebb92690d5233264947e13cdf63c7570ab1efc0ec3cde10e934b6a22f63ad2', 0, '2020-09-26 21:16:49'),
	('9443c378ce2eefceba6b45ada160a309e181c177bb9ccd393516cb815b1c559c9dbceec9b2b7515c', 'b19d8df1e0976871bbf2ed5a17e63b3820a4b672c44f3dcabb63079140573b758c1e9c29f63852b4', 0, '2020-09-26 19:04:39'),
	('96d777c4cc240946621abd3838e271857d1d80697e962af73a266d0c30a7349b4c12db9cd1e0c460', '35cb6b3b551a6e4aed3e46100d4ee3b0f96879f5e4c27dd261370a350e78fdc01005a6a6e8194735', 0, '2020-09-26 23:56:07'),
	('ab9aba06090397534b59b425e3355722e31ebbba3a2d07871d078e360bfe91de356e6099219f9def', '1921375516dfe8365d33b24916b6b9336c8b59d5355a4a5ed155d760109fd5e967afb4d3754a0f2e', 0, '2020-09-26 21:12:46'),
	('b2285c9fbd86a4c56f960551efb1c2faa09e5e4e40c313494f74bb9a4d56da00164bcb9232a0df4e', 'f22e5cc42891dee01b34c6024974c6576d292784afc65420bfc0411c30bb57adee96a1886dcda76e', 1, '2020-09-26 20:51:12'),
	('ba52300baee9cfefd7979c92e91a51f0321578f712936b92a75ec59ae2eec4c71c58946adcd91c13', '33ed5e87e2f356b9f276cfda339ca48f2865bc50925479e38b306867f99ed36ae14355ca568d4e45', 0, '2020-09-26 23:50:08'),
	('d22a9b85867aa17a09e574f01742205ce345e3508a85a2653d61cc438ef89881869799701fc0ef9d', '30423c9f8dd952f33c416c9bb76c7b3fc148943c4da3cab742061519e54eba4df1da02e01187861a', 0, '2020-09-26 16:13:13'),
	('eb1c60a94fa22f84af9dbcacd541db041491de65241fb5f4787c125e764975dd53c31869ee92a7c8', '0debb4b9522e8a481ed6f1a35d0d2d3bf7a9411bdb100efa447c9a2ec8c1f4f6799bdebaca12b04c', 0, '2020-09-26 23:54:35'),
	('edbfe07f48cb11755fb25aff87d1f49495e5218f062bed7a94cfacf0bf0c43ad23a7e51bf88d15cd', 'c6627acd3d1ef9268b9e3668ce418beb364fe2954c36f80886f0d37061e1ee900ec76fb7043b7dad', 1, '2020-09-24 17:02:29'),
	('eff25dbf1259f05402b92d7b5632246d07b40c21b707034a914c3601c7e364957c8bdc08ab00dbab', '98f54c637bf6e67be91a9cb704b3a3531dd5c23d93e77f22920ac462971e43012bbcaeaa34883473', 0, '2020-09-26 21:13:04'),
	('f86e8325a5c1f1a11ec02b3753aaf88e7f3a1a8d2eed66b750db6bb7bdba147baac391a8e3d3f3e5', 'f02c39a6a2882e9720edddc80e57b0e0e9c029803b8ea01771de98d92870048e0625421429c52427', 1, '2020-09-24 17:00:32'),
	('f8de3c9f71fa21a408b342b20bfaae81d046497a2f88704ea4ecafb8b4f335945c2a893e85c16913', 'e6fe9001d3608b9d346815555c50764522e747af4752c1d7443b0137780dd14b7ffb4590546acd5d', 0, '2020-09-27 15:55:12'),
	('ff81ef290e781f254057972a0a7d758087012e811c83bf008d6243b94996688af35b4f375df8b598', '475bb14214b4d69f1d33f7f771fe2d7b0a9802dc08c6cd125741c624abfb25d5fce5e7b001fab6c6', 0, '2020-09-26 19:12:36');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.users: ~4 rows (aproximadamente)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `email`, `password`, `confirmado`, `codigo_confirmacion`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'mleandrocardenas@ucundinamarca.edu.co', '$2y$10$jwUvvmq6rtKxCHAvUvi3W.lnVYIRikZAQR8N3/wPMSrjBguI9EOii', 0, 'nracGKCSJ6xWVYGHpNTHVLZMg', NULL, '2020-09-08 15:31:17', '2020-09-08 15:31:17'),
	(2, 'jeandrade@ucundinamarca.edu.co', '$2y$10$rRzBRND0HsHt/6stNk1tfeLU8Ri33b06oBUxLJdKrYMyAPcW4tTY6', 0, '52XLN5SxOKcqCicGdMKygxeuA', NULL, '2020-09-08 15:32:29', '2020-09-08 15:32:29'),
	(3, 'sistemas@ucundinamarca.edu.co', '$2y$10$XTrmxiNgfG22gjyj2M30JO4RzSM9HD8zix4pnFru9IlS0NrdPFn9q', 0, '1lOrZgS9PEii63S12G4se64Da', NULL, '2020-09-08 15:34:16', '2020-09-08 15:34:16'),
	(4, 'admin@ucundinamarca.edu.co', '$2y$10$X8Kt4u2pvpgjwvgLi3CieO2sCu4/PprAgrfL8CVptZGksocasXvc2', 0, 'rxKu9jByc0Jv3Fnwv8kyWHjRP', NULL, '2020-09-08 15:37:05', '2020-09-08 15:37:05');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `identificacion` (`identificacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla bd_proyecto.usuarios: ~4 rows (aproximadamente)
DELETE FROM `usuarios`;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` (`id`, `id_user`, `apellidos`, `nombres`, `identificacion`, `estado`, `foto`, `id_rol`, `created_at`, `updated_at`) VALUES
	(1, 1, 'CARDENAS VILLAMIL', 'MICHAEL LEANDRO', '970828123461', 1, NULL, 4, '2020-09-08 15:31:22', '2020-09-08 15:31:22'),
	(2, 2, 'ANDRADE RAMIREZ', 'JAIME EDUARDO', '1079823456', 1, NULL, 3, '2020-09-08 15:32:29', '2020-09-08 15:32:29'),
	(3, 3, 'ROA', 'GLADYS', '1069823456', 1, NULL, 2, '2020-09-08 15:34:16', '2020-09-08 15:34:16'),
	(4, 4, 'PARRA', 'JAIME', '1029123456', 1, NULL, 1, '2020-09-08 15:37:06', '2020-09-08 15:37:06');
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
