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
                <h2><spring:message code="sales.ledger.title" /></h2>
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
                <form name="searchForm" id="searchForm">
                    <fieldset class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchYearMonth" id="searchYearMonth" class="form-control datepicker-year-month" value="<c:out value="${commandMap.searchYearMonth}"/>"  readonly="readonly"/>
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
                <div class="form-group text-right">
                    <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="alert alert-dismissible alert-success">
                <strong><spring:message code="common.title.that.month.sales" /> : <fmt:formatNumber value="${profitSum}" type="number"/></strong>
            </div>
        </div>
        <div class="col-lg-5">
            <div class="alert alert-dismissible alert-info">
                <c:set var="totalProfit" value="${profitSum}" />
                <c:forEach var="row" items="${ledgerSumList}" varStatus="i">
                    <c:set var="totalProfit" value="${totalProfit - row.ACT_BOK_PAY_SUM}" />
                </c:forEach>
                <strong><spring:message code="common.title.that.month.profit" /> : <fmt:formatNumber value="${totalProfit}" type="number"/></strong>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center">NO</th>
                        <th class="text-center"><spring:message code="common.title.type" /></th>
                        <th class="text-center"><spring:message code="common.title.content" /></th>
                        <th class="text-center"><spring:message code="common.title.price" /></th>
                        <th class="text-center">%</th>
                        <th class="text-center"><spring:message code="common.title.reg.date" /></th>
                        <th class="text-center"><spring:message code="common.btn.delete" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalEmployeeSalary" value="0" />
                    <c:forEach var="row" items="${ledgerList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${i.index + 1}" /></td>
                        <td class="text-center"><c:out value="${row.ACT_BOK_GBN_NM}" /></td>
                        <td class="text-center"><c:out value="${row.ACT_BOK_CTS}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ACT_BOK_PAY}" type="number" /></td>
                        <td class="text-center"><c:out value="${row.ACT_BOK_PAY_RAT}" /></td>
                        <td class="text-center"><ui:formatDate value="${row.ACT_BOK_DT}" pattern="yyyy-MM-dd" /></td>
                        <td class="text-center"><a class="btn btn-danger" href="javascript:goDelete('<c:out value="${row.ACT_BOK_IDX}" />');"><spring:message code="common.btn.delete" /></a></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty ledgerList }">
                    <tr><td colspan="7" class="text-center"><spring:message code="common.list.empty" /></td></tr>
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
                <h3><spring:message code="common.title.total" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.type" /></th>
                        <th class="text-center"><spring:message code="common.title.total" /></th>
                        <th class="text-center">%</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${totalEmployeeSalary > 0}">
                    <tr>
                        <c:forEach var="row" items="${ledgerGbnList}" varStatus="i">
                        <c:if test="${row.CMN_COM_IDX eq Code.LEDGERLIST_GBN_SLR}">
                            <td class="text-center"><c:out value="${row.CMN_COM_NM}" /></td>
                        </c:if>
                        </c:forEach>
                        <td class="text-center"><fmt:formatNumber value="${totalEmployeeSalary}" type="number" /></td>
                        <td class="text-center">
                            <fmt:formatNumber var="num1" value="${totalEmployeeSalary}" pattern="#.###"/>
                            <fmt:formatNumber var="num2" value="${profitSum}" pattern="#.###"/>
                            <fmt:formatNumber value="${num1/num2 * 100}" pattern="#.###"/> %
                        </td>
                    </tr>
                    </c:if>
                    <c:forEach var="row" items="${ledgerSumList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ACT_BOK_GBN_NM}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ACT_BOK_PAY_SUM}" type="number" /></td>
                        <td class="text-center"><c:out value="${row.ACT_BOK_PAY_SUM_RAT}" /></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty ledgerSumList}">
                    <tr><td colspan="3" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="ACT_BOK_IDX" id="ACT_BOK_IDX" value="" />
<input type="hidden" name="searchYearMonth" value="<c:out value="${commandMap.searchYearMonth}"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm")
    , $dataForm = $("#dataForm");

    // 검색
    goSearch = function(){
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/ledgerList.do", "method":"post", "target":"_self"}).submit();
    };

    // 등록
    goForm = function(){
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/ledgerForm.do", "method":"post", "target":"_self"}).submit();
    };

    // 삭제
    goDelete = function(actBokIdx){
        $("#ACT_BOK_IDX").val(actBokIdx);
        if(confirm("<spring:message code="common.alert.confirm.delete" />")){
            $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/ledgerDelete.do", "method":"post", "target":"_self"}).submit();
        }
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>