package com.shopAdmin.sales.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.exception.AccessException;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.session.SessionsAdmin;
import com.common.util.DateUtil;
import com.common.util.ExcelUtil;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.employee.service.EmployeeService;
import com.shopAdmin.manage.service.StoreService;
import com.shopAdmin.sales.service.SalesService;

/**
 * 매출관리 Controller
 */
@Controller
@AccessLevel(ROLE.manager)
public class SalesController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="salesService")
    private SalesService salesService;

    @Resource(name="employeeService")
    private EmployeeService employeeService;

    @Resource(name="commonService")
    private CommonService commonService;

    @Resource(name="storeService")
    private StoreService storeService;
    
    @Autowired
    MessageSource messageSource;

    /**
     * 직원별매출 리스트
     */
    @RequestMapping("/sales/employeeSalesList")
    public ModelAndView employeeSalesList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 조회 여부
        String searchYn = StringUtil.getString(commandMap.get("searchYn"));

        if(("Y").equals(searchYn)){

            // 관리자 구분 디자이너(본인매출만 확인 가능)
            if(adminGbn == Code.ADMIN_TYPE_DESIGNER){ 
                commandMap.put("searchDesigner", SessionsAdmin.getSessionAdminId(request));
            }

            // 매출 목록 조회
            List<Map<String, Object>> salesList = this.salesService.selectSalesList(commandMap);

            // 매출 합계 조회
            Map<String, Object> salesTotalSum = this.salesService.selectSalesTotalSum(commandMap);

            // 회원 수 조회
            List<Map<String, Object>> salesCustomerList = this.salesService.selectSalesCustomerList(commandMap);

            // 구매확률 조회
            commandMap.put("ordCnt", salesList.size());
            List<Map<String, Object>> salesProbabilityList = this.salesService.selectSalesProbabilityList(commandMap);

            mv.addObject("salesList", salesList);
            mv.addObject("salesCustomerList", salesCustomerList);
            mv.addObject("salesProbabilityList", salesProbabilityList);
            mv.addObject("salesTotalSum", salesTotalSum);
        }

        // 디자이너 목록 조회(관리자인경우만 조회)
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){ 
            List<Map<String, Object>> designerList = this.commonService.selectDesignerList();
            mv.addObject("designerList", designerList);
        }

        mv.addObject("commandMap", commandMap);

        return mv;
    }

    /**
     * 매장매출 리스트
     */
    @RequestMapping("/sales/storeSalesList")
    public ModelAndView storeSalesList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 매장매출 권한자만 접근 가능
        String salesYn = SessionsAdmin.getSessionSalesYn(request);
        if(("Y").equals(salesYn)){

            String searchYn = StringUtil.getString(commandMap.get("searchYn"));

            if(("Y").equals(searchYn)){
                // 매출 목록 조회
                List<Map<String, Object>> salesList = this.salesService.selectSalesList(commandMap);

                // 매출 합계 조회
                Map<String, Object> salesTotalSum = this.salesService.selectSalesTotalSum(commandMap);

                // 회원 수 조회
                List<Map<String, Object>> salesCustomerList = this.salesService.selectSalesCustomerList(commandMap);

                // 구매확률 조회
                commandMap.put("ordCnt", salesList.size());
                List<Map<String, Object>> salesProbabilityList = this.salesService.selectSalesProbabilityList(commandMap);

                mv.addObject("salesList", salesList);
                mv.addObject("salesCustomerList", salesCustomerList);
                mv.addObject("salesProbabilityList", salesProbabilityList);
                mv.addObject("salesTotalSum", salesTotalSum);
            }

            // 매장목록
            mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }

        return mv;
    }
    
    /**
     * 매장매출 엑셀 리스트
     */
    @RequestMapping("/sales/storeSalesExcelList")
    public void storeSalesExcelList (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        
        // 매장매출 권한자만 접근 가능
        String salesYn = SessionsAdmin.getSessionSalesYn(request);
        if(("Y").equals(salesYn)){
            // 조회 여부
            String searchYn = StringUtil.getString(commandMap.get("searchYn"));
            if(("Y").equals(searchYn)){
                
                String type = StringUtil.getString(commandMap, "type", "");
                if ("Sales".equals(type)) {
                    // 매출 목록 조회
                    List<Map<String, Object>> list = this.salesService.selectSalesList(commandMap);
                    String [] rowTitle = {messageSource.getMessage("common.title.order.date", null, locale)
                            , messageSource.getMessage("common.title.name", null, locale)
                            , messageSource.getMessage("common.title.vendor", null, locale)
                            , messageSource.getMessage("common.title.balance", null, locale)
                            , messageSource.getMessage("common.title.selling.price", null, locale)
                            , messageSource.getMessage("common.title.incen", null, locale)
                            , messageSource.getMessage("common.title.pay.price", null, locale)
                    };
                    String [] cellSize = {"50", "50", "50", "50", "50", "50", "50", "50"};
                    String [] dataName = {"ORD_MST_ORD_DT", "MEM_MST_NM", "COM_INF_NM", "ORD_MST_BAL", "ORD_MST_SAL", "COM_INCEN", "PROFIT"};
                    String [] dataType = {"String", "String", "String", "Dollar", "Dollar", "Dollar", "Dollar"};
                    ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "storeSalesExcel" + type + "List" + DateUtil.getToday());
                } else if ("Sum".equals(type)) {
                    // 매출 합계 조회
                    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
                    list.add(this.salesService.selectSalesTotalSum(commandMap));
                    String [] rowTitle = {messageSource.getMessage("common.title.cash", null, locale)
                            , messageSource.getMessage("common.title.card", null, locale)
                            , messageSource.getMessage("common.title.weixin", null, locale)
                            , messageSource.getMessage("common.title.jjeupu", null, locale)
                            , messageSource.getMessage("common.title.honbooe", null, locale)
                            , messageSource.getMessage("common.title.ttajung", null, locale)
                            , messageSource.getMessage("common.title.etc", null, locale)
                            , messageSource.getMessage("common.title.balance", null, locale)
                            , messageSource.getMessage("common.title.incen", null, locale)
                            , messageSource.getMessage("common.title.total", null, locale)
                            , messageSource.getMessage("common.title.pay.price", null, locale)
                    };
                    String [] cellSize = {"50", "50", "50", "50", "50", "50", "50", "50", "50", "50", "50", "50"};
                    String [] dataName = {"ORD_MST_CSH_SUM", "ORD_MST_CRD_SUM", "ORD_MST_WXN_SUM", "ORD_MST_ZFU_SUM", "ORD_MST_HBH_SUM", "ORD_MST_DZH_SUM", "ORD_MST_PAY_ETC_SUM", "ORD_MST_BAL_SUM", "COM_INCEN_SUM", "ORD_MST_SAL_SUM", "PROFIT_SUM"};
                    String [] dataType = {"Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar", "Dollar"};
                    ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "storeSalesExcel" + type + "List" + DateUtil.getToday());
                } else if ("Count".equals(type)) {
                    // 회원 수 조회
                    List<Map<String, Object>> list = this.salesService.selectSalesCustomerList(commandMap);
                    String [] rowTitle = {messageSource.getMessage("common.title.vendor", null, locale)
                            , messageSource.getMessage("common.title.member.count", null, locale)
                            , messageSource.getMessage("common.title.price", null, locale)
                    };
                    String [] cellSize = {"50", "50", "50"};
                    String [] dataName = {"COM_INF_NM", "MEM_CNT", "ORD_MST_SAL_SUM"};
                    String [] dataType = {"String", "Number", "Dollar"};
                    ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "storeSalesExcel" + type + "List" + DateUtil.getToday());
                    
                } else if ("Probability".equals(type)) {
                    // 구매확률 조회
                    commandMap.put("ordCnt", this.salesService.selectSalesList(commandMap).size());
                    List<Map<String, Object>> list = this.salesService.selectSalesProbabilityList(commandMap);
                    String [] rowTitle = {messageSource.getMessage("common.title.vendor", null, locale), "%"};
                    String [] cellSize = {"50", "50"};
                    String [] dataName = {"COM_INF_NM", "COM_RAT"};
                    String [] dataType = {"String", "String"};
                    ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "storeSalesExcel" + type + "List" + DateUtil.getToday());
                }
            }
        } else {
            throw new AccessException();
        }
    }

    /**
     * 업체별 인센 리스트
     */
    @RequestMapping("/sales/vendorIncenList")
    public ModelAndView vendorIncenList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            // 조회 여부
            String searchYn = StringUtil.getString(commandMap.get("searchYn"));

            if(("Y").equals(searchYn)){
                // 업체별 인센 목록 조회
                List<Map<String, Object>> incenList = this.salesService.selectSalesList(commandMap);

                // 업체별 인센 합계 조회
                Map<String, Object> incenTotalSum = this.salesService.selectSalesTotalSum(commandMap);

                mv.addObject("incenList", incenList);
                mv.addObject("incenTotalSum", incenTotalSum);
            }

            // 업체 목록 조회
            List<Map<String, Object>> vendorList = this.commonService.selectVendorList();

            mv.addObject("vendorList", vendorList);
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }

        return mv;
    }
    
    /**
     * 업체별 인센 엑셀 리스트 
     */
    @RequestMapping("/sales/vendorIncenExcelList")
    public void vendorIncenExcelList (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if (adminGbn == Code.ADMIN_TYPE_ADMIN) {
            
            // 조회 여부
            String searchYn = StringUtil.getString(commandMap.get("searchYn"));
            if(("Y").equals(searchYn)){
                List<Map<String, Object>> list = this.salesService.selectSalesList(commandMap);
                
                String [] rowTitle = {messageSource.getMessage("common.title.date", null, locale)
                        , messageSource.getMessage("common.title.name", null, locale)
                        , messageSource.getMessage("common.title.hp", null, locale)
                        , messageSource.getMessage("common.title.designer", null, locale)
                        , messageSource.getMessage("common.title.wedding.planne", null, locale)
                        , messageSource.getMessage("common.title.selling.price", null, locale)
                        , messageSource.getMessage("common.title.incen", null, locale)
                        , messageSource.getMessage("common.title.pay.price", null, locale)
                };
                String [] cellSize = {"50", "50", "50", "50", "50", "50", "50", "50", "50"};
                String [] dataName = {"ORD_MST_ORD_DT", "MEM_MST_NM", "MEM_MST_TEL", "ADM_MST_NM", "ORD_MST_WDP", "ORD_MST_SAL", "COM_INCEN", "PROFIT"};
                String [] dataType = {"String", "String", "String", "String", "String", "Dollar", "Dollar", "Dollar"};
                ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "vendorIncenExcelList_" + DateUtil.getToday());
            }
        } else {
            throw new AccessException();
        }
    }
    
    /**
     * 업체별 인센 합계 엑셀 리스트 
     */
    @RequestMapping("/sales/vendorIncenSumExcelList")
    public void vendorIncenSumExcelList (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if (adminGbn == Code.ADMIN_TYPE_ADMIN) {
            
            // 조회 여부
            String searchYn = StringUtil.getString(commandMap.get("searchYn"));

            if(("Y").equals(searchYn)){
                List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
                list.add(this.salesService.selectSalesTotalSum(commandMap));
                String [] rowTitle = {messageSource.getMessage("common.title.selling.price", null, locale)
                        , messageSource.getMessage("common.title.incen", null, locale)
                        , messageSource.getMessage("common.title.pay.price", null, locale)
                };
                String [] cellSize = {"50", "50", "50"};
                String [] dataName = {"ORD_MST_SAL_SUM", "COM_INCEN_SUM", "PROFIT_SUM"};
                String [] dataType = {"Dollar", "Dollar", "Dollar"};
                ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "vendorIncenSumExcelList_" + DateUtil.getToday());
            }
        } else {
            throw new AccessException();
        }
    }

    /**
     * 일일일지 리스트
     */
    @RequestMapping("/sales/dailyReportList")
    public ModelAndView dailyReportList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 조회기간
        String searchReportStartDate = StringUtil.getString(commandMap.get("searchReportStartDate"), "");
        String searchReportEndDate = StringUtil.getString(commandMap.get("searchReportEndDate"), "");
        String searchReportSumStartDate = StringUtil.getString(commandMap.get("searchReportSumStartDate"), "");
        String searchReportSumEndDate = StringUtil.getString(commandMap.get("searchReportSumEndDate"), "");

        // 일일일지 목록 조회
        List<Map<String, Object>> dailyReportList = null;
        if(!("").equals(searchReportStartDate) && !("").equals(searchReportEndDate)){
            dailyReportList = this.salesService.selectDailyReportList(commandMap);
        }

        // 일일일지 합계 목록 조회
        List<Map<String, Object>> dailyReportSumList = null;
        if(!("").equals(searchReportSumStartDate) && !("").equals(searchReportSumEndDate)){
            commandMap.put("DAY_WORK_GBN_ADV", Code.DAY_WORK_GBN_ADV);
            commandMap.put("DAY_WORK_GBN_SAL", Code.DAY_WORK_GBN_SAL);
            dailyReportSumList = this.salesService.selectDailyReportSumList(commandMap);
        }

        // 디자이너 목록 조회 
        List<Map<String, Object>> designerList = this.commonService.selectDesignerList();

        mv.addObject("dailyReportList", dailyReportList);
        mv.addObject("dailyReportSumList", dailyReportSumList);
        mv.addObject("designerList", designerList);
        mv.addObject("commandMap", commandMap);

        return mv;
    }

    /**
     * 일일일지 등록 화면
     */
    @RequestMapping("/sales/dailyReportForm")
    public ModelAndView dailyReportForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 디자이너 목록 조회
        List<Map<String, Object>> designerList = this.commonService.selectDesignerList();

        // 업체 목록 조회
        List<Map<String, Object>> vendorList = this.commonService.selectVendorList();

        // 공통코드 조회(일일일지업무목록)
        String code = "DAY_WORK_GBN";
        List<Map<String, Object>> dayWorkList = this.commonService.selectCode(code);

        mv.addObject("designerList", designerList);
        mv.addObject("vendorList", vendorList);
        mv.addObject("dayWorkList", dayWorkList);
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 일일일지 등록
     */
    @RequestMapping("/sales/dailyReportRegist")
    public ModelAndView dailyReportRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();
        try{
            // 일일일지 등록
            this.salesService.insertDailyReport(commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/sales/dailyReportList.do");
        mv.setViewName("common/result");
        
        return mv;
    }

    /**
     * 일일일지 삭제
     */
    @RequestMapping("/sales/dailyReportDelete")
    public ModelAndView dailyReportDelete (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 일일일지 삭제
            if(this.salesService.deleteDailyReport(commandMap) == 1){
                mv.addObject("alertMsg", "common.alert.save.success");
            }else{
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/sales/dailyReportList.do");
        mv.setViewName("common/result");
        return mv;
    }

    /**
     * 일일일지 합계 엑셀다운로드
     */
    @RequestMapping("/sales/dailyReportSumListExcelDown")
    public void dailyReportSumListExcelDown (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        // 일일일지 합계 목록 조회
        commandMap.put("DAY_WORK_GBN_ADV", Code.DAY_WORK_GBN_ADV);
        commandMap.put("DAY_WORK_GBN_SAL", Code.DAY_WORK_GBN_SAL);
        List<Map<String, Object>> list =  this.salesService.selectDailyReportSumList(commandMap);

        String [] rowTitle = {messageSource.getMessage("common.title.designer", null, locale)
                , messageSource.getMessage("common.title.vendor", null, locale)
                , messageSource.getMessage("common.title.advice.cnt", null, locale)
                , messageSource.getMessage("common.title.sales.cnt", null, locale)
                , messageSource.getMessage("common.btn.probability", null, locale)};
        
        String [] cellSize = {"50", "50", "50", "50", "50"};
        String [] dataName = {"ADM_MST_NM", "COM_INF_NM", "DAY_WRK_GBN_ADV_CNT", "DAY_WORK_GBN_SAL_CNT", "DAY_WRK_GBN_PROBABILITY"};
        String [] dataType = {"String", "String", "String", "String", "String"};
        ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "dailyReportSumList_" + DateUtil.getToday());
    }

    /**
     * 가계부 리스트
     */
    @RequestMapping("/sales/ledgerList")
    public ModelAndView ledgerList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            // 조회 월
            String searchYearMonth = StringUtil.getString(commandMap.get("searchYearMonth"), "");
            if(("").equals(searchYearMonth)){
                Date date = new Date();
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");

                searchYearMonth = dateFormat.format(date);
                commandMap.put("searchYearMonth", searchYearMonth);
            }

            // 조회 기간
            commandMap.put("searchStartDate", searchYearMonth + "-" + "01");
            commandMap.put("searchEndDate", searchYearMonth + "-" + "31");

            // 매출 합계 조회
            Map<String, Object> salesTotalSum = this.salesService.selectSalesTotalSum(commandMap);

            // 당월 순 매출
            int profitSum = 0;
            if(salesTotalSum != null){
                profitSum = StringUtil.getInt(salesTotalSum.get("PROFIT_SUM"), 0);
            }
            commandMap.put("profitSum", profitSum);

            // 가계부 목록 조회
            List<Map<String, Object>> ledgerList = this.salesService.selectLedgerList(commandMap);

            // 가계부 합계 조회
            List<Map<String, Object>> ledgerSumList = this.salesService.selectLedgerSumList(commandMap);

            // 공통코드 조회(가계부 항목)
            String code = "LEDGERLIST_GBN";
            List<Map<String, Object>> ledgerGbnList = this.commonService.selectCode(code);

            mv.addObject("profitSum", profitSum);
            mv.addObject("ledgerList", ledgerList);
            mv.addObject("ledgerSumList", ledgerSumList);
            mv.addObject("ledgerGbnList", ledgerGbnList);
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 가계부 등록 화면
     */
    @RequestMapping("/sales/ledgerForm")
    public ModelAndView ledgerForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            // 공통코드 조회(가계부 항목)
            String code = "LEDGERLIST_GBN";
            List<Map<String, Object>> ledgerGbnList = this.commonService.selectCode(code);

            mv.addObject("ledgerGbnList", ledgerGbnList);
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 가계부 등록
     */
    @RequestMapping("/sales/ledgerRegist")
    public ModelAndView ledgerRegist(HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            try{
                // 가계부 등록
                this.salesService.insertLedger(commandMap);
                mv.addObject("alertMsg", "common.alert.save.success");
            }catch(Exception e){
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
            
            mv.addObject("commandMap", commandMap);
            mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/sales/ledgerList.do");
            mv.setViewName("common/result");
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 가계부 삭제
     */
    @RequestMapping("/sales/ledgerDelete")
    public ModelAndView ledgerDelete (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            try{
                // 가계부 삭제
                if(this.salesService.deleteLedger(commandMap) == 1){
                    mv.addObject("alertMsg", "common.alert.save.success");
                }else{
                    mv.addObject("alertMsg", "common.alert.save.fail");
                }
            }catch(Exception e){
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
            
            mv.addObject("commandMap", commandMap);
            mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/sales/ledgerList.do");
            mv.setViewName("common/result");
        }else{
            throw new AccessException();
        }
        return mv;
    }
}
