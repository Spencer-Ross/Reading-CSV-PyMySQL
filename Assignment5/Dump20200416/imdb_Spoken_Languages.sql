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
-- Table structure for table `Spoken_Languages`
--

DROP TABLE IF EXISTS `Spoken_Languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Spoken_Languages` (
  `iso_639_1` varchar(2) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iso_639_1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Spoken_Languages`
--

LOCK TABLES `Spoken_Languages` WRITE;
/*!40000 ALTER TABLE `Spoken_Languages` DISABLE KEYS */;
INSERT INTO `Spoken_Languages` VALUES ('af','Afrikaans'),('am',''),('ar','العربية'),('bg','български език'),('bm','Bamanankan'),('bn','বাংলা'),('bo',''),('br',''),('bs','Bosanski'),('ca','Català'),('ce',''),('cn','广州话 / 廣州話'),('co',''),('cs','Český'),('cy','Cymraeg'),('da','Dansk'),('de','Deutsch'),('dz',''),('el','ελληνικά'),('en','English'),('eo','Esperanto'),('es','Español'),('et','Eesti'),('fa','فارسی'),('fi','suomi'),('fr','Français'),('ga','Gaeilge'),('gd',''),('gl','Galego'),('he','עִבְרִית'),('hi','हिन्दी'),('hr','Hrvatski'),('hu','Magyar'),('hy',''),('id','Bahasa indonesia'),('is','Íslenska'),('it','Italiano'),('iu',''),('ja','日本語'),('ka','ქართული'),('kk','қазақ'),('km',''),('ko','한국어/조선말'),('ku',''),('kw',''),('ky','??????'),('la','Latin'),('mi',''),('ml',''),('mn',''),('ne',''),('nl','Nederlands'),('no','Norsk'),('nv',''),('ny',''),('pa','ਪੰਜਾਬੀ'),('pl','Polski'),('ps','پښتو'),('pt','Português'),('ro','Română'),('ru','Pусский'),('sa',''),('sh',''),('si',''),('sk','Slovenčina'),('sl','Slovenščina'),('so','Somali'),('sq','shqip'),('sr','Srpski'),('st',''),('sv','svenska'),('sw','Kiswahili'),('ta','தமிழ்'),('te','తెలుగు'),('th','ภาษาไทย'),('tl',''),('to',''),('tr','Türkçe'),('uk','Український'),('ur','اردو'),('vi','Tiếng Việt'),('wo','Wolof'),('xh',''),('xx','No Language'),('yi',''),('zh','普通话'),('zu','isiZulu');
/*!40000 ALTER TABLE `Spoken_Languages` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-16 21:19:51
