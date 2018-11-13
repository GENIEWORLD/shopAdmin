package com.shopAdmin.product.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ProductService {

    /**
     * 상품관리 > 상품목록 개수 
     */
    public int selectProductListCount (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 상품목록 
     */
    public List<Map<String, Object>> selectProductList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 상품상세정보 
     */
    public Map<String, Object> selectProductInfo (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 상품관리 > 상품등록 
     */
    public void insertProduct (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
 
    /**
     * 상품관리 > 상품수정 
     */
    public void updateProduct (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
}