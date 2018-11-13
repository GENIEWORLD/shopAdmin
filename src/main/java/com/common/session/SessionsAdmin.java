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
public class SessionsAdmin {
    /**
    * 관리자 정보를 세션에 저장한다. 
    */
    public static void setSessionAdmin(HttpServletRequest request, Map<String, Object> sessionMap){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_ADMIN_SESSION_INFO__", sessionMap);
    }

    /**
    * 관리자 세션정보 전체를 반환한다. 
    */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static Map<String, Object> getSessionAdminMap(HttpServletRequest request){
        try{
            return (Map)request.getSession().getAttribute("__MALL_ADMIN_SESSION_INFO__");
        }
        catch (Exception e){
            return null;
        }
    }

    /**
    * 관리자 세션 정보 중 관리자 ID를 반환한다. 
    */
    public static String getSessionAdminId(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("adminId"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 관리자 명을 반환한다. 
    */
    public static String getSessionAdminNm(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("adminNm"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 관리자 구분을 반환한다. 
    */
    public static String getSessionAdminGbn(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("admingGbn"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 매출관리 > 매장매출 접근권한을 반환한다. 
    */
    public static String getSessionSalesYn(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("salesYn"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 직원관리 > 급여관리 : 모든직원 급여 조회 권한을 반환한다. 
    */
    public static String getSessionSalaryAllYn(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("salaryAllYn"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 직원관리 > 휴일관리 : 휴일삭제 권한을 반환한다. 
    */
    public static String getSessionHolidayDelYn(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("holidayDelYn"));
            }catch (Exception e) {
                return "";
            }
        }
    }

    /**
    * 관리자 세션 정보 중 메인 > 공지사항 : 등록, 삭제 권한을 반환한다. 
    */
    public static String getSessionNoticeYn(HttpServletRequest request){
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("noticeYn"));
            }catch (Exception e) {
                return "";
            }
        }
    }
    
    /**
     * 관리자 세션 정보 중 매장 IDX 정보를 반환한다.
     */
    public static String getSessionStrMstIdx (HttpServletRequest request) {
        if (getSessionAdminMap(request) == null){
            return "";
        }else{
            try{
                return String.valueOf(getSessionAdminMap(request).get("strMstIdx"));
            }catch (Exception e) {
                return "";
            }
        }
    }
    

    /**
    * 관리자 메뉴 정보 세션에 저장한다. 
    */
    public static void setSessionAdminMenuList(HttpServletRequest request, List<Map<String, Object>> menuList){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_ADMIN_MENU_SESSION_LIST__", menuList);
    }

    /**
    * 관리자 메뉴 정보를 반환한다. 
    */
    @SuppressWarnings("unchecked")
    public static List<Map<String, Object>> getSessionAdminMenuList(HttpServletRequest request){
        try {
            return (List<Map<String, Object>>) request.getSession().getAttribute("__MALL_ADMIN_MENU_SESSION_LIST__");
        } catch (Exception e){
            return null;
        }
    }

    /**
    * 관리자 세션을 삭제한다.
    */
    public static void setSessionAdminClear(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.setAttribute("__MALL_ADMIN_SESSION_INFO__", null);
        session.setAttribute("__MALL_ADMIN_MENU_SESSION_LIST__", null);
    }

    /**
    * 관리자 접근 LEVEL을 반환한다. 
    */
    public static ROLE getSessionRoleAdmin(HttpServletRequest request){
        if(isLoginAdmin(request)){
            Map<String, Object> map = getSessionAdminMap(request);
            String mapRole = StringUtil.getString(map.get("roleAdmin"), "guest");
            if (mapRole.equals(ROLE.administrator.toString())){
                return ROLE.administrator;
            } else if (mapRole.equals(ROLE.manager.toString())){
                return ROLE.manager;
            } else if (mapRole.equals(ROLE.member.toString())){
                return ROLE.member;
            } else {
                return ROLE.guest;
            }
        }else{
            return ROLE.guest;
        }
    }

    /**
    * 관리자 로그인 유무를 반환한다.
    */ 
    public static boolean isLoginAdmin(HttpServletRequest request){
        return getSessionAdminMap(request) != null;
    }
}