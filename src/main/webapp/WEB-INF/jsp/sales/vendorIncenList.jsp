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
                <h2><spring:message code="sales.vendor.incen.title" /></h2>
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
                            <label class="col-lg-2 control-label"><spring:message code="common.title.vendor" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchVendor">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${vendorList}" varStatus="i">
                                    <option value="<c:out value="${row.COM_INF_IDX}" />" <c:if test="${row.COM_INF_IDX eq commandMap.searchVendor}"> selected="selected"</c:if>><c:out value="${row.COM_INF_NM}" /></option>
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
                <h3><spring:message code="common.title.incen" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown('list');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.date" /></th>
                        <th class="text-center"><spring:message code="common.title.name" /></th>
                        <th class="text-center"><spring:message code="common.title.hp" /></th>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.wedding.planne" /></th>
                        <th class="text-center"><spring:message code="common.title.selling.price" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.pay.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${incenList}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.ORD_MST_ORD_DT}" /></td>
                        <td class="text-center"><c:out value="${row.MEM_MST_NM}" /></td>
                        <td class="text-center"><c:out value="${row.MEM_MST_TEL}" /></td>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM}" /></td>
                        <td class="text-center"><c:out value="${row.ORD_MST_WDP}" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_SAL}" type="number" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.COM_INCEN}" type="number" /></td>
                        <td class="text-center"><fmt:formatNumber value="${row.PROFIT}" type="number"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty incenList}">
                    <tr><td colspan="8" class="text-center"><spring:message code="common.list.empty" /></td></tr>
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
                    <a class="btn btn-default" href="javascript:goExcelDown('sum');"><spring:message code="common.btn.exceldown" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.selling.price" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.pay.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${!empty incenTotalSum}">
                    <tr>
                        <td class="text-center"><fmt:formatNumber value="${incenTotalSum.ORD_MST_SAL_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${incenTotalSum.COM_INCEN_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${incenTotalSum.PROFIT_SUM }" type="number"/></td>
                    </tr>
                    </c:if>
                    <c:if test="${empty incenTotalSum}">
                    <tr><td colspan="3" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

<form name="dataForm" id="dataForm">
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
    var $dataForm  = $("#dataForm") 
        , $searchForm = $("#searchForm");

    // 폼체크
    $searchForm.validate({
        rules: {
            searchVendor : {required:true},
            searchStartDate : {required:true},
            searchEndDate : {required:true}
        },
        messages :{
            searchVendor : {required:"<spring:message code="common.title.vendor" /><spring:message code="common.validate.select" />"},
            searchStartDate : {required:"<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />"},
            searchEndDate : {required:"<spring:message code="common.title.search.date" /><spring:message code="common.validate.select" />"}
        }
    });

    // 검색
    goSearch = function () {
        if($searchForm.valid()){
            $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/sales/vendorIncenList.do", "method":"post", "target":"_self"}).submit();
        }
    };
    
    // 엑셀다운로드
    goExcelDown = function (type) {
    	if ($dataForm.find("input[name='searchYn']").val() == "Y") {
    		var action = "";
            action = type == "list" ? "<c:out value="${serverSslDomain}"/>/sales/vendorIncenExcelList.do" : "<c:out value="${serverSslDomain}"/>/sales/vendorIncenSumExcelList.do";
            $dataForm.attr({"action":action, "method":"post", "target":"_self"}).submit();    		
    	}
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>