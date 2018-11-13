package com.shopAdmin.product.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.RequestParams;
import com.common.model.Code;
import com.common.paging.Paging;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.manage.service.StoreService;
import com.shopAdmin.product.service.StockService;

@Controller
public class StockController {

    @Resource(name="stockService")
    private StockService stockService;
    
    @Resource(name="storeService")
    private StoreService storeService;
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    private static final String RET_URL = "/product/stockList.do";
    /**
     * 재고관리 목록
     */
    @RequestMapping(value="/product/stockList")
    public ModelAndView stockList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("searchStrMstIdx", SessionsAdmin.getSessionStrMstIdx(request));
        }
        
        int totalCount = this.stockService.selectStockListCount(commandMap);
        mv.addObject("totalCount", totalCount);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        
        if (totalCount > 0) {
            mv.addObject("list", this.stockService.selectStockList(commandMap));
        }
        
        // 공통코드 목록
        String [] codes = {"PRODUCT_STATUS"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 재고관리 수정
     */
    @RequestMapping(value="/product/stockModify")
    public ModelAndView stockModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        try {
            // 재고관리 수정
            this.stockService.updateStock(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
    
}
