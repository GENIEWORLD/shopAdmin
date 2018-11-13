package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class PageSizeTag extends TagSupport {

	private static final long serialVersionUID = 5762600886371119678L;
	private String value;
	private String name;
	private String type;
	private String jsFunction;
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getJsFunction() {
		return jsFunction;
	}
	public void setJsFunction(String jsFunction) {
		this.jsFunction = jsFunction;
	}
	@SuppressWarnings("deprecation")
	public String resultView(String v, String n, String t, String j) throws JspException{
		StringBuffer sb = new StringBuffer();
		String selectedText = "";
		String[] arrPageSize = null;
		if ("front".equals(t)){
			arrPageSize = this.getProductPageSize();
			sb.append("<select class=\"select\" id=\""+n+"\" name=\""+n+"\" onchange=\"javascript:"+j+"(1);\" title=\"상품 보기 개수\" >");
		} else {
			arrPageSize = this.getDefaultPageSize();
			sb.append("<select class=\"select\" id=\""+n+"\" name=\""+n+"\" onchange=\"javascript:"+j+"(1);\" title=\"상품 보기 개수\" >");
		}
		
		for(String item : arrPageSize){
			if (v.equals(item)){
				selectedText = "selected";
			} else {
				selectedText = "";
			}
			sb.append("<option value=\""+item+"\" "+selectedText+">"+item+"개씩 보기</option>");
		}
		sb.append("</select>");
		
		return sb.toString();
	}
	public int doEndTag() throws JspException {
		// TODO Auto-generated method stub
		try{
			JspWriter out = pageContext.getOut();
            String contents = resultView(value, name, type, jsFunction);
            out.println(contents);
			
			return EVAL_PAGE;
		}catch(IOException e){
			throw new JspException();
		}
	}
	
	// PageSize 
	public String [] getDefaultPageSize(){		
		return "20,40,60,80,100".split(",");
	}
	// Front PageSize
	public String[] getProductPageSize(){		
		return "12,24,36,48".split(",");
	}	
}
