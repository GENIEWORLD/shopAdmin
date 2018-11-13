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

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <form name="searchForm" id="searchForm" class="form-horizontal">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                            <div class="col-lg-8 input-group">
                                <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                                <input type="text" name="searchStartDate" id="searchStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchStartDate }"/>"  readonly="readonly"/>
                                <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                                <input type="text" name="searchEndDate" id="searchEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchEndDate }"/>" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchBrdNtsTitle" class="col-lg-2 control-label"><spring:message code="common.title.title" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchBrdNtsTitle" id="searchBrdNtsTitle" class="form-control" value="<c:out value="${commandMap.searchBrdNtsTitle }"/>" />
                            </div>
                        </div>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN }">
                        <div class="form-group">
                            <label for="searchStrMstIdx" class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchStrMstIdx" id="searchStrMstIdx">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <option value="0" <c:if test="${commandMap.searchStrMstIdx eq '0' }">selected="selected"</c:if>><spring:message code="common.title.shop.all.name" /></option>
                                    <c:forEach var="row" items="${storeList}" varStatus="i">
                                    <option value="<c:out value="${row.STR_MST_IDX}" />" <c:if test="${row.STR_MST_IDX eq commandMap.searchStrMstIdx}"> selected="selected"</c:if>><c:out value="${row.STR_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div> 
                        </c:if>
                        <div class="form-group">
                            <label for="searchNtsUseYn0" class="col-lg-2 control-label"><spring:message code="common.title.use.type" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="searchNtsUseYn" id="searchNtsUseYn0" value="" <c:if test="${empty commandMap.searchNtsUseYn }">checked="checked"</c:if>><spring:message code="common.title.all" /></label>
                                    <label><input type="radio" name="searchNtsUseYn" id="searchNtsUseYn1" value="Y" <c:if test="${commandMap.searchNtsUseYn eq 'Y'}">checked="checked"</c:if>><spring:message code="common.title.use" /></label>
                                    <label><input type="radio" name="searchNtsUseYn" id="searchNtsUseYn2" value="N" <c:if test="${commandMap.searchNtsUseYn eq 'N'}">checked="checked"</c:if>><spring:message code="common.title.nonuse" /></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchNtsTopYn0" class="col-lg-2 control-label"><spring:message code="common.title.notice.top.type" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="searchNtsTopYn" id="searchNtsTopYn0" value="" <c:if test="${empty commandMap.searchNtsTopYn }">checked="checked"</c:if>><spring:message code="common.title.all" /></label>
                                    <label><input type="radio" name="searchNtsTopYn" id="searchNtsTopYn1" value="Y" <c:if test="${commandMap.searchNtsTopYn eq 'Y'}">checked="checked"</c:if>><spring:message code="common.title.use" /></label>
                                    <label><input type="radio" name="searchNtsTopYn" id="searchNtsTopYn2" value="N" <c:if test="${commandMap.searchNtsTopYn eq 'N'}">checked="checked"</c:if>><spring:message code="common.title.nonuse" /></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a class="btn btn-success" href="javascript:goSearch();"><spring:message code="common.btn.search" /></a>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center">NO</th>
                        <th class="text-center"><spring:message code="common.title.title" /></th>
                        <th class="text-center"><spring:message code="common.title.shop" /></th>
                        <th class="text-center"><spring:message code="common.title.notice.top.type" /></th>
                        <th class="text-center"><spring:message code="common.title.use.type" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.id" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.date" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty list }">
                    <c:forEach var="row" items="${list }" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${paging.listNum-i.index }"/></td>
                        <c:choose>
                            <c:when test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                                <td class="text-center"><a href="javascript:goEdit('<c:out value="${row.BRD_NTS_IDX }" />');"><c:out value="${row.BRD_NTS_TITLE }"/></a></td>
                            </c:when>
                            <c:otherwise>
                                <td class="text-center"><a href="javascript:goView('<c:out value="${row.BRD_NTS_IDX }" />');"><c:out value="${row.BRD_NTS_TITLE }"/></a></td>
                            </c:otherwise>
                        </c:choose>
                        <td class="text-center">
                            <c:if test="${row.STR_MST_IDX ne '0' }"><c:out value="${row.STR_MST_NM  }" /></c:if>
                            <c:if test="${row.STR_MST_IDX eq '0' }"><spring:message code="common.title.shop.all.name" /></c:if>
                        </td>
                        <td class="text-center"><spring:message code="${row.BRD_NTS_TOP_YN eq 'Y' ? 'common.title.use' : 'common.title.nonuse' }" /></td>
                        <td class="text-center"><spring:message code="${row.BRD_NTS_USE_YN eq 'Y' ? 'common.title.use' : 'common.title.nonuse' }" /></td>
                        <td class="text-center"><c:out value="${row.BRD_NTS_REG_ID }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.BRD_NTS_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty list }">
                    <tr><td colspan="7" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-10 text-center">
            <ul class="pagination">
                <ui:paging paging="${paging }" jsFunction="goPage"/>
            </ul>
        </div>
        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
        <div class="form-group text-right">
            <div class="col-lg-8 col-lg-offset-2">
                <a class="btn btn-primary" href="javascript:goRegist();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
        </c:if>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>


<form name="dataForm" id="dataForm">
<input type="hidden" name="BRD_NTS_IDX" value="" />
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
<input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
<input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
<input type="hidden" name="searchBrdNtsTitle" value="<c:out value="${commandMap.searchBrdNtsTitle }"/>" />
<input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
<input type="hidden" name="searchNtsUseYn" value="<c:out value="${commandMap.searchNtsUseYn }"/>" />
<input type="hidden" name="searchNtsTopYn" value="<c:out value="${commandMap.searchNtsTopYn }"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm")
        , $dataForm = $("#dataForm");
    // 검색 엔터 이벤트 
    $searchForm.find("input").not(".datepicker").keydown(function (e) {
        if(e.keyCode == 13) {
            goSearch();
        }
    });

    // 검색
    goSearch = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeList.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeList.do", "method":"post", "target":"_self"}).submit();
    };

    // 등록페이지 이동
    goRegist = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeForm.do", "method":"post", "target":"_self"}).submit();
    };

    <c:choose>
        <c:when test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
            // 수정페이지 이동
            goEdit = function (BRD_NTS_IDX) {
                $dataForm.find("input[name='BRD_NTS_IDX']").val(BRD_NTS_IDX);
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeEdit.do", "method":"post", "target":"_self"}).submit();
            };
        </c:when>
        <c:otherwise>
            // 상세페이지 이동
            goView = function (BRD_NTS_IDX) {
                $dataForm.find("input[name='BRD_NTS_IDX']").val(BRD_NTS_IDX);
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeView.do", "method":"post", "target":"_self"}).submit();
            };
        </c:otherwise>
    </c:choose>
});
</script>
<%-- // script 종료 --%>
</body>
</html>