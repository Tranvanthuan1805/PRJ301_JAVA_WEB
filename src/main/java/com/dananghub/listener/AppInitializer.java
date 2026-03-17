package com.dananghub.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.util.TimeZone;

@WebListener
public class AppInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Set default TimeZone to Vietnam (GMT+7)
        TimeZone.setDefault(TimeZone.getTimeZone("Asia/Ho_Chi_Minh"));
        System.out.println("=========================================");
        System.out.println(">>> AppInitializer: TimeZone set to Asia/Ho_Chi_Minh");
        System.out.println(">>> Current Time: " + new java.util.Date());
        System.out.println("=========================================");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Clean up if needed
    }
}
