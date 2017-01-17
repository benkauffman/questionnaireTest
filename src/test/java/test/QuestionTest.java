package test;

import com.dataabstractsolutions.model.Question;
import org.junit.Rule;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 * Created by Illiak on 1/13/2017.
 */
public class QuestionTest {
    @Rule
    public DatabaseRule databaseRule = new DatabaseRule();

    @Test
    public void question_createsNewQuestion() {
        Question question = new Question("question?");
        assertEquals("question?", question.getQuestion());
    }

    @Test
    public void question_storesToDB() {
        Question question = new Question("Is this a question?");
        assertNotNull(question.getId());
        assertTrue(question.getId() > 0);
    }

    @Test
    public void question_loadsAllQuestions() {
        Question question1 = new Question("Question 1");
        Question question2 = new Question("Question 2");
        Question.getQuestions().clear();
        Question.loadQuestions();
        assertTrue(Question.getQuestions().contains(question1));
        assertTrue(Question.getQuestions().contains(question2));
    }

    @Test
    public void returnQuestionById() {
        Question question = new Question("new question");
        Question searchQuestion = Question.getQuestionById(question.getId());
        assertEquals(searchQuestion, question);
    }

    @Test
    public void returnFirstQuestionOfSurvey() {
        Question question = Question.getFirstSurveyQuestion();
        assertNotNull(question);
        assertEquals("survey?", question.getQuestion());
    }
}
