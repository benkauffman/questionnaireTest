USE questionnaire;
/*!50003 DROP PROCEDURE IF EXISTS `clone_question_set` */;
/*!50003 SET @saved_cs_client = @@character_set_client */;
/*!50003 SET @saved_cs_results = @@character_set_results */;
/*!50003 SET @saved_col_connection = @@collation_connection */;
/*!50003 SET character_set_client = utf8 */;
/*!50003 SET character_set_results = utf8 */;
/*!50003 SET collation_connection = utf8_general_ci */;
/*!50003 SET @saved_sql_mode = @@sql_mode */;
/*!50003 SET sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */;
DELIMITER ;;
CREATE PROCEDURE `clone_question_set`(questionId INT)
  BEGIN
    DECLARE s VARCHAR(20);
    DECLARE flag INT DEFAULT 0;
    DECLARE id INT DEFAULT 0;
    DECLARE insQID INT;
    DECLARE i INT DEFAULT 0;
    DECLARE nextQuestionId INT DEFAULT 0;
    SET s = 'copy of - ';
    SET i = 0;
    SELECT count(*)
    INTO flag
    FROM question_answer AS qa
    WHERE qa.question_id = questionId;
    INSERT INTO question (question_name) SELECT CONCAT(s, q.question_name)
                                         FROM question_answer AS qa JOIN question AS q ON qa.question_id = q.question_id
                                         WHERE qa.qa_id = questionId;
    SET insQID = LAST_INSERT_ID();
    WHILE i < flag DO
      SELECT qa.qa_id
      INTO id
      FROM question_answer AS qa
      WHERE qa.question_id = questionId
      LIMIT i, 1;
      INSERT INTO question_answer (question_id, answer_id) SELECT
                                                             insQID,
                                                             answer_id
                                                           FROM question_answer AS qa
                                                           WHERE qa.qa_id = id;
      SELECT IFNULL(a.question_id, -1)
      INTO nextQuestionId
      FROM question_answer AS qa JOIN answer AS a ON qa.answer_id = a.answer_id
      WHERE qa.qa_id = id;
      IF nextQuestionId > 0
      THEN CALL clone_question_set(nextQuestionId);
      END IF;
      SET i = i + 1;
    END WHILE;

    #mysql_use_result();
  END ;;
DELIMITER ;