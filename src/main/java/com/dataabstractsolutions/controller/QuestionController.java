package com.dataabstractsolutions.controller;

import com.dataabstractsolutions.model.Answer;
import com.dataabstractsolutions.model.Question;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.*;

import javax.websocket.server.PathParam;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Illiak on 1/13/2017.
 */
@RestController
public class QuestionController {
    static Logger logger = Logger.getLogger(QuestionController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public Question getFirstQuestion() {
        //load questions on root request and return first question of the survey
        Question.loadQuestions();
        return Question.getFirstSurveyQuestion();
    }


//    I would have used path parameters instead of query parameters
//    query parameters are used to filter data after it has already been identified (or optional)
//    path parameters should be used to identify data or when the parameter is required
//    https://tools.ietf.org/html/rfc3986#section-3.3 & https://tools.ietf.org/html/rfc3986#section-3.4

    @RequestMapping(value = "/getAnswers/{questionId}", method = RequestMethod.GET)
    public List<Answer> getAnswers(@PathVariable Integer questionId) { // <-- I also would recommend using integers
        //return answer list by question
        Question question = Question.getQuestionById(questionId); // <-- Integer  variable removes the need to parse
        return question.getAnswers();
    }

    @RequestMapping(value = "/getQuestion", method = RequestMethod.GET)
    public Question getQuestion(@RequestParam(value = "questionId") String name) {
        //return question by ID
        if (Question.getQuestions().size() == 0) {
            Question.loadQuestions();
        }
        return Question.getQuestionById(Integer.valueOf(name));
    }

    @RequestMapping(value = "/saveAnswer", method = RequestMethod.POST)
    public Question saveAnswer(@RequestParam Map<String,String> requestParams) throws Exception {
        //TODO: save answer from requestParams and return new question
        return null;
    }
}
