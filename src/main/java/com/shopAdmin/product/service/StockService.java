package com.shopAdmin.product.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface StockService {

    /**
     * 상품관리 > 재고목록 개수 
     */
    public int selectStockListCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 재고목록 
     */
    public List<Map<String, Object>> selectStockList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 재고등록 
     */
    public void insertStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception ;
    
    /**
     * 상품관리 > 재고수정 
     */
    public void updateStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 재고MERGE 
     */
    public void mergeStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception; 
    /**
     * 상품관리 > 재고삭제 
     */
    public void deleteStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * 메인 > 재고 품절 목록 
     */
    public List<Map<String, Object>> selectStockSoldOutList (Map<String, Object> commandMap) throws Exception;
}
