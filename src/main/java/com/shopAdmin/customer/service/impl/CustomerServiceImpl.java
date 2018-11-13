package com.shopAdmin.customer.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.model.Code;
import com.shopAdmin.customer.service.CustomerService;

/**
 * 고객관리 Service Implements
 */
@Service("customerSerivce")
public class CustomerServiceImpl implements CustomerService{
    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    /**
     * 구매고객 수
     */
    public int selectCustomerListCount(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectCount("Customer.selectCustomerListCount", commandMap);
    }

    /**
     * 구매고객 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCustomerList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Customer.selectCustomerList", commandMap);
    }

    /**
     * 고객 등록
     */
    public void insertCustomer(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Customer.insertCustomer", commandMap);
    }

    /**
     * 고객 상세 정보
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectCustomerInfo(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.select("Customer.selectCustomerInfo", commandMap);
    }

    /**
     * 고객 수정
     */
    public int updateCustomer(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.update("Customer.updateCustomer", commandMap);
    }

    /**
     * 확률 업체별
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCustomerProbabilityVendorList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Customer.selectCustomerProbabilityVendorList", commandMap);
    }

    /**
     * 확률 직원별
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCustomerProbabilityEmployeeList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Customer.selectCustomerProbabilityEmployeeList", commandMap);
    }

    /**
     * 가망고객 > 구매고객 변경
     */
    public int updateCustomerBuyLvl(Map<String, Object> commandMap) throws Exception{
        commandMap.put("MEM_MST_LVL", Code.CUSTOMER_BUY);
        commandMap.put("MEM_MST_RAT", Code.CUSTOMER_RAT_G);
        return defaultDAO.update("Customer.updateCustomerBuyLvl", commandMap);
    }
}
