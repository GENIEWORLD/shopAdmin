package com.shopAdmin.employee.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.model.Role.ROLE;
import com.common.paging.Paging;
import com.common.session.SessionsAdmin;
import com.common.util.DateUtil;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.employee.service.EmployeeService;
import com.shopAdmin.manage.service.StoreService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 직원관리 Controller
 */
@Controller
public class EmployeeController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="employeeService")
    private EmployeeService employeeService;
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    @Resource(name="storeService")
    private StoreService storeService;
    
    private static final String MANAGER_RET_URL = "/employee/managerList.do";
    private static final String VENDOR_RET_URL = "/employee/vendorList.do";
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : salaryList
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
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/salaryList")
    public ModelAndView salaryList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        int year = DateUtil.getCurrentYear();
        int month = DateUtil.getCurrentMonth();
        mv.addObject("year", StringUtil.getString(year));
        mv.addObject("month", month < 10 ? "0" + StringUtil.getString(month) : StringUtil.getString(month));
        mv.addObject("adminGbn", SessionsAdmin.getSessionAdminGbn(request));
        mv.addObject("list", this.employeeService.selectEmployeeDesignerSalaryList(request, commandMap));
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : salaryListAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 목록 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/salaryListAjax")
    public JSONArray salaryListAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        return JSONArray.fromObject(this.employeeService.selectEmployeeDesignerSalaryList(request, commandMap));
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : salaryModifyAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 27.
     * @version    : 1.0
     * @comment    : 직원관리 > 급여관리 > 디자이너 급여 수정 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/salaryModifyAjax")
    public JSONObject salaryModifyAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.employeeService.updateEmployeeDesignerSalary(request, commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 직원관리 > 급여관리 > 디자이너 급여 수정 Ajax =================");
            e.printStackTrace();
            this.logger.error("============================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
    

    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일관리 리스트
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/holidayList")
    public ModelAndView holidayList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.addObject("adminGbn", SessionsAdmin.getSessionAdminGbn(request));
        mv.addObject("adminId", SessionsAdmin.getSessionAdminId(request));
        mv.addObject("holidayDelYn", SessionsAdmin.getSessionHolidayDelYn(request));
        mv.addObject("adminList", this.employeeService.selectEmployeeHolidayAdminList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayInfoAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 24.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일정보 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/holidayInfoAjax")
    public JSONObject holidayInfoAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = JSONObject.fromObject(this.employeeService.selectEmployeeHolidayInfo(request, commandMap));
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayMaterMergeAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 26.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일마스터 MERGE
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/holidayMaterMergeAjax")
    public JSONObject holidayMaterMergeAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.employeeService.mergeEmployeeHolidayMaster(request, commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 직원관리 > 휴일관리 > 휴일마스터 MERGE Ajax =================");
            e.printStackTrace();
            this.logger.error("===========================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayRegistAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일등록 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/holidayRegistAjax")
    public JSONObject holidayRegistAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.employeeService.insertEmployeeHoliday(request, commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 직원관리 > 휴일관리 > 휴일등록 Ajax =================");
            e.printStackTrace();
            this.logger.error("====================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayModifyAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일수정 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/holidayModifyAjax")
    public JSONObject holidayModifyAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.employeeService.updateEmployeeHoliday(request, commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 직원관리 > 휴일관리 > 휴일수정 Ajax =================");
            e.printStackTrace();
            this.logger.error("====================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : holidayRemoveAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 직원관리 > 휴일관리 > 휴일삭제 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/employee/holidayRemoveAjax")
    public JSONObject holidayRemoveAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.employeeService.deleteEmployeeHoliday(commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 직원관리 > 휴일관리 > 휴일삭제 Ajax =================");
            e.printStackTrace();
            this.logger.error("====================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    } 
    

    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 목록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerList")
    public ModelAndView managerList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        int totalCount = this.employeeService.selectEmployeeManagerListCount(commandMap);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        if (totalCount > 0) {
            mv.addObject("list", this.employeeService.selectEmployeeManagerList(commandMap));
        }
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerForm
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 등록 폼
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerForm")
    public ModelAndView managerForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        String [] codes = {"ADMIN_TYPE", "INCEN_TYPE"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerEdit
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 수정 폼
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerEdit")
    public ModelAndView managerEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.addObject("info", this.employeeService.selectEmployeeManagerInfo(commandMap));
        String [] codes = {"ADMIN_TYPE", "INCEN_TYPE"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerDupCountAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 아이디 중복 체크
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerDupCountAjax")
    public JSONObject managerDupCountAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("isDup", (this.employeeService.selectEmployeeManagerDupCount(commandMap) > 0));
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerRegist
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 등록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerRegist")
    public ModelAndView managerRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            this.employeeService.insertEmployeeManager(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
            this.logger.error("================= 직원관리 >  관리자 관리 > 관리자 등록 =================");
            e.printStackTrace();
            this.logger.error("=====================================================================");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + MANAGER_RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : managerModify
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 관리자 수정
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/managerModify")
    public ModelAndView managerModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            this.employeeService.updateEmployeeManager(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
            this.logger.error("================= 직원관리 >  관리자 관리 > 관리자 수정 =================");
            e.printStackTrace();
            this.logger.error("=====================================================================");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + MANAGER_RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : vendorList
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 목록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/vendorList")
    public ModelAndView vendorList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        int totalCount = this.employeeService.selectEmployeeVendorListCount(commandMap);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        if (totalCount > 0) {
            mv.addObject("list", this.employeeService.selectEmployeeVendorList(commandMap));
        }
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : vendorForm
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 등록 폼
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/vendorForm")
    public ModelAndView vendorForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : vendorEdit
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 수정 폼
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/vendorEdit")
    public ModelAndView vendorEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.addObject("info", this.employeeService.selectEmployeeVendorInfo(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : vendorRegist
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 등록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/vendorRegist")
    public ModelAndView vendorRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            this.employeeService.insertEmployeeVendor(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
            this.logger.error("================= 직원관리 >  관리자 관리 > 업체 등록 =================");
            e.printStackTrace();
            this.logger.error("=====================================================================");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + VENDOR_RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.employee.controller
     * @fileName   : EmployeeController.java
     * @methodName : vendorModify
     * @author     : CHANG SHIN
     * @since      : 2017. 7. 28.
     * @version    : 1.0
     * @comment    : 직원관리 >  관리자 관리 > 업체 수정
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.administrator)
    @RequestMapping("/employee/vendorModify")
    public ModelAndView vendorModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        try {
            this.employeeService.updateEmployeeVendor(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
            this.logger.error("================= 직원관리 >  관리자 관리 > 업체 수정 =================");
            e.printStackTrace();
            this.logger.error("=====================================================================");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + VENDOR_RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
}
