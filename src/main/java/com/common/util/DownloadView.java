package com.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

public class DownloadView extends AbstractView{
    public DownloadView() {  
        setContentType("application/download; charset=utf-8");
    }
    @Override
    protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response) throws Exception {
 
        File file = (File)model.get("downloadFile");
        String orgFileName = StringUtil.getString(model.get("orgFileName"), "");
        response.setContentType(getContentType());
        response.setContentLength((int)file.length());
 
        String userAgent = request.getHeader("User-Agent");
 
        String fileName = null;
        
        if(!"".equals(orgFileName))
        {
            fileName = orgFileName;
        }
        else
        {
            fileName = file.getName();
        }
        
        //한글깨짐 처리
         if(userAgent.contains("MSIE") || userAgent.contains("Trident") || userAgent.contains("Chrome")){               
             fileName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
         } else {               
             fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
         }

        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
 
        OutputStream out = response.getOutputStream();
 
        FileInputStream fis = null;
 
        try {
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
        } finally {
            if(fis != null) {
                fis.close();
            }
        }
        out.flush();
    } 
}
