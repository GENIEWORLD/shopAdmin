package com.shopAdmin.board.controller;

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
import com.shopAdmin.board.service.NoticeService;
import com.shopAdmin.manage.service.StoreService;

/**
 * 공지사항 Controller
 */
@Controller
@AccessLevel(ROLE.manager)
public class NoticeController {
    
    @Resource(name="noticeService")
    private NoticeService noticeService;
    
    @Resource(name="storeService")
    private StoreService storeService;
    
    private static final String RET_URL = "/board/noticeList.do";
    
    /**
     * 공지사항 목록
     */
    @RequestMapping(value="/board/noticeList")
    public ModelAndView noticeList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();
        
        int totalCount = this.noticeService.selectNoticeListCount(commandMap);
        mv.addObject("totalCount", totalCount);
        mv.addObject("paging", new Paging(totalCount, commandMap));
        
        if (totalCount > 0) {
            mv.addObject("list", this.noticeService.selectNoticeList(commandMap));
        }
        // 매장목록
        mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 공지사항 등록 화면
     */
    @RequestMapping(value="/board/noticeForm")
    public ModelAndView noticeForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            // 매장목록
            mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 공지사항 상세 화면
     */
    @RequestMapping(value="/board/noticeView")
    public ModelAndView noticeView (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();

        mv.addObject("info", this.noticeService.selectNoticeInfo(commandMap));
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * 공지사항 수정 화면
     */
    @RequestMapping(value="/board/noticeEdit")
    public ModelAndView noticeEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            // 매장목록
            mv.addObject("storeList", this.storeService.selectStoreCommonList(commandMap));
            mv.addObject("info", this.noticeService.selectNoticeInfo(commandMap));
            mv.addObject("commandMap", commandMap);
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 공지사항 등록
     */
    @RequestMapping(value="/board/noticeRegist")
    public ModelAndView noticeRegist (HttpServletRequest request, @RequestParams Map<String, Object> commandMap, Locale locale) throws Exception {
        ModelAndView mv =  new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            try {
                // 공지사항 등록
                this.noticeService.insertNotice(request, commandMap);
                mv.addObject("alertMsg", "common.alert.save.success");
            } catch (Exception e) {
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
            mv.addObject("commandMap", commandMap);
            mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
            mv.setViewName("common/result");
        }else{
            throw new AccessException();
        }
        return mv;
    }

    /**
     * 공지사항 수정
     */
    @RequestMapping(value="/board/noticeModify")
    public ModelAndView noticeModify (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception {
        ModelAndView mv =  new ModelAndView();

        // 관리자 구분
        int adminGbn = StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request));

        // 관리자만 접근 가능
        if(adminGbn == Code.ADMIN_TYPE_ADMIN){
            try {
                // 공지사항 수정
                this.noticeService.updateNotice(request, commandMap);
                mv.addObject("alertMsg", "common.alert.save.success");
            } catch (Exception e) {
                mv.addObject("alertMsg", "common.alert.save.fail");
            }
            mv.addObject("commandMap", commandMap);
            mv.addObject("returnUrl", request.getAttribute("serverDomain") + RET_URL);
            mv.setViewName("common/result");
            return mv;
        }else{
            throw new AccessException();
        }
    }
}
