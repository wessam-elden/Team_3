CREATE DATABASE  IF NOT EXISTS `mydb` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci */;
USE `mydb`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
REPLACE INTO `city` (`id`, `name`) VALUES (1,'Giza'),(2,'Cairo'),(3,'Luxor');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `landmark`
--

DROP TABLE IF EXISTS `landmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `landmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `image_url` varchar(150) DEFAULT NULL,
  `opening_hours` varchar(45) DEFAULT NULL,
  `ticket_price` int(11) DEFAULT NULL,
  `City_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_Landmark_City1_idx` (`City_id`),
  CONSTRAINT `fk_Landmark_City1` FOREIGN KEY (`City_id`) REFERENCES `city` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landmark`
--

LOCK TABLES `landmark` WRITE;
/*!40000 ALTER TABLE `landmark` DISABLE KEYS */;
REPLACE INTO `landmark` (`id`, `name`, `description`, `location`, `image_url`, `opening_hours`, `ticket_price`, `City_id`) VALUES (1,'Citadel of Salah El-Din','Historic Islamic fortification','Cairo','','9 AM - 4 PM',50,1),(2,'Pyramids of Giza','Ancient pyramids','Giza Plateau','https://example.com/pyramids.jpg','8 AM - 5 PM',200,2),(3,'Karnak Temple','Famous temple complex','Luxor','https://example.com/karnak.jpg','9 AM - 4 PM',150,3);
/*!40000 ALTER TABLE `landmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo_url` varchar(150) DEFAULT NULL,
  `landmark_id` int(11) DEFAULT NULL,
  `User_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_photos_landmarekes1_idx` (`landmark_id`),
  KEY `fk_photo_User1_idx` (`User_id`),
  CONSTRAINT `fk_photo_User1` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_photos_landmarekes1` FOREIGN KEY (`landmark_id`) REFERENCES `landmark` (`id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

LOCK TABLES `photo` WRITE;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `isverified` tinyint(4) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `provider` enum('GOOGLE','FACEBOOK') DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` enum('TOURIST','GUIDE','ADMIN') DEFAULT NULL,
  `verification_code` varchar(255) DEFAULT NULL,
  `provider_id` int(11) DEFAULT NULL,
  `OTP_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
REPLACE INTO `user` (`id`, `email`, `password`, `name`, `country`, `isverified`, `created_at`, `provider`, `phone_number`, `role`, `verification_code`, `provider_id`, `OTP_date`) VALUES (1,'wessam.com','$2b$10$3VPLgS1AxT6dpM3JXD6Ki.AOJSi8Zy0J29jfl.qPna8f/hfNg2jSu','wessam','',0,NULL,'GOOGLE','','TOURIST','1198',0,NULL),(2,'mohamed.com','$2b$10$vH5jS9SOBRWpTOs124FHM.hoxSGA55LOKpJDnTPn1sqIWtMkAyomy','dr.mohamed','Egypt',1,NULL,'','01012345678','ADMIN',NULL,NULL,NULL),(3,'youssef.com','$2b$10$vH5jS9SOBRWpTOs124FHM.hoxSGA55LOKpJDnTPn1sqIWtMkAyomy','youssef','Egypt',1,NULL,'','01098765432','TOURIST',NULL,NULL,NULL),(4,'mohab.com','$2b$10$SqGzS4H2bP2AXMXFcGgBQuL4V7GiPuqW6Cz7EZ.7T0LQ1DYRWMkCy','mohab','',0,NULL,'GOOGLE','','TOURIST',NULL,0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visit`
--

DROP TABLE IF EXISTS `visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `visit` (
  `visit_date` datetime DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `User_id` int(11) DEFAULT NULL,
  `City_id` int(11) DEFAULT NULL,
  `Landmark_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `opinion` text DEFAULT NULL,
  `isfavorite` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_visit_User1_idx` (`User_id`),
  KEY `fk_visit_cities1_idx` (`City_id`),
  KEY `fk_visit_landmarkes1_idx` (`Landmark_id`),
  CONSTRAINT `fk_visit_User1` FOREIGN KEY (`User_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_visit_cities1` FOREIGN KEY (`City_id`) REFERENCES `city` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `fk_visit_landmarkes1` FOREIGN KEY (`Landmark_id`) REFERENCES `landmark` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visit`
--

LOCK TABLES `visit` WRITE;
/*!40000 ALTER TABLE `visit` DISABLE KEYS */;
REPLACE INTO `visit` (`visit_date`, `id`, `User_id`, `City_id`, `Landmark_id`, `rating`, `opinion`, `isfavorite`) VALUES ('2024-07-15 03:00:00',6,1,2,2,5,'Amazing experience!',1);
/*!40000 ALTER TABLE `visit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-29 17:37:36
