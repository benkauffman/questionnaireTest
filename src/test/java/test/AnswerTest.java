package test;

import com.dataabstractsolutions.model.Answer;
import com.dataabstractsolutions.model.Question;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by Illiak on 1/13/2017.
 */
public class AnswerTest {
    @Rule
    public DatabaseRule databaseRule = new DatabaseRule();

    private Question question;

    @Before
    public void initiate() {
        question = new Question("ques1?");
    }

    @Test
    public void answer_createsCorrectly() {
        Answer answer = new Answer(question, "answer1");
        assertEquals("answer1", answer.getAnswer());
    }

    @Test
    public void answer_storesToDB() {
        Answer answer = new Answer(question, "answer1");
        assertNotNull(question.getId());
        assertTrue(question.getId() > 0);
    }

    @Test
    public void answer_loadsAllQuestions() {
        Answer answer1 = new Answer(question, "answer1");
        Answer answer2 = new Answer(question, "answer2");
        List<Answer> answers = question.getAnswers();
        assertTrue(answers.contains(answer1));
        assertTrue(answers.contains(answer2));
    }

    @Test
    public void answer_addesQuestionNode() {
        Answer answer = new Answer(question, "answer");
        answer.addQuestionNode(new Question("testQuestion"));
        assertEquals("testQuestion", question.getAnswers().get(0).getQuestion().getQuestion());
    }
}