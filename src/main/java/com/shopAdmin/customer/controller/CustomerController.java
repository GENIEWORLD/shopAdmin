package com.shopAdmin.customer.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.common.util.DateUtil;
import com.common.util.ExcelUtil;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.customer.service.CustomerService;
import com.shopAdmin.manage.service.StoreService;
import com.shopAdmin.sales.service.SalesService;

import net.sf.json.JSONArray;

/**
 * 고객관리 Controller
 */
@Controller
@AccessLevel(ROLE.manager)
public class CustomerController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="customerSerivce")
    private CustomerService customerService;

    @Resource(name="salesService")
    private SalesService salesService;

    @Resource(name="commonService")
    private CommonService commonService;

    @Resource(name="storeService")
    private StoreService storeService;
    
    @Autowired
    MessageSource messageSource;

    /**
     * 구매고객 리스트
     */
    @RequestMapping("/customer/buyCustomerList")
    public ModelAndView buyCustomerList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 조회조건 구매고객
        commandMap.put("searchMemMstLvl", Code.CUSTOMER_BUY);

        // 고객 수
        int totalCount = this.customerService.selectCustomerListCount(commandMap);

        // 페이징
        Paging paging = new Paging(totalCount, commandMap);
        commandMap.put("startNum", paging.getStartNum());
        commandMap.put("endNum", paging.getEndNum());
        
        // 고객 목록 조회
        List<Map<String, Object>> list = null;

        if(totalCount > 0){
            commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
            commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);
            commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
            list = this.customerService.selectCustomerList(commandMap);
        }

        // 공통코드 조회(매장, 선물set, 커프스)
        String[] codes = {"GIFT_KIND_SET", "GIFT_KIND_CUFFS"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);
        
        mv.addObject("list", list);
        mv.addObject("paging", paging);
        mv.addObject("codes", codesMap);
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * 구매고객 수정
     */
    @RequestMapping("/customer/buyCustomerModify")
    public ModelAndView buyCustomerModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv = new ModelAndView();
        
        try {
            commandMap.put("MEM_MST_LVL", Code.CUSTOMER_BUY);
            // 구매고객 수정
            this.customerService.updateCustomer(commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + "/customer/buyCustomerList.do");
        mv.setViewName("common/result");
        
        return mv;
    }
    

    /**
     * 가망고객 리스트
     */
    @RequestMapping("/customer/prsCustomerList")
    public ModelAndView prsCustomerList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 조회조건 가망고객
        commandMap.put("searchMemMstLvl", Code.CUSTOMER_PROSPECT);

        // 고객 수
        int totalCount = this.customerService.selectCustomerListCount(commandMap);

        // 페이징
        Paging paging = new Paging(totalCount, commandMap);
        commandMap.put("startNum", paging.getStartNum());
        commandMap.put("endNum", paging.getEndNum());

        // 고객 목록 조회
        List<Map<String, Object>> list = null;

        if(totalCount > 0){
            commandMap.put("GIFT_KIND_SET", Code.GIFT_KIND_SET);
            commandMap.put("GIFT_KIND_CUFFS", Code.GIFT_KIND_CUFFS);
            commandMap.put("GIFT_KIND_SOCKS", Code.GIFT_KIND_SOCKS);
            commandMap.put("GIFT_KIND_ETC", Code.GIFT_KIND_ETC);
            commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
            commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);
            commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
            list = this.customerService.selectCustomerList(commandMap);
        }

        // 선택 보기
        String viewChoices = StringUtil.getString(commandMap.get("viewChoices"), "");
        if(("").equals(viewChoices)){
            viewChoices = "";
            commandMap.put("viewChoices", "viewChoiceName,viewChoiceHp,viewChoiceDesigner,viewChoiceVisit,viewChoiceWedding,viewChoiceVendor,viewChoicePossible,viewChoiceGift,viewChoicePickup");
        }

        // 공통코드 조회(매장, 선물set, 커프스)
        String[] codes = {"GIFT_KIND_SET", "GIFT_KIND_CUFFS"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);

        mv.addObject("list", list);
        mv.addObject("paging", paging);
        mv.addObject("codes", codesMap);
        mv.addObject("commandMap", commandMap);

        return mv;
    }

    /**
     * 가망고객 엑셀 리스트
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/customer/prsCustomerExcelList")
    public void prsCustomerExcelList (Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception{
        
        // 조회조건 가망고객
        commandMap.put("searchMemMstLvl", Code.CUSTOMER_PROSPECT);
        
        commandMap.put("GIFT_KIND_SET", Code.GIFT_KIND_SET);
        commandMap.put("GIFT_KIND_CUFFS", Code.GIFT_KIND_CUFFS);
        commandMap.put("GIFT_KIND_SOCKS", Code.GIFT_KIND_SOCKS);
        commandMap.put("GIFT_KIND_ETC", Code.GIFT_KIND_ETC);
        commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
        commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);
        commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
        
        // 고객 목록 조회
        List<Map<String, Object>> list = this.customerService.selectCustomerList(commandMap);
        // 공통코드 조회(매장, 선물set, 커프스)
        String[] codes = {"GIFT_KIND_SET", "GIFT_KIND_CUFFS"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);
        
        for (Map<String, Object> info : list) {
            String MEM_MST_GFT_STR = "";
            String MEM_MST_GFT = StringUtil.getString(info, "MEM_MST_GFT", "");
            if (!"".equals(MEM_MST_GFT)) {
                int giftSetCnt = 0;
                int giftCuffsCnt = 0;
                List<Map<String, Object>> setList = (List<Map<String, Object>>) codesMap.get("GIFT_KIND_SET");
                for (Map<String, Object> set : setList) {
                    if (MEM_MST_GFT.indexOf(StringUtil.getString(set, "CMN_COM_IDX", "")) != -1) {
                        if (giftSetCnt == 0) {
                            MEM_MST_GFT_STR += messageSource.getMessage("common.title.gift.set", null, locale);
                            MEM_MST_GFT_STR += " : ";
                            MEM_MST_GFT_STR += StringUtil.getString(set, "CMN_COM_NM", "");
                        } else {
                            MEM_MST_GFT_STR += ", ";
                            MEM_MST_GFT_STR += StringUtil.getString(set, "CMN_COM_NM", "");
                        }
                        giftSetCnt = giftSetCnt + 1;
                    }
                }
                List<Map<String, Object>> cuffsList = (List<Map<String, Object>>) codesMap.get("GIFT_KIND_CUFFS");
                for (Map<String, Object> cuffs : cuffsList) {
                    if (MEM_MST_GFT.indexOf(StringUtil.getString(cuffs, "CMN_COM_IDX", "")) != -1) {
                        if (giftCuffsCnt == 0) {
                            MEM_MST_GFT_STR += (giftSetCnt > 0) ? "|" : "";
                            MEM_MST_GFT_STR += messageSource.getMessage("common.title.cuffs", null, locale);
                            MEM_MST_GFT_STR += " : ";
                            MEM_MST_GFT_STR += StringUtil.getString(cuffs, "CMN_COM_NM", "");
                        } else {
                            MEM_MST_GFT_STR += ", ";
                            MEM_MST_GFT_STR += StringUtil.getString(cuffs, "CMN_COM_NM", "");
                        }
                        giftCuffsCnt = giftCuffsCnt + 1;
                    }
                }
                if (MEM_MST_GFT.indexOf(StringUtil.getString(Code.GIFT_KIND_SOCKS)) != -1) {
                    MEM_MST_GFT_STR += (giftSetCnt > 0 || giftCuffsCnt > 0) ? "|" : "";
                    MEM_MST_GFT_STR += messageSource.getMessage("common.title.socks", null, locale);
                }
                if (MEM_MST_GFT.indexOf(StringUtil.getString(Code.GIFT_KIND_ETC)) != -1) {
                    if (MEM_MST_GFT.indexOf(StringUtil.getString(Code.GIFT_KIND_SOCKS)) != -1) {
                        MEM_MST_GFT_STR += ", ";
                        MEM_MST_GFT_STR += messageSource.getMessage("common.title.etc", null, locale);
                    } else {
                        MEM_MST_GFT_STR += (giftSetCnt > 0 || giftCuffsCnt > 0) ? "|" : "";
                        MEM_MST_GFT_STR += messageSource.getMessage("common.title.etc", null, locale);
                    }
                }
            }
            info.put("MEM_MST_GFT_STR", MEM_MST_GFT_STR);
        }
        
        String [] rowTitle = {messageSource.getMessage("common.title.member.name", null, locale)
                , messageSource.getMessage("common.title.hp", null, locale)
                , messageSource.getMessage("common.title.designer", null, locale)
                , messageSource.getMessage("common.title.visit.date", null, locale)
                , messageSource.getMessage("common.title.wedding.date", null, locale)
                , messageSource.getMessage("common.title.vendor", null, locale)
                , messageSource.getMessage("common.title.possible", null, locale)
                , messageSource.getMessage("common.title.gift", null, locale)
                , messageSource.getMessage("common.title.pickup.possible", null, locale)
        };
        String [] cellSize = {"50", "50", "50", "50", "50", "50", "50", "50", "50"};
        String [] dataName = {"MEM_MST_NM", "MEM_MST_TEL", "ADM_MST_NM", "MEM_MST_VST", "MEM_MST_WED", "COM_INF_NM", "MEM_MST_RAT_STR", "MEM_MST_GFT_STR", "MEM_MST_GFT_YN"};
        String [] dataType = {"String", "String", "String", "String", "String", "String", "String", "String", "String"};
        ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "vendorIncenExcelList_" + DateUtil.getToday());
        
    }
    
    
    /**
     * 가망고객 등록 화면
     */
    @RequestMapping("/customer/prsCustomerForm")
    public ModelAndView prsCustomerForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 공통코드 조회(매장, 선물set, 커프스)
        String[] codes = {"GIFT_KIND_SET", "GIFT_KIND_CUFFS"};
        Map<String, Object> codesMap = this.commonService.selectCodes(codes);

        // 디자이너 목록 조회
        List<Map<String, Object>> designerList = this.commonService.selectDesignerList();

        // 업체 목록 조회
        List<Map<String, Object>> vendorList = this.commonService.selectVendorList();

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
     * 가망고객 등록
     */
    @RequestMapping("/customer/prsCustomerRegist")
    public ModelAndView prsCustomerRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 고객 등록
            this.customerService.insertCustomer(commandMap);

            // 일일일지 등록
            String DAY_WRK_CTS = StringUtil.getString(commandMap.get("MEM_MST_CSL"), "");
            int DAY_WRK_GBN = Code.DAY_WORK_GBN_ADV;
            
            commandMap.put("DAY_WRK_GBN", DAY_WRK_GBN);
            commandMap.put("DAY_WRK_CTS", DAY_WRK_CTS);
            this.salesService.insertDailyReport(commandMap);

            mv.addObject("alertMsg", "common.alert.save.success");
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/customer/prsCustomerList.do");
        mv.setViewName("common/result");
        return mv;
    }

    /**
     * 가망고객 수정 화면
     */
    @RequestMapping("/customer/prsCustomerEdit")
    public ModelAndView prsCustomerEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 가망고객 상세정보
        commandMap.put("MEM_MST_LVL", Code.CUSTOMER_PROSPECT); // 가망고객
        Map<String, Object> customerInfo = this.customerService.selectCustomerInfo(commandMap);

        if(customerInfo != null){
            // 공통코드 조회(매장, 선물set, 커프스)
            String[] codes = {"GIFT_KIND_SET", "GIFT_KIND_CUFFS"};
            Map<String, Object> codesMap = this.commonService.selectCodes(codes);

            // 디자이너 목록 조회
            List<Map<String, Object>> designerList = this.commonService.selectDesignerList();

            // 업체 목록 조회
            List<Map<String, Object>> vendorList = this.commonService.selectVendorList();

            mv.addObject("codes", codesMap);
            mv.addObject("designerList", designerList);
            mv.addObject("vendorList", vendorList);
            mv.addObject("customerInfo", customerInfo);
            // 매장목록
            mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
            mv.addObject("commandMap", commandMap);
        }else{
            mv.addObject("alertMsg", "common.list.empty");
            mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/customer/prsCustomerList.do");
            mv.setViewName("common/result");
        }

        return mv;
    }

    /**
     * 가망고객 수정
     */
    @RequestMapping("/customer/prsCustomerModify")
    public ModelAndView prsCustomerModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        try{
            // 고객 수정
            commandMap.put("MEM_MST_LVL", Code.CUSTOMER_PROSPECT); // 가망고객
            if(this.customerService.updateCustomer(commandMap) == 1){
                mv.addObject("alertMsg", "common.alert.save.success");
            }else{
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
        }catch(Exception e){
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverSslDomain") + "/customer/prsCustomerList.do");
        mv.setViewName("common/result");
        return mv;
    }

    /**
     * 가망고객 달력
     */
    @RequestMapping("/customer/prsCustomerCalendar")
    public ModelAndView prsCustomerCalendar (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }

    /**
     * 가망고객 스케줄 조회
     */
    @ResponseBody
    @RequestMapping("/customer/customerSchedultListAjax")
    public JSONArray customerSchedultListAjax (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        // 조회조건 가망고객
        commandMap.put("searchMemMstLvl", Code.CUSTOMER_PROSPECT);

        commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
        commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);
        commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
        
        // 고객 스케줄 조회
        List<Map<String, Object>> list = this.customerService.selectCustomerList(commandMap);

        // 스케줄 목록 calendar 형태로 변환
        List<Map<String, Object>> schedultList = new ArrayList<Map<String, Object>>();
        Map<String, Object> schdultMap = null;
        String backgroundColor = "";
        for(Map<String, Object> dataMap : list){
            // 가능여부
            if((Code.CUSTOMER_RAT_R).equals(StringUtil.getString(dataMap.get("MEM_MST_RAT")))){
                backgroundColor = "red";
            }else if((Code.CUSTOMER_RAT_Y).equals(StringUtil.getString(dataMap.get("MEM_MST_RAT")))){
                backgroundColor = "orange";
            }else if((Code.CUSTOMER_RAT_G).equals(StringUtil.getString(dataMap.get("MEM_MST_RAT")))){
                backgroundColor = "green";
            }else{
                backgroundColor = "black";
            }

            // 방문일
            if(!("").equals(StringUtil.getString(dataMap.get("MEM_MST_VST")))){
                schdultMap = new HashMap<String, Object>();

                schdultMap.put("id", dataMap.get("MEM_MST_IDX"));
                schdultMap.put("title", StringUtil.getString(dataMap.get("MEM_MST_CD")) + "-" + StringUtil.getString(dataMap.get("MEM_MST_NM")) + "-" + StringUtil.getString(dataMap.get("ADM_MST_NM")));
                schdultMap.put("start", dataMap.get("MEM_MST_VST"));
                schdultMap.put("backgroundColor", backgroundColor);

                schedultList.add(schdultMap);
            }
        }

        // 스케줄 목록 jsonArray 형태로 변환
        JSONArray jsonArray = JSONArray.fromObject(schedultList);

        return jsonArray;
    }

    /**
     * 전체고객 확률
     */
    @RequestMapping("/customer/customerProbability")
    public ModelAndView customerProbability (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        // 조회기간
        String searchVendorStartDate = StringUtil.getString(commandMap.get("searchVendorStartDate"), "");
        String searchVendorEndDate = StringUtil.getString(commandMap.get("searchVendorEndDate"), "");
        String searchEmployeeStartDate = StringUtil.getString(commandMap.get("searchEmployeeStartDate"), "");
        String searchEmployeeEndDate = StringUtil.getString(commandMap.get("searchEmployeeEndDate"), "");

        // 가능여부 코드
        commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
        commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
        commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);

        // 업체별 조회
        List<Map<String, Object>> vendorList = null;
        if(!("").equals(searchVendorStartDate) && !("").equals(searchVendorEndDate)){
            vendorList = this.customerService.selectCustomerProbabilityVendorList(commandMap);
        }

        // 직원별 조회
        List<Map<String, Object>> employeeList = null;
        if(!("").equals(searchEmployeeStartDate) && !("").equals(searchEmployeeEndDate)){
            employeeList = this.customerService.selectCustomerProbabilityEmployeeList(commandMap);
        }

        mv.addObject("vendorList", vendorList);
        mv.addObject("employeeList", employeeList);
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 전체고객 확률 엑셀다운로드
     */
    @RequestMapping("/customer/customerProbabilityExcelDown")
    public void customerProbabilityExcelDown(Locale locale, HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception {

        List<Map<String, Object>> list = null;
        String excelKind = StringUtil.getString(commandMap.get("excelKind"), "");

        // 가능여부 코드
        commandMap.put("CUSTOMER_RAT_R", Code.CUSTOMER_RAT_R);
        commandMap.put("CUSTOMER_RAT_Y", Code.CUSTOMER_RAT_Y);
        commandMap.put("CUSTOMER_RAT_G", Code.CUSTOMER_RAT_G);

        if(("Vendor").equals(excelKind)){ // 업체별
            list = this.customerService.selectCustomerProbabilityVendorList(commandMap);

            String [] rowTitle = {messageSource.getMessage("common.title.vendor", null, locale)
                                    , messageSource.getMessage("common.title.member.count", null, locale)
                                    , messageSource.getMessage("common.title.buy.probability", null, locale) + "0%"
                                    , messageSource.getMessage("common.title.buy.probability", null, locale) + "50%"
                                    , messageSource.getMessage("common.title.buy", null, locale)};
            String [] cellSize = {"50", "50", "50", "50", "50"};
            String [] dataName = {"COM_INF_NM", "MEM_CNT", "RAT_R", "RAT_Y", "RAT_G"};
            String [] dataType = {"String", "String", "String", "String", "String"};
            ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "customerProbabilityVendor_" + DateUtil.getToday());
        }else if(("Employee").equals(excelKind)){ // 직원별
            list = this.customerService.selectCustomerProbabilityEmployeeList(commandMap);

            String [] rowTitle = {messageSource.getMessage("common.title.vendor", null, locale)
                    , messageSource.getMessage("common.title.member.count", null, locale)
                    , messageSource.getMessage("common.title.buy.probability", null, locale) + "0%"
                    , messageSource.getMessage("common.title.buy.probability", null, locale) + "50%"
                    , messageSource.getMessage("common.title.buy", null, locale)};
            
            String [] cellSize = {"50", "50", "50", "50", "50"};
            String [] dataName = {"ADM_MST_NM", "MEM_CNT", "RAT_R", "RAT_Y", "RAT_G"};
            String [] dataType = {"String", "String", "String", "String", "String"};
            ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "customerProbabilityEmployee_" + DateUtil.getToday());
        }
    }
}
