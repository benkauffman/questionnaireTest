package com.dataabstractsolutions.controller;

import com.dataabstractsolutions.model.Answer;
import com.dataabstractsolutions.model.Question;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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

    @RequestMapping(value = "/getAnswers", method = RequestMethod.GET)
    public List<Answer> getAnswers(@RequestParam(value = "questionId") String name) {
        //return answer list by question
        Question question = Question.getQuestionById(Integer.valueOf(name));
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
