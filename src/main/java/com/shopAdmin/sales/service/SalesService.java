package com.shopAdmin.sales.service;

import java.util.List;
import java.util.Map;

/**
 * 매출관리 Service Interface
 */
public interface SalesService {

    /**
     * 매출 목록
     */
    public List<Map<String, Object>> selectSalesList(Map<String, Object> commandMap) throws Exception;

    /**
     * 매출 합계
     */
    public Map<String, Object> selectSalesTotalSum(Map<String, Object> commandMap) throws Exception;

    /**
     * 구매 회원수
     */
    public List<Map<String, Object>> selectSalesCustomerList(Map<String, Object> commandMap) throws Exception;

    /**
     * 구매확률
     */
    public List<Map<String, Object>> selectSalesProbabilityList(Map<String, Object> commandMap) throws Exception;

    /**
     * 일일일지 목록
     */
    public List<Map<String, Object>> selectDailyReportList(Map<String, Object> commandMap) throws Exception;

    /**
     * 일일일지 합계 목록
     */
    public List<Map<String, Object>> selectDailyReportSumList(Map<String, Object> commandMap) throws Exception;

    /**
     * 일일일지 등록
     */
    public void insertDailyReport(Map<String, Object> commandMap) throws Exception;

    /**
     * 일일일지 삭제
     */
    public int deleteDailyReport(Map<String, Object> commandMap) throws Exception;

    /**
     * 가계부 목록
     */
    public List<Map<String, Object>> selectLedgerList(Map<String, Object> commandMap) throws Exception;

    /**
     * 가계부 합계 목록
     */
    public List<Map<String, Object>> selectLedgerSumList(Map<String, Object> commandMap) throws Exception;

    /**
     * 가계부 등록
     */
    public void insertLedger(Map<String, Object> commandMap) throws Exception;

    /**
     * 가계부 삭제
     */
    public int deleteLedger(Map<String, Object> commandMap) throws Exception;
}
