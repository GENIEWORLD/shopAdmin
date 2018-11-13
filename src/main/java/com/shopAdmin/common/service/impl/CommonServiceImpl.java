package com.shopAdmin.common.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.common.model.Code;
import com.common.util.StringUtil;
import com.shopAdmin.common.service.CommonService;

/**
 * Common Service Implements
 */
@Service("commonService")
public class CommonServiceImpl implements CommonService{
    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

    /**
     * 공통코드 하위코드 조회
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectCode(String code) throws Exception{
        return defaultDAO.selectList("Common.selectCodeList", StringUtil.getString(Code.class.getDeclaredField(code).get(Code.class)));
    }

    /**
     * 공통코드 하위코드 묶음 조회
     */
    public Map<String, Object> selectCodes(String[] codes) throws Exception{
        Map<String, Object> codeMap = new HashMap<String, Object>();
        for (int i=0;i<codes.length;i++) {
            codeMap.put(codes[i].toString(),defaultDAO.selectList("Common.selectCodeList", StringUtil.getString(Code.class.getDeclaredField(codes[i]).get(Code.class))));
        }
        return codeMap;
    }

    /**
     * 디자이너 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectDesignerList() throws Exception{
        return defaultDAO.selectList("Common.selectDesignerList", StringUtil.getString(Code.ADMIN_TYPE_DESIGNER));
    }

    /**
     * 업체 목록 조회
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> selectVendorList() throws Exception{
        return defaultDAO.selectList("Common.selectVendorList", null);
    }
}
