-- MySQL dump 10.13  Distrib 8.0.19, for macos10.15 (x86_64)
--
-- Host: localhost    Database: imdb
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `Production_Countries`
--

DROP TABLE IF EXISTS `Production_Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Production_Countries` (
  `iso_3166_1` varchar(2) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iso_3166_1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Production_Countries`
--

LOCK TABLES `Production_Countries` WRITE;
/*!40000 ALTER TABLE `Production_Countries` DISABLE KEYS */;
INSERT INTO `Production_Countries` VALUES ('AE','United Arab Emirates'),('AF','Afghanistan'),('AO','Angola'),('AR','Argentina'),('AT','Austria'),('AU','Australia'),('AW','Aruba'),('BA','Bosnia and Herzegovina'),('BE','Belgium'),('BG','Bulgaria'),('BO','Bolivia'),('BR','Brazil'),('BS','Bahamas'),('BT','Bhutan'),('CA','Canada'),('CH','Switzerland'),('CL','Chile'),('CM','Cameroon'),('CN','China'),('CO','Colombia'),('CS','Serbia and Montenegro'),('CY','Cyprus'),('CZ','Czech Republic'),('DE','Germany'),('DK','Denmark'),('DM','Dominica'),('DO','Dominican Republic'),('DZ','Algeria'),('EC','Ecuador'),('EG','Egypt'),('ES','Spain'),('FI','Finland'),('FJ','Fiji'),('FR','France'),('GB','United Kingdom'),('GP','Guadaloupe'),('GR','Greece'),('GY','Guyana'),('HK','Hong Kong'),('HU','Hungary'),('ID','Indonesia'),('IE','Ireland'),('IL','Israel'),('IN','India'),('IR','Iran'),('IS','Iceland'),('IT','Italy'),('JM','Jamaica'),('JO','Jordan'),('JP','Japan'),('KE','Kenya'),('KG','Kyrgyz Republic'),('KH','Cambodia'),('KR','South Korea'),('KZ','Kazakhstan'),('LB','Lebanon'),('LT','Lithuania'),('LU','Luxembourg'),('LY','Libyan Arab Jamahiriya'),('MA','Morocco'),('MC','Monaco'),('MT','Malta'),('MX','Mexico'),('MY','Malaysia'),('NG','Nigeria'),('NL','Netherlands'),('NO','Norway'),('NZ','New Zealand'),('PA','Panama'),('PE','Peru'),('PH','Philippines'),('PK','Pakistan'),('PL','Poland'),('PT','Portugal'),('RO','Romania'),('RS','Serbia'),('RU','Russia'),('SE','Sweden'),('SG','Singapore'),('SI','Slovenia'),('SK','Slovakia'),('TH','Thailand'),('TN','Tunisia'),('TR','Turkey'),('TW','Taiwan'),('UA','Ukraine'),('US','United States of America'),('ZA','South Africa');
/*!40000 ALTER TABLE `Production_Countries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-16 21:19:48
