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
                <input type="hidden" name="searchYearMonth" value="<c:out value="${commandMap.searchYearMonth}"/>" />
                    <fieldset class="form-horizontal">
                        <legend><spring:message code="common.btn.create" /></legend>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.type" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="ACT_BOK_GBN" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${ledgerGbnList}" varStatus="i">
                                    <c:if test="${row.CMN_COM_IDX ne Code.LEDGERLIST_GBN_SLR}">
                                        <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.reg.date" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="ACT_BOK_DT" class="form-control datepicker" value="" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.content" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="ACT_BOK_CTS" class="form-control" value="" maxlength="100"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.price" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="ACT_BOK_PAY" class="form-control number" value="" />
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
<input type="hidden" name="searchYearMonth" value="<c:out value="${commandMap.searchYearMonth}"/>" />
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
            ACT_BOK_GBN : {required:true},
            ACT_BOK_DT : {required:true},
            ACT_BOK_PAY : {required:true}
        },
        messages :{
            ACT_BOK_GBN : {required:"<spring:message code="common.title.type" /><spring:message code="common.validate.select" />"},
            ACT_BOK_DT : {required:"<spring:message code="common.title.reg.date" /><spring:message code="common.validate.select" />"},
            ACT_BOK_PAY : {required:"<spring:message code="common.title.price" /><spring:message code="common.validate.input" />"},
        }
    });

    // 저장
    goRegist = function(){
        if($dataForm.valid()){
            if(confirm("<spring:message code="common.alert.confirm.save" />")){
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/sales/ledgerRegist.do", "method":"post", "target":"_self"}).submit();
            }
        }
    };

    // 목록
    goList = function(){
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/sales/ledgerList.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>