package com.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoggingInterceptor extends HandlerInterceptorAdapter {
    final Logger logger = LoggerFactory.getLogger(LoggingInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestUri = request.getRequestURI().toString();
        Class<?> thisClass = handler.getClass();
        logger.debug("=====================================================================================");
        logger.debug("::: " + thisClass + " ["+requestUri+"] Start :::");
        logger.debug("::: Access IP ["+ request.getRemoteAddr() +"] :::");
        return true;
    }

    //after the handler is executed
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	//empty
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        String requestUri = request.getRequestURI().toString();
        Class<?> thisClass = handler.getClass();
        logger.debug("::: " + thisClass + " ["+requestUri+"] End :::");
        logger.debug("=====================================================================================\n\n");
    }
}
