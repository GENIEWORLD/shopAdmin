package com.shopAdmin.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 공지사항 Service Interface
 */
public interface NoticeService {

    /**
     * 공지사항 목록 개수
     */
    public int selectNoticeListCount (Map<String, Object> commandMap) throws Exception;

    /**
     * 공지사항 목록
     */
    public List<Map<String, Object>> selectNoticeList (Map<String, Object> commandMap) throws Exception;

    /**
     * 공지사항 상세 정보
     */
    public Map<String, Object> selectNoticeInfo (Map<String, Object> commandMap) throws Exception;

    /**
     * 공지사항 등록
     */
    public void insertNotice (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;

    /**
     * 공지사항 수정
     */
    public void updateNotice (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;

    /**
     * 공지사항 상단 공지 목록
     */
    public List<Map<String, Object>> selectNoticeTopList (Map<String, Object> commandMap) throws Exception;
}
