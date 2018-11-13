package com.common.session;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.common.model.Role.ROLE;
import com.common.util.StringUtil;


/**
 * @프로그램 설명 : 세션처리
 */
public class SessionsMember {
    /**
    * 멤버 정보를 세션에 저장한다. 
    */
    public static void setSessionMember(HttpServletRequest request, Map<String, Object> sessionMap){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_MEMBER_SESSION_INFO__", sessionMap);
    }

    /**
    * 멤버 세션정보 전체를 반환한다. 
    */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static Map<String, Object> getSessionMemberMap(HttpServletRequest request){
        try{
            return (Map)request.getSession().getAttribute("__MALL_MEMBER_SESSION_INFO__");
        }
        catch (Exception e){
            return null;
        }
    }

    /**
    * 멤버 세션 정보 중 멤버 ID를 반환한다. 
    */
    public static String getSessionMemberId(HttpServletRequest request){
        if (getSessionMemberMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionMemberMap(request).get("memberId"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 멤버 세션 정보 중 멤버명을 반환한다. 
    */
    public static String getSessionMemberNm(HttpServletRequest request){
        if (getSessionMemberMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionMemberMap(request).get("memberNm"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 멤버 메뉴 정보 세션에 저장한다. 
    */
    public static void setSessionMemberMenuList(HttpServletRequest request, List<Map<String, Object>> menuList){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_MEMBER_MENU_SESSION_LIST__", menuList);
    }

    /**
    * 멤버 메뉴 정보를 반환한다. 
    */
    @SuppressWarnings("unchecked")
    public static List<Map<String, Object>> getSessionMemberMenuList(HttpServletRequest request){
        try {
            return (List<Map<String, Object>>) request.getSession().getAttribute("__MALL_MEMBER_MENU_SESSION_LIST__");
        } catch (Exception e){
            return null;
        }
    }

    /**
    * 멤버 세션을 삭제한다.
    */
    public static void setSessionMemberClear(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_MEMBER_SESSION_INFO__", null);
        session.setAttribute("__MALL_MEMBER_MENU_SESSION_LIST__", null);
    }

    /**
    * 멤버 접근 LEVEL을 반환한다. 
    */
    public static ROLE getSessionRoleMember(HttpServletRequest request){
        if(isLoginMember(request)){
            Map<String, Object> map = getSessionMemberMap(request);
            String mapRole = StringUtil.getString(map.get("roleMember"), "guest");
            if (mapRole.equals(ROLE.member.toString())){
                return ROLE.member;
            } else {
                return ROLE.guest;
            }
        }else{
            return ROLE.guest;
        }
    }

    /**
    * 멤버 로그인 유무를 반환한다.
    */ 
    public static boolean isLoginMember(HttpServletRequest request){
        return getSessionMemberMap(request) != null;
    }
}