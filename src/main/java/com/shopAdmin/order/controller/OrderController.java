package com.shopAdmin.order.controller;

import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.paging.Paging;
import com.common.session.SessionsAdmin;
import com.common.util.DateUtil;
import com.common.util.ExcelUtil;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.customer.service.CustomerService;
import com.shopAdmin.employee.service.EmployeeService;
import com.shopAdmin.manage.service.StoreService;
import com.shopAdmin.order.service.OrderService;
import com.shopAdmin.sales.service.SalesService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 주문관리 Controller
 */
@Controller
@AccessLevel(ROLE.manager)
public class OrderController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="orderSerivce")
    private OrderService orderSerivce;
    
    @Resource(name="commonService")
    private CommonService commonService;    
    
    @Resource(name="customerSerivce")
    private CustomerService customerService;    
    
    @Resource(name="employeeService")
    private EmployeeService employeeService;
    
    @Resource(name="salesService")
    private SalesService salesService;
    
    @Resource(name="storeService")
    private StoreService storeService;
    
    @Autowired
    MessageSource messageSource;    

    private static final String RET_URL = "/order/orderList.do";
    /**
     * 주문 리스트
     */
    @RequestMapping("/order/orderList")
    public ModelAndView orderList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv =  new ModelAndView();
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("searchOrdShop", SessionsAdmin.getSessionStrMstIdx(request));
        }
        
        // 공통코드 조회(매장, 주문상태)
        String[] codes = {"ORDER"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);        
        
        // 납품완료 제외
        commandMap.put("ORDER_STATE_COMPLETE", Code.ORDER_STATE_COMPLETE);
        
        int totalCount = this.orderSerivce.selectOrderListCount(commandMap);
        mv.addObject("totalCount", totalCount);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        
        if (totalCount > 0) {
            mv.addObject("list", this.orderSerivce.selectOrderList(commandMap));
        }
        
        mv.addObject("codes", codesMap);
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 주문 엑셀 다운로드
     */
    @RequestMapping("/order/orderListExcelDownload")
    public void orderListExcelDownload (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("searchOrdShop", SessionsAdmin.getSessionStrMstIdx(request));
        }
        
        commandMap.put("searchExcel", "Y");
        // 납품완료 제외
        commandMap.put("ORDER_STATE_COMPLETE", Code.ORDER_STATE_COMPLETE);
        List<Map<String,Object>> list = this.orderSerivce.selectOrderList(commandMap);
        
        String [] rowTitle = {messageSource.getMessage("common.title.member.no", null, locale), 
                messageSource.getMessage("common.title.name", null, locale), 
                messageSource.getMessage("common.title.hp", null, locale), 
                messageSource.getMessage("common.title.designer", null, locale), 
                "JK", "P", "V", "Y", "C", "SC", "SH", "O",
                "T", "B", "H", "ETC",
                messageSource.getMessage("common.title.order.date", null, locale),
                messageSource.getMessage("common.title.release.date", null, locale),
                messageSource.getMessage("common.title.pickup.date", null, locale),
                messageSource.getMessage("common.title.state", null, locale),
                messageSource.getMessage("common.title.give", null, locale)};
        String [] cellSize = {"50", "40", "60", "60", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "10", "40", "40", "40", "40", "60", "20"};
        String [] dataName = {"MEM_MST_CD", "MEM_MST_NM", "MEM_MST_TEL", "DSN_NM"
                             ,"ORD_MST_JK", "ORD_MST_P", "ORD_MST_V", "ORD_MST_Y", "ORD_MST_C", "ORD_MST_SC", "ORD_MST_SH", "ORD_MST_O"
                             ,"ORD_MST_NKT", "ORD_MST_BWT", "ORD_MST_HKC", "ORD_MST_SVC_ETC", "ORD_MST_REG_DT", "ORD_MST_RLS_DT", "ORD_MST_PIK_DT", "ORD_MST_ORD", "ORD_MST_GIV_YN"};
        String [] dataType = {"String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String", "String"};
        ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "orderList_" + DateUtil.getToday());
    }

    /**
     * 고객주문 리스트
     */
    @RequestMapping("/order/customerOrderListAjax")
    public ModelAndView customerOrderList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 고객 주문 목록 조회
        List<Map<String,Object>> list = this.orderSerivce.selectCustomerOrderList(commandMap);
        
        mv.addObject("list", list);
        return mv;
    }
    
    @RequestMapping("/order/orderForm")
    public ModelAndView orderForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        
        // 공통코드 조회(매장, 주문상태)
        String[] codes = {"ORDER"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);  
        
        // 디자이너 목록 조회
        List<Map<String, Object>> designerList = this.commonService.selectDesignerList();
        
     // 업체 목록 조회
        List<Map<String, Object>> vendorList = this.commonService.selectVendorList();
        
        ModelAndView mv = new ModelAndView();
        
        mv.addObject("codes", codesMap);
        mv.addObject("designerList", designerList);
        mv.addObject("vendorList", vendorList);
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("today", DateUtil.getToday("-"));
        mv.addObject("commandMap", commandMap);

        return mv;
    }
    
    /**
     * 회원 검색
     */
    @RequestMapping("/order/memberSearch")
    public ModelAndView memberSearch (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 고객 수
        int totalCount = this.customerService.selectCustomerListCount(commandMap);

        // 페이징
        Paging paging = new Paging(totalCount, commandMap);
        commandMap.put("startNum", paging.getStartNum());
        commandMap.put("endNum", paging.getEndNum());

        // 고객 목록 조회
        List<Map<String, Object>> list = null;

        if(totalCount > 0){
            list = this.customerService.selectCustomerList(commandMap);
        }

        mv.addObject("list", list);
        mv.addObject("paging", paging);
        mv.addObject("commandMap", commandMap);
        return mv;
    }  
    
    /**
     * 주문 등록
     */
    @RequestMapping("/order/insertOrder")
    public ModelAndView insertOrder (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 주문 등록
            this.orderSerivce.insertOrder(commandMap);
            if (commandMap.get("MEM_MST_LVL").equals("P")) {
                this.customerService.updateCustomerBuyLvl(commandMap);
            }
            
            // 일일일지 등록
            String DAY_WRK_CTS = StringUtil.getString(commandMap.get("MEM_MST_CSL"), "");
            int DAY_WRK_GBN = Code.DAY_WORK_GBN_SAL;
            
            commandMap.put("DAY_WRK_GBN", DAY_WRK_GBN);
            commandMap.put("DAY_WRK_CTS", DAY_WRK_CTS);
            this.salesService.insertDailyReport(commandMap);
            
            
            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }    
    
    @RequestMapping("/order/orderEdit")
    public ModelAndView orderEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        
        // 공통코드 조회(매장, 주문상태)
        String[] codes = {"STORE", "ORDER"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);  
        
        // 디자이너 목록 조회
        List<Map<String, Object>> designerList = this.commonService.selectDesignerList();
        
        // 업체 목록 조회
        List<Map<String, Object>> vendorList = this.commonService.selectVendorList();
        
        
        ModelAndView mv = new ModelAndView();
        
        // 주문정보
        mv.addObject("orderInfo", this.orderSerivce.selectOrderInfo(commandMap));
        mv.addObject("codes", codesMap);
        mv.addObject("designerList", designerList);
        mv.addObject("vendorList", vendorList);
        mv.addObject("commandMap", commandMap);

        return mv;
    }
    
    /**
     * 주문 수정
     */
    @RequestMapping("/order/updateOrder")
    public ModelAndView updateOrder (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 주문 등록
            this.orderSerivce.updateOrder(commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * 주문 삭제
     */
    @AccessLevel(ROLE.manager)
    @RequestMapping("/order/orderRemove")
    public ModelAndView orderRemove (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        try{
            // 주문 삭제
            this.orderSerivce.deleteOrder(commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * 주문 상태 수정
     */
    @RequestMapping("/order/updateOrderState")
    public ModelAndView updateOrderState (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 주문 상태 변경
            commandMap.put("ORD_MST_IDXs", StringUtil.getArray(commandMap, "ORD_MST_IDX"));
            this.orderSerivce.updateOrderState(commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.order.controller
     * @fileName   : OrderController.java
     * @methodName : orderReservationList
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 주문관리 > 납품예약관리 > 납품예약 목록
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @AccessLevel(ROLE.manager)
    @RequestMapping("/order/orderReservationList")
    public ModelAndView orderReservationList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        mv.addObject("adminList", this.employeeService.selectEmployeeHolidayAdminList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * @packeName  : com.shopAdmin.order.controller
     * @fileName   : OrderController.java
     * @methodName : orderReservationListAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 주문관리 > 납품예약관리 > 납품예약 목록 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/order/orderReservationListAjax")
    public JSONArray orderReservationListAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        return JSONArray.fromObject(this.orderSerivce.selectOrderReservationList(commandMap));
    }

    /**
     * @packeName  : com.shopAdmin.order.controller
     * @fileName   : OrderController.java
     * @methodName : orderReservationRegistAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 주문관리 > 납품예약관리 > 납품예약 등록 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/order/orderReservationRegistAjax")
    public JSONObject orderReservationRegistAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.orderSerivce.insertOrderReservation(request, commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 주문관리 > 납품예약관리 > 납품예약 등록 Ajax =================");
            e.printStackTrace();
            this.logger.error("============================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
    
    /**
     * @packeName  : com.shopAdmin.order.controller
     * @fileName   : OrderController.java
     * @methodName : orderReservationRemoveAjax
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 주문관리 > 납품예약관리 > 납품예약 삭제 Ajax
     *
     * @param request
     * @param commandMap
     * @return
     * @throws Exception
     */
    @ResponseBody
    @AccessLevel(ROLE.manager)
    @RequestMapping("/order/orderReservationRemoveAjax")
    public JSONObject orderReservationRemoveAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        JSONObject jsonObject = new JSONObject();
        try {
            this.orderSerivce.deleteOrderReservation(commandMap);
            jsonObject.accumulate("isSuccess", true);
        } catch (Exception e) {
            this.logger.error("================= 주문관리 > 납품예약관리 > 납품예약 삭제 Ajax =================");
            e.printStackTrace();
            this.logger.error("============================================================================");
            jsonObject.accumulate("isSuccess", false);
        }
        return jsonObject;
    }
}
