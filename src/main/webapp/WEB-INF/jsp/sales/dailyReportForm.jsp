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
            <div class="well">
                <form name="dataForm" id="dataForm" method="post">
                <input type="hidden" name="searchReportDesigner" value="<c:out value="${commandMap.searchReportDesigner}"/>" />
                <input type="hidden" name="searchReportStartDate" value="<c:out value="${commandMap.searchReportStartDate}"/>" />
                <input type="hidden" name="searchReportEndDate" value="<c:out value="${commandMap.searchReportEndDate}"/>" />
                <input type="hidden" name="searchReportSumDesigner" value="<c:out value="${commandMap.searchReportSumDesigner}"/>" />
                <input type="hidden" name="searchReportSumStartDate" value="<c:out value="${commandMap.searchReportSumStartDate}"/>" />
                <input type="hidden" name="searchReportSumEndDate" value="<c:out value="${commandMap.searchReportSumEndDate}"/>" />
                    <fieldset class="form-horizontal">
                        <legend><spring:message code="common.btn.create" /></legend>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.designer" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="ADM_MST_ID" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${designerList}" varStatus="i">
                                    <option value="<c:out value="${row.ADM_MST_ID}" />"><c:out value="${row.ADM_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.business" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="DAY_WRK_GBN" class="form-control">
                                    <c:forEach var="row" items="${dayWorkList}" varStatus="i">
                                    <c:if test="${row.CMN_COM_IDX eq Code.DAY_WORK_GBN_ADV }">
                                    <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.vendor" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="COM_INF_IDX" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${vendorList}" varStatus="i">
                                    <option value="<c:out value="${row.COM_INF_IDX}" />"><c:out value="${row.COM_INF_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="textArea" class="col-lg-2 control-label"><spring:message code="common.title.content" /></label>
                            <div class="col-lg-8 input-group">
                                <textarea class="form-control" rows="3" name="DAY_WRK_CTS" maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list" /></a>
                                <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="searchForm" id="searchForm">
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
    var $searchForm = $("#searchForm")
    , $dataForm = $("#dataForm");

    // 폼체크
    $dataForm.validate({
        rules: {
            ADM_MST_ID : {required:true},
            DAY_WRK_GBN : {required:true},
            COM_INF_IDX : {required:true}
        },
        messages :{
            ADM_MST_ID : {required:"<spring:message code="common.title.designer" /><spring:message code="common.validate.select" />"},
            DAY_WRK_GBN : {required:"<spring:message code="common.title.business" /><spring:message code="common.validate.select" />"},
            COM_INF_IDX : {required:"<spring:message code="common.title.vendor" /><spring:message code="common.validate.select" />"}
        }
    });

    // 저장
    goRegist = function(){
        if($dataForm.valid()){
            if(confirm("<spring:message code="common.alert.confirm.save" />")){
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/sales/dailyReportRegist.do", "method":"post", "target":"_self"}).submit();
            }
        }
    };

    // 목록
    goList = function(){
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/sales/dailyReportList.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>,