package com.shopAdmin.layout.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.common.annotation.RequestParams;
import com.common.paging.Paging;
import com.common.util.DateUtil;
import com.common.util.ExcelUtil;
import com.shopAdmin.layout.service.LayoutService;

/**
 * Layout Sample Controller
 */
@Controller
public class LayoutController {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Resource(name="layoutService")
    private LayoutService layoutService;
    
    @Autowired
    private ExcelUtil excelUtil;
    
    /**
     * Layout Sample Login
     */
    @RequestMapping("/layout/sampleLogin")
    public ModelAndView sampleLogin (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }

    /**
     * Layout Sample List
     */
    @RequestMapping("/layout/sampleList")
    public ModelAndView sampleList (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();
        
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("RNUM", 1);
        map.put("MEM_MST_NM", "칭웨이");
        map.put("MEM_MST_USE_YN", "Y");
        map.put("MEM_MST_REG_DT", "20170704122000");
        list.add(map);
        map = new HashMap<String, Object>();
        map.put("RNUM", 2);
        map.put("MEM_MST_NM", "탕웨이");
        map.put("MEM_MST_USE_YN", "N");
        map.put("MEM_MST_REG_DT", "20170520132700");
        list.add(map);
        map = new HashMap<String, Object>();
        map.put("RNUM", 3);
        map.put("MEM_MST_NM", "쫘파");
        map.put("MEM_MST_USE_YN", "Y");
        map.put("MEM_MST_REG_DT", "20170705122000");
        list.add(map);
        
        int totalCount = list.size();
        mv.addObject("paging", new Paging(totalCount, commandMap));
        mv.addObject("totalCount", totalCount);
        mv.addObject("list", list);
        mv.addObject("commandMap", commandMap);
        return mv;
    }

    /**
     * Layout Sample Form
     */
    @RequestMapping("/layout/sampleForm")
    public ModelAndView sampleForm (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }

    /**
     * Layout Sample View
     */
    @RequestMapping("/layout/sampleView")
    public ModelAndView sampleView (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }

    /**
     * Layout Sample Edit
     */
    @RequestMapping("/layout/sampleEdit")
    public ModelAndView sampleEdit (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }
    
    
    /**
     * Layout Sample Excel Download
     */
    @RequestMapping("/layout/sampleExcelDownload")
    public void sampleExcelDownload (HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception {
        
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("RNUM", 1);
        map.put("MEM_MST_NM", "칭웨이");
        map.put("MEM_MST_USE_YN", "Y");
        map.put("MEM_MST_REG_DT", "20170704122000");
        list.add(map);
        map = new HashMap<String, Object>();
        map.put("RNUM", 2);
        map.put("MEM_MST_NM", "탕웨이");
        map.put("MEM_MST_USE_YN", "N");
        map.put("MEM_MST_REG_DT", "20170520132700");
        list.add(map);
        map = new HashMap<String, Object>();
        map.put("RNUM", 3);
        map.put("MEM_MST_NM", "쫘파");
        map.put("MEM_MST_USE_YN", "Y");
        map.put("MEM_MST_REG_DT", "20170705122000");
        list.add(map);
        
        String [] rowTitle = {"순번", "이름", "사용여부", "등록일"};
        String [] cellSize = {"50", "60", "30", "80"};
        String [] dataName = {"RNUM", "MEM_MST_NM", "MEM_MST_USE_YN", "MEM_MST_REG_DT"};
        String [] dataType = {"String", "String", "String", "String"};
        ExcelUtil.excelDownload(response, rowTitle, cellSize, list, dataName, dataType, "sampleExcelList_" + DateUtil.getToday());
    }

    /**
     * servletTest
     */
    @RequestMapping("/servlet/servletTest")
    public ModelAndView servletTest (HttpServletRequest request, @RequestParams Map<String, Object> commandMap) throws Exception{
        ModelAndView mv = new ModelAndView();

        return mv;
    }
    
    @RequestMapping("/excel/test")
    public void test (HttpServletRequest request, HttpServletResponse response, @RequestParams Map<String, Object> commandMap) throws Exception {
        Map<String, Object> dataMap = new HashMap<String, Object>();
        
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> listData1 = new HashMap<String, Object>();
        listData1.put("NUM", 1);
        Map<String, Object> listData2 = new HashMap<String, Object>();
        listData2.put("NUM", 2);
        list.add(listData1);
        list.add(listData2);
        
        Map<String, Object> info = new HashMap<String, Object>();
        info.put("PRD_MST_PRICE", 10000);
        
        dataMap.put("PRD_MST_NM", "상품명");
        dataMap.put("info", info);
        dataMap.put("list", list);
        
        this.excelUtil.excelDownloadForJXTL(request, response, "template", dataMap);
    }
}