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
                <h2><spring:message code="sales.daily.report.title" /></h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.designer" /></label>
                        <div class="col-lg-8 input-group">
                            <select class="form-control" name="searchReportDesigner" id="searchReportDesigner">
                                <option value=""><spring:message code="common.title.all" /></option>
                                <c:forEach var="row" items="${designerList}" varStatus="i">
                                <option value="<c:out value="${row.ADM_MST_ID}" />" <c:if test="${row.ADM_MST_ID eq commandMap.searchReportDesigner}"> selected="selected"</c:if>><c:out value="${row.ADM_MST_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                        <div class="col-lg-8 input-group">
                            <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                            <input type="text" name="searchReportStartDate" id="searchReportStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchReportStartDate}"/>"  readonly="readonly"/>
                            <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                            <input type="text" name="searchReportEndDate" id="searchReportEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchReportEndDate}"/>" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a class="btn btn-success" href="javascript:goSearch('Report');"><spring:message code="common.btn.search" /></a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /></h3>
                <div class="form-group text-right">
                    <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.business" /></th>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.date" /></th>
                        <th class="text-center"><spring:message code="common.btn.delete" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${dailyReportList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM}" /></td>
                        <td class="text-center"><c:out value="${row.DAY_WRK_GBN_NM}" /></td>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}" /></td>
                        <td class="text-center"><ui:formatDate value="${row.COM_INF_REG_DT}" pattern="yyyy-MM-dd" /></td>
                        <td class="text-center"><a class="btn btn-danger" href="javascript:goDelete('<c:out value="${row.DAY_WRK_IDX}" />');"><spring:message code="common.btn.delete" /></a></td>
                    </tr>
                    <tr>
                        <td class="text-left" colspan="6">
                            <spring:message code="common.title.content" /> : <ui:replaceLineBreak content="${row.DAY_WRK_CTS}"/>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty dailyReportList}">
                    <tr><td colspan="6" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.total" /><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.designer" /></label>
                        <div class="col-lg-8 input-group">
                            <select class="form-control" name="searchReportSumDesigner" id="searchReportSumDesigner">
                                <option value=""><spring:message code="common.title.all" /></option>
                                <c:forEach var="row" items="${designerList}" varStatus="i">
                                <option value="<c:out value="${row.ADM_MST_ID}" />" <c:if test="${row.ADM_MST_ID eq commandMap.searchReportSumDesigner}"> selected="selected"</c:if>><c:out value="${row.ADM_MST_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                        <div class="col-lg-8 input-group">
                            <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                            <input type="text" name="searchReportSumStartDate" id="searchReportSumStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchReportSumStartDate}"/>"  readonly="readonly"/>
                            <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                            <input type="text" name="searchReportSumEndDate" id="searchReportSumEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchReportSumEndDate}"/>" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a class="btn btn-success" href="javascript:goSearch('ReportSum');"><spring:message code="common.btn.search" /></a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.total" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center"><spring:message code="common.title.advice.cnt" /></th>
                        <th class="text-center"><spring:message code="common.title.sales.cnt" /></th>
                        <th class="text-center"><spring:message code="common.btn.probability" /></th>
                    </tr>
                </thead>
                <tbody>
                    <%-- 
                    <c:set var="rowspanCnt" value="0" />
                    <c:forEach var="row" items="${dailyReportSumList}" varStatus="i">
                    <c:set var="rowspanCnt" value="${fn:length(row.dayWrkGbnList)}" />
                    <tr>
                        <td class="text-center" <c:if test="${rowspanCnt > 1}">rowspan="<c:out value="${rowspanCnt}" />"</c:if>><c:out value="${row.ADM_MST_NM }" /></td>
                        <c:forEach var="dayWrkGbn" items="${row.dayWrkGbnList}" varStatus="j">
                        <c:if test="${j.index > 0}"><tr></c:if>
                        <td class="text-center"><c:out value="${dayWrkGbn.COM_INF_NM}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${dayWrkGbn.DAY_WRK_GBN_ADV_CNT}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${dayWrkGbn.DAY_WRK_GBN_PRS_CNT}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${dayWrkGbn.DAY_WRK_GBN_TOTAL_CNT}" type="number"/></td>
                        <c:if test="${j.index > 0}"></tr></c:if>
                        </c:forEach>
                    </tr>
                    </c:forEach>
                    --%>
                    <c:forEach var="row" items="${dailyReportSumList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM }" /></td>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DAY_WRK_GBN_ADV_CNT}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DAY_WORK_GBN_SAL_CNT}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DAY_WRK_GBN_PROBABILITY}" type="number"/>%</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty dailyReportSumList}">
                    <tr><td colspan="5" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                    
                </tbody>
            </table>
        </div>
    </div>

    <c:if test="${!empty dailyReportSumList}">
    <div class="form-group text-right">
        <div class="col-lg-10">
            <a class="btn btn-default" href="javascript:goExcelDown();"><spring:message code="common.btn.exceldown" /></a>
        </div>
    </div>
    </c:if>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="searchForm" id="searchForm">
<input type="hidden" name="DAY_WRK_IDX" id="DAY_WRK_IDX" value="" />
<input type="hidden" name="searchReportDesigner" value="<c:out value="${commandMap.searchReportDesigner}"/>" />
<input type="hidden" name="searchReportStartDate" value="<c:out value="${commandMap.searchReportStartDate}"/>" />
<input type="hidden" name="searchReportEndDate" value="<c:out value="${commandMap.searchReportEndDate}"/>" />
<input type="hidden" name="searchReportSumDesigner" value="<c:out value="${commandMap.searchReportSumDesigner}"/>" />
<input type="hidden" name="searchReportSumStartDate" value="<c:out value="${commandMap.searchReportSumStartDate}"/>" />
<input type="hidden" name="searchReportSumEndDate" value="<c:out value="${commandMap.searchReportSumEndDate}"/>" />
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

        $("#searchForm").find("input[name=search"+type+"Designer]").val($("#search"+type+"Designer").val());
        $("#searchForm").find("input[name=search"+type+"StartDate]").val($("#search"+type+"StartDate").val());
        $("#searchForm").find("input[name=search"+type+"EndDate]").val($("#search"+type+"EndDate").val());
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/dailyReportList.do", "method":"post", "target":"_self"}).submit();
    };

    // 등록
    goForm = function(){
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/dailyReportForm.do", "method":"post", "target":"_self"}).submit();
    };

    // 삭제
    goDelete = function(dayWrkIdx){
        $("#DAY_WRK_IDX").val(dayWrkIdx);
        if(confirm("<spring:message code="common.alert.confirm.delete" />")){
            $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/dailyReportDelete.do", "method":"post", "target":"_self"}).submit();
        }
    };

    // 엑셀다운
    goExcelDown = function(type){
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/dailyReportSumListExcelDown.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>