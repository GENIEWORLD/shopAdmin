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
        <div class="col-lg-6">
            <div class="page-header">
                <h1 id="typography">고객관리 목록</h1>
            </div>
        </div>
        <div class="col-lg-6">
            <ul class="breadcrumb right">
                <li><a href="<c:out value="${serverDomain}"/>">Home</a></li>
                <li>고객관리</li>
                <li class="active">목록</li>
            </ul>
        </div>
    </div>

    <div class="row">
        <div class="page-header"><h2>Search</h2></div>
        <div class="col-lg-12">
            <div class="well">
                <form name="searchForm" id="searchForm" class="form-horizontal">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label for="select" class="col-lg-2 control-label">검색어</label>
                            <div class="col-lg-2">
                                <select class="form-control" name="searchType" id="searchType">
                                    <option value="" <c:if test="${empty commandMap.searchUseYn }">selected="selected"</c:if>>선택</option>
                                    <option value="name" <c:if test="${commandMap.searchUseYn eq 'name'}">selected="selected"</c:if>>이름</option>
                                    <option value="id" <c:if test="${commandMap.searchUseYn eq 'id'}">selected="selected"</c:if>>아이디</option>
                                </select>
                            </div>
                            <div class="col-lg-8">
                                <input type="text" name="searchWoard" id="searchWoard" class="form-control" value="<c:out value="${commandMap.searchWoard }"/>" maxlength="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">사용여부</label>
                            <div class="col-lg-10">
                                <div class="radio">
                                    <label><input type="radio" name="searchUseYn" id="searchUseYn0" value="" <c:if test="${empty commandMap.searchUseYn }">checked="checked"</c:if>>전체</label>
                                    <label><input type="radio" name="searchUseYn" id="searchUseYn1" value="Y" <c:if test="${commandMap.searchUseYn eq 'Y'}">checked="checked"</c:if>>사용</label>
                                    <label><input type="radio" name="searchUseYn" id="searchUseYn2" value="N" <c:if test="${commandMap.searchUseYn eq 'N'}">checked="checked"</c:if>>미사용</label>
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
        <div class="page-header"><h2>List</h2></div>
        <div class="form-group text-right">
            <div class="col-lg-10 col-lg-offset-2">
                <a class="btn btn-default" href="javascript:goExcelDownload();"><spring:message code="common.btn.exceldown" /></a>
                <a class="btn btn-primary" href="javascript:goRegist();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
        <div class="col-lg-12">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th>순번</th>
                        <th>이름</th>
                        <th>사용여부</th>
                        <th>등록일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty list }">
                    <c:forEach var="row" items="${list }" varStatus="i">
                    <tr>
                        <td><c:out value="${paging.listNum-i.index }"/></td>
                        <td><c:out value="${row.MEM_MST_NM }"/></td>
                        <td><c:out value="${row.MEM_MST_USE_YN }"/></td>
                        <td><ui:formatDate value="${row.MEM_MST_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty list }">
                    <tr><td colspan="4" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-12 text-center">
            <ul class="pagination">
                <ui:paging paging="${paging }" jsFunction="goPage"/>
            </ul>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>


<form name="dataForm" id="dataForm">
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
<input type="hidden" name="searchType" value="<c:out value="${commandMap.searchType }"/>" />
<input type="hidden" name="searchWoard" value="<c:out value="${commandMap.searchWoard }"/>" />
<input type="hidden" name="searchUseYn" value="<c:out value="${commandMap.searchUseYn }"/>" />
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
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/layout/sampleList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 페이지 이동
    goPage = function (cPage) {
    	$dataForm.find("input[name='cPage']").val(cPage);
    	$dataForm.attr({"action":"<c:out value="${serverDomain}"/>/layout/sampleList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 등록페이지 이동
    goRegist = function () {
    	$dataForm.attr({"action":"<c:out value="${serverDomain}"/>/layout/sampleList.do", "method":"post", "target":"_self"}).submit();
    };
    // 엑셀다운로드
    goExcelDownload = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/layout/sampleExcelDownload.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>