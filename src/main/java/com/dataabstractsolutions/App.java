package com.dataabstractsolutions;

import application.DB;
import org.apache.log4j.PropertyConfigurator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileInputStream;
import java.util.Properties;

/**
 * Created by Illiak on 1/13/2017.
 */

@SpringBootApplication
public class App {
    public static void main(String[] args) throws Exception {

        new DB(App.class.getClassLoader().getResource("my.properties").getPath());

        FileInputStream fileInputStream = new FileInputStream(App.class.getClassLoader().getResource("log4j.properties").getPath());
        Properties properties = new Properties();
        properties.load(fileInputStream);
        PropertyConfigurator.configure(properties);

        // Uncomment in order to run web-server
        SpringApplication.run(App.class, args);

    }
}
