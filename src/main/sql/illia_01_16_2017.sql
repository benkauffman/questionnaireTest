DROP SCHEMA IF EXISTS questionnaire;
CREATE SCHEMA IF NOT EXISTS questionnaire;
USE questionnaire;

-- MySQL dump 10.13  Distrib 5.7.16, for Win64 (x86_64)
--
-- Host: localhost    Database: questionnaire
-- ------------------------------------------------------
-- Server version	5.7.16-log

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
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_name` varchar(200) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `datetime_created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`answer_id`),
  KEY `question_idx` (`question_id`),
  CONSTRAINT `questions` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
INSERT INTO `answer` VALUES (1,'answer1Q1',2,'2017-01-13 10:04:23'),(2,'answer2Q1',NULL,'2017-01-13 10:04:23'),(3,'answer3Q1',NULL,'2017-01-13 10:04:23'),(4,'answer1Q2',4,'2017-01-13 10:04:23'),(5,'answer2Q2',NULL,'2017-01-13 10:04:23'),(6,'answer1Q3',1,'2017-01-13 10:04:23'),(7,'answer1Q4',NULL,'2017-01-13 10:08:47'),(8,'answer2Q4',NULL,'2017-01-13 10:08:47'),(9,'answer3Q4',NULL,'2017-01-13 10:08:47');
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_name` varchar(200) NOT NULL,
  `datetime_created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=699 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
INSERT INTO `question` VALUES (1,'question1','2017-01-13 10:02:34'),(2,'question2','2017-01-13 10:02:34'),(3,'question3','2017-01-13 10:02:34'),(4,'question4','2017-01-13 10:08:07');
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_answer`
--

DROP TABLE IF EXISTS `question_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_answer` (
  `qa_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `datetime_created` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`qa_id`),
  KEY `answer_idx` (`answer_id`),
  KEY `question_idx` (`question_id`),
  CONSTRAINT `answer` FOREIGN KEY (`answer_id`) REFERENCES `answer` (`answer_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `question` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_answer`
--

LOCK TABLES `question_answer` WRITE;
/*!40000 ALTER TABLE `question_answer` DISABLE KEYS */;
INSERT INTO `question_answer` VALUES (1,1,1,'2017-01-13 00:00:00'),(2,1,2,'2017-01-13 00:00:00'),(3,1,3,'2017-01-13 00:00:00'),(4,2,4,'2017-01-13 00:00:00'),(5,2,5,'2017-01-13 00:00:00'),(6,3,6,'2017-01-13 00:00:00'),(7,4,7,'2017-01-13 00:00:00'),(8,4,8,'2017-01-13 00:00:00'),(9,4,9,'2017-01-13 00:00:00');
/*!40000 ALTER TABLE `question_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey` (
  `survey_id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_name` varchar(45) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`survey_id`),
  KEY `question_idx` (`question_id`),
  CONSTRAINT `questionKey` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `survey`
--

LOCK TABLES `survey` WRITE;
/*!40000 ALTER TABLE `survey` DISABLE KEYS */;
INSERT INTO `survey` VALUES (1,'Some questionnaire',1);
/*!40000 ALTER TABLE `survey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'questionnaire'
--
/*!50003 DROP PROCEDURE IF EXISTS `clone_question_set` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clone_question_set`(questionId INT)
  BEGIN
    DECLARE s VARCHAR(20);
    DECLARE flag INT DEFAULT 0;
    DECLARE id INT DEFAULT 0;
    DECLARE insQID INT;
    DECLARE i INT DEFAULT 0;
    DECLARE nextQuestionId INT DEFAULT 0;
    SET s = 'copy of - ';
    SET i=0;
    SELECT count(*) INTO flag FROM question_answer as qa WHERE qa.question_id = questionId;
    INSERT INTO question (question_name) SELECT CONCAT(s, q.question_name) FROM question_answer as qa JOIN question AS q ON qa.question_id = q.question_id WHERE qa.qa_id = questionId;
    SET insQID = LAST_INSERT_ID();
    while i<flag DO
      SELECT qa.qa_id INTO id FROM question_answer as qa WHERE qa.question_id = questionId LIMIT i,1;
      INSERT INTO question_answer (question_id, answer_id) SELECT insQID, answer_id FROM question_answer as qa WHERE qa.qa_id = id;
      SELECT IFNULL(a.question_id, -1) INTO nextQuestionId FROM question_answer as qa JOIN answer as a ON qa.answer_id = a.answer_id WHERE qa.qa_id = id;
      IF nextQuestionId > 0
      THEN CALL clone_question_set(nextQuestionId);
      END IF;
      SET i = i + 1;
    END WHILE;

    #mysql_use_result();
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_test_DB` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_test_DB`()
  BEGIN
    SELECT * FROM question;
    SELECT * FROM answer;
    DROP DATABASE IF EXISTS  questionnaire_test;
    CREATE DATABASE questionnaire_test;
    CREATE TABLE questionnaire_test.answer LIKE questionnaire.answer;
    CREATE TABLE questionnaire_test.question LIKE questionnaire.question;
    CREATE TABLE questionnaire_test.question_answer LIKE questionnaire.question_answer;
    CREATE TABLE questionnaire_test.survey LIKE questionnaire.survey;
  END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-16 11:13:26
