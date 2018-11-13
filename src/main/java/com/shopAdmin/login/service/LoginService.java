package com.shopAdmin.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 관리자 로그인 Service Interface
 */
public interface LoginService {

    /**
     * 로그인 처리
     */
    public Map<String, Object> loginProc(HttpServletRequest request, HttpServletResponse response, Map<String, Object> commandMap) throws Exception;
}
