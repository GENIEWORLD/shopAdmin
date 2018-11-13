package com.common.paging;

import java.text.MessageFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Class Name : PagingRenderer
 * 기본적인 페이징 기능이 구현되어 있으며, 화면에서 아래와 같이 display 된다.
 *
 * [<<][<] 1 2 3 4 5 6 7 8 [>][>>]
 *
 * firstPageLabel = [<<]
 * previousPageLabel = [<]
 * currentPageLabel = 현재 페이지 번호
 * otherPageLabel = 현재 페이지를 제외한 페이지 번호
 * nextPageLabel = [>]
 * lastPageLabel = [>>]
 *
 */
public class PagingRenderer {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
    public String firstPageLabel;
    public String previousPageLabel;
    public String currentPageLabel;
    public String otherPageLabel;
    public String nextPageLabel;
    public String lastPageLabel;
    public String firstPageLabelDisable;
    public String previousPageLabelDisable;
    public String nextPageLabelDisable;
    public String lastPageLabelDisable;

    public PagingRenderer(){
        firstPageLabel = "<li><a href=\"javascript:;\" onclick=\"{0}({1}); return false;\">&laquo;</a></li>";
        previousPageLabel = "<li><a href=\"javascript:;\" onclick=\"{0}({1}); return false;\">&lsaquo;</a></li>";
        currentPageLabel = "<li class=\"active\"><a href=\"javascript:;\">{0}</a></li>";
        otherPageLabel = "<li><a href=\"javascript:;\" onclick=\"{0}({1}); return false;\">{1}</a></li>";
        nextPageLabel = "<li><a href=\"javascript:;\" onclick=\"{0}({1}); return false;\">&rsaquo;</a></li>";
        lastPageLabel = "<li><a href=\"javascript:;\" onclick=\"{0}({1}); return false;\">&raquo;</a></li>";
        firstPageLabelDisable = "<li class=\"disabled\"><a href=\"javascript:;\">&laquo;</a></li>";
        previousPageLabelDisable = "<li class=\"disabled\"><a href=\"javascript:;\">&lsaquo;</a></li>";
        nextPageLabelDisable = "<li class=\"disabled\"><a href=\"javascript:;\">&rsaquo;</a></li>";
        lastPageLabelDisable = "<li class=\"disabled\"><a href=\"javascript:;\">&raquo;</a></li>";
    }

    public String renderPagination(Paging paging, String jsFunction){
        StringBuffer strBuff = new StringBuffer();
        if (paging != null){
        	int firstPageNo = paging.getFirstPageNo();
            int firstPageNoOnPageList = paging.getFirstPageNoOnPageList();
            int totalPageCount = paging.getTotalPageCount();
            int lastPageNoOnPageList = paging.getLastPageNoOnPageList();
            int cPage = paging.getcPage();
            int lastPageNo = paging.getLastPageNo();
            int pageSize = paging.getPageSize();
            int pagingSize = paging.getPagingSize();
            
            if(totalPageCount > pagingSize){
                if(firstPageNoOnPageList > pagingSize){
                    strBuff.append(MessageFormat.format(firstPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNo)}));
                    strBuff.append(MessageFormat.format(previousPageLabel,new Object[]{jsFunction,Integer.toString(firstPageNoOnPageList-1)}));
                } else {
                    strBuff.append(firstPageLabelDisable);
                    strBuff.append(previousPageLabelDisable);
                }
            } else {
                strBuff.append(firstPageLabelDisable);
                strBuff.append(previousPageLabelDisable);
            }
 
            if (lastPageNoOnPageList > totalPageCount){
                lastPageNoOnPageList = totalPageCount;
            }

            for(int i=firstPageNoOnPageList;i<=lastPageNoOnPageList;i++){
                if(i==cPage){
                    strBuff.append(MessageFormat.format(currentPageLabel,new Object[]{Integer.toString(i)}));
                }else{
                    strBuff.append(MessageFormat.format(otherPageLabel,new Object[]{jsFunction,Integer.toString(i),Integer.toString(i)}));
                }
            }

            if(totalPageCount > pagingSize){
                if(lastPageNoOnPageList < totalPageCount){
                    strBuff.append(MessageFormat.format(nextPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNoOnPageList+1)}));
                    strBuff.append(MessageFormat.format(lastPageLabel,new Object[]{jsFunction,Integer.toString(lastPageNo)}));
                }else {
                    strBuff.append(nextPageLabelDisable);
                    strBuff.append(lastPageLabelDisable);
                }
            } else {
                strBuff.append(nextPageLabelDisable);
                strBuff.append(lastPageLabelDisable);
            }
        }
        return strBuff.toString();
    }
}
