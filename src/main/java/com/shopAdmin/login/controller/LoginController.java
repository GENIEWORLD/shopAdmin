package com.shopAdmin.login.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.RequestParams;
import com.common.session.SessionsAdmin;
import com.shopAdmin.login.service.LoginService;

/**
 * 관리자 로그인 Controller
 */
@Controller
public class LoginController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="loginService")
    private LoginService loginService;

    /**
     * 관리자 로그인 페이지
     */
    @RequestMapping("/login/login")
    public ModelAndView login (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        if(SessionsAdmin.isLoginAdmin(request)){
            mv.addObject("returnUrl", request.getAttribute("serverDomain") + "/dashboard/main.do");
            mv.setViewName("common/result");
        }

        return mv;
    }

    /**
     * 관리자 로그인 처리
     */
    @RequestMapping(value="/login/loginProc", method=RequestMethod.POST)
    public ModelAndView loginProc (HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 로그인 처리
        Map<String, Object> loginResult = this.loginService.loginProc(request, response, commandMap);

        mv.addObject("loginResult", loginResult);
        return mv;
    }

    /**
     * 관리자 로그아웃 처리
     */
    @RequestMapping("/login/logout")
    public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap){
        ModelAndView mv = new ModelAndView();

        // 세션을 삭제한다.
        SessionsAdmin.setSessionAdminClear(request);

        mv.addObject("returnUrl", request.getAttribute("serverDomain") + "/login/login.do");
        mv.setViewName("common/result");

        return mv;
    }
}
