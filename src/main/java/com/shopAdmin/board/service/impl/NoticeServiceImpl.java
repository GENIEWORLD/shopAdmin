package com.shopAdmin.board.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.session.SessionsAdmin;
import com.shopAdmin.board.service.NoticeService;

/**
 * 공지사항 Service Implements
 */
@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    /**
     * 공지사항 목록 개수
     */
    public int selectNoticeListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Notice.selectNoticeListCount", commandMap);
    }

    /**
     * 공지사항 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectNoticeList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Notice.selectNoticeList", commandMap);
    }

    /**
     * 공지사항 상세 정보
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectNoticeInfo (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.select("Notice.selectNoticeInfo", commandMap);
    }

    /**
     * 공지사항 등록
     */
    public void insertNotice (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.insert("Notice.insertNotice", commandMap);
    }

    /**
     * 공지사항 수정
     */
    public void updateNotice (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.update("Notice.updateNotice", commandMap);
    }

    /**
     * 공지사항 상단공지 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectNoticeTopList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Notice.selectNoticeTopList", commandMap);
    }
}