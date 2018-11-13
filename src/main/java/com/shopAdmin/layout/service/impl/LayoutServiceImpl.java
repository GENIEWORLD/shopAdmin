package com.shopAdmin.layout.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.common.dao.CommonDefaultDAO;
import com.shopAdmin.layout.service.LayoutService;

/**
 * Layout Sample Service Implements
 */
@Service("layoutService")
public class LayoutServiceImpl implements LayoutService{
    @Resource(name="defaultDAO") 
    private CommonDefaultDAO defaultDAO;

}
