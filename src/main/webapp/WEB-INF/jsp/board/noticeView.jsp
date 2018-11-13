<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
</head>
<body>
<%-- top 시작 --%>
<%@ include file="/WEB-INF/jsp/include/top.jsp" %>
<%-- // top 종료 --%>

<div class="container">
<%-- contents 시작 --%>
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h2><spring:message code="board.notice.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
    <input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
    <input type="hidden" name="searchBrdNtsTitle" value="<c:out value="${commandMap.searchBrdNtsTitle }"/>" />
    <input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
    <input type="hidden" name="searchNtsUseYn" value="<c:out value="${commandMap.searchNtsUseYn }"/>" />
    <input type="hidden" name="searchNtsTopYn" value="<c:out value="${commandMap.searchNtsTopYn }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-2 text-right"><spring:message code="common.title.title" /></label>
                        <div class="col-lg-8">
                            <label><c:out value="${info.BRD_NTS_TITLE }"/></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 text-right"><spring:message code="common.title.shop" /></label>
                        <div class="col-lg-8">
                            <label>
                                <c:if test="${info.STR_MST_IDX ne '0' }"><c:out value="${info.STR_MST_NM  }" /></c:if>
                                <c:if test="${info.STR_MST_IDX eq '0' }"><spring:message code="common.title.shop.all.name" /></c:if>
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 text-right"><spring:message code="common.title.reg.id" /></label>
                        <div class="col-lg-8">
                            <label><c:out value="${info.BRD_NTS_REG_ID }"/></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 text-right"><spring:message code="common.title.content" /></label>
                        <div class="col-lg-8">
                            <label><ui:replaceLineBreak content="${info.BRD_NTS_CONTENTS }"/></label>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a href="javascript:goList();" class="btn btn-primary">목록</a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>
    
<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm");
    
    // 공지사항 목록 이동
    goList = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeList.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>