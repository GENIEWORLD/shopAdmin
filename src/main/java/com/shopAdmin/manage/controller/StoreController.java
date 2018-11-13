package com.shopAdmin.manage.controller;

import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.AccessLevel;
import com.common.annotation.RequestParams;
import com.common.exception.AccessException;
import com.common.model.Code;
import com.common.model.Role.ROLE;
import com.common.paging.Paging;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;
import com.shopAdmin.manage.service.StoreService;

@Controller
@AccessLevel(ROLE.manager)
public class StoreController {

    @Resource(name="storeService")
    private StoreService storeService;
    
    @Resource(name="commonService")
    private CommonService commonService;
    
    
    private static final String RET_URL = "/manage/storeList.do";
    
    /**
     * 매장관리 목록
     */
    @RequestMapping(value="/manage/storeList")
    public ModelAndView storeList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_DESIGNER) {
            commandMap.put("searchStrMstIdx", SessionsAdmin.getSessionStrMstIdx(request));
        }
        
        int totalCount = this.storeService.selectStoreListCount(commandMap);
        mv.addObject("totalCount", totalCount);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        
        if (totalCount > 0) {
            mv.addObject("list", this.storeService.selectStoreList(commandMap));
        }
        // 매장등급 코드 목록
        mv.addObject("gradeList", this.commonService.selectCode("STORE_GRADE_CODE"));
        mv.addObject("commandMap", commandMap);
        return mv;
    }
    
    
    /**
     * 매장관리 등록 화면
     */
    @RequestMapping(value="/manage/storeForm")
    public ModelAndView storeForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        // 관리자만 접근 가능
        if(StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_ADMIN){
            // 매장등급 코드 목록
            mv.addObject("gradeList", this.commonService.selectCode("STORE_GRADE_CODE"));
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }
        return mv;
    }
    
    /**
     * 매장관리 수정 화면
     */
    @RequestMapping(value="/manage/storeEdit")
    public ModelAndView storeEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        mv.addObject("info", this.storeService.selectStoreInfo(request, commandMap));
        // 매장등급 코드 목록
        mv.addObject("gradeList", this.commonService.selectCode("STORE_GRADE_CODE"));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 매장관리 등록
     */
    @RequestMapping(value="/manage/storeRegist")
    public ModelAndView storeRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap, Locale locale) throws Exception {
        ModelAndView mv =  new ModelAndView();
        try {
            // 매장관리 등록
            this.storeService.insertStore(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (AccessException e){
            throw e;
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }

    /**
     * 매장관리 수정
     */
    @RequestMapping(value="/manage/storeModify")
    public ModelAndView storeModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        try {
            // 매장관리 수정
            this.storeService.updateStore(request, commandMap);
            mv.addObject("alertMsg", "common.alert.save.success");
        } catch (AccessException e){
            throw e;
        } catch (Exception e) {
            mv.addObject("alertMsg", "common.alert.save.fail");
        }
        mv.addObject("commandMap", commandMap);
        mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
        mv.setViewName("common/result");
        return mv;
    }
}
