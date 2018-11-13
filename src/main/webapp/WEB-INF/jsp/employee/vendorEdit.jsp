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
                <h2><spring:message code="employee.vendor.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchComInfNm" value="<c:out value="${commandMap.searchComInfNm }"/>" />
    <input type="hidden" name="searchComInfYn" value="<c:out value="${commandMap.searchComInfYn }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <input type="hidden" name="COM_INF_IDX" value="<c:out value="${info.COM_INF_IDX }"/>" />
                <fieldset>
                <legend><spring:message code="common.btn.create"/></legend>
                    <div class="form-group">
                        <label for="COM_INF_NM" class="col-lg-2 control-label"><spring:message code="common.title.vendor.name"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="COM_INF_NM" id="COM_INF_NM" class="form-control" value="<c:out value="${info.COM_INF_NM }"/>" maxlength="20"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="COM_INF_CMS" class="col-lg-2 control-label"><spring:message code="common.title.commission"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="COM_INF_CMS" id="COM_INF_CMS" class="form-control" value="<c:out value="${info.COM_INF_CMS }"/>" maxlength="5"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="COM_INF_YN1" class="col-lg-2 control-label"><spring:message code="common.title.use.type"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name=COM_INF_YN id="COM_INF_YN1" value="Y" <c:if test="${info.COM_INF_YN eq 'Y' }">checked="checked"</c:if>/><spring:message code="common.title.use"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="COM_INF_YN" id="COM_INF_YN2" value="N" <c:if test="${info.COM_INF_YN eq 'N' }">checked="checked"</c:if>/><spring:message code="common.title.nonuse"/></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list"/></a>
                            <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save"/></a>
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
	
	// 목록 이동
	goList = function () {
	    $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorList.do", "method":"post", "target":"_self"}).submit();
	};
	
	// 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
        	COM_INF_NM: {required:true}
            , COM_INF_CMS: {required:true}
            , COM_INF_YN: {required:true}
        }
        , messages: {
        	ADM_MST_NM: {required:"<spring:message code="common.title.vendor.name"/><spring:message code="common.validate.input" />"}
            , ADM_MST_BSC_PAY: {
            	required:"<spring:message code="common.title.commission"/><spring:message code="common.validate.input" />"
            	, number:"<spring:message code="common.validate.num" />"
        	}
            , COM_INF_YN: {required:"<spring:message code="common.title.use.type" />"}
        }
    });
	
	// 등록
	goRegist = function () {
		if ($dataForm.valid()) {
			if (confirm("<spring:message code="common.alert.confirm.save" />")) {
			    $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/vendorModify.do", "method":"post", "target":"_self"}).submit();
			}
		}
	};
});
</script>
<%-- // script 종료 --%>
</body>
</html>