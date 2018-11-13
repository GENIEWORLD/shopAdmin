package com.common.resolver;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.context.request.NativeWebRequest;

import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;

public class CommandMapArgumentResolver implements WebArgumentResolver {

    final Log logger = LogFactory.getLog(getClass());

    /**
     * Controller의 메소드 argument에 commandMap이라는 Map 객체가 있다면
     * HTTP request 객체에 있는 파라미터이름과 값을 commandMap에 담아 returng한다.
     * 배열인 파라미터 값은 배열로 Map에 저장한다.
     */
    public Object resolveArgument(MethodParameter methodParameter,  NativeWebRequest webRequest) throws Exception {
        Map<String, Object> commandMap = new HashMap<String, Object>();
        Class<?> clazz = methodParameter.getParameterType();
        String paramName = methodParameter.getParameterName();
        HttpServletRequest request = (HttpServletRequest)webRequest.getNativeRequest();
        boolean isSend = false;
               
        if(clazz.equals(Map.class) && paramName.equals("commandMap")) {
            Enumeration<?> enumeration = request.getParameterNames();
            while(enumeration.hasMoreElements()) {
                    String key = (String) enumeration.nextElement();
                    String[] values = request.getParameterValues(key);
                    if(values != null) {
                        commandMap.put(key, (values.length > 1) ? values : StringUtil.setInjectionReplace(values[0]) );
                    }
            }
            isSend = true;
        }
        if(isSend){
            commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
            commandMap.put("REG_IP", request.getRemoteAddr());
            return commandMap;
        } else {
            return UNRESOLVED;
        }
    }
}
