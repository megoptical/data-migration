-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table home.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_slug` varchar(70) COLLATE utf8mb4_unicode_ci NOT NULL,
  `posturl_slug` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(550) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` varchar(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_parent_id_foreign` (`parent_id`),
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.categories: ~5 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `order`, `name`, `name_slug`, `posturl_slug`, `description`, `type`, `disabled`, `created_at`, `updated_at`, `language`, `parent_id`) VALUES
	(1, '1', 'News', 'news', 'news', 'News enables you to share the latest breaking news content on the web.', 'news', '0', NULL, NULL, 'en', NULL),
	(2, '2', 'Lists', 'lists', 'list', 'Create most interesting viral lists on your site and share with all your friends.', 'list', '0', NULL, NULL, 'en', NULL),
	(3, '3', 'Quizzes', 'quizzes', 'quiz', 'Get start to make great viral quizzes with Buzzy Quizzes Plugin TODAY!', 'quiz', '0', NULL, NULL, 'en', NULL),
	(4, '4', 'Polls', 'polls', 'poll', 'Polls are awesome! Share all questions in your mind! Learn the other people thoughts.', 'poll', '0', NULL, NULL, 'en', NULL),
	(5, '5', 'Videos', 'videos', 'video', 'Share post popular, funny videos.', 'video', '0', NULL, NULL, 'en', NULL);

-- Dumping structure for table home.comments
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `spoiler` tinyint(1) NOT NULL DEFAULT 0,
  `approve` tinyint(1) NOT NULL DEFAULT 0,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_post_id_foreign` (`post_id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_parent_id_foreign` (`parent_id`),
  CONSTRAINT `comments_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.comments: ~0 rows (approximately)
DELETE FROM `comments`;

-- Dumping structure for table home.comment_reports
DROP TABLE IF EXISTS `comment_reports`;
CREATE TABLE IF NOT EXISTS `comment_reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_reports_comment_id_foreign` (`comment_id`),
  KEY `comment_reports_user_id_foreign` (`user_id`),
  CONSTRAINT `comment_reports_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.comment_reports: ~0 rows (approximately)
DELETE FROM `comment_reports`;

-- Dumping structure for table home.comment_votes
DROP TABLE IF EXISTS `comment_votes`;
CREATE TABLE IF NOT EXISTS `comment_votes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vote` tinyint(1) NOT NULL DEFAULT 1,
  `ipno` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comment_votes_comment_id_foreign` (`comment_id`),
  KEY `comment_votes_user_id_foreign` (`user_id`),
  KEY `comment_votes_vote_index` (`vote`),
  CONSTRAINT `comment_votes_comment_id_foreign` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_votes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.comment_votes: ~0 rows (approximately)
DELETE FROM `comment_votes`;

-- Dumping structure for table home.contacts
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE IF NOT EXISTS `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `label_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(155) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read` tinyint(1) DEFAULT NULL,
  `stared` tinyint(1) DEFAULT NULL,
  `important` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.contacts: ~0 rows (approximately)
DELETE FROM `contacts`;

-- Dumping structure for table home.entries
DROP TABLE IF EXISTS `entries`;
CREATE TABLE IF NOT EXISTS `entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `video` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `source` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entrys_post_id_index` (`post_id`),
  KEY `entrys_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.entries: ~0 rows (approximately)
DELETE FROM `entries`;

-- Dumping structure for table home.feeds
DROP TABLE IF EXISTS `feeds`;
CREATE TABLE IF NOT EXISTS `feeds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_fetcher` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `post_categories` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_user_id` int(11) NOT NULL,
  `post_fetch_count` int(11) NOT NULL DEFAULT 10,
  `checked_at` timestamp NULL DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.feeds: ~0 rows (approximately)
DELETE FROM `feeds`;

-- Dumping structure for table home.followers
DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `followed_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `followers_user_id_foreign` (`user_id`),
  KEY `followers_followed_id_foreign` (`followed_id`),
  CONSTRAINT `followers_followed_id_foreign` FOREIGN KEY (`followed_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `followers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.followers: ~0 rows (approximately)
DELETE FROM `followers`;

-- Dumping structure for table home.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.jobs: ~0 rows (approximately)
DELETE FROM `jobs`;

-- Dumping structure for table home.languages
DROP TABLE IF EXISTS `languages`;
CREATE TABLE IF NOT EXISTS `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `direction` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ltr',
  `order` int(11) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `languages_direction_index` (`direction`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.languages: ~78 rows (approximately)
DELETE FROM `languages`;
INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `order`, `active`) VALUES
	(1, 'Afrikaans', 'af', 'ltr', 0, 0),
	(2, 'Irish', 'ga', 'ltr', 1, 0),
	(3, 'Albanian', 'sq', 'ltr', 2, 0),
	(4, 'Italian', 'it', 'ltr', 3, 1),
	(5, 'Arabic', 'ar', 'rtl', 4, 1),
	(6, 'Japanese', 'ja', 'ltr', 5, 0),
	(7, 'Azerbaijani', 'az', 'ltr', 6, 0),
	(8, 'Kannada', 'kn', 'ltr', 7, 0),
	(9, 'Basque', 'eu', 'ltr', 8, 0),
	(10, 'Korean', 'ko', 'ltr', 9, 0),
	(11, 'Bengali', 'bn', 'ltr', 10, 0),
	(12, 'Croatian', 'bs', 'ltr', 11, 0),
	(13, 'Finnish', 'fi', 'ltr', 12, 0),
	(14, 'Hebrew', 'he', 'ltr', 13, 0),
	(15, 'Armenian', 'hy', 'ltr', 14, 0),
	(16, 'Kazakh', 'kk', 'ltr', 15, 0),
	(17, 'Mongolian', 'mn', 'ltr', 16, 0),
	(18, 'Marathi', 'mr', 'ltr', 17, 0),
	(19, 'Latin', 'la', 'ltr', 18, 0),
	(20, 'Belarusian', 'be', 'ltr', 19, 0),
	(21, 'Latvian', 'lv', 'ltr', 20, 0),
	(22, 'Bulgarian', 'bg', 'ltr', 21, 0),
	(23, 'Lithuanian', 'lt', 'ltr', 22, 0),
	(24, 'Catalan', 'ca', 'ltr', 23, 0),
	(25, 'Macedonian', 'mk', 'ltr', 24, 0),
	(26, 'Chinese Simplified', 'zh_CN', 'ltr', 25, 0),
	(27, 'Chinese Traditional', 'zh_TW', 'ltr', 26, 0),
	(28, 'Malay', 'ms', 'ltr', 27, 0),
	(29, 'Maltese', 'mt', 'ltr', 28, 0),
	(30, 'Croatian', 'hr', 'ltr', 29, 0),
	(31, 'Norwegian', 'no', 'ltr', 30, 0),
	(32, 'Czech', 'cs', 'ltr', 31, 0),
	(33, 'Persian', 'fa', 'rtl', 32, 0),
	(34, 'Danish', 'da', 'ltr', 33, 0),
	(35, 'Polish', 'pl', 'ltr', 34, 0),
	(36, 'Dutch', 'nl', 'ltr', 35, 1),
	(37, 'Portuguese', 'pt', 'ltr', 36, 1),
	(38, 'Portuguese (Brazil)', 'pt_BR', 'ltr', 37, 0),
	(39, 'English', 'en', 'ltr', 38, 1),
	(40, 'Romanian', 'ro', 'ltr', 39, 0),
	(41, 'Esperanto', 'eo', 'ltr', 40, 0),
	(42, 'Russian', 'ru', 'ltr', 41, 1),
	(43, 'Estonian', 'et', 'ltr', 42, 0),
	(44, 'Serbian (Cyrillic)', 'sr_Cyrl', 'ltr', 43, 0),
	(45, 'Serbian (Latin)', 'sr_Latn', 'ltr', 44, 0),
	(46, 'Filipino', 'tl', 'ltr', 45, 0),
	(47, 'Slovak', 'sk', 'ltr', 46, 0),
	(48, 'Slovenian', 'sl', 'ltr', 47, 0),
	(49, 'French', 'fr', 'ltr', 48, 0),
	(50, 'Spanish', 'es', 'ltr', 49, 1),
	(51, 'Galician', 'gl', 'ltr', 50, 0),
	(52, 'Swahili', 'sw', 'ltr', 51, 0),
	(53, 'Georgian', 'ka', 'ltr', 52, 0),
	(54, 'Swedish', 'sv', 'ltr', 53, 0),
	(55, 'German', 'de', 'ltr', 54, 0),
	(56, 'Tamil', 'ta', 'ltr', 55, 0),
	(57, 'Greek', 'el', 'ltr', 56, 0),
	(58, 'Telugu', 'te', 'ltr', 57, 0),
	(59, 'Gujarati', 'gu', 'ltr', 58, 0),
	(60, 'Thai', 'th', 'ltr', 59, 0),
	(61, 'Tajik', 'tj', 'ltr', 60, 0),
	(62, 'Turkmen', 'tk', 'ltr', 61, 0),
	(63, 'Uyghur', 'ug', 'ltr', 62, 0),
	(64, 'Haitian Creole', 'ht', 'ltr', 63, 0),
	(65, 'Turkish', 'tr', 'ltr', 64, 1),
	(66, 'Hebrew', 'iw', 'ltr', 65, 0),
	(67, 'Nepali', 'ne', 'ltr', 66, 0),
	(68, 'Ukrainian', 'uk', 'ltr', 67, 0),
	(69, 'Hindi', 'hi', 'ltr', 68, 0),
	(70, 'Urdu', 'ur', 'rtl', 69, 0),
	(71, 'Uzbek (Cyrillic)', 'uz_Cyrl', 'ltr', 70, 0),
	(72, 'Uzbek (Latin)', 'uz_Latn', 'ltr', 71, 0),
	(73, 'Hungarian', 'hu', 'ltr', 72, 0),
	(74, 'Vietnamese', 'vi', 'ltr', 73, 0),
	(75, 'Icelandic', 'is', 'ltr', 74, 0),
	(76, 'Welsh', 'cy', 'ltr', 75, 0),
	(77, 'Indonesian', 'id', 'ltr', 76, 0),
	(78, 'Yiddish', 'yi', 'rtl', 77, 0);

-- Dumping structure for table home.ltm_translations
DROP TABLE IF EXISTS `ltm_translations`;
CREATE TABLE IF NOT EXISTS `ltm_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL DEFAULT 0,
  `locale` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `group` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.ltm_translations: ~0 rows (approximately)
DELETE FROM `ltm_translations`;

-- Dumping structure for table home.menus
DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `order` int(10) unsigned NOT NULL DEFAULT 0,
  `custom_class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.menus: ~4 rows (approximately)
DELETE FROM `menus`;
INSERT INTO `menus` (`id`, `name`, `slug`, `location`, `active`, `order`, `custom_class`, `created_at`, `updated_at`) VALUES
	(1, 'Main Menu', 'main-menu', 'main-menu', 1, 0, NULL, '2022-07-30 04:07:20', '2022-07-30 04:07:20'),
	(2, 'Mobile Menu', 'mobile-menu', 'mobile-menu', 1, 0, NULL, '2022-07-30 04:07:20', '2022-07-30 04:07:20'),
	(3, 'Mega Menu', 'mega-menu', 'mega-menu', 1, 0, NULL, '2022-07-30 04:07:20', '2022-07-30 04:07:20'),
	(4, 'Footer Menu', 'footer-menu', 'footer-menu', 1, 0, NULL, '2022-07-30 04:07:20', '2022-07-30 04:07:20');

-- Dumping structure for table home.menu_items
DROP TABLE IF EXISTS `menu_items`;
CREATE TABLE IF NOT EXISTS `menu_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `target` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `order` int(10) unsigned NOT NULL DEFAULT 0,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_class` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.menu_items: ~10 rows (approximately)
DELETE FROM `menu_items`;
INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `parent_id`, `order`, `icon`, `custom_class`, `created_at`, `updated_at`, `language`) VALUES
	(1, 1, 'News', '/news', '_self', NULL, 1, 'library_books', NULL, '2022-07-30 04:07:20', '2022-07-30 04:07:20', 'en'),
	(2, 2, 'News', '/news', '_self', NULL, 1, 'library_books', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(3, 1, 'Lists', '/lists', '_self', NULL, 2, 'collections', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(4, 2, 'Lists', '/lists', '_self', NULL, 2, 'collections', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(5, 1, 'Quizzes', '/quizzes', '_self', NULL, 3, 'quiz', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(6, 2, 'Quizzes', '/quizzes', '_self', NULL, 3, 'quiz', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(7, 1, 'Polls', '/polls', '_self', NULL, 4, 'library_add_check', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(8, 2, 'Polls', '/polls', '_self', NULL, 4, 'library_add_check', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(9, 1, 'Videos', '/videos', '_self', NULL, 5, 'video_library', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en'),
	(10, 2, 'Videos', '/videos', '_self', NULL, 5, 'video_library', NULL, '2022-07-30 04:07:21', '2022-07-30 04:07:21', 'en');

-- Dumping structure for table home.messages
DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.messages: ~0 rows (approximately)
DELETE FROM `messages`;

-- Dumping structure for table home.message_participants
DROP TABLE IF EXISTS `message_participants`;
CREATE TABLE IF NOT EXISTS `message_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `thread_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `last_read` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.message_participants: ~0 rows (approximately)
DELETE FROM `message_participants`;

-- Dumping structure for table home.message_threads
DROP TABLE IF EXISTS `message_threads`;
CREATE TABLE IF NOT EXISTS `message_threads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.message_threads: ~0 rows (approximately)
DELETE FROM `message_threads`;

-- Dumping structure for table home.migrations
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.migrations: ~42 rows (approximately)
DELETE FROM `migrations`;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_04_02_193005_create_translations_table', 1),
	(2, '2014_10_12_000000_create_users_table', 1),
	(3, '2014_10_12_100000_create_password_resets_table', 1),
	(4, '2015_09_15_105839_create_posts_table', 1),
	(5, '2015_09_15_172559_create_categories_table', 1),
	(6, '2015_09_22_133125_create_pool_votes_table', 1),
	(7, '2015_09_25_110638_create_entrys_table', 1),
	(8, '2015_09_29_073303_create_popularity_stats_table', 1),
	(9, '2015_10_06_171448_create_pages_table', 1),
	(10, '2015_10_06_195254_create_widget_table', 1),
	(11, '2015_11_01_075837_create_reaction_votes_table', 1),
	(12, '2015_11_24_162414_create_followers_table', 1),
	(13, '2015_11_27_114411_create_contacts_table', 1),
	(14, '2017_05_23_112745_create_reactions_table', 1),
	(15, '2019_08_16_210046_update_tables_to_v3', 1),
	(16, '2020_07_15_110757_add_menu_item_show_column_to_categories_table', 1),
	(17, '2021_02_09_102216_create_message_threads_table', 1),
	(18, '2021_02_09_102225_create_messages_table', 1),
	(19, '2021_02_09_103754_create_message_participants_table', 1),
	(20, '2021_02_11_200836_create_menus_table', 1),
	(21, '2021_02_11_200857_create_menu_items_table', 1),
	(22, '2021_02_20_232149_add_language_column_to_posts_table', 1),
	(23, '2021_06_01_161445_add_email_verified_at_column_to_users_table', 1),
	(24, '2021_06_30_142909_add_language_column_to_menu_items_table', 1),
	(25, '2021_07_29_161214_create_feeds_table', 1),
	(26, '2021_07_31_003032_add_language_column_to_categories_table', 1),
	(27, '2021_07_31_012952_create_post_categories_table', 1),
	(28, '2021_07_31_215216_create_tags_table', 1),
	(29, '2021_07_31_215638_create_taggables_table', 1),
	(30, '2021_08_01_121545_add_parent_id_column_to_categories_table', 1),
	(31, '2021_08_01_133358_drop_main_column_from_categories_table', 1),
	(32, '2021_08_01_133734_drop_menu_icon_show_column_from_categories_table', 1),
	(33, '2021_08_02_163127_create_jobs_table', 1),
	(34, '2021_08_08_142517_create_languages_table', 1),
	(35, '2021_09_26_120021_create_add_indexes_to_columns', 1),
	(36, '2021_10_14_151041_drop_posts_columns_table', 1),
	(37, '2022_01_05_102147_update_tables_to_v475', 1),
	(38, '2022_01_05_105547_create_comments_table', 1),
	(39, '2022_01_05_105616_create_comment_votes_table', 1),
	(40, '2022_01_05_105641_create_comment_reports_table', 1),
	(41, '2022_01_11_131418_add_social_profiles_column_to_users_table', 1),
	(42, '2022_02_03_104755_add_language_column_to_reactions_table', 1);

-- Dumping structure for table home.pages
DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `footer` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.pages: ~0 rows (approximately)
DELETE FROM `pages`;

-- Dumping structure for table home.password_resets
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.password_resets: ~0 rows (approximately)
DELETE FROM `password_resets`;

-- Dumping structure for table home.poll_votes
DROP TABLE IF EXISTS `poll_votes`;
CREATE TABLE IF NOT EXISTS `poll_votes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.poll_votes: ~0 rows (approximately)
DELETE FROM `poll_votes`;

-- Dumping structure for table home.popularity_stats
DROP TABLE IF EXISTS `popularity_stats`;
CREATE TABLE IF NOT EXISTS `popularity_stats` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `trackable_id` bigint(20) unsigned NOT NULL,
  `trackable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `one_day_stats` int(11) NOT NULL DEFAULT 0,
  `seven_days_stats` int(11) NOT NULL DEFAULT 0,
  `thirty_days_stats` int(11) NOT NULL DEFAULT 0,
  `all_time_stats` int(11) NOT NULL DEFAULT 0,
  `raw_stats` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.popularity_stats: ~0 rows (approximately)
DELETE FROM `popularity_stats`;

-- Dumping structure for table home.posts
DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `categories` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ordertype` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(225) COLLATE utf8mb4_unicode_ci NOT NULL,
  `body` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thumb` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `approve` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_in_homepage` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shared` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tags` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pagination` int(11) DEFAULT NULL,
  `featured_at` timestamp NULL DEFAULT NULL,
  `published_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  PRIMARY KEY (`id`),
  KEY `posts_user_id_index` (`user_id`),
  KEY `posts_category_id_index` (`category_id`),
  KEY `posts_categories_index` (`categories`),
  KEY `posts_type_index` (`type`),
  KEY `posts_title_index` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.posts: ~0 rows (approximately)
DELETE FROM `posts`;

-- Dumping structure for table home.post_categories
DROP TABLE IF EXISTS `post_categories`;
CREATE TABLE IF NOT EXISTS `post_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `post_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `post_categories_category_id_foreign` (`category_id`),
  KEY `post_categories_post_id_foreign` (`post_id`),
  CONSTRAINT `post_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `post_categories_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.post_categories: ~0 rows (approximately)
DELETE FROM `post_categories`;

-- Dumping structure for table home.reactions
DROP TABLE IF EXISTS `reactions`;
CREATE TABLE IF NOT EXISTS `reactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL,
  `user_id` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reaction_type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.reactions: ~0 rows (approximately)
DELETE FROM `reactions`;

-- Dumping structure for table home.reactions_icons
DROP TABLE IF EXISTS `reactions_icons`;
CREATE TABLE IF NOT EXISTS `reactions_icons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ord` int(11) NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reaction_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT 'en',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.reactions_icons: ~8 rows (approximately)
DELETE FROM `reactions_icons`;
INSERT INTO `reactions_icons` (`id`, `ord`, `icon`, `name`, `reaction_type`, `display`, `created_at`, `updated_at`, `language`) VALUES
	(1, 1, '/assets/images/reactions/awesome.gif', 'AWESOME!', 'awesome', 'on', NULL, NULL, 'en'),
	(2, 2, '/assets/images/reactions/nice.png', 'NICE', 'nice', 'on', NULL, NULL, 'en'),
	(3, 3, '/assets/images/reactions/loved.gif', 'LOVED', 'loved', 'on', NULL, NULL, 'en'),
	(4, 4, '/assets/images/reactions/lol.gif', 'LOL', 'loL', 'on', NULL, NULL, 'en'),
	(5, 5, '/assets/images/reactions/funny.gif', 'FUNNY', 'funny', 'on', NULL, NULL, 'en'),
	(6, 6, '/assets/images/reactions/fail.gif', 'FAIL!', 'fail', 'on', NULL, NULL, 'en'),
	(7, 7, '/assets/images/reactions/wow.gif', 'OMG!', 'omg', 'on', NULL, NULL, 'en'),
	(8, 8, '/assets/images/reactions/cry.gif', 'EW!', 'ew', 'on', NULL, NULL, 'en');

-- Dumping structure for table home.taggables
DROP TABLE IF EXISTS `taggables`;
CREATE TABLE IF NOT EXISTS `taggables` (
  `tag_id` bigint(20) unsigned NOT NULL,
  `taggable_id` bigint(20) unsigned NOT NULL,
  `taggable_type` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  UNIQUE KEY `taggables_tag_id_taggable_id_user_id_taggable_type_unique` (`tag_id`,`taggable_id`,`user_id`,`taggable_type`),
  KEY `taggables_tag_id_taggable_id_taggable_type_index` (`tag_id`,`taggable_id`,`taggable_type`),
  KEY `taggables_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.taggables: ~0 rows (approximately)
DELETE FROM `taggables`;

-- Dumping structure for table home.tags
DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'custom',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tags_slug_index` (`slug`),
  KEY `tags_type_index` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.tags: ~7 rows (approximately)
DELETE FROM `tags`;
INSERT INTO `tags` (`id`, `name`, `slug`, `icon`, `color`, `type`, `created_at`, `updated_at`) VALUES
	(1, 'Inbox', 'inbox', 'inbox', NULL, 'mailcat', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(2, 'Sent', 'sent', 'envelope-o', NULL, 'mailcat', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(3, 'Drafts', 'drafts', 'file-text-o', NULL, 'mailcat', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(4, 'Junk', 'junk', 'filter', NULL, 'mailcat', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(5, 'Trash', 'trash', 'trash-o', NULL, 'mailcat', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(6, 'Advertisement', 'advertisement', '', NULL, 'maillabel', '2022-07-30 04:07:19', '2022-07-30 04:07:19'),
	(7, 'Other', 'other', '', NULL, 'maillabel', '2022-07-30 04:07:20', '2022-07-30 04:07:20');

-- Dumping structure for table home.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `usertype` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username_slug` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `town` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `splash` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `facebook_id` int(11) DEFAULT NULL,
  `about` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facebookurl` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `twitterurl` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `weburl` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `updated_at` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `social_profiles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`social_profiles`)),
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_username_slug_unique` (`username_slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.users: ~1 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `usertype`, `username`, `username_slug`, `name`, `town`, `genre`, `splash`, `icon`, `email`, `password`, `facebook_id`, `about`, `facebookurl`, `twitterurl`, `weburl`, `remember_token`, `created_at`, `updated_at`, `email_verified_at`, `social_profiles`) VALUES
	(1, 'Admin', 'admin', 'admin', NULL, NULL, NULL, NULL, NULL, 'admin@admin.com', '$2y$10$RVcdvnzrdhx2f8k5Umpn6.iNDgMKvmZQ3wYd7MEzKITvSkEqYBvGK', NULL, NULL, NULL, NULL, NULL, 'wp0ca4voNz', '2022-07-30 07:07:17', '2022-07-30 07:07:17', NULL, NULL);

-- Dumping structure for table home.widgets
DROP TABLE IF EXISTS `widgets`;
CREATE TABLE IF NOT EXISTS `widgets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `display` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `showweb` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `showmobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table home.widgets: ~0 rows (approximately)
DELETE FROM `widgets`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
