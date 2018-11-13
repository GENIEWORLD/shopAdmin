<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
</head>
<body>

<div class="container">
<%-- contents 시작 --%>
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <form name="searchForm" id="searchForm">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.search.woard" /></label>
                            <div class="col-lg-2">
                                <select class="form-control" name="searchType" id="searchType">
                                    <option value="" <c:if test="${empty commandMap.searchType}">selected="selected"</c:if>><spring:message code="common.title.check" /></option>
                                    <option value="name" <c:if test="${commandMap.searchType eq 'name'}">selected="selected"</c:if>><spring:message code="common.title.member.name" /></option>
                                    <option value="no" <c:if test="${commandMap.searchType eq 'no'}">selected="selected"</c:if>><spring:message code="common.title.member.no" /></option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-4">
                                <input type="text" name="searchWoard" id="searchWoard" class="form-control" value="<c:out value="${commandMap.searchWoard}"/>" maxlength="20" />
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
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.member.no" /></th>
                        <th class="text-center"><spring:message code="common.title.member.name" /></th>
                        <th class="text-center"><spring:message code="common.title.hp" /></th>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.wedding.date" /></th>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${list}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.MEM_MST_CD}"/></td>
                        <td class="text-center">
                            <a href="javascript:setMemberData('<c:out value="${row.MEM_MST_IDX}"/>','<c:out value="${row.MEM_MST_CD}"/>',  '<c:out value="${row.MEM_MST_NM}"/>','<c:out value="${row.MEM_MST_TEL}"/>' , '<c:out value="${row.MEM_MST_WED}"/>', '<c:out value="${row.ADM_MST_ID}"/>', '<c:out value="${row.COM_INF_IDX}"/>', '<c:out value="${row.MEM_MST_LVL}"/>');">
                                <c:out value="${row.MEM_MST_NM}"/>
                            </a>
                        </td>
                        <td class="text-center"><c:out value="${row.MEM_MST_TEL}"/></td>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM}"/></td>
                        <td class="text-center"><c:out value="${row.MEM_MST_WED}"/></td>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                    <tr><td colspan="6" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10 text-center">
            <ul class="pagination">
                <ui:paging paging="${paging}" jsFunction="goPage"/>
            </ul>
        </div>
    </div>

    <div class="row" id="orderListDiv" style="display:none;">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.order" /><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset>
                    <div class="form-group">
                        <label class="col-lg-2 control-label" id="memMstCd"></label>
                        <label class="col-lg-2 control-label" id="memMstNm"></label>
                    </div>
                </fieldset>
            </div>
        </div>
        <div class="col-lg-10" id="orderListHtmlDiv">
        </div>
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-default" href="javascript:closeOrderList();"><spring:message code="common.btn.close" /></a>
            </div>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage}"/>" />
<input type="hidden" name="searchType" value="<c:out value="${commandMap.searchType}"/>" />
<input type="hidden" name="searchWoard" value="<c:out value="${commandMap.searchWoard}"/>" />
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
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/order/memberSearch.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/order/memberSearch.do", "method":"post", "target":"_self"}).submit();
    };

    // 
    setMemberData = function (MEM_MST_IDX, MEM_MST_CD, MEM_MST_NM, MEM_MST_TEL, MEM_MST_WED, ADM_MST_ID, COM_INF_IDX, MEM_MST_LVL) {
        opener.setMemberInfo(MEM_MST_IDX, MEM_MST_CD, MEM_MST_NM, MEM_MST_TEL, MEM_MST_WED, ADM_MST_ID, COM_INF_IDX, MEM_MST_LVL);
        window.close();
    };    
    
    // 고객 주문 목록 보기
    $(".reqCustomerOrderList").on("click", function(e){
        e.preventDefault();

        opener.setMemberInfo(name);
        window.close();
    });

    // 고객 주문 목록 닫기
    closeOrderList = function(){
        $("#orderListDiv").hide();
        $("#orderListHtmlDiv").empty();
        $("#memMstCd").text("");
        $("#memMstNm").text("");
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>