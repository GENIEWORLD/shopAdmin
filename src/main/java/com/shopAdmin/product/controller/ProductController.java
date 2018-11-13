package com.shopAdmin.product.controller;

import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.paging.Paging;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.manage.service.StoreService;
import com.shopAdmin.product.service.ProductService;

@Controller
@AccessLevel(ROLE.manager)
public class ProductController {

    @Resource(name="productService")
    private ProductService productService;
    
    @Resource(name="storeService")
    private StoreService storeService;
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    
    private static final String RET_URL = "/product/productList.do";
    
    /**
     * 상품관리 목록
     */
    @RequestMapping(value="/product/productList")
    public ModelAndView productList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("searchStrMstIdx", SessionsAdmin.getSessionStrMstIdx(request));
        }
        
        int totalCount = this.productService.selectProductListCount(commandMap);
        mv.addObject("totalCount", totalCount);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        
        if (totalCount > 0) {
            mv.addObject("list", this.productService.selectProductList(commandMap));
        }
        
        // 공통코드 목록
        String [] codes = {"PRODUCT_GBN", "PRODUCT_STATUS"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    
    /**
     * 상품관리 등록 화면
     */
    @RequestMapping(value="/product/productForm")
    public ModelAndView productForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        // 공통코드 목록
        String [] codes = {"PRODUCT_GBN", "PRODUCT_STATUS"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    /**
     * 상품관리 수정 화면
     */
    @RequestMapping(value="/product/productEdit")
    public ModelAndView productEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        mv.addObject("info", this.productService.selectProductInfo(commandMap));
        // 공통코드 목록
        String [] codes = {"PRODUCT_GBN", "PRODUCT_STATUS"};
        mv.addObject("codes", this.commonService.selectCodes(codes));
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 상품관리 등록
     */
    @RequestMapping(value="/product/productRegist")
    public ModelAndView productRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap, Locale locale) throws Exception {
        ModelAndView mv =  new ModelAndView();
        try {
            // 상품관리 등록
            this.productService.insertProduct(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }

    /**
     * 상품관리 수정
     */
    @RequestMapping(value="/product/productModify")
    public ModelAndView productModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        try {
            // 상품관리 수정
            this.productService.updateProduct(request, commandMap);
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
