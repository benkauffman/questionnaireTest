package com.dataabstractsolutions.model;

import application.DB;
import application.DBResultParser;
import org.apache.log4j.Logger;
import org.omg.PortableInterceptor.INACTIVE;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Created by Illiak on 1/13/2017.
 */
public class Question {
    private final String QUERY_INSERT = "INSERT INTO question (question_name) VALUES (?)";
    private static final String QUERY_SELECT = "SELECT * FROM question";
    private static final String QUERY_SELECT_FIRST = "SELECT question_id FROM survey LIMIT 1";

    private static final Logger LOG = Logger.getLogger(Question.class);

    private Integer id;
    private String question;
    private static List<Question> questions = new ArrayList<Question>();

    public Question(String question) {
        this.question = question;
        this.id = insertToDB();
        questions.add(this);
    }

    public Question(Integer id, String question) {
        this.question = question;
        this.id = id;
        questions.add(this);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Question question1 = (Question) o;

        return (getId() != null ? getId().equals(question1.getId()) : question1.getId() == null) && (getQuestion() != null ? getQuestion().equals(question1
                .getQuestion()) : question1.getQuestion() == null);
    }

    public Integer getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public static List<Question> getQuestions() {
        return questions;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    private Integer insertToDB() {
        Integer resut = 0;
        List<Object> params = new ArrayList<Object>();
        params.add(getQuestion());
        try {
            resut = DB.executeUpdate(QUERY_INSERT, params);
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
        return resut;
    }

    public static void loadQuestions() {
        try {
            for (DBResultParser row : DBResultParser.getResultSet(DB.executeQuery(QUERY_SELECT))) {
                new Question(row.getInt("question_id"), row.getString("question_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
    }

    public static Question getQuestionById(Integer id) {
        return Question.getQuestions().stream().filter(question -> Objects.equals(question.getId(), id)).findFirst().orElse(null);
    }

    public List<Answer> getAnswers() {
        return Answer.getAnswers(getId());
    }

    public static Question getFirstSurveyQuestion() {
        Question question = null;
        try {
            for (DBResultParser row : DBResultParser.getResultSet(DB.executeQuery(QUERY_SELECT_FIRST))) {
                question = Question.getQuestionById(row.getInt("question_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            LOG.error(e);
        }
        return question;
    }
}
