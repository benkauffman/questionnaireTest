package com.dataabstractsolutions.filter;

import org.apache.log4j.Logger;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

/**
 * Created by benkauffman on 1/17/17.
 */
@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class OriginFilter implements Filter {
    static Logger logger = Logger.getLogger(OriginFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {

        logger.info("REQUEST PROCESSED THROUGH ORIGIN FILTER");

//            spring has it's own error mapping, but I like to wrap everything in an "origin filter"
//            this allows me to debug each request and also return custom error messages
//            which ensures that if there is a sensitive error we won't send back too much information to the client

        String uuid = "[" + UUID.randomUUID().toString() + "]"; // <-- to keep track of each request with a unique id
        try {
            HttpServletRequest request = ((HttpServletRequest) servletRequest);
            String url = request.getRequestURL().toString();

            long start = System.currentTimeMillis();

            String secured = request.isSecure() ? "SECURED" : "UNSECURED ";
            String verb = request.getMethod();
            logger.info(secured + verb + " REQUEST AT " + url);


            filterChain.doFilter(servletRequest, servletResponse);
            logger.debug(uuid + " Origin request completed in " + (System.currentTimeMillis() - start) + "ms");


        } catch (Exception e) {
            logger.error(uuid + "UNABLE TO PROCESS REQUEST", e);
            ((HttpServletResponse) servletResponse).setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }

    }





}