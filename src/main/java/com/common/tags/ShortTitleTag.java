package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.common.model.Code;

public class ShortTitleTag extends TagSupport{

	private static final long serialVersionUID = 6828720489628497555L;
	private String title = "";
	private int length = 20;

    /**
	 * @return the length
	 */
	public int getLength() {
		return length;
	}

	/**
	 * @param length the length to set
	 */
	public void setLength(int length) {
		this.length = length;
	}

	public String getTitle(){
    	return title;
    }
    
    public void setTitle(String title){
    	this.title = title;
    }

    public String resultView(String title) throws JspException{
    	
    	String returnVal = "";
        if (title != null) {
            if (title.length() > Code.product_title_length_max) {
                returnVal = title.substring(0, Code.product_title_length_max) + "...";
            } else
                returnVal = title;
        }
        return returnVal;
    }
    
    public String resultView(String title, int length) throws JspException{
    	
    	String returnVal = "";
        if (title != null) {
            if (title.length() > length ) {
                returnVal = title.substring(0, length) + "...";
            } else
                returnVal = title;
        }
        return returnVal;
    }

    @Override
    public int doEndTag() throws JspException {
        // TODO Auto-generated method stub
        try{
            JspWriter out = pageContext.getOut();
            String contents = resultView(title, length);
            out.println(contents);

            return EVAL_PAGE;
        }catch(IOException e){
            throw new JspException();
        }
    }	
	
}
