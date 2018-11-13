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
                <h2><spring:message code="customer.prs.customer.title" /></h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <ul class="nav nav-tabs">
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/prsCustomerList.do"><spring:message code="common.btn.list" /></a></li>
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/prsCustomerCalendar.do"><spring:message code="common.btn.calendar" /></a></li>
                <li class="active"><a href="javascript:;"><spring:message code="common.btn.probability" /></a></li>
            </ul>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.byvendor" /><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                        <div class="col-lg-8 input-group">
                            <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                            <input type="text" name="searchVendorStartDate" id="searchVendorStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchVendorStartDate}"/>"  readonly="readonly"/>
                            <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                            <input type="text" name="searchVendorEndDate" id="searchVendorEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchVendorEndDate}"/>" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a class="btn btn-success" href="javascript:goSearch('Vendor');"><spring:message code="common.btn.search" /></a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.byvendor" /><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center"><spring:message code="common.title.member.count" /></th>
                        <th class="text-center"><spring:message code="common.title.buy.probability" />0%</th>
                        <th class="text-center"><spring:message code="common.title.buy.probability" />50%</th>
                        <th class="text-center"><spring:message code="common.title.buy" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${vendorList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}"/></td>
                        <td class="text-center"><c:out value="${row.MEM_CNT}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_R}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_Y}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_G}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty vendorList}">
                    <tr><td colspan="5" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${!empty vendorList}">
    <div class="row">
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-default" href="javascript:goExcelDown('Vendor');"><spring:message code="common.btn.exceldown" /></a>
            </div>
        </div>
    </div>
    </c:if>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.byemployee" /><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                        <div class="col-lg-8 input-group">
                            <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                            <input type="text" name="searchEmployeeStartDate" id="searchEmployeeStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchEmployeeStartDate}"/>"  readonly="readonly"/>
                            <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                            <input type="text" name="searchEmployeeEndDate" id="searchEmployeeEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchEmployeeEndDate}"/>" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a class="btn btn-success" href="javascript:goSearch('Employee');"><spring:message code="common.btn.search" /></a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.byemployee" /><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.member.count" /></th>
                        <th class="text-center"><spring:message code="common.title.buy.probability" />0%</th>
                        <th class="text-center"><spring:message code="common.title.buy.probability" />50%</th>
                        <th class="text-center"><spring:message code="common.title.buy" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${employeeList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM}"/></td>
                        <td class="text-center"><c:out value="${row.MEM_CNT}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_R}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_Y}"/></td>
                        <td class="text-center"><c:out value="${row.RAT_G}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty employeeList}">
                    <tr><td colspan="5" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${!empty employeeList}">
    <div class="row">
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-default" href="javascript:goExcelDown('Employee');"><spring:message code="common.btn.exceldown" /></a>
            </div>
        </div>
    </div>
    </c:if>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="searchForm" id="searchForm">
<input type="hidden" name="excelKind" value="" />
<input type="hidden" name="searchVendorStartDate" value="<c:out value="${commandMap.searchVendorStartDate}"/>" />
<input type="hidden" name="searchVendorEndDate" value="<c:out value="${commandMap.searchVendorEndDate}"/>" />
<input type="hidden" name="searchEmployeeStartDate" value="<c:out value="${commandMap.searchEmployeeStartDate}"/>" />
<input type="hidden" name="searchEmployeeEndDate" value="<c:out value="${commandMap.searchEmployeeEndDate}"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm");

    // 검색
    goSearch = function (type) {
        var startDate = $("#search"+type+"StartDate").val();
        var endDate = $("#search"+type+"EndDate").val();
        
        if(startDate == ""){
            alert("<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />");
            $("#search"+type+"StartDate").focus();
            return;
        }
        if(endDate == ""){
            alert("<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />");
            $("#search"+type+"EndDate").focus();
            return;
        }
        
        $("#searchForm").find("input[name=search"+type+"StartDate]").val($("#search"+type+"StartDate").val());
        $("#searchForm").find("input[name=search"+type+"EndDate]").val($("#search"+type+"EndDate").val());
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/customerProbability.do", "method":"post", "target":"_self"}).submit();
    };

    // 엑셀다운
    goExcelDown = function(type){
    	$searchForm.find("input[name='excelKind']").val(type);
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/customerProbabilityExcelDown.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>