package com.shopAdmin.login.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.session.SessionsAdmin;
import com.common.util.AesCrypto;
import com.common.util.StringUtil;
import com.shopAdmin.login.service.LoginService;

/**
 * 관리자 로그인 Service Implements
 */
@Service("loginService")
public class LoginServiceImpl implements LoginService{

    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    /**
     * 로그인 처리
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> loginProc(HttpServletRequest request, HttpServletResponse response, Map<String, Object> commandMap) throws Exception{
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String resultMsg = "";
        String loginSuccess = "N";

        String adminId = StringUtil.getString(commandMap.get("adminId"), "");
        String adminPw = StringUtil.getString(commandMap.get("adminPw"), "");

        if(("").equals(adminId)){
            resultMsg = Code.login_id_invalid;
        }else if(("").equals(adminPw)){
            resultMsg = Code.login_pw_invalid;
        }else{
            
            commandMap.put("SALES_TYPE_INDIVIDUAL", Code.SALES_TYPE_INDIVIDUAL);
            commandMap.put("SALES_TYPE_SOP", Code.SALES_TYPE_SOP);
            commandMap.put("SALARY_TYPE_INDIVIDUAL", Code.SALARY_TYPE_INDIVIDUAL);
            commandMap.put("SALARY_TYPE_SHOP", Code.SALARY_TYPE_SHOP);
            
            // 관리자 정보 조회
            Map<String, Object> adminInfo = (Map<String, Object>)defaultDAO.select("Login.selectLoginInfo", commandMap);

            // 비밀번호 확인
            adminPw = AesCrypto.encryptOnly(adminPw); // 비밀번호 암호화
            if(adminInfo == null || !StringUtil.getString(adminInfo.get("ADM_MST_PWD")).equals(adminPw)){
                resultMsg = Code.login_id_pw_incorrect;
            }else{
                // 관리자 계정 체크
                if(("N").equals(StringUtil.getString(adminInfo.get("ADM_MST_USE_YN"), "N"))){
                    resultMsg = Code.login_stop_login;
                }else{
                    // login 이력 등록
                    defaultDAO.insert("Login.insertLoginHistory", commandMap);

                    // 로그인 session 등록
                    Map<String, Object> sessionMap = new HashMap<String, Object>();
                    sessionMap.put("adminId", adminInfo.get("ADM_MST_ID")); // 로그인 ID
                    sessionMap.put("adminNm", adminInfo.get("ADM_MST_NM")); // 로그인 사용자 명
                    sessionMap.put("admingGbn", adminInfo.get("ADM_MST_GBN")); // 관리자 구분
                    sessionMap.put("strMstIdx", adminInfo.get("STR_MST_IDX")); // 매장 IDX
                    sessionMap.put("strMstNm", adminInfo.get("STR_MST_NM")); // 매장명
                    sessionMap.put("salesYn", adminInfo.get("salesYn")); // 매출관리 > 매장매출 접근권한
                    sessionMap.put("salaryAllYn", adminInfo.get("salaryAllYn")); // 직원관리 > 급여관리 : 모든직원 급여 조회 권한
                    sessionMap.put("holidayDelYn", adminInfo.get("holidayDelYn")); // 직원관리 > 휴일관리 : 휴일삭제 권한
                    sessionMap.put("noticeYn", adminInfo.get("noticeYn")); // 메인 > 공지사항 : 등록, 삭제 권한
                    
                    if (StringUtil.getInt(adminInfo, "ADM_MST_GBN", Code.ADMIN_TYPE_DESIGNER) == Code.ADMIN_TYPE_ADMIN) {
                        sessionMap.put("roleAdmin", ROLE.administrator); // 관리자 권한
                    } else if (StringUtil.getInt(adminInfo, "ADM_MST_GBN", Code.ADMIN_TYPE_DESIGNER) == Code.ADMIN_TYPE_DESIGNER) {
                        sessionMap.put("roleAdmin", ROLE.manager); // 매니저 권한
                    }

                    SessionsAdmin.setSessionAdmin(request, sessionMap);
                    loginSuccess = "Y";
                }
            }
        }

        resultMap.put("resultMsg", resultMsg);
        resultMap.put("loginSuccess", loginSuccess);

        return resultMap;
    }
}
