package com.shopAdmin.common.service;

import java.util.List;
import java.util.Map;

/**
 * Common Service Interface
 */
public interface CommonService {


    /**
     * 공통코드 하위코드 조회
     */
    public List<Map<String, Object>> selectCode(String code) throws Exception;

    /**
     * 공통코드 하위코드 묶음 조회
     */
    public Map<String, Object> selectCodes(String[] codes) throws Exception;

    /**
     * 디자이너 목록 조회
     */
    public List<Map<String, Object>> selectDesignerList() throws Exception;

    /**
     * 업체 목록 조회
     */
    public List<Map<String, Object>> selectVendorList() throws Exception;
}