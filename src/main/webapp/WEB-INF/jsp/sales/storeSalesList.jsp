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
                <h2><spring:message code="sales.store.sales.title" /></h2>
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
                <input type="hidden" name="searchYn" value="Y" /> 
                    <fieldset class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchShop">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${storeList}" varStatus="i">
                                    <option value="<c:out value="${row.STR_MST_IDX}" />" <c:if test="${row.STR_MST_IDX eq commandMap.searchShop}"> selected="selected"</c:if>><c:out value="${row.STR_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                            <div class="col-lg-8 input-group">
                                <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                                <input type="text" name="searchStartDate" id="searchStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchStartDate}"/>"  readonly="readonly"/>
                                <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                                <input type="text" name="searchEndDate" id="searchEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchEndDate}"/>" readonly="readonly"/>
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
                <h3><spring:message code="common.title.sales" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown('Sales');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.order.date" /></th>
                        <th class="text-center"><spring:message code="common.title.name" /></th>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center"><spring:message code="common.title.balance" /></th>
                        <th class="text-center"><spring:message code="common.title.selling.price" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.pay.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${salesList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ORD_MST_ORD_DT}" /></td>
                        <td class="text-center"><c:out value="${row.MEM_MST_NM}" /></td>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_BAL}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_SAL}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.COM_INCEN}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.PROFIT}" type="number"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty salesList}">
                    <tr><td colspan="7" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.total" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown('Sum');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.cash" /></th>
                        <th class="text-center"><spring:message code="common.title.card" /></th>
                        <th class="text-center"><spring:message code="common.title.weixin" /></th>
                        <th class="text-center"><spring:message code="common.title.jjeupu" /></th>
                        <th class="text-center"><spring:message code="common.title.honbooe" /></th>
                        <th class="text-center"><spring:message code="common.title.ttajung" /></th>
                        <th class="text-center"><spring:message code="common.title.etc" /></th>
                        <th class="text-center"><spring:message code="common.title.balance" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.total" /></th>
                        <th class="text-center"><spring:message code="common.title.pay.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${!empty salesTotalSum}">
                    <tr>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_CSH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_CRD_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_WXN_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_ZFU_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_HBH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_DZH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_PAY_ETC_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_BAL_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.COM_INCEN_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_SAL_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.PROFIT_SUM }" type="number"/></td>
                    </tr>
                    </c:if>
                    <c:if test="${empty salesTotalSum}">
                    <tr><td colspan="11" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.member.count" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown('Count');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center"><spring:message code="common.title.member.count" /></th>
                        <th class="text-center"><spring:message code="common.title.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${salesCustomerList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.MEM_CNT}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_SAL_SUM}" type="number"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty salesCustomerList}">
                    <tr><td colspan="3" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.byvendor"/>&nbsp;<spring:message code="common.title.buy.probability" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown('Probability');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center">%</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${salesProbabilityList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}" /></td>
                        <td class="text-center"><c:out value="${row.COM_RAT}" /></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty salesProbabilityList}">
                    <tr><td colspan="3" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="type" value="" />
<input type="hidden" name="searchYn" value="<c:out value="${commandMap.searchYn }"/>" />
<input type="hidden" name="searchVendor" value="<c:out value="${commandMap.searchVendor }"/>" />
<input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
<input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
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

    // 폼체크
    $searchForm.validate({
        rules: {
            searchShop : {required:true},
            searchStartDate : {required:true},
            searchEndDate : {required:true}
        },
        messages :{
            searchShop : {required:"<spring:message code="common.title.shop" /><spring:message code="common.validate.select" />"},
            searchStartDate : {required:"<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />"},
            searchEndDate : {required:"<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />"}
        }
    });

    // 검색
    goSearch = function () {
        if($searchForm.valid()){
            $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/storeSalesList.do", "method":"post", "target":"_self"}).submit();
        }
    };
    
    // 엑셀다운로드
    goExcelDown = function (type) {
        if ($dataForm.find("input[name='searchYn']").val() == "Y") {
        	$dataForm.find("input[name='type']").val(type)
            $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/storeSalesExcelList.do", "method":"post", "target":"_self"}).submit();          
        }
    };
    
});
</script>
<%-- // script 종료 --%>
</body>
</html>