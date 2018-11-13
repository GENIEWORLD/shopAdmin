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
                <h2><spring:message code="manage.store.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
    <input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
    <input type="hidden" name="searchStrMstNm" value="<c:out value="${commandMap.searchStrMstNm }"/>" />
    <input type="hidden" name="searchStrMstGbn" value="<c:out value="${commandMap.searchStrMstGbn }"/>" />
    <input type="hidden" name="searchStrMstTel" value="<c:out value="${commandMap.searchStrMstTel }"/>" />
    <input type="hidden" name="searchStrMstUseYn" value="<c:out value="${commandMap.searchStrMstUseYn }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <fieldset>
                    <legend><spring:message code="common.btn.create" /></legend>
                    <div class="form-group">
                        <label for="STR_MST_NM" class="col-lg-2 control-label"><spring:message code="common.title.store.name" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="STR_MST_NM" id="STR_MST_NM" class="form-control" value="" maxlength="30"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_GBN" class="col-lg-2 control-label"><spring:message code="common.title.store.grade" /></label>
                        <div class="col-lg-8">
                            <select class="form-control" name="STR_MST_GBN" id="STR_MST_GBN">
                                <option value="">선택</option>
                                <c:forEach var="row" items="${gradeList}" varStatus="i">
                                <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_TEL" class="col-lg-2 control-label"><spring:message code="common.title.hp" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="STR_MST_TEL" id="STR_MST_TEL" class="form-control" value="" maxlength="15"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_ADDR" class="col-lg-2 control-label"><spring:message code="common.title.addr" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="STR_MST_ADDR" id="STR_MST_ADDR" class="form-control" value="" maxlength="100"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_USE_YN1" class="col-lg-2 control-label"><spring:message code="common.title.use.type" /></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="STR_MST_USE_YN" id="STR_MST_USE_YN1" value="Y" checked="checked" /><spring:message code="common.title.use" /></label>
                                <label><input type="radio" name="STR_MST_USE_YN" id="STR_MST_USE_YN2" value="N" /><spring:message code="common.title.nonuse" /></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list"/></a>
                            <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                            <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save"/></a>
                            </c:if>
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

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){

    var $dataForm = $("#dataForm")
       , $searchForm = $("#searchForm");

    // 매장관리 목록 이동
    goList = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeList.do", "method":"post", "target":"_self"}).submit();
    };

    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
    // 매장관리 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
            STR_MST_NM: {required:true}
            , STR_MST_GBN: {required:true}
            , STR_MST_TEL: {required:false}
            , STR_MST_ADDR: {required:false}
            , STR_MST_USE_YN: {required:true}
        }
        , messages: {
            STR_MST_NM: {required:"<spring:message code="common.title.store.name" /><spring:message code="common.validate.input" />"}
            , STR_MST_GBN: {required:"<spring:message code="common.title.store.grade" /><spring:message code="common.validate.select" />"}
            , STR_MST_TEL: {required:"<spring:message code="common.title.hp" /><spring:message code="common.validate.input" />"}
            , STR_MST_ADDR: {required:"<spring:message code="common.title.addr" /><spring:message code="common.validate.input" />"}
            , STR_MST_USE_YN: {required:"<spring:message code="common.title.use.type" /><spring:message code="common.validate.select" />"}
        }
    });

    // 매장관리 등록
    goRegist = function () {
        if ($dataForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/manage/storeRegist.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };
    </c:if>
});
</script>
<%-- // script 종료 --%>
</body>
</html>