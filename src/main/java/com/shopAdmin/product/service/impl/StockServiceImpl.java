package com.shopAdmin.product.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.model.Code;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.product.service.StockService;

@Service("stockService")
public class StockServiceImpl implements StockService {

    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;
    
    /**
     * 상품관리 > 재고목록 개수 
     */
    public int selectStockListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Stock.selectStockListCount", commandMap);
    }
    
    /**
     * 상품관리 > 재고목록 
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStockList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Stock.selectStockList", commandMap);
    }
    
    /**
     * 상품관리 > 재고등록 
     */
    public void insertStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.insert("Stock.insertStock", commandMap);
    }
    
    /**
     * 상품관리 > 재고수정 
     */
    public void updateStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("PRODUCT_STATUS_SOLD_OUT", Code.PRODUCT_STATUS_SOLD_OUT);
        
        String [] SKU_MST_STATUSs = StringUtil.getArray(commandMap, "SKU_MST_STATUSs");
        String [] SKU_MST_IDXs = StringUtil.getArray(commandMap, "SKU_MST_IDXs");
        String [] SKU_MST_STCs = StringUtil.getArray(commandMap, "SKU_MST_STCs");
        String [] SKU_MST_PRCs = StringUtil.getArray(commandMap, "SKU_MST_PRCs");
        
        for (int i = 0; i < SKU_MST_IDXs.length; i++) {
            commandMap.put("SKU_MST_STATUS", StringUtil.getString(SKU_MST_STATUSs[i]));
            commandMap.put("SKU_MST_IDX", StringUtil.getString(SKU_MST_IDXs[i]));
            commandMap.put("SKU_MST_STC", StringUtil.getString(SKU_MST_STCs[i]));
            commandMap.put("SKU_MST_PRC", StringUtil.getString(SKU_MST_PRCs[i]));
            this.defaultDAO.update("Stock.updateStock", commandMap);
        }
    }
    
    /**
     * 상품관리 > 재고MERGE 
     */
    public void mergeStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        commandMap.put("PRODUCT_STATUS_SOLD_OUT", Code.PRODUCT_STATUS_SOLD_OUT);
        this.defaultDAO.insert("Stock.mergeStock", commandMap);
    }
    
    /**
     * 상품관리 > 재고삭제 
     */
    public void deleteStock (HttpServletRequest request, Map<String, Object> commandMap) throws Exception  {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.update("Stock.deleteStock", commandMap);
    }
    
    /**
     * 메인 > 재고 품절 목록 
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStockSoldOutList (Map<String, Object> commandMap) throws Exception {
       return this.defaultDAO.selectList("Stock.selectStockSoldOutList", commandMap); 
    }
}
