package com.shopAdmin.manage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface StoreService {

    /**
     * 매장관리 > 매장 목록 개수 
     */
    public int selectStoreListCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 매장관리 > 매장 목록 
     */
    public List<Map<String, Object>> selectStoreList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 매장관리 > 매장 상세정보 
     */
    public Map<String, Object> selectStoreInfo (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
 
    /**
     * 매장관리 >  매장 등록 
     */
    public void insertStore (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * 매장관리 > 매장 수정 
     */
    public void updateStore (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * 공통 > 매장 목록 
     */
    public List<Map<String, Object>> selectStoreCommonList(Map<String, Object> commandMap) throws Exception;
    
}