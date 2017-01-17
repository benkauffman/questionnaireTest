package com.dataabstractsolutions.model;

import application.DB;
import application.DBResultParser;
import org.apache.log4j.Logger;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Illiak on 1/13/2017.
 */
public class Answer {
    private final String QUERY_INSERT = "INSERT INTO answer (answer_name) VALUES (?)";
    private final String QUERY_INSERT_QUESTION_LINK = "INSERT INTO question_answer (question_id, answer_id) VALUES (?,?)";
    private final String QUERY_UPDATE = "UPDATE answer SET question_id = ? WHERE answer_id = ?";
    private static final String QUERY_SELECT_ANSWERS = "SELECT a.answer_id, a.answer_name, a.question_id FROM question_answer AS qa " +
            "JOIN answer AS a ON qa.answer_id = a.answer_id " +
            "WHERE qa.question_id = %d";

    private static final Logger LOG = Logger.getLogger(Answer.class);

    private Integer id;
    private String answer;
    private Question question;

    public Answer(Question question, String answer) {
        this.answer = answer;
        this.id = insertToDB();
        linkToQuestion(question);
    }


    public Answer(Integer id, Integer questionId, String answer) {
        this.question = Question.getQuestionById(questionId);
        this.answer = answer;
        this.id = id;
    }

    @Override
    public boolean equals(Object o) {

        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Answer answer1 = (Answer) o;

        return (getId() != null ? getId().equals(answer1.getId()) : answer1.getId() == null) && (getAnswer() != null ? getAnswer().equals(answer1
                .getAnswer()) : answer1.getAnswer() == null) && (getQuestion() != null ? getQuestion().equals(answer1.getQuestion()) : answer1
                .getQuestion() == null);
    }

    public Integer getId() {
        return id;
    }

    public String getAnswer() {
        return answer;
    }

    public Question getQuestion() {
        return question;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    private Integer insertToDB() {
        Integer resut = 0;
        List<Object> params = new ArrayList<Object>();
        params.add(getAnswer());
        try {
            resut = DB.executeUpdate(QUERY_INSERT, params);
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
        return resut;
    }

    static List<Answer> getAnswers(Integer id) {
        List<Answer> answers = new ArrayList<>();
        try {
            for (DBResultParser row : DBResultParser.getResultSet(DB.executeQuery(String.format(QUERY_SELECT_ANSWERS, id)))) {
                Integer questionId = null;
                try {
                    questionId = row.getInt("question_id");
                } catch (NullPointerException e) {
                    //ignore
                }
                answers.add(new Answer(row.getInt("answer_id"), questionId, row.getString("answer_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
        return answers;
    }

    private void linkToQuestion(Question question) {
        List<Object> params = new ArrayList<>();
        params.add(question.getId());
        params.add(getId());
        try {
            DB.executeUpdate(QUERY_INSERT_QUESTION_LINK, params);
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
    }

    public void addQuestionNode(Question question) {
        List<Object> params = new ArrayList<>();
        params.add(question.getId());
        params.add(getId());
        try {
            DB.executeUpdate(QUERY_UPDATE, params);
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
    }
}
