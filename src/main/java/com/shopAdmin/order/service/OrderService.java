package com.shopAdmin.order.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * 주문관리 Service Interface
 */
public interface OrderService {

    /**
     * 주문 개수
     */
    public int selectOrderListCount(Map<String, Object> commandMap) throws Exception;

    /**
     * 주문 목록
     */
    public List<Map<String, Object>> selectOrderList(Map<String, Object> commandMap) throws Exception;

    /**
     * 고객 주문 목록
     */
    public List<Map<String, Object>> selectCustomerOrderList(Map<String, Object> commandMap) throws Exception;
    
    /**
     * 주문 등록
     */
    public void insertOrder(Map<String, Object> commandMap) throws Exception;    
    
    /**
     * 주문 상세 정보
     */
    public Map<String, Object> selectOrderInfo (Map<String, Object> commandMap) throws Exception;
    
    /**
     * 주문 수정
     */
    public void updateOrder(Map<String, Object> commandMap) throws Exception;
    
    /**
     * 주문 삭제
     */
    public void deleteOrder(Map<String, Object> commandMap) throws Exception;
    
    /**
     * 주문 상태 수정
     */
    public void updateOrderState(Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.order.service
     * @fileName   : OrderService.java
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
    public List<Map<String, Object>> selectOrderReservationList (Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.order.service
     * @fileName   : OrderService.java
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
    public void insertOrderReservation (HttpServletRequest request, Map<String, Object> commandMap) throws Exception;
    
    /**
     * @packeName  : com.shopAdmin.order.service
     * @fileName   : OrderService.java
     * @methodName : deleteOrderReservation
     * @author     : CHANG SHIN
     * @since      : 2017. 8. 4.
     * @version    : 1.0
     * @comment    : 납품예약삭제
     *
     * @param commandMap
     * @throws Exception
     */
    public void deleteOrderReservation (Map<String, Object> commandMap) throws Exception;
}
