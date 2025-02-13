-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.10-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table fivem.player_data
CREATE TABLE IF NOT EXISTS `player_data` (
  `license` varchar(200) NOT NULL DEFAULT '0',
  `name` text DEFAULT NULL,
  `job` text DEFAULT NULL,
  `cash` int(200) DEFAULT NULL,
  `bank` int(200) DEFAULT NULL,
  `model` text DEFAULT NULL,
  `heat` int(200) DEFAULT 1,
  `weed` int(200) DEFAULT 1,
  `coke` int(200) DEFAULT 1,
  `meth` int(200) DEFAULT 1,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table fivem.player_data: ~1 rows (approximately)
INSERT INTO `player_data` (`license`, `name`, `job`, `cash`, `bank`, `model`, `heat`, `weed`, `coke`, `meth`) VALUES
	('steam:1100001129630ef', 'Vision', 'Dealer', 3115, 27500, 'mp_m_weapexp_01', 0, 100, 20, 10);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
