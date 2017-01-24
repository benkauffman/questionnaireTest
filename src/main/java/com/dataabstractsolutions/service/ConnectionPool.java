package com.dataabstractsolutions.service;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.log4j.Logger;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import static com.dataabstractsolutions.service.Properties.getStringSetting;

/**
 * Created by benkauffman on 1/23/17.
 */
public class ConnectionPool implements Runnable {
    private static final Logger logger = Logger.getLogger(ConnectionPool.class);
    private static DataSource datasource;

    public static synchronized DataSource getDataSource() {
        if (datasource == null) {
            logger.debug("CREATE NEW CONNECTION POOL");

            // pool efficiency formula
            // ((cpu core count * 2) + effective spindle count)
            // ((4 * 2) + 1) = 9

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(getStringSetting("sqlConnection"));
            config.setUsername(getStringSetting("sqlUser"));
            config.setPassword(getStringSetting("sqlPass"));
            config.setMinimumIdle(6);
            config.setMaximumPoolSize(9);
            config.setAutoCommit(true);
            config.addDataSourceProperty("cachePrepStmts", "true");
            config.addDataSourceProperty("prepStmtCacheSize", "250");
            config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
            config.setLeakDetectionThreshold(2500); // 2.5 seconds
            config.setConnectionTimeout(5000); // 5 seconds
            config.setIdleTimeout(900_000); // 15 minutes
            config.setMaxLifetime(28_440_000); // 7.9 hours

            datasource = new HikariDataSource(config);

        }

        return datasource;
    }

    public void run() {
    }

    public void print() {
    }


    public static Connection getConnection() {
        long poolStarted = System.currentTimeMillis();
        long poolStopped = System.currentTimeMillis();

        Connection conn = null;
        try {
            conn = ConnectionPool.getDataSource().getConnection();
            poolStopped = System.currentTimeMillis();
        } catch (SQLException sqlEx) {
            logger.fatal("Unable to get connection from connection pool...", sqlEx);
            //last attempt to manually establish a connection
            try {

                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection(
                        getStringSetting("sqlConnection"),
                        getStringSetting("sqlUser"),
                        getStringSetting("sqlPass"));

                return conn;
            } catch (Exception ex) {
                logger.fatal("Error connecting to the database...", ex);
            }
        }
        logger.debug("Pool connection time took " + (poolStopped - poolStarted) + "ms");
        return conn;
    }
}