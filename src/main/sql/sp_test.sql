USE questionnaire;

SELECT * FROM question;

CALL clone_question_set(1);

SELECT * FROM question;