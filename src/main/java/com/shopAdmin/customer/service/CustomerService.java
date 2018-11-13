package com.shopAdmin.customer.service;

import java.util.List;
import java.util.Map;

/**
 * 고객관리 Service Interface
 */
public interface CustomerService {

    /**
     * 고객 수
     */
    public int selectCustomerListCount(Map<String, Object> commandMap) throws Exception;

    /**
     * 고객 목록
     */
    public List<Map<String, Object>> selectCustomerList(Map<String, Object> commandMap) throws Exception;

    /**
     * 고객 등록
     */
    public void insertCustomer(Map<String, Object> commandMap) throws Exception;

    /**
     * 고객 상세 정보
     */
    public Map<String, Object> selectCustomerInfo(Map<String, Object> commandMap) throws Exception;

    /**
     * 고객 정보 수정
     */
    public int updateCustomer(Map<String, Object> commandMap) throws Exception;

    /**
     * 확률 업체별
     */
    public List<Map<String, Object>> selectCustomerProbabilityVendorList(Map<String, Object> commandMap) throws Exception;

    /**
     * 확률 직원별
     */
    public List<Map<String, Object>> selectCustomerProbabilityEmployeeList(Map<String, Object> commandMap) throws Exception;

    /**
     * 가망고객 > 구매고객 변경
     */
    public int updateCustomerBuyLvl(Map<String, Object> commandMap) throws Exception;
}
