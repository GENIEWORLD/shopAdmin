<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
<link rel="stylesheet" href="/css/colorpicker.css" type="text/css"/>
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
                <h2><spring:message code="employee.manager.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchType" value="<c:out value="${commandMap.searchType }"/>" />
    <input type="hidden" name="searchWoard" value="<c:out value="${commandMap.searchWoard }"/>" />
    <input type="hidden" name="searchAdmMstUseYn" value="<c:out value="${commandMap.searchAdmMstUseYn }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <input type="hidden" name="ID_CHECK" id="ID_CHECK" value="N" />
                <fieldset>
                <legend><spring:message code="common.btn.create"/></legend>
                    <div class="form-group">
                        <label for="ADM_MST_NM" class="col-lg-2 control-label"><spring:message code="common.title.name"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_NM" id="ADM_MST_NM" class="form-control" value="" maxlength="20"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_TEL" class="col-lg-2 control-label"><spring:message code="common.title.hp"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_TEL" id="ADM_MST_TEL" class="form-control" value="" maxlength="20"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_ID" class="col-lg-2 control-label"><spring:message code="common.title.id"/></label>
                        <div class="col-lg-8 input-group">
                            <input type="text" name="ADM_MST_ID" id="ADM_MST_ID" class="form-control" value="" maxlength="20" onkeydown="document.getElementById('ID_CHECK').value='N';" style="margin-left: 2.5%;"/>
                            <span class="input-group-btn">
                                <a href="javascript:goManagerDupCheck();" class="btn btn-success"><spring:message code="common.btn.dup.check"/></a>
                            </span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_PWD" class="col-lg-2 control-label"><spring:message code="common.title.password"/></label>
                        <div class="col-lg-8">
                            <input type="password" name="ADM_MST_PWD" id="ADM_MST_PWD" class="form-control" value="" maxlength="14"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_PWD_RE" class="col-lg-2 control-label"><spring:message code="common.title.re.password"/></label>
                        <div class="col-lg-8">
                            <input type="password" name="ADM_MST_PWD_RE" id="ADM_MST_PWD_RE" class="form-control" value="" maxlength="14"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="STR_MST_IDX" class="col-lg-2 control-label"><spring:message code="common.title.shop"/></label>
                        <div class="col-lg-8">
                            <select name="STR_MST_IDX" id="STR_MST_IDX" class="form-control">
                                <option value=""><spring:message code="common.title.check"/></option>
                                <c:forEach var="row" items="${storeList }" varStatus="i">
                                <option value="<c:out value="${row.STR_MST_IDX }"/>"><c:out value="${row.STR_MST_NM }"/></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_GBN0" class="col-lg-2 control-label"><spring:message code="common.title.class"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <c:forEach var="row" items="${codes.ADMIN_TYPE }" varStatus="i">
                                <div class="radio">
                                    <label><input type="radio" name="ADM_MST_GBN" id="ADM_MST_GBN<c:out value="${i.index }"/>" value="<c:out value="${row.CMN_COM_IDX }"/>" <c:if test="${i.first }">checked="checked"</c:if>/><c:out value="${row.CMN_COM_NM }"/></label>
                                </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_SAL1" class="col-lg-2 control-label"><spring:message code="common.title.sales"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_SAL" id="ADM_MST_SAL1" value="<c:out value="${Code.SALES_TYPE_INDIVIDUAL }"/>" checked="checked"/><spring:message code="common.title.individual.sales"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_SAL" id="ADM_MST_SAL2" value="<c:out value="${Code.SALES_TYPE_SOP }"/>" /><spring:message code="common.title.branch.sales"/></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_PAY1" class="col-lg-2 control-label"><spring:message code="common.title.salary"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_PAY" id="ADM_MST_PAY1" value="<c:out value="${Code.SALARY_TYPE_INDIVIDUAL }"/>" checked="checked"/><spring:message code="common.title.individual.salary"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_PAY" id="ADM_MST_PAY2" value="<c:out value="${Code.SALARY_TYPE_SHOP }"/>" /><spring:message code="common.title.branch.salary"/></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_DEL1" class="col-lg-2 control-label"><spring:message code="common.title.holiday.right"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_DEL" id="ADM_MST_DEL1" value="Y" checked="checked"/><spring:message code="common.title.use"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_DEL" id="ADM_MST_DEL2" value="N" /><spring:message code="common.title.nonuse"/></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_NTC1" class="col-lg-2 control-label"><spring:message code="common.title.notice.right"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_NTC" id="ADM_MST_NTC1" value="Y" checked="checked"/><spring:message code="common.title.use"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_NTC" id="ADM_MST_NTC2" value="N" /><spring:message code="common.title.nonuse"/></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_BSC_PAY" class="col-lg-2 control-label"><spring:message code="common.title.base.salary"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_BSC_PAY" id="ADM_MST_BSC_PAY" class="form-control number" value="" maxlength="9"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_JOB_PAY" class="col-lg-2 control-label"><spring:message code="common.title.duty.salary"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_JOB_PAY" id="ADM_MST_JOB_PAY" class="form-control number" value="" maxlength="9"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_ICT_GBN" class="col-lg-2 control-label"><spring:message code="common.title.incen"/></label>
                        <div class="col-lg-2">
                            <select name="ADM_MST_ICT_GBN" id="ADM_MST_ICT_GBN" class="form-control">
                                <option value=""><spring:message code="common.title.check"/></option>
                                <c:forEach var="row" items="${codes.INCEN_TYPE }" varStatus="i">
                                <option value="<c:out value="${row.CMN_COM_IDX }"/>"><c:out value="${row.CMN_COM_NM }"/></option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-lg-6">
                            <input type="text" name="ADM_MST_ICT" id="ADM_MST_ICT" class="form-control" value="" maxlength="5"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_ISR" class="col-lg-2 control-label"><spring:message code="common.title.social.insurance"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_ISR" id="ADM_MST_ISR" class="form-control number" value="" maxlength="9"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_TAX" class="col-lg-2 control-label"><spring:message code="common.title.individual.income.tax"/></label>
                        <div class="col-lg-8">
                            <input type="text" name="ADM_MST_TAX" id="ADM_MST_TAX" class="form-control number" value="" maxlength="9"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_USE_YN1" class="col-lg-2 control-label"><spring:message code="common.title.holiday.color"/></label>
                        <div class="col-lg-8">
                            <input type="hidden" name="ADM_MST_COR" id="ADM_MST_COR" value="353cb8" />
                            <div id="colorpickerHolder"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ADM_MST_USE_YN1" class="col-lg-2 control-label"><spring:message code="common.title.use.type"/></label>
                        <div class="col-lg-8">
                            <div class="radio">
                                <label><input type="radio" name=ADM_MST_USE_YN id="ADM_MST_USE_YN1" value="Y" checked="checked"/><spring:message code="common.title.use"/></label>
                            </div>
                            <div class="radio">
                                <label><input type="radio" name="ADM_MST_USE_YN" id="ADM_MST_USE_YN2" value="N" /><spring:message code="common.title.nonuse"/></label>
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
<script type="text/javascript" src="/js/plugins/colorpicker/colorpicker.js"></script>
<script type="text/javascript" src="/js/plugins/colorpicker/eye.js"></script>
<script type="text/javascript" src="/js/plugins/colorpicker/utils.js"></script>
<script>
$(function(){

	var $dataForm = $("#dataForm")
	   , $searchForm = $("#searchForm");
	
	// ColorPicker Init
	$("#colorpickerHolder").ColorPicker({
	    flat : true
	    , color : "#353cb8"
	    , onChange : function (hsb, hex, rgb) {
	    	$dataForm.find("input[name='ADM_MST_COR']").val("#" + hex);
	    }
	    , onSubmit : function (hsb, hex, rgb) {
	        $dataForm.find("input[name='ADM_MST_COR']").val("#" + hex);
	    }
	});
	
	// 아이디 중복 체크
	goManagerDupCheck = function () {
	    var $ADM_MST_ID = $dataForm.find("input[name='ADM_MST_ID']");
		var value = $ADM_MST_ID.val();
		if (value == "") {
			alert("<spring:message code="common.title.id"/><spring:message code="common.validate.input"/>");
			$ADM_MST_ID.focus();
            return;
		}
		if (!(/^[a-zA-Z0-9]*$/.test(value) && /[a-z]/ig.test(value) && /[0-9]/g.test(value) && value.length >= 8 && value.length <= 14)) {
			alert("<spring:message code="common.validate.id"/>");
			$ADM_MST_ID.focus();
			return;
		}
		$.postSyncJsonAjax("/employee/managerDupCountAjax.do", {ADM_MST_ID:value}, function (data) {
			if (data.isDup) {
				alert("<spring:message code="common.alert.dup.id"/>");
			} else {
				alert("<spring:message code="common.alert.id"/>");
				$dataForm.find("#ID_CHECK").val("Y");
			}
		});
	};
	
	// 목록 이동
	goList = function () {
	    $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/managerList.do", "method":"post", "target":"_self"}).submit();
	};
	
	// 폼 유효성 규칙 추가
	$.validator.addMethod("adminIdCheck", function(value, element) {
        return this.optional(element) || ($dataForm.find("#ID_CHECK").val() == "Y");
    }, "<spring:message code="common.validate.dup.id"/>");
	
	$.validator.addMethod("adminId", function(value, element) {
        return this.optional(element) || (/^[a-zA-Z0-9]*$/.test(value) && /[a-z]/ig.test(value) && /[0-9]/g.test(value) && value.length >= 8 && value.length <= 14);
    }, "<spring:message code="common.validate.id"/>");
	
	// 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
        	ADM_MST_NM: {required:true}
            , ADM_MST_TEL: {required:true}
            , ADM_MST_ID: {required:true, adminId:true, adminIdCheck:true}
            , ADM_MST_PWD: {required:true, minlength:8, maxlength:14}
            , ADM_MST_PWD_RE: {required:true, equalTo:"#ADM_MST_PWD", minlength:8, maxlength:14}
            , STR_MST_IDX: {required:true}
            , ADM_MST_GBN: {required:true}
            , ADM_MST_SAL: {required:true}
            , ADM_MST_PAY: {required:true}
            , ADM_MST_DEL: {required:true}
            , ADM_MST_NTC: {required:true}
            , ADM_MST_BSC_PAY: {required:true, number:true}
            , ADM_MST_JOB_PAY: {required:true, number:true}
            , ADM_MST_ICT_GBN: {required:true}
            , ADM_MST_ICT: {required:true}
            , ADM_MST_ISR: {required:true, number:true}
            , ADM_MST_TAX: {required:true, number:true}
            , ADM_MST_USE_YN: {required:true}
        }
        , messages: {
        	ADM_MST_NM: {required:"<spring:message code="common.title.name"/><spring:message code="common.validate.input" />"}
            , ADM_MST_TEL: {required:"<spring:message code="common.title.hp"/><spring:message code="common.validate.input" />"}
            , ADM_MST_ID: {required:"<spring:message code="common.title.id"/><spring:message code="common.validate.input" />"}
            , ADM_MST_PWD: {
            	required:"<spring:message code="common.title.password"/><spring:message code="common.validate.input" />"
            	, minlength:"<spring:message code="common.validate.pwd" />"
            	, maxlength:"<spring:message code="common.validate.pwd" />"
        	}
            , ADM_MST_PWD_RE: {
            	required:"<spring:message code="common.title.re.password"/><spring:message code="common.validate.input" />"
                , equalTo:"<spring:message code="common.title.password"/><spring:message code="common.validate.equals" />"
                , minlength:"<spring:message code="common.validate.pwd" />"
                , maxlength:"<spring:message code="common.validate.pwd" />"
            	}
            , STR_MST_IDX: {required:"<spring:message code="common.title.shop"/><spring:message code="common.validate.select" />"}
            , ADM_MST_GBN: {required:"<spring:message code="common.title.class"/><spring:message code="common.validate.select" />"}
            , ADM_MST_SAL: {required:"<spring:message code="common.title.sales"/><spring:message code="common.validate.select" />"}
            , ADM_MST_PAY: {required:"<spring:message code="common.title.salary"/><spring:message code="common.validate.select" />"}
            , ADM_MST_DEL: {required:"<spring:message code="common.title.holiday.right"/><spring:message code="common.validate.select" />"}
            , ADM_MST_NTC: {required:"<spring:message code="common.title.notice.right"/><spring:message code="common.validate.select" />"}
            , ADM_MST_BSC_PAY: {
            	required:"<spring:message code="common.title.base.salary"/><spring:message code="common.validate.input" />"
            	, number:"<spring:message code="common.validate.num" />"
        	}
            , ADM_MST_JOB_PAY: {
            	required:"<spring:message code="common.title.duty.salary"/><spring:message code="common.validate.input" />"
            	, number:"<spring:message code="common.validate.num" />"
        	}
            , ADM_MST_ICT_GBN: {required:"<spring:message code="common.title.incen.type"/><spring:message code="common.validate.select" />"}
            , ADM_MST_ICT: {
            	required:"<spring:message code="common.title.incen"/><spring:message code="common.validate.input" />"
        	}
            , ADM_MST_ISR: {
            	required:"<spring:message code="common.title.social.insurance"/><spring:message code="common.validate.input" />"
            	, number:"<spring:message code="common.validate.num" />"
        	}
            , ADM_MST_TAX: {
            	required:"<spring:message code="common.title.individual.income.tax"/><spring:message code="common.validate.input" />"
            	, number:"<spring:message code="common.validate.num" />"
            }
            , ADM_MST_USE_YN: {required:"<spring:message code="common.title.use"/><spring:message code="common.validate.select" />"}
        }
    });
	
	// 등록
	goRegist = function () {
		if ($dataForm.valid()) {
			if (confirm("<spring:message code="common.alert.confirm.save" />")) {
			    $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/employee/managerRegist.do", "method":"post", "target":"_self"}).submit();
			}
		}
	};
});
</script>
<%-- // script 종료 --%>
</body>
</html>