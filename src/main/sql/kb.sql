DROP SCHEMA IF EXISTS kb_questionnaire;
CREATE SCHEMA IF NOT EXISTS kb_questionnaire;
USE kb_questionnaire;

-- tables
-- Table: answer
CREATE TABLE answer (
  id               INT          NOT NULL AUTO_INCREMENT,
  text             VARCHAR(250) NOT NULL,
  question_id      INT          NOT NULL,
  next_question_id INT          NULL,
  sort             INT          NOT NULL DEFAULT 0,
  UNIQUE INDEX answer_ak_1 (next_question_id),
  CONSTRAINT answer_pk PRIMARY KEY (id)
)
  COMMENT 'Available answers for a single question. Also containing the logic for redirecting to another question node based on the answer.';

-- Table: question
CREATE TABLE question (
  id               INT          NOT NULL AUTO_INCREMENT,
  text             VARCHAR(500) NOT NULL,
  sort             INT          NOT NULL DEFAULT 0,
  questionnaire_id INT          NOT NULL,
  CONSTRAINT question_pk PRIMARY KEY (id)
)
  COMMENT 'Questions associated with the questionnaire';

-- Table: questionnaire
CREATE TABLE questionnaire (
  id   INT          NOT NULL AUTO_INCREMENT,
  text VARCHAR(500) NOT NULL,
  CONSTRAINT questionnaire_pk PRIMARY KEY (id)
)
  COMMENT 'Question set categorized as a questionnaire';

-- Table: user
CREATE TABLE user (
  id         INT         NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name  VARCHAR(50) NOT NULL,
  email      VARCHAR(50) NOT NULL,
  salt       VARCHAR(20) NOT NULL,
  hash       VARCHAR(20) NOT NULL,
  CONSTRAINT user_pk PRIMARY KEY (id)
)
  COMMENT 'Application user information';

-- Table: user_questionnaire
CREATE TABLE user_questionnaire (
  id               INT      NOT NULL AUTO_INCREMENT,
  questionnaire_id INT      NOT NULL,
  user_id          INT      NOT NULL,
  started          DATETIME NOT NULL,
  completed        DATETIME NULL,
  CONSTRAINT user_questionnaire_pk PRIMARY KEY (id)
)
  COMMENT 'The generic information about a user''''s questoinnaire';

-- Table: user_questionnaire_data
CREATE TABLE user_questionnaire_data (
  survey_id   INT  NOT NULL,
  question_id INT  NOT NULL,
  answered    BOOL NOT NULL DEFAULT 0,
  answer_id   INT  NULL,
  CONSTRAINT user_questionnaire_data_pk PRIMARY KEY (survey_id, question_id)
)
  COMMENT 'answered data associated with the user''''s questionnaire';

