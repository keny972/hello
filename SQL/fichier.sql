-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: diwoo14_entreprise
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
-- Table structure for table `employes`
--

DROP TABLE IF EXISTS `employes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employes` (
  `id_employes` int(3) NOT NULL AUTO_INCREMENT,
  `prenom` varchar(20) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `sexe` enum('m','f') NOT NULL,
  `service` varchar(30) NOT NULL,
  `date_embauche` date NOT NULL,
  `salaire` int(3) NOT NULL,
  PRIMARY KEY (`id_employes`)
) ENGINE=InnoDB AUTO_INCREMENT=992 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employes`
--

LOCK TABLES `employes` WRITE;
/*!40000 ALTER TABLE `employes` DISABLE KEYS */;
INSERT INTO `employes` VALUES (350,'Jean-pierre','Laborde','m','direction','1999-12-09',4000),(388,'Clement','Gallet','m','commercial','2000-01-15',2400),(415,'Thomas','Winter','m','commercial','2000-05-03',3650),(417,'Chloe','Dubar','f','production','2001-09-05',2000),(509,'Fabrice','Grand','m','comptabilite','2003-02-20',2000),(547,'Melanie','Collier','f','commercial','2004-09-08',3200),(592,'Laura','Blanchet','f','direction','2005-06-09',4600),(627,'Guillaume','Miller','m','commercial','2006-07-02',2000),(655,'Celine','Perrin','f','commercial','2006-09-10',2800),(701,'Mathieu','Vignal','m','informatique','2008-12-03',2100),(780,'Amandine','Thoyer','f','communication','2010-01-23',1600),(802,'Damien','Durand','m','informatique','2010-07-05',2350),(854,'Daniel','Chevel','m','informatique','2011-09-28',1800),(876,'Nathalie','Martin','f','juridique','2012-01-12',3300),(900,'Benoit','Lagarde','m','production','2013-01-03',2650),(933,'Emilie','Sennard','f','commercial','2014-09-11',1900),(990,'Stephanie','Lafaye','f','assistant','2015-06-02',1875),(991,'Claude','Hillion','f','informatique','2016-12-09',2600);
/*!40000 ALTER TABLE `employes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-12 17:01:28
