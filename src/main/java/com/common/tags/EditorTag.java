package com.common.tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class EditorTag extends TagSupport{

    private static final long serialVersionUID = 9129002983166671196L;
    private String objId = "";
    private String jsLoadYn = "Y";
    private String height = "500";
    private String btn1 = "";
    private String btn2 = "";
    private String num = "";

    public String getObjId() {
        return objId;
    }

    public void setObjId(String objId) {
        this.objId = objId;
    }

    public String getJsLoadYn() {
        return jsLoadYn;
    }

    public void setJsLoadYn(String jsLoadYn) {
        this.jsLoadYn = jsLoadYn;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getBtn1() {
        return btn1;
    }

    public void setBtn1(String btn1) {
        this.btn1 = btn1;
    }

    public String getBtn2() {
        return btn2;
    }

    public void setBtn2(String btn2) {
        this.btn2 = btn2;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }
    
	public String resultView(String objId, String jsLoadYn, String height, String btn1, String btn2, String num) throws JspException{
        StringBuffer sb = new StringBuffer();

        if ("".equals(btn1)){
            btn1 = "fontselect,fontsizeselect,|,forecolor,backcolor,|,bold,italic,underline,sub,sup,|,justifyleft,justifycenter,justifyright,justifyfull,|,undo,redo";
        }
        if ("".equals(btn2)){
            btn2 = "tablecontrols,|,print,|,image,|,code,preview";
        }
        if ("NotAll".equals(btn1)){
            btn1 = "";
        }
        if ("NotAll".equals(btn2)){
            btn2 = "";
        }

        if ("Y".equals(jsLoadYn)){
        sb.append("<script type=\"text/javascript\" src=\"/smartEditor/js/HuskyEZCreator.js\" charset=\"utf-8\"></script>");
        }

        sb.append("<script type=\"text/javascript\">");
        sb.append("var oEditors"+num+" = [];\n");
        //sb.append("$(document).ready(function () {\n");

        sb.append("nhn.husky.EZCreator.createInIFrame({\n");
        sb.append("oAppRef: oEditors"+num+",\n");
        sb.append("elPlaceHolder: \""+objId.replace("#", "")+"\",\n");
        sb.append("sSkinURI: \"/smartEditor/SmartEditor2Skin.html\",\n");
        sb.append("htParams : {\n");
        sb.append("bUseToolbar : true,\n");
        sb.append("bUseVerticalResizer : true,\n");
        sb.append("bUseModeChanger : true,\n");
        sb.append("//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록\n");
        sb.append("fOnBeforeUnload : function(){\n");
        sb.append("}\n");
        sb.append("}, //boolean\n");
        sb.append("fOnAppLoad : function(){\n");
        sb.append("},\n");
        sb.append("fCreator: \"createSEditor2\"\n");
        sb.append("});\n");

        //sb.append("});\n");
        sb.append("</script>");
        return sb.toString();
    }

    @Override
    public int doEndTag() throws JspException {
        try{
            JspWriter out = pageContext.getOut();
            String contents = resultView(objId, jsLoadYn, height, btn1, btn2, num);
            out.println(contents);

            return EVAL_PAGE;
        }catch(IOException e){
            throw new JspException();
        }
    }
}
