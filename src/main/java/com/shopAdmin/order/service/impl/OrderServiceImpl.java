package com.shopAdmin.order.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.util.DateUtil;
import com.common.util.StringUtil;
import com.shopAdmin.order.service.OrderService;

/**
 * 주문관리 Service Implements
 */
@Service("orderSerivce")
public class OrderServiceImpl implements OrderService{
    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    /**
     * 주문 개수
     */
    public int selectOrderListCount(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectCount("Order.selectOrderListCount", commandMap);
    }

    /**
     * 주문 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectOrderList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Order.selectOrderList", commandMap);
    }

    /**
     * 고객 주문 목록
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCustomerOrderList(Map<String, Object> commandMap) throws Exception{
        return defaultDAO.selectList("Order.selectCustomerOrderList", commandMap);
    }
    
    /**
     * 주문 등록
     */
    public void insertOrder(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Order.insertOrder", commandMap);
    }
    
    /**
     * 주문 상세 정보
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectOrderInfo (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.select("Order.selectOrderInfo", commandMap);
    }    
    
    /**
     * 주문 수정
     */
    public void updateOrder(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Order.updateOrder", commandMap);
    }
    
    /**
     * 주문 삭제
     */
    public void deleteOrder(Map<String, Object> commandMap) throws Exception {
        defaultDAO.delete("Order.deleteOrder", commandMap);
    }
    
    /**
     * 주문 상태 수정
     */
    public void updateOrderState(Map<String, Object> commandMap) throws Exception{
        defaultDAO.insert("Order.updateOrderState", commandMap);
    }
    
    /**
     * @packeName  : com.shopAdmin.order.service.impl
     * @fileName   : OrderServiceImpl.java
     * @methodName : selectOrderReservationList
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 납품예약목록
     * 
     * @param commandMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectOrderReservationList (Map<String, Object> commandMap) throws Exception {
        
        int currentYear = DateUtil.getCurrentYear();
        int currentMonth = DateUtil.getCurrentMonth();
        commandMap.put("searchYear", StringUtil.getString(commandMap, "searchYear", StringUtil.getString(currentYear)));
        commandMap.put("searchMonth", StringUtil.getString(commandMap, "searchMonth", currentMonth > 9 ? StringUtil.getString(currentMonth) : "0" + StringUtil.getString(currentMonth)));
        
        List<Map<String, Object>> list = this.defaultDAO.selectList("Order.selectOrderReservationList", commandMap);
        return list == null ? new ArrayList<Map<String, Object>>() : list;
    }
    
    /**
     * @packeName  : com.shopAdmin.order.service.impl
     * @fileName   : OrderServiceImpl.java
     * @methodName : insertOrderReservation
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 납품예약등록
     * 
     * @param request
     * @param commandMap
     * @throws Exception
     */
    public void insertOrderReservation (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        String [] ORD_RSV_DATEs = StringUtil.getString(commandMap, "ORD_RSV_DATE", "").split("-");
        commandMap.put("ORD_RSV_YER", ORD_RSV_DATEs[0]);
        commandMap.put("ORD_RSV_MON", ORD_RSV_DATEs[1]);
        commandMap.put("ORD_RSV_DAY", ORD_RSV_DATEs[2]);
        if (this.defaultDAO.selectCount("Order.selectOrderReservationDupCount", commandMap) > 0) {
            throw new Exception("F00");
        }
        if (this.defaultDAO.insert("Order.insertOrderReservation", commandMap) <= 0) {
            throw new Exception();
        }
    }
    
    /**
     * @packeName  : com.shopAdmin.order.service.impl
     * @fileName   : OrderServiceImpl.java
     * @methodName : deleteOrderReservation
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 납품예약삭제
     * 
     * @param commandMap
     * @throws Exception
     */
    public void deleteOrderReservation (Map<String, Object> commandMap) throws Exception {
        if (this.defaultDAO.delete("Order.deleteOrderReservation", commandMap) <= 0) {
            throw new Exception();
        }
    }
}
