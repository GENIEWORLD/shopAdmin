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
                <h2><spring:message code="board.notice.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
    <input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
    <input type="hidden" name="searchBrdNtsTitle" value="<c:out value="${commandMap.searchBrdNtsTitle }"/>" />
    <input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
    <input type="hidden" name="searchNtsUseYn" value="<c:out value="${commandMap.searchNtsUseYn }"/>" />
    <input type="hidden" name="searchNtsTopYn" value="<c:out value="${commandMap.searchNtsTopYn }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <fieldset>
                    <legend><spring:message code="common.btn.create" /></legend>
                    <div class="form-group">
                        <label for="BRD_NTS_TITLE" class="col-lg-2 control-label"><spring:message code="common.title.title" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="BRD_NTS_TITLE" id="BRD_NTS_TITLE" class="form-control" value="" maxlength="70"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="BRD_NTS_CONTENTS" class="col-lg-2 control-label"><spring:message code="common.title.content" /></label>
                        <div class="col-lg-8">
                            <textarea name="BRD_NTS_CONTENTS" id="BRD_NTS_CONTENTS" class="form-control" rows="10"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_IDX" class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                        <div class="col-lg-8">
                            <select class="form-control" name="STR_MST_IDX" id="STR_MST_IDX">
                                <option value="0"><spring:message code="common.title.shop.all.name" /></option>
                                <c:forEach var="row" items="${storeList}" varStatus="i">
                                <option value="<c:out value="${row.STR_MST_IDX}" />"><c:out value="${row.STR_MST_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="BRD_NTS_TOP_YN1" class="col-lg-2 control-label"><spring:message code="common.title.notice.top.type" /></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="BRD_NTS_TOP_YN" id="BRD_NTS_TOP_YN1" value="Y" checked="checked" /><spring:message code="common.title.use" /></label>
                                <label><input type="radio" name="BRD_NTS_TOP_YN" id="BRD_NTS_TOP_YN2" value="N" /><spring:message code="common.title.nonuse" /></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="BRD_NTS_USE_YN1" class="col-lg-2 control-label"><spring:message code="common.title.use.type" /></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="BRD_NTS_USE_YN" id="BRD_NTS_USE_YN1" value="Y" checked="checked" /><spring:message code="common.title.use" /></label>
                                <label><input type="radio" name="BRD_NTS_USE_YN" id="BRD_NTS_USE_YN2" value="N" /><spring:message code="common.title.nonuse" /></label>
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

    // 공지사항 목록 이동
    goList = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeList.do", "method":"post", "target":"_self"}).submit();
    };

    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
    // 공지사항 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
            BRD_NTS_TITLE: {required:true}
            , BRD_NTS_CONTENTS: {required:true}
            , STR_MST_IDX: {required:true}
            , BRD_NTS_TOP_YN: {required:true}
            , BRD_NTS_USE_YN: {required:true}
        }
        , messages: {
            BRD_NTS_TITLE: {required:"<spring:message code="common.title.title" /><spring:message code="common.validate.input" />"}
            , BRD_NTS_CONTENTS: {required:"<spring:message code="common.title.content" /><spring:message code="common.validate.input" />"}
            , STR_MST_IDX: {required:"<spring:message code="common.title.shop" /><spring:message code="common.validate.select" />"}
            , BRD_NTS_TOP_YN: {required:"<spring:message code="common.title.notice.top.type" /><spring:message code="common.validate.select" />"}
            , BRD_NTS_USE_YN: {required:"<spring:message code="common.title.use.type" /><spring:message code="common.validate.select" />"}
        }
    });

    // 공지사항 등록
    goRegist = function () {
        if ($dataForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeRegist.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };
    </c:if>
});
</script>
<%-- // script 종료 --%>
</body>
</html>