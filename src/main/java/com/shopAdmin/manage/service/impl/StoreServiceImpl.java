package com.shopAdmin.manage.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.exception.AccessException;
import com.common.model.Code;
import com.common.session.SessionsAdmin;
import com.common.util.StringUtil;
import com.shopAdmin.manage.service.StoreService;

@Service("storeService")
public class StoreServiceImpl implements StoreService {

    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;
    
    /**
     * 매장관리 > 매장 목록 개수 
     */
    public int selectStoreListCount (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectCount("Store.selectStoreListCount", commandMap);
    }
    
    /**
     * 매장관리 > 매장 목록 
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStoreList (Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Store.selectStoreList", commandMap);
    }
    
    /**
     * 매장관리 > 매장 상세정보 
     */
    @SuppressWarnings("unchecked")
    public Map<String, Object> selectStoreInfo (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        Map<String, Object> info = this.defaultDAO.select("Store.selectStoreInfo", commandMap);
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_ADMIN
                || StringUtil.getInt(info, "STR_MST_IDX", 0) == StringUtil.getInt(SessionsAdmin.getSessionStrMstIdx(request))) {
            return info;
        } else {
            throw new AccessException(); 
        }
    }
 
    /**
     * 매장관리 >  매장 등록 
     */
    public void insertStore (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_ADMIN) {
            commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
            this.defaultDAO.insert("Store.insertStore", commandMap);
        } else {
            throw new AccessException();
        }
    }
    
    /**
     * 매장관리 > 매장 수정 
     */
    public void updateStore (HttpServletRequest request, Map<String, Object> commandMap) throws Exception {
        Map<String, Object> info = this.selectStoreInfo(request, commandMap);
        if (StringUtil.getInt(SessionsAdmin.getSessionAdminGbn(request)) == Code.ADMIN_TYPE_ADMIN
                || StringUtil.getInt(info, "STR_MST_IDX", 0) == StringUtil.getInt(SessionsAdmin.getSessionStrMstIdx(request))) {
            commandMap.put("REG_ID", SessionsAdmin.getSessionAdminId(request));
            this.defaultDAO.insert("Store.updateStore", commandMap);
        } else {
            throw new AccessException(); 
        }
    }
    
    /**
     * 공통 > 매장 목록 
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectStoreCommonList(Map<String, Object> commandMap) throws Exception {
        return this.defaultDAO.selectList("Store.selectStoreCommonList", commandMap);
    }
}
