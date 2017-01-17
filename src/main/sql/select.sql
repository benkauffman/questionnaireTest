USE questionnaire;

SELECT *
FROM
  question AS q
  LEFT JOIN answer AS a ON q.question_id = a.question_id;