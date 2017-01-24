-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: diwoo14_bibliotheque
-- ------------------------------------------------------
-- Server version	5.7.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abonne`
--

DROP TABLE IF EXISTS `abonne`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abonne` (
  `id_abonne` int(3) NOT NULL AUTO_INCREMENT,
  `Prenom` varchar(20) NOT NULL,
  PRIMARY KEY (`id_abonne`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonne`
--

LOCK TABLES `abonne` WRITE;
/*!40000 ALTER TABLE `abonne` DISABLE KEYS */;
INSERT INTO `abonne` VALUES (1,'Guillaume'),(2,'Benoit'),(3,'Chloe'),(4,'Laura'),(5,'Claude');
/*!40000 ALTER TABLE `abonne` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emprunt` (
  `id_emprunt` int(3) NOT NULL AUTO_INCREMENT,
  `id_livre` int(3) NOT NULL,
  `id_abonne` int(3) NOT NULL,
  `Date_sortie` date NOT NULL,
  `Date_rendu` date DEFAULT NULL,
  PRIMARY KEY (`id_emprunt`),
  KEY `id_livre` (`id_livre`),
  KEY `id_abonne` (`id_abonne`),
  CONSTRAINT `emprunt_ibfk_1` FOREIGN KEY (`id_livre`) REFERENCES `livre` (`id_livre`),
  CONSTRAINT `emprunt_ibfk_2` FOREIGN KEY (`id_abonne`) REFERENCES `abonne` (`id_abonne`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emprunt`
--

LOCK TABLES `emprunt` WRITE;
/*!40000 ALTER TABLE `emprunt` DISABLE KEYS */;
INSERT INTO `emprunt` VALUES (1,100,1,'2014-12-17','2014-12-18'),(2,101,2,'2014-12-18','2014-12-20'),(3,100,3,'2014-12-19','2014-12-22'),(4,103,4,'2014-12-19','2014-12-22'),(5,104,1,'2014-12-19','2014-12-28'),(6,105,2,'2015-03-20','2015-03-26'),(7,105,3,'2015-06-13',NULL),(8,100,2,'2015-06-15',NULL);
/*!40000 ALTER TABLE `emprunt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `livre`
--

DROP TABLE IF EXISTS `livre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `livre` (
  `id_livre` int(3) NOT NULL AUTO_INCREMENT,
  `Titre` varchar(100) NOT NULL,
  `Auteur` varchar(100) NOT NULL,
  PRIMARY KEY (`id_livre`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `livre`
--

LOCK TABLES `livre` WRITE;
/*!40000 ALTER TABLE `livre` DISABLE KEYS */;
INSERT INTO `livre` VALUES (100,'Une vie','GUY DE MAUPASSANT'),(101,'Bel-Ami ','GUY DE MAUPASSANT'),(102,'Le père Goriot','HONORE DE BALZAC'),(103,'Le Petit chose','ALPHONSE DAUDET'),(104,'La Reine Margot','ALEXANDRE DUMAS'),(105,'Les Trois Mousquetaires','ALEXANDRE DUMAS');
/*!40000 ALTER TABLE `livre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vue_emprunt`
--

DROP TABLE IF EXISTS `vue_emprunt`;
/*!50001 DROP VIEW IF EXISTS `vue_emprunt`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `vue_emprunt` AS SELECT 
 1 AS `prenom`,
 1 AS `titre`,
 1 AS `date_sortie`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vue_emprunt`
--

/*!50001 DROP VIEW IF EXISTS `vue_emprunt`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vue_emprunt` AS select `a`.`Prenom` AS `prenom`,`l`.`Titre` AS `titre`,`e`.`Date_sortie` AS `date_sortie` from ((`abonne` `a` join `emprunt` `e`) join `livre` `l`) where ((`a`.`id_abonne` = `e`.`id_abonne`) and (`e`.`id_livre` = `l`.`id_livre`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-12 17:01:35
