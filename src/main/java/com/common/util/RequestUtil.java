package com.common.util;

import javax.servlet.http.HttpServletRequest;

public class RequestUtil {


    public static HttpServletRequest currentRequest;

    public static HttpServletRequest getCurrentRequest() {
        return currentRequest;
    }

    public static void setCurrentRequest(HttpServletRequest currentRequest) {
        RequestUtil.currentRequest = currentRequest;
    }



}
