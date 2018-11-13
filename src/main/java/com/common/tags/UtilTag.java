package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class UtilTag extends TagSupport{
	
	private static final long serialVersionUID = 1023086192404034683L;
	private String v;
	private String t;
	private String g;
	
	public String getV() {
		return v;
	}
	public void setV(String v) {
		this.v = v;
	}
	public String getT() {
		return t;
	}
	public void setT(String t) {
		this.t = t;
	}
	
	public String getG() {
		return g;
	}
	public void setG(String g) {
		this.g = g;
	}
	public String resultView(String v, String t, String g) throws JspException{
		if (v.equals(t)){
			return g;
		} else {
			return "";
		}
	}
	public int doEndTag() throws JspException {
		// TODO Auto-generated method stub
		try{
			JspWriter out = pageContext.getOut();
            String contents = resultView(v, t, g);
            out.println(contents);
			
			return EVAL_PAGE;
		}catch(IOException e){
			throw new JspException();
		}
	}
}
