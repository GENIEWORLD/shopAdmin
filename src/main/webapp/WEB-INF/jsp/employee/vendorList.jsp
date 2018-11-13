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
                <h2><spring:message code="employee.vendor.title" /></h2>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-10">
            <ul class="nav nav-tabs">
                <li><a href="<c:out value="${serverSslDomain}"/>/employee/managerList.do"><spring:message code="employee.manager.title" /></a></li>
                <li class="active"><a href="javascript:;"><spring:message code="employee.vendor.title" /></a></li>
            </ul>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-10"><div class="page-header"><h3><spring:message code="common.btn.search" /></h3></div></div>
        <div class="col-lg-10">
            <div class="well">
                <form name="searchForm" id="searchForm" class="form-horizontal">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label for="select" class="col-lg-2 control-label"><spring:message code="common.title.vendor.name"/></label>
                            <div class="col-lg-8">
                                <input type="text" name="searchComInfNm" id="searchComInfNm" class="form-control" value="<c:out value="${commandMap.searchComInfNm }"/>" maxlength="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.use.type"/></label>
                            <div class="col-lg-8">
                                <div class="radio">
                                    <label><input type="radio" name="searchComInfYn" id="searchComInfYn0" value="" <c:if test="${empty commandMap.searchComInfYn }">checked="checked"</c:if>><spring:message code="common.title.all"/></label>
                                    <label><input type="radio" name="searchComInfYn" id="searchComInfYn1" value="Y" <c:if test="${commandMap.searchComInfYn eq 'Y'}">checked="checked"</c:if>><spring:message code="common.title.use"/></label>
                                    <label><input type="radio" name="searchComInfYn" id="searchComInfYn2" value="N" <c:if test="${commandMap.searchComInfYn eq 'N'}">checked="checked"</c:if>><spring:message code="common.title.nonuse"/></label>
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
        <div class="col-lg-10"><div class="page-header"><h3><spring:message code="common.btn.list" /></h3></div></div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.num"/></th>
                        <th class="text-center"><spring:message code="common.title.vendor.name"/></th>
                        <th class="text-center"><spring:message code="common.title.commission"/></th>
                        <th class="text-center"><spring:message code="common.title.use.type"/></th>
                        <th class="text-center"><spring:message code="common.title.reg.id"/></th>
                        <th class="text-center"><spring:message code="common.title.reg.date"/></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty list }">
                    <c:forEach var="row" items="${list }" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${paging.listNum-i.index }"/></td>
                        <td class="text-center"><a href="javascript:goEdit('<c:out value="${row.COM_INF_IDX }"/>');"><c:out value="${row.COM_INF_NM }"/></a></td>
                        <td class="text-center"><c:out value="${row.COM_INF_CMS }"/></td>
                        <td class="text-center"><spring:message code="${row.COM_INF_YN eq 'Y' ? 'common.title.use' : 'common.title.nonuse' }"/></td>
                        <td class="text-center"><c:out value="${row.COM_INF_REG_ID }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.COM_INF_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty list }">
                    <tr><td colspan="6" class="text-center"><spring:message code="common.list.empty" /></td></tr>
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
        <div class="form-group text-right">
            <div class="col-lg-8 col-lg-offset-2">
                <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
    </div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="COM_INF_IDX" value="" />
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
<input type="hidden" name="searchComInfNm" value="<c:out value="${commandMap.searchComInfNm }"/>" />
<input type="hidden" name="searchComInfYn" value="<c:out value="${commandMap.searchComInfYn }"/>" />
</form>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

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
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 등록페이지 이동
    goForm = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorForm.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 수정페이지 이동
    goEdit = function (COM_INF_IDX) {
    	$dataForm.find("input[name='COM_INF_IDX']").val(COM_INF_IDX);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorEdit.do", "method":"post", "target":"_self"}).submit();
    };
	
});
</script>
<%-- // script 종료 --%>
</body>
</html>