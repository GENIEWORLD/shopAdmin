package com.common.tags;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.common.util.StringUtil;

public class DateTag extends TagSupport {

    private static final long serialVersionUID = 8093966354398588343L;
    private String value;
    private String pattern;
    private String minView;

    public String getValue() {
        return value;
    }
    public void setValue(String value) {
        this.value = value;
    }
    public String getPattern() {
        return pattern;
    }
    public void setPattern(String pattern) {
        this.pattern = pattern;
    }
    public String getMinView() {
        return minView;
    }
    public void setMinView(String minView) {
        this.minView = minView;
    }
    @SuppressWarnings("deprecation")
    public String resultView(String d, String p) throws JspException{

        if (d.length()== 14){

            Date td = new Date(StringUtil.getInt(d.substring(0, 4))-1900,
                    StringUtil.getInt(d.substring(4, 6))-1,
                    StringUtil.getInt(d.substring(6, 8)),
                    StringUtil.getInt(d.substring(8, 10)),
                    StringUtil.getInt(d.substring(10, 12)),
                    StringUtil.getInt(d.substring(12, 14))
                    );
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
            if (p != null && !"".equals(p)) {
                try {
                ((SimpleDateFormat) sdf).applyPattern(p);
                } catch (ClassCastException cce) {
                    sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.KOREA);
                }
            }

            return sdf.format(td);

        }else if(d.length()==8) {
            Date td = new Date(StringUtil.getInt(d.substring(0, 4))-1900,
                    StringUtil.getInt(d.substring(4, 6))-1,
                    StringUtil.getInt(d.substring(6, 8))
                    /*StringUtil.getInt(d.substring(8, 10)),
                    StringUtil.getInt(d.substring(10, 12)),
                    StringUtil.getInt(d.substring(12, 14))*/
                    );
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA);
            if (p != null && !"".equals(p)) {
                try {
                ((SimpleDateFormat) sdf).applyPattern(p);
                } catch (ClassCastException cce) {
                    sdf = new SimpleDateFormat("yyyy-MM-dd",Locale.KOREA);
                }
            }
            return sdf.format(td);

        } else {
            return "";
        }
    }
    public int doEndTag() throws JspException {
        // TODO Auto-generated method stub
        try{
            JspWriter out = pageContext.getOut();
            String contents = resultView(value, pattern);
            out.println(contents);

            return EVAL_PAGE;
        }catch(IOException e){
            throw new JspException();
        }
    }
}
