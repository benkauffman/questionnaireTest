package com.dataabstractsolutions;

/**
 * Created by benkauffman on 1/17/17.
 */

import com.dataabstractsolutions.filter.OriginFilter;
import com.dataabstractsolutions.filter.PrivateFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;


@Configuration
public class WebConfig {

    @Bean
    public FilterRegistrationBean originFilterRegistrationBean() {
        //filter all requests through this filter
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setName("originFilter");
        registration.addUrlPatterns("*");
        OriginFilter originFilter = new OriginFilter();
        registration.setFilter(originFilter);
        registration.setOrder(1);
        return registration;
    }


    @Bean
    public FilterRegistrationBean privateFilterRegistrationBean() {
        //filter only the "private" which would be "authenticated" requests through this filter
        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setName("privateFilter");
        registration.addUrlPatterns("/private/*");
        PrivateFilter filter = new PrivateFilter();
        registration.setFilter(filter);
        registration.setOrder(2);
        return registration;
    }
}
