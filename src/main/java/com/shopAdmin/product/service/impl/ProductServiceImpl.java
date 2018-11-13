package com.shopAdmin.product.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.product.service.ProductService;
import com.shopAdmin.product.service.StockService;


@Service("productService")
public class ProductServiceImpl implements ProductService {

    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    @Resource(name="stockService")
    private StockService stockService;
    
    /**
     * 상품코드 생성 
     */
    private String makeProductCode () {
        int len = 20;
        List<String> stringList = new ArrayList<String>();
        Random rnd = new Random();
        do {
            if(rnd.nextBoolean()){
                stringList.add(String.valueOf((char)((int)(rnd.nextInt(26)) + 65)));
            }else{
                stringList.add(StringUtil.getString(rnd.nextInt(10)));
            }
        } while (stringList.size() < len);
        
        return org.springframework.util.StringUtils.collectionToDelimitedString(stringList, "");
    }
    
    /**
     * 상품관리 > 상품목록 개수 
     */
    public int selectProductListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Product.selectProductListCount", commandMap);
    }
    
    /**
     * 상품관리 > 상품목록 
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectProductList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Product.selectProductList", commandMap);
    }
    
    /**
     * 상품관리 > 상품상세정보 
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectProductInfo (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.select("Product.selectProductInfo", commandMap);
    }
    
    /**
     * 상품관리 > 상품등록 
     */
    public void insertProduct (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        int cnt = 1;
        do {
            commandMap.put("PRD_MST_CD", this.makeProductCode());
            cnt = this.defaultDAO.selectCount("Product.selectProductCodeValidCount", commandMap);
        } while(cnt > 0);
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.insert("Product.insertProduct", commandMap);
        
        String [] STR_MST_IDXs = StringUtil.getArray(commandMap, "STR_MST_IDXs");
        String [] SKU_MST_STATUSs = StringUtil.getArray(commandMap, "SKU_MST_STATUSs");
        String [] SKU_MST_STCs = StringUtil.getArray(commandMap, "SKU_MST_STCs");
        String [] SKU_MST_PRCs = StringUtil.getArray(commandMap, "SKU_MST_PRCs");
        for (int i = 0; i < STR_MST_IDXs.length; i++) {
            commandMap.put("STR_MST_IDX", StringUtil.getString(STR_MST_IDXs[i]));
            commandMap.put("SKU_MST_STATUS", StringUtil.getString(SKU_MST_STATUSs[i]));
            commandMap.put("SKU_MST_STC", StringUtil.getString(SKU_MST_STCs[i]));
            commandMap.put("SKU_MST_PRC", StringUtil.getString(SKU_MST_PRCs[i]));
            // 매장별 재고등록
            this.stockService.insertStock(request, commandMap);
        }
    }
 
    /**
     * 상품관리 > 상품수정 
     */
    public void updateProduct (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
        this.defaultDAO.update("Product.updateProduct", commandMap);

        String [] DEL_STR_MST_IDXs = StringUtil.getArray(commandMap, "DEL_STR_MST_IDXs");
        
        for (int i = 0; i < DEL_STR_MST_IDXs.length; i++) {
            commandMap.put("STR_MST_IDX", DEL_STR_MST_IDXs[i]);
            // 매장별 재고 삭제
            this.stockService.deleteStock(request, commandMap);
        }
        String [] SKU_MST_IDXs = StringUtil.getArray(commandMap, "SKU_MST_IDXs");
        String [] STR_MST_IDXs = StringUtil.getArray(commandMap, "STR_MST_IDXs");
        String [] SKU_MST_STATUSs = StringUtil.getArray(commandMap, "SKU_MST_STATUSs");
        String [] SKU_MST_STCs = StringUtil.getArray(commandMap, "SKU_MST_STCs");
        String [] SKU_MST_PRCs = StringUtil.getArray(commandMap, "SKU_MST_PRCs");
        for (int i = 0; i < STR_MST_IDXs.length; i++) {
            commandMap.put("SKU_MST_IDX", StringUtil.getInt(SKU_MST_IDXs[i]));
            commandMap.put("STR_MST_IDX", StringUtil.getString(STR_MST_IDXs[i]));
            commandMap.put("SKU_MST_STATUS", StringUtil.getString(SKU_MST_STATUSs[i]));
            commandMap.put("SKU_MST_STC", StringUtil.getString(SKU_MST_STCs[i]));
            commandMap.put("SKU_MST_PRC", StringUtil.getString(SKU_MST_PRCs[i]));
            // 매장별 재고 MERGE
            this.stockService.mergeStock(request, commandMap);
        }
        
    }
}
