package com.shopAdmin.employee.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.model.Code;
import com.common.session.SessionsAdmin;
import com.common.util.AesCrypto;
import com.common.util.DateUtil;
import com.common.util.StringUtil;
import com.shopAdmin.employee.service.EmployeeService;

/**
 * 직원관리 Service Implements
 */
@Service("employeeService")
public class EmployeeServiceImpl implements EmployeeService{
    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeDesignerSalaryList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 목록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeDesignerSalaryList (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        int currentYear = DateUtil.getCurrentYear();
        int currentMonth = DateUtil.getCurrentMonth();
        commandMap.put("searchDay", StringUtil.getString(commandMap, "searchDay", StringUtil.getString(currentYear) + (currentMonth > 9 ? StringUtil.getString(currentMonth) : "0" + StringUtil.getString(currentMonth))));
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("ADM_MST_ID", SessionsAdmin.getSessionAdminId(request));
        }
        commandMap.put("INCEN_TYPE_INDIVIDUAL", Code.INCEN_TYPE_INDIVIDUAL);
        commandMap.put("INCEN_TYPE_SHOP", Code.INCEN_TYPE_SHOP);
        List<Map<String, Object>> list = this.defaultDAO.selectList("Employee.selectEmployeeDesignerSalaryList", commandMap);
        return list == null ? new ArrayList<Map<String, Object>>() : list;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : insertEmployeeDesignerSalary
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 등록
     *
     * @throws Exception
     */
    public void insertEmployeeDesignerSalary () throws Exception {
        Map<String, Object> commandMap = new HashMap<String, Object>();
        commandMap.put("ADMIN_TYPE_DESIGNER", Code.ADMIN_TYPE_DESIGNER);
        if (this.defaultDAO.insert("Employee.insertEmployeeDesignerSalary", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : updateEmployeeDesignerSalary
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 수정
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void updateEmployeeDesignerSalary (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        if (this.defaultDAO.update("Employee.updateEmployeeDesignerSalary", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeHolidayMasterInfo
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 이번달 휴일정보
     * 
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectEmployeeHolidayMasterInfo (Map<String, Object> commandMap) throws Exception {
        Map<String, Object> info = this.defaultDAO.select("Employee.selectEmployeeHolidayMasterInfo", commandMap);
        return info == null ? new HashMap<String, Object>() : info;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeHolidayAdminList
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 직원 목록
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeHolidayAdminList (Map<String, Object> commandMap) throws Exception {
        List<Map<String, Object>> list = this.defaultDAO.selectList("Employee.selectEmployeeHolidayAdminList", commandMap);
        return list == null ? new ArrayList<Map<String, Object>>() : list; 
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeHolidayRemainList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 남은휴일 목록
     * 
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeHolidayRemainList (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("ADM_MST_ID", SessionsAdmin.getSessionAdminId(request));
        }
        List<Map<String, Object>> list = this.defaultDAO.selectList("Employee.selectEmployeeHolidayRemainList", commandMap);
        return list == null ? new ArrayList<Map<String, Object>>() : list;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeHolidayList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일목록
     * 
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeHolidayList (Map<String, Object> commandMap) throws Exception {
        List<Map<String, Object>> list = this.defaultDAO.selectList("Employee.selectEmployeeHolidayList", commandMap);
        return list == null ? new ArrayList<Map<String, Object>>() : list;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeHolidayInfo
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 상세정보
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    public Map<String, Object> selectEmployeeHolidayInfo (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        Map<String, Object> returnMap = new HashMap<String, Object>();
        
        int currentYear = DateUtil.getCurrentYear();
        int currentMonth = DateUtil.getCurrentMonth();
        commandMap.put("searchYear", StringUtil.getString(commandMap, "searchYear", StringUtil.getString(currentYear)));
        commandMap.put("searchMonth", StringUtil.getString(commandMap, "searchMonth", currentMonth > 9 ? StringUtil.getString(currentMonth) : "0" + StringUtil.getString(currentMonth)));
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("ADM_MST_ID", SessionsAdmin.getSessionAdminId(request));
        }
        returnMap.put("holidayMasterInfo", this.selectEmployeeHolidayMasterInfo(commandMap));
        returnMap.put("holidayRemainList", this.selectEmployeeHolidayRemainList(request, commandMap));
        returnMap.put("holidayList", this.selectEmployeeHolidayList(commandMap));
        return returnMap;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : mergeEmployeeHolidayMaster
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 26.
     * @version    : 1.0
     * @comment    : 휴일마스터 정보 MERGE
     * 
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void mergeEmployeeHolidayMaster (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        // 접속정보
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        // 휴일 마스터 MERGE
        if (this.defaultDAO.insert("Employee.mergeEmployeeHolidayMaster", commandMap) <= 0) {
            throw new Exception();
        }
        String [] DSN_HLD_CNTs = StringUtil.getArray(commandMap, "DSN_HLD_CNTs");
        String [] DSN_HLD_IDs = StringUtil.getArray(commandMap, "DSN_HLD_IDs");
        for (int i = 0; i < DSN_HLD_CNTs.length; i++) {
            commandMap.put("DSN_HLD_CNT", DSN_HLD_CNTs[i]);
            commandMap.put("DSN_HLD_ID", DSN_HLD_IDs[i]);
            // 디자이너 별 휴일 MERGE
            if (this.defaultDAO.insert("Employee.mergeEmployeeHolidayRemain", commandMap) <= 0) {
                throw new Exception();
            }
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : insertEmployeeHoliday
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 휴일 등록
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void insertEmployeeHoliday (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        
        if (Code.ADMIN_TYPE_DESIGNER == StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request))) {
            commandMap.put("ADM_MST_ID", SessionsAdmin.getSessionAdminId(request));
        }
        // 디자이너 남은 휴일 조회
        Map<String, Object> holidayRemainInfo = this.defaultDAO.select("Employee.selectEmployeeHolidayPrevRemainList", commandMap);
        // 디자이너 남은 휴일
        int DSN_HLD_CNT = StringUtil.getInt(holidayRemainInfo.get("DSN_HLD_CNT"));
        // 디자이너가 신청한 휴일
        int HLD_INF_DAY = DateUtil.getDateDiff(StringUtil.getString(commandMap, "HLD_INF_SRT_DT", ""), StringUtil.getString(commandMap, "HLD_INF_END_DT", ""));
        if (DSN_HLD_CNT > HLD_INF_DAY) {
            
            // 선입선출
            
            
            // Access Info Setting
            commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
            commandMap.put("REG_IP", request.getRemoteAddr());
            
            if (this.defaultDAO.insert("Employee.insertEmployeeHoliday", commandMap) <= 0) {
                throw new Exception();
            }
        } else {
            commandMap.put("error", "");
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : updateEmployeeHoliday
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 휴일 수정
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void updateEmployeeHoliday (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        this.deleteEmployeeHoliday(commandMap);
        this.insertEmployeeHoliday(request, commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : deleteEmployeeHoliday
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 휴일삭제
     * 
     * @param commandMap
     * @throws Exception
     */
    public void deleteEmployeeHoliday (Map<String, Object> commandMap) throws Exception {
        if (this.defaultDAO.delete("Employee.deleteEmployeeHoliday", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeManagerListCount
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 목록 개수
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    public int selectEmployeeManagerListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Employee.selectEmployeeManagerListCount", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeManagerList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 목록
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeManagerList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Employee.selectEmployeeManagerList", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeManagerInfo
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 상세정보
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectEmployeeManagerInfo (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.select("Employee.selectEmployeeManagerInfo", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeManagerDupCount
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 아이디 중복 체크 개수
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    public int selectEmployeeManagerDupCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Employee.selectEmployeeManagerDupCount", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : insertEmployeeManager
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 등록
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void insertEmployeeManager (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        if (this.selectEmployeeManagerDupCount(commandMap) > 0) {
            throw new Exception();
        }
        commandMap.put("ADM_MST_PWD", AesCrypto.encryptOnly(StringUtil.getString(commandMap, "ADM_MST_PWD", "")));
        if (defaultDAO.insert("Employee.insertEmployeeManager", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : updateEmployeeManager
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 수정
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void updateEmployeeManager (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        if (!"".equals(StringUtil.getString(commandMap, "ADM_MST_PWD", ""))) {
            commandMap.put("ADM_MST_PWD", AesCrypto.encryptOnly(StringUtil.getString(commandMap, "ADM_MST_PWD", "")));
        }
        if (defaultDAO.update("Employee.updateEmployeeManager", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeVendorListCount
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 개수
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    public int selectEmployeeVendorListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Employee.selectEmployeeVendorListCount", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeVendorList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 목록
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectEmployeeVendorList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Employee.selectEmployeeVendorList", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : selectEmployeeVendorInfo
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 상세정보
     *
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectEmployeeVendorInfo (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.select("Employee.selectEmployeeVendorInfo", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : insertEmployeeVendor
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 등록
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void insertEmployeeVendor (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        if (defaultDAO.insert("Employee.insertEmployeeVendor", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : updateEmployeeVendor
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 수정
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void updateEmployeeVendor (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("REG_IP", request.getRemoteAddr());
        if (defaultDAO.update("Employee.updateEmployeeVendor", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.service.impl
     * @fileName   : EmployeeServiceImpl.java
     * @methodName : mergeEmployeeRemainHoliday
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 배치 > 직원 휴일 등록
     *
     * @param request
     * @param commandMap
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public void mergeEmployeeRemainHoliday () throws Exception {
        Map<String, Object> commandMap = new HashMap<String, Object>();
        int yyyy = DateUtil.getCurrentYear();
        int mm = DateUtil.getCurrentMonth();
        String YEAR = StringUtil.getString(yyyy);
        String MONTH = mm < 10 ? "0" + StringUtil.getString(mm) : StringUtil.getString(mm);
        
        // 이번달 휴일 등록
        int HLD_MST_CNT = 6;
        commandMap.put("HLD_MST_YER", YEAR);
        commandMap.put("HLD_MST_MON", MONTH);
        commandMap.put("HLD_MST_MON", HLD_MST_CNT);
        commandMap.put("REG_ID", "SYSTEM");
        commandMap.put("REG_IP", "0:0:0:0:0:0:0:1");
        // 휴일 마스터 MERGE
        this.defaultDAO.insert("Employee.mergeEmployeeHolidayMaster", commandMap);
        
        // 이전달 남은 휴일 조회
        List<Map<String, Object>> list = this.defaultDAO.selectList("Employee.selectEmployeeHolidayPrevRemainList", commandMap);
        for (Map<String, Object> info : list) {
            int DSN_HLD_CNT = StringUtil.getInt(info, "DSN_HLD_CNT", 0);
            // 이월된 휴일정보 합산
            DSN_HLD_CNT = HLD_MST_CNT + DSN_HLD_CNT;
            // 휴일정보 SET
            info.put("DSN_HLD_YER", YEAR);
            info.put("DSN_HLD_MON", MONTH);
            info.put("DSN_HLD_CNT", DSN_HLD_CNT);
            info.put("REG_ID", "SYSTEM");
            info.put("REG_IP", "0:0:0:0:0:0:0:1");
            // 디자이너 별 휴일 MERGE
            if (this.defaultDAO.insert("Employee.mergeEmployeeHolidayRemain", info) <= 0) {
                throw new Exception();
            }
        }
    }

}