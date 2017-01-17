package test;

import application.DB;
import com.dataabstractsolutions.App;
import com.dataabstractsolutions.model.Question;
import org.junit.rules.ExternalResource;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Created by Illiak on 1/13/2017.
 */
public class DatabaseRule extends ExternalResource{
    @Override
    protected void before() throws Throwable {
        Properties properties = new Properties();
        FileInputStream fileInputStream = null;
        String url = "";
        String login = "";
        String passwd = "";
        try {
            fileInputStream = new FileInputStream(App.class.getClassLoader().getResource("my.properties").getPath());
            properties.load(fileInputStream);
            url = properties.getProperty("MYSQL_DB_TEST");
            login = properties.getProperty("MYSQL_DB_USERNAME");
            passwd = properties.getProperty("MYSQL_DB_PASSWORD");
        } catch (IOException var5) {
            var5.printStackTrace();
            System.out.println("USER_NAME: " + properties.getProperty("MYSQL_DB_USERNAME"));
        }
        new DB(url, login, passwd);

        //insert first survey's question
        Question question = new Question("survey?");
        DB.executeUpdate(String.format("INSERT INTO survey (survey_name, question_id) VALUES ('some survey', %d)", question.getId()));
    }

    @Override
    protected void after() {
        try {
            DB.executeUpdate("DELETE FROM question");
            DB.executeUpdate("DELETE FROM answer");
            DB.executeUpdate("DELETE FROM question_answer");
            DB.executeUpdate("DELETE FROM survey");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
