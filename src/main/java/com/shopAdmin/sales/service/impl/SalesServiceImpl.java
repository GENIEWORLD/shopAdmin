package com.shopAdmin.sales.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.shopAdmin.sales.service.SalesService;

/**
 * 매출관리 Service Implements
 */
@Service("salesService")
public class SalesServiceImpl implements SalesService {
    @Resource(name = "defaultDAO")
    private CommonDefaultDAO defaultDAO;

    /**
     * 매출 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectSalesList(Map<String, Object> commandMap) throws Exception {
        return defaultDAO.selectList("Sales.selectSalesList", commandMap);
    }

    /**
     * 매출 합계
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectSalesTotalSum(Map<String, Object> commandMap) throws Exception {
        return defaultDAO.select("Sales.selectSalesTotalSum", commandMap);
    }

    /**
     * 구매 회원수
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectSalesCustomerList(Map<String, Object> commandMap) throws Exception {
        return defaultDAO.selectList("Sales.selectSalesCustomerList", commandMap);
    }

    /**
     * 구매확률
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectSalesProbabilityList(Map<String, Object> commandMap) throws Exception {
        return defaultDAO.selectList("Sales.selectSalesProbabilityList", commandMap);
    }

    /**
     * 일일일지 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectDailyReportList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Sales.selectDailyReportList", commandMap);
    }

    /**
     * 일일일지 합계 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectDailyReportSumList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Sales.selectDailyReportSumList", commandMap);
    }

    /**
     * 일일일지 등록
     */
    public void insertDailyReport(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Sales.insertDailyReport", commandMap);
    }

    /**
     * 일일일지 삭제
     */
    public int deleteDailyReport(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.delete("Sales.deleteDailyReport", commandMap);
    }

    /**
     * 가계부 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectLedgerList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Sales.selectLedgerList", commandMap);
    }

    /**
     * 가계부 합계 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectLedgerSumList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Sales.selectLedgerSumList", commandMap);
    }

    /**
     * 가계부 등록
     */
    public void insertLedger(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Sales.insertLedger", commandMap);
    }

    /**
     * 가계부 삭제
     */
    public int deleteLedger(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.delete("Sales.deleteLedger", commandMap);
    }
}