-- foreign keys
-- Reference: answer_question (table: answer)
ALTER TABLE answer ADD CONSTRAINT answer_question FOREIGN KEY answer_question (question_id)
REFERENCES question (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: answer_question_logic (table: answer)
ALTER TABLE answer ADD CONSTRAINT answer_question_logic FOREIGN KEY answer_question_logic (next_question_id)
REFERENCES question (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: question_questionnaire (table: question)
ALTER TABLE question ADD CONSTRAINT question_questionnaire FOREIGN KEY question_questionnaire (questionnaire_id)
REFERENCES questionnaire (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: user_questionnaire_data (table: user_questionnaire_data)
ALTER TABLE user_questionnaire_data ADD CONSTRAINT user_questionnaire_data FOREIGN KEY user_questionnaire_data (survey_id)
REFERENCES user_questionnaire (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: user_questionnaire_data_answer (table: user_questionnaire_data)
ALTER TABLE user_questionnaire_data ADD CONSTRAINT user_questionnaire_data_answer FOREIGN KEY user_questionnaire_data_answer (answer_id)
REFERENCES answer (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: user_questionnaire_data_question (table: user_questionnaire_data)
ALTER TABLE user_questionnaire_data ADD CONSTRAINT user_questionnaire_data_question FOREIGN KEY user_questionnaire_data_question (question_id)
REFERENCES question (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: user_questionnaire_questionnaire (table: user_questionnaire)
ALTER TABLE user_questionnaire ADD CONSTRAINT user_questionnaire_questionnaire FOREIGN KEY user_questionnaire_questionnaire (questionnaire_id)
REFERENCES questionnaire (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

-- Reference: user_questionnaire_user (table: user_questionnaire)
ALTER TABLE user_questionnaire ADD CONSTRAINT user_questionnaire_user FOREIGN KEY user_questionnaire_user (user_id)
REFERENCES user (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;


USE kb_questionnaire;

INSERT INTO questionnaire (id, text) VALUES (1, 'Initial Questionnaire');
INSERT INTO question (id, text, sort, questionnaire_id)

VALUES
  (0, 'Q1', 1, 1)
  , (0, 'Q2', 2, 1)
  , (0, 'Q3', 3, 1)
  , (0, 'Q4', 4, 1)
  , (0, 'Q5', 5, 1)
  , (0, 'Q6', 6, 1)
  , (0, 'Q7', 7, 1)
  , (0, 'Q8', 8, 1)
  , (0, 'Q9', 9, 1)
  , (0, 'Q10', 10, 1);

INSERT INTO answer (id, text, question_id, next_question_id, sort)
VALUES
  (0, 'Q1 - Option A go to Q2', 1, 2, 1)
  , (0, 'Q1 - Option B go to end', 1, NULL, 2)
  , (0, 'Q1 - Option C go to Q4', 1, 4, 2)

  , (0, 'Q2 - Option A go to Q3', 2, 3, 1)
  , (0, 'Q2 - Option B go to end', 2, NULL, 2)
  , (0, 'Q2 - Option C go to end', 2, NULL, 3)

  , (0, 'Q3 - Option A go to end', 3, NULL, 1)
  , (0, 'Q3 - Option B go to end', 3, NULL, 2)

  , (0, 'Q4 - Option A go to end', 4, NULL, 1)
  , (0, 'Q4 - Option B go to end', 4, NULL, 2)
  , (0, 'Q4 - Option C go to Q5', 4, 5, 3)

  , (0, 'Q5 - Option A go to end', 5, NULL, 1)
  , (0, 'Q5 - Option B go to end', 5, NULL, 2)
  , (0, 'Q5 - Option C go to Q6', 5, 6, 3)

  , (0, 'Q6 - Option A go to end', 6, NULL, 1)
  , (0, 'Q6 - Option B go to end', 6, NULL, 2)
  , (0, 'Q6 - Option C go to end', 6, NULL, 3)
  , (0, 'Q6 - Option D go to Q7', 6, 7, 4)

  , (0, 'Q7 - Option A go to Q8', 7, 8, 1)
  , (0, 'Q7 - Option B go to end', 7, NULL, 2)
  , (0, 'Q7 - Option C go to end', 7, NULL, 3)
  , (0, 'Q7 - Option D go to end', 7, NULL, 4)

  , (0, 'Q8 - Option A go to Q9', 8, 9, 1)
  , (0, 'Q8 - Option B go to end', 8, NULL, 2)
  , (0, 'Q8 - Option C go to end', 8, NULL, 3)

  , (0, 'Q9 - Option A go to end', 9, NULL, 1)
  , (0, 'Q9 - Option B go to Q10', 9, 10, 2)
  , (0, 'Q9 - Option C go to end', 9, NULL, 3)

  , (0, 'Q10 - Option A go to end', 10, NULL, 1);


SELECT *
FROM question AS q
  LEFT JOIN answer AS a ON q.id = a.question_id
ORDER BY q.sort, a.sort;


USE kb_questionnaire;

DROP PROCEDURE IF EXISTS CLONE_QUESTION;
DELIMITER ;;


CREATE PROCEDURE `CLONE_QUESTION`(
  IN `oldQuestionId` INT,
  IN `returnNewId`   BOOLEAN
)

  BEGIN
    DECLARE newQuestionId INT DEFAULT -1;
    CALL RTN_CLONE_QUESTION(oldQuestionId, @newQuestionId);
    IF returnNewId
    THEN
      SELECT @newQuestionId AS cloned_question_id;
    END IF;
  END;;
DELIMITER ;;


DROP PROCEDURE IF EXISTS RTN_CLONE_QUESTION;
DELIMITER ;;
CREATE PROCEDURE RTN_CLONE_QUESTION(
  IN  originalQuestionId INT,
  OUT newQuestionId      INT
)
  BEGIN

    # clone question
    # clone the available answers for the question
    # check to see if the answers redirect to another question
    # clone that question
    # check to see if there are children
    # send the child through the same clone process
    DECLARE prependText VARCHAR(10) DEFAULT 'copy of - ';
    DECLARE done TINYINT DEFAULT FALSE;

    -- NESTED QUESTION VARIABLES
    DECLARE answerText VARCHAR(500);
    DECLARE newChildQuestionId INT DEFAULT -1;
    DECLARE answerQuestionId INT DEFAULT -1;
    DECLARE answerNextQuestionId INT DEFAULT -1;
    DECLARE answerSort INT DEFAULT -1;

    DECLARE answers CURSOR FOR SELECT
                                 text,
                                 question_id,
                                 next_question_id,
                                 sort
                               FROM answer
                               WHERE question_id = originalQuestionId;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    SET @@SESSION.max_sp_recursion_depth = 255;

    -- make sure that the question exists first
    IF (SELECT COUNT(id)
        FROM question
        WHERE id = originalQuestionId) > 0
    THEN
      BEGIN

        -- clone the question
        INSERT INTO question (text, sort, questionnaire_id)
          SELECT
            CONCAT(prependText, text),
            sort,
            questionnaire_id
          FROM question
          WHERE id = originalQuestionId;

        -- make sure the question was cloned/created
        IF (ROW_COUNT()) > 0
        THEN
          -- find the question that was just created
          SET newQuestionId = LAST_INSERT_ID(); -- same as (SELECT MAX(id) FROM question AS most_recent);

          OPEN answers;

          read_loop: LOOP
            FETCH answers
            INTO answerText, answerQuestionId, answerNextQuestionId, answerSort;

            IF done
            THEN
              LEAVE read_loop;
            END IF;

            -- CLONE CHILD QUESTION BASE ON ANSWER LOGIC
            IF answerNextQuestionId >= 0
            THEN
              -- this answer does redirect to the "next question"
              CALL RTN_CLONE_QUESTION(answerNextQuestionId, @newChildQuestionId);
              INSERT INTO answer (text, question_id, next_question_id, sort)
              VALUES (CONCAT(prependText, answerText), newQuestionId, @newChildQuestionId, answerSort);
            ELSE
              -- this answer doesn't redirect to the "next question"
              INSERT INTO answer (text, question_id, next_question_id, sort)
              VALUES (CONCAT(prependText, answerText), newQuestionId, NULL, answerSort);
            END IF;

          END LOOP;
          CLOSE answers;
        ELSE
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'UNABLE TO CLONE QUESTION!';
        END IF;
      END;
    ELSE
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'QUESTION DOES NOT EXIST, AND THEREFORE CANNOT BE CLONED!';
    END IF;
  END ;;
DELIMITER ;;


-- a little demonstration of how cloning works
CALL CLONE_QUESTION(1, TRUE);
CALL CLONE_QUESTION(16, TRUE);
# CALL CLONE_QUESTION(99, FALSE); # should error because question doesn't exist

SELECT *
FROM question AS q LEFT JOIN answer a ON q.id = a.question_id
ORDER BY q.id, a.sort;

# TEXT EXAMPLE OF HOW THIS TREE LOGIC SHOULD WORK
# Original Structure :=
#   question 1 -
#     answer 1 - end
#     answer 2 - goes question 2
#     answer 3 - end
#
#   question 2 -
#     answer 1 - goes question 3
#     answer 2 - end
#     answer 3 - goes question 4
#     answer 4 - end
#
#   question 3 -
#     answer 1 - end
#     answer 2 - end
#     answer 3 - end
#
#   question 4 -
#     answer 1 - end
#     answer 2 - end
#
#
# Cloned Structure :=
#   question 5 -
#     answer 1 - end
#     answer 2 - goes question 6
#     answer 3 - end
#
#   question 6 -
#     answer 1 - goes question 7
#     answer 2 - end
#     answer 3 - goes question 8
#     answer 4 - end
#
#   question 7 -
#     answer 1 - end
#     answer 2 - end
#     answer 3 - end
#
#   question 8 -
#     answer 1 - end
#     answer 2 - end
