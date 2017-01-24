package com.dataabstractsolutions.service;

import com.netflix.config.ConfigurationManager;
import com.netflix.config.DynamicPropertyFactory;
import org.apache.log4j.Logger;

import java.io.IOException;

/**
 * Created by benkauffman on 1/23/17.
 */
public class Properties {
    private static final Logger logger = Logger.getLogger(Properties.class);

    private static DynamicPropertyFactory dynamicPropertyFactory;

    static {
        String env = System.getProperty("archaius.deployment.environment");
        logger.debug("validating environment");
        if(env == null || env.isEmpty() || env.equalsIgnoreCase("Undefined")){
            logger.debug("environment is not defined");
            env = "my";
        }else {
            logger.debug("environment is defined as " + env);
        }
        try {
            ConfigurationManager.loadCascadedPropertiesFromResources(env);
        } catch (IOException e) {
            logger.error("UNABLE TO SET DEFAULT CONFIG FILE", e);
        }
        dynamicPropertyFactory = DynamicPropertyFactory.getInstance();
    }



    public static String getStringSetting(String settingName){
        return dynamicPropertyFactory.getStringProperty(settingName, "").get();
    }

    public static int getIntSetting(String settingName){
        return dynamicPropertyFactory.getIntProperty(settingName, -1).get();
    }

    public static boolean getBooleanSetting(String settingName){
        return dynamicPropertyFactory.getBooleanProperty(settingName, false).get();
    }

    public static String[] getArraySetting(String settingName){
        return getStringSetting(settingName).split(",");
    }
}


