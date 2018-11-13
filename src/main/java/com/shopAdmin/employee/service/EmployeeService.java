package com.shopAdmin.employee.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 직원관리 Service Interface
 */
public interface EmployeeService {
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeDesignerSalaryList (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
     * @methodName : insertEmployeeDesignerSalary
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 등록
     *
     * @throws Exception
     */
    public void insertEmployeeDesignerSalary () throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void updateEmployeeDesignerSalary (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeHolidayAdminList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public Map<String, Object> selectEmployeeHolidayMasterInfo (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeHolidayRemainList (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeHolidayList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public Map<String, Object> selectEmployeeHolidayInfo (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void mergeEmployeeHolidayMaster (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void insertEmployeeHoliday (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void updateEmployeeHoliday (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
     * @methodName : deleteEmployeeHoliday
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 휴일삭제
     *
     * @param commandMap
     * @throws Exception
     */
    public void deleteEmployeeHoliday (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public int selectEmployeeManagerListCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeManagerList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public Map<String, Object> selectEmployeeManagerInfo (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public int selectEmployeeManagerDupCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void insertEmployeeManager (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void updateEmployeeManager (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public int selectEmployeeVendorListCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public List<Map<String, Object>> selectEmployeeVendorList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public Map<String, Object> selectEmployeeVendorInfo (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void insertEmployeeVendor (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void updateEmployeeVendor (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.employee.service
     * @fileName   : EmployeeService.java
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
    public void mergeEmployeeRemainHoliday () throws Exception;
    
}
