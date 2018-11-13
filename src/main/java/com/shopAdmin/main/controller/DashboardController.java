package com.shopAdmin.main.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.session.SessionsAdmin;
import com.common.util.DateUtil;
import com.common.util.StringUtil;
import com.shopAdmin.board.service.NoticeService;
import com.shopAdmin.main.service.DashboardService;
import com.shopAdmin.product.service.StockService;
import com.shopAdmin.sales.service.SalesService;

/**
 * DashBoard Main Controller
 */
@Controller
@AccessLevel(ROLE.manager)
public class DashboardController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="dashboardService")
    private DashboardService dashboardService;
    
    @Resource(name="noticeService")
    private NoticeService noticeService;
    
    @Resource(name="stockService")
    private StockService stockService;
    
    @Resource(name="salesService")
    private SalesService salesService;

    /**
     * DashBoard Main
     */
    @RequestMapping(value="/dashboard/main")
    public ModelAndView dashboardMain(HttpServletRequest request, @RequestParams() Map<String, Object> commandMap) throws Exception  {
        ModelAndView mv = new ModelAndView();

        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("STR_MST_IDX", StringUtil.getInt(SessionsAdmin.getSessionStrMstIdx(request)));
            commandMap.put("SKU_MST_STATUS", Code.PRODUCT_STATUS_SOLD_OUT);
        }
        
        // 재고 품절 목록
        List<Map<String, Object>> stockSoldOutList = this.stockService.selectStockSoldOutList(commandMap);
        mv.addObject("stockSoldOutList", stockSoldOutList);
        
        // 공지사항 상단 목록
        List<Map<String, Object>> noticeTopList = this.noticeService.selectNoticeTopList(commandMap); 
        mv.addObject("noticeTopList", noticeTopList);
        
        commandMap.put("searchStartDate", DateUtil.getToday("-"));
        commandMap.put("searchEndDate", DateUtil.getToday("-"));
        Map<String, Object> salesTotalSum = this.salesService.selectSalesTotalSum(commandMap);
        mv.addObject("salesTotalSum", salesTotalSum);
        
        return mv;
    }
}
