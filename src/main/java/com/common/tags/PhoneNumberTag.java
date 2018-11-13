package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class PhoneNumberTag extends TagSupport{

	private static final long serialVersionUID = 9129002983166671196L;
	
    private String phonenumber = "";

    public String getPhonenumber(){
    	return phonenumber;
    }
    
    public void setPhonenumber(String phonenumber){
    	this.phonenumber = phonenumber;
    }

    public String resultView(String phonenumber) throws JspException{
    	
    	phonenumber = phonenumber.replaceAll("\\-", "");
    	
    	String fmtNumber = "";
    	
    	try{
    		
    		if(phonenumber!=null && !"".equals(phonenumber)){
    			
    			// 휴대전화
    			if(phonenumber.indexOf("01")==0){
    				if(phonenumber.length()==10){
    					fmtNumber = phonenumber.substring(0,3) + "-" + phonenumber.substring(3,6) + "-" + phonenumber.substring(6,10); 
    				}else if(phonenumber.length()==11){
    					fmtNumber = phonenumber.substring(0,3) + "-" + phonenumber.substring(3,7) + "-" + phonenumber.substring(7,11);
    				}
    			}
    			// 일반전화 - 서울
    			else if(phonenumber.indexOf("02")==0){
    				if(phonenumber.length()==9){
    					fmtNumber = phonenumber.substring(0,2) + "-" + phonenumber.substring(2,5) + "-" + phonenumber.substring(5,9); 
    				}else if(phonenumber.length()==10){
    					fmtNumber = phonenumber.substring(0,2) + "-" + phonenumber.substring(2,6) + "-" + phonenumber.substring(6,10); 
    				}
    			}
    			// 일반전화 - 기타
    			else{
    				if(phonenumber.length()==10){
    					fmtNumber = phonenumber.substring(0,3) + "-" + phonenumber.substring(3,6) + "-" + phonenumber.substring(6,10); 
    				}else if(phonenumber.length()==11){
    					fmtNumber = phonenumber.substring(0,3) + "-" + phonenumber.substring(3,7) + "-" + phonenumber.substring(7,11);
    				}else if(phonenumber.length()==8){
    					fmtNumber = phonenumber.substring(0,4) + "-" + phonenumber.substring(4,8);	// 국번없이 1588 이렇게 시작하는 전화번호
    				}
    			}
    			
    		}
    	}catch(Exception ex){
    		fmtNumber = phonenumber;
    		ex.printStackTrace();
    	}
    	
    	
    	return fmtNumber;
    }

    @Override
    public int doEndTag() throws JspException {
        // TODO Auto-generated method stub
        try{
            JspWriter out = pageContext.getOut();
            String contents = resultView(phonenumber);
            out.println(contents);

            return EVAL_PAGE;
        }catch(IOException e){
            throw new JspException();
        }
    }	
	
}
