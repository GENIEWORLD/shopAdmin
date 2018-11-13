package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class ReplaceLineBreakTag extends TagSupport {
	
	static final long serialVersionUID = -5351060064721192312L;
	private String content = "";	

    public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String resultView(String content) throws JspException{
    	
    	String returnVal = "";
        if (content != null) 
        {
                returnVal = content.replace("\r\n","<br/>");
                returnVal = returnVal.replace("\n","<br/>");
        }
        return returnVal;
    }
    
    @Override
    public int doEndTag() throws JspException {
        // TODO Auto-generated method stub
        try{
            JspWriter out = pageContext.getOut();
            String contents = resultView(content);
            out.println(contents);

            return EVAL_PAGE;
        }catch(IOException e){
            throw new JspException();
        }
    }	
}
