package com.dataabstractsolutions.filter;

import org.apache.log4j.Logger;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by benkauffman on 1/17/17.
 */
@Component
@Order(Ordered.LOWEST_PRECEDENCE)
public class PrivateFilter implements Filter {
    static Logger logger = Logger.getLogger(PrivateFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {

        HttpServletRequest request = ((HttpServletRequest) servletRequest);

        logger.info("REQUEST PROCESSED THROUGH PRIVATE FILTER");

        String authHeader = request.getHeader("Authorization");
        boolean isAuthenticated = false;
        if (authHeader != null) {
            isAuthenticated = parseToken(authHeader);

        }

        if (!isAuthenticated) {
            //this user is not authenticated
            //kick out their request
            logger.info("USER IS NOT AUTHENTICATED");
            ((HttpServletResponse) servletResponse).setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }

    private boolean parseToken(String token) {
        logger.debug("USER TOKEN = " + token);
        //normally we would check to make sure the token is actually valid
        //for now just return true if they supplied something in the header
        return true;
    }

}
