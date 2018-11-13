package com.common.interceptor;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.support.AopUtils;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.exception.AccessException;
import com.common.exception.SessionException;
import com.common.model.Role;
import com.common.model.Role.ROLE;
import com.common.session.SessionsAdmin;
import com.common.util.RequestUtil;

import egovframework.rte.fdl.property.EgovPropertyService;

public class WebAccessInterceptor implements HandlerInterceptor{
    @Resource(name="propertiesService") protected EgovPropertyService propertiesService;
    
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
        String requestUri = request.getRequestURI();
        String serverHost = request.getRemoteHost();
        Class<?> thisClass = AopUtils.getTargetClass(handler);
        Method thisMethod = this.getMethod(thisClass, requestUri);

        RequestUtil.setCurrentRequest(request);
        
        /* 접근권한 체크 */
        this.authorityCheck(request, response, requestUri, thisClass, thisMethod);

        // serverType (local, dev, real)
        String serveType = "local"; 
        if(serverHost.indexOf("localhost") >= 0){
            serveType = "local";
        }else if(serverHost.indexOf("dev.linuo0713.com") >= 0){
            serveType = "dev";
        }else if(serverHost.indexOf("www.linuo0713.com") >= 0){
            serveType = "real";
        }

        // domain
        String ssl = request.isSecure() ? ".ssl" : "";
        String curDomain = propertiesService.getString("server."+ serveType + ssl + ".domain");
        String serverDomain = propertiesService.getString("server."+ serveType +".domain");
        String serverSslDomain = propertiesService.getString("server."+ serveType +".ssl.domain");

        request.setAttribute("curDomain", curDomain);
        request.setAttribute("serverDomain", serverDomain);
        request.setAttribute("serverSslDomain", serverSslDomain);

        // session info
        if(SessionsAdmin.isLoginAdmin(request)){
            request.setAttribute("sessionInfo", SessionsAdmin.getSessionAdminMap(request));
        }

        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
        //today
        request.setAttribute("today", new SimpleDateFormat("yyyy.MM.dd",Locale.KOREA).format(new Date()));
    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception{
        //empty
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public Method getMethod(Class thisClass, String requestUri) throws SecurityException, NoSuchMethodException{
        Method thisMethod = null;
        String reqUrl = requestUri.substring(requestUri.lastIndexOf("/") + 1, requestUri.lastIndexOf("."));
        for(Method item : thisClass.getMethods()){
            if((reqUrl).equals(item.getName())){
                thisMethod = thisClass.getMethod(item.getName(), item.getParameterTypes());
                break;              
            }
        }
        return thisMethod;
    }

    /**
     * 접근권한 체크
     */
    public void authorityCheck(HttpServletRequest request, HttpServletResponse response, String requestUri, Class<?> thisClass, Method thisMethod) throws Exception{
        // 접근권한 디폴트 셋팅
       ROLE baseAccessRole = ROLE.guest;
       
       try {
           // 접근하고자 하는 Class 또는 Method의 접근 레벨 확인
           if(thisClass.isAnnotationPresent(AccessLevel.class)){
               baseAccessRole = thisClass.getAnnotation(AccessLevel.class).value();
           }else if(AnnotationUtils.findAnnotation(thisMethod, AccessLevel.class) != null){
               baseAccessRole = AnnotationUtils.findAnnotation(thisMethod, AccessLevel.class).value();
           }
       }catch(Exception e){
           
       }
       // 로그인 유무 확인
       if(!SessionsAdmin.isLoginAdmin(request) && requestUri.indexOf("/login") == -1){
           throw new SessionException();
       }

       // 로그인 세션이 존재 유무에 따른 접근자 레벨 설정 
       ROLE userAccessRole = (ROLE)SessionsAdmin.getSessionRoleAdmin(request);

       int baseAccessAdminRoleCnt = Role.levels.get(baseAccessRole);
       int userAccessAdminRoleCnt = Role.levels.get(userAccessRole);
       
       this.logger.debug("baseAccessRole : " + baseAccessRole.toString() + ", baseAccessAdminRoleCnt : " + baseAccessAdminRoleCnt);
       this.logger.debug("userAccessRole : " + userAccessRole.toString() + ", userAccessAdminRoleCnt : " + userAccessAdminRoleCnt); 
       
       // 접근권한 체크
       if(userAccessAdminRoleCnt < baseAccessAdminRoleCnt){
           throw new AccessException();
       }
   }
}
