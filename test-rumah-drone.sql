-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for test-rumah-drone
CREATE DATABASE IF NOT EXISTS `test-rumah-drone` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `test-rumah-drone`;

-- Dumping structure for table test-rumah-drone.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.failed_jobs: ~0 rows (approximately)

-- Dumping structure for table test-rumah-drone.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.migrations: ~9 rows (approximately)
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(3, '2019_08_19_000000_create_failed_jobs_table', 1),
	(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(5, '2024_02_19_132818_create_products_table', 2),
	(6, '2024_02_20_054605_create_orders_table', 3),
	(7, '2024_02_20_054832_create_order_details_table', 3),
	(8, '2024_02_20_135531_create_notifications_table', 4),
	(9, '2024_02_20_181222_create_reports_table', 5);

-- Dumping structure for table test-rumah-drone.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.notifications: ~0 rows (approximately)

-- Dumping structure for table test-rumah-drone.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `order_status` varchar(50) NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.orders: ~7 rows (approximately)
INSERT INTO `orders` (`id`, `order_date`, `order_status`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(8, '2024-02-20 01:05:54', 'Pending', '2024-02-20 01:05:54', '2024-02-20 01:05:54', NULL),
	(35, '2024-02-20 13:07:41', 'Pending', '2024-02-20 13:07:41', '2024-02-20 13:07:41', NULL),
	(36, '2024-02-20 13:08:24', 'Pending', '2024-02-20 13:08:24', '2024-02-20 13:08:24', NULL),
	(37, '2024-02-20 13:09:39', 'Pending', '2024-02-20 13:09:39', '2024-02-20 13:09:39', NULL),
	(38, '2024-02-20 13:12:07', 'Pending', '2024-02-20 13:12:07', '2024-02-20 13:12:07', NULL),
	(39, '2024-02-20 13:13:36', 'Pending', '2024-02-20 13:13:36', '2024-02-20 13:13:36', NULL),
	(40, '2024-02-20 13:14:38', 'Pending', '2024-02-20 13:14:38', '2024-02-20 13:14:38', NULL);

-- Dumping structure for table test-rumah-drone.order_details
CREATE TABLE IF NOT EXISTS `order_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` varchar(255) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `amount_in` int(11) NOT NULL DEFAULT 0,
  `amount_out` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.order_details: ~7 rows (approximately)
INSERT INTO `order_details` (`id`, `order_id`, `product_name`, `amount_in`, `amount_out`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(3, '8', 'Produk 7', 0, 12345, '2024-02-20 01:05:54', '2024-02-20 01:05:54', NULL),
	(36, '8', 'Produk 9', 0, 10, '2024-02-20 13:07:41', '2024-02-20 13:07:41', NULL),
	(37, '8', 'Produk 6', 0, 10, '2024-02-20 13:08:24', '2024-02-20 13:08:24', NULL),
	(38, '8', 'Produk 6', 0, 10, '2024-02-20 13:09:39', '2024-02-20 13:09:39', NULL),
	(39, '8', 'Produk 9', 0, 10, '2024-02-20 13:12:07', '2024-02-20 13:12:07', NULL),
	(40, '8', 'Produk 9', 0, 10, '2024-02-20 13:13:36', '2024-02-20 13:13:36', NULL),
	(41, '8', 'Produk 8', 0, 10, '2024-02-20 13:14:38', '2024-02-20 13:14:38', NULL);

-- Dumping structure for table test-rumah-drone.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.password_reset_tokens: ~0 rows (approximately)

-- Dumping structure for table test-rumah-drone.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table test-rumah-drone.products
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_initial_stock` int(11) NOT NULL,
  `product_stock` int(11) NOT NULL,
  `product_min_stock` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.products: ~10 rows (approximately)
INSERT INTO `products` (`id`, `product_name`, `product_initial_stock`, `product_stock`, `product_min_stock`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Samsung Galaxy S24', 100, 10, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(2, 'Produk 2', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(3, 'Produk 3', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(4, 'Produk 4', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(5, 'Produk 5', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(6, 'Produk 6', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(7, 'Produk 7', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(8, 'Produk 8', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-20 12:55:29', NULL),
	(9, 'Produk 9', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(10, 'Produk 10', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(11, 'Produk 11', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:18:45', NULL),
	(12, 'Produk 12', 100, 100, 10, '2024-02-19 20:18:30', '2024-02-19 20:39:22', '2024-02-19 20:39:22');

-- Dumping structure for table test-rumah-drone.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `report_name` varchar(255) NOT NULL,
  `report_view` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.reports: ~0 rows (approximately)
INSERT INTO `reports` (`id`, `report_name`, `report_view`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Inventory Report', 'report/inventory', '2024-02-20 18:29:51', '2024-02-20 18:29:52', NULL);

-- Dumping structure for table test-rumah-drone.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','staff') NOT NULL DEFAULT 'admin',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table test-rumah-drone.users: ~0 rows (approximately)
INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin@mail.com', NULL, '$2y$12$7SGCtPlH2.jzMQAGNAAUION1GG4u02tHtniTcJhWtsJei/L3/B5sa', 'admin', NULL, '2024-02-19 03:01:15', '2024-02-19 03:01:15'),
	(2, 'staff', 'staff@mail.com', NULL, '$2y$12$ntONpE/MDDhXhrNqcUdy..NX2zhiiP6EV5HSV8uMTmqSIPxXs0e06', 'staff', NULL, '2024-02-19 21:36:56', '2024-02-19 21:36:56');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
