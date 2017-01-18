package com.dataabstractsolutions.controller;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by benkauffman on 1/17/17.
 */
@RestController
public class PrivateController {
    static Logger logger = Logger.getLogger(PrivateController.class);

    @RequestMapping(value = "/private/test", method = RequestMethod.GET)
    public String getPrivateTest() {
        logger.debug("PRIVATE CONTROLLER");
        //load questions on root request and return first question of the survey
        return "You supplied an \"Authorization\" header, and were successfully authenticated.";
    }
}