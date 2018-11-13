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
                <h2><spring:message code="manage.store.title" /></h2>
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
                            <label for="searchStrMstNm" class="col-lg-2 control-label"><spring:message code="common.title.store.name" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchStrMstNm" id="searchStrMstNm" class="form-control" value="<c:out value="${commandMap.searchStrMstNm }"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchStrMstGbn" class="col-lg-2 control-label"><spring:message code="common.title.store.grade" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchStrMstGbn" id="searchStrMstGbn">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <c:forEach var="row" items="${gradeList}" varStatus="i">
                                    <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq commandMap.searchStrMstGbn}"> selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div> 
                        <div class="form-group">
                            <label for="searchStrMstTel" class="col-lg-2 control-label"><spring:message code="common.title.hp" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchStrMstTel" id="searchStrMstTel" class="form-control" value="<c:out value="${commandMap.searchStrMstTel }"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchStrMstUseYn0" class="col-lg-2 control-label"><spring:message code="common.title.use.type" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="searchStrMstUseYn" id="searchStrMstUseYn0" value="" <c:if test="${empty commandMap.searchStrMstUseYn }">checked="checked"</c:if>><spring:message code="common.title.all" /></label>
                                    <label><input type="radio" name="searchStrMstUseYn" id="searchStrMstUseYn1" value="Y" <c:if test="${commandMap.searchStrMstUseYn eq 'Y'}">checked="checked"</c:if>><spring:message code="common.title.use" /></label>
                                    <label><input type="radio" name="searchStrMstUseYn" id="searchStrMstUseYn2" value="N" <c:if test="${commandMap.searchStrMstUseYn eq 'N'}">checked="checked"</c:if>><spring:message code="common.title.nonuse" /></label>
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
                        <th class="text-center"><spring:message code="common.title.store.name" /></th>
                        <th class="text-center"><spring:message code="common.title.store.grade" /></th>
                        <th class="text-center"><spring:message code="common.title.hp" /></th>
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
                        <td class="text-center"><a href="javascript:goEdit('<c:out value="${row.STR_MST_IDX }" />');"><c:out value="${row.STR_MST_NM }"/></a></td>
                        <td class="text-center"><c:out value="${row.STR_MST_GBN_NM }"/></td>
                        <td class="text-center"><c:out value="${row.STR_MST_TEL }"/></td>
                        <td class="text-center"><spring:message code="${row.STR_MST_USE_YN eq 'Y' ? 'common.title.use' : 'common.title.nonuse' }" /></td>
                        <td class="text-center"><c:out value="${row.STR_MST_REG_ID }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.STR_MST_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
<input type="hidden" name="STR_MST_IDX" value="" />
<input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
<input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
<input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
<input type="hidden" name="searchStrMstNm" value="<c:out value="${commandMap.searchStrMstNm }"/>" />
<input type="hidden" name="searchStrMstGbn" value="<c:out value="${commandMap.searchStrMstGbn }"/>" />
<input type="hidden" name="searchStrMstTel" value="<c:out value="${commandMap.searchStrMstTel }"/>" />
<input type="hidden" name="searchStrMstUseYn" value="<c:out value="${commandMap.searchStrMstUseYn }"/>" />
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
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeList.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeList.do", "method":"post", "target":"_self"}).submit();
    };

    // 등록페이지 이동
    goRegist = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeForm.do", "method":"post", "target":"_self"}).submit();
    };

    
    // 수정페이지 이동
    goEdit = function (STR_MST_IDX) {
        $dataForm.find("input[name='STR_MST_IDX']").val(STR_MST_IDX);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeEdit.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>