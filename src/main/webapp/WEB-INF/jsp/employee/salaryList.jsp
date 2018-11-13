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
                <h2><spring:message code="employee.salary.title" /></h2>
            </div>
        </div>
    </div>
    
    <form name="dataForm" id="dataForm">
        <input type="hidden" name="year" value="<c:out value="${year }"/>" />
        <input type="hidden" name="month" value="<c:out value="${month }"/>" />
    </form>
    
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header" style="text-align: center;">
                <h3>
                    <a href="javascript:requestList('prev', 'year');" class="btn btn-default">&laquo;</a>
                    <a href="javascript:requestList('prev', 'month');" class="btn btn-default">&lsaquo;</a>
                    <span id="dateTitle"><c:out value="${year }"/>. <c:out value="${month }"/>.</span>
                    <a href="javascript:requestList('next', 'month');" class="btn btn-default">&rsaquo;</a>
                    <a href="javascript:requestList('next', 'year');" class="btn btn-default">&raquo;</a>
                </h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.base.salary" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.duty.salary" /></th>
                        <th class="text-center"><spring:message code="common.title.bonus" /></th>
                        <th class="text-center"><spring:message code="common.title.social.insurance" /></th>
                        <th class="text-center"><spring:message code="common.title.individual.income.tax" /></th>
                        <th class="text-center"><spring:message code="common.title.total" /></th>
                    </tr>
                </thead>
                <tbody id="listArea">
                    <c:if test="${not empty list }">
                    <c:forEach var="row" items="${list }" varStatus="i">
                    <tr>
                        <td class="text-center">
                            <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
                            <a href="javascript:;" onclick="openBonusModal(this);">
                                <input type="hidden" class="DSN_SLR_DT" value="<c:out value="${row.DSN_SLR_DT }"/>" />
                                <input type="hidden" class="DSN_SLR_BNS" value="<c:out value="${row.DSN_SLR_BNS }"/>" />
                                <input type="hidden" class="ADM_MST_ID" value="<c:out value="${row.ADM_MST_ID }"/>" />
                                <input type="hidden" class="ADM_MST_NM" value="<c:out value="${row.ADM_MST_NM }"/>" />
                                <c:out value="${row.ADM_MST_NM }"/>
                            </a>
                            </c:if>
                            <c:if test="${adminGbn ne Code.ADMIN_TYPE_ADMIN }"><c:out value="${row.ADM_MST_NM }"/></c:if>
                        </td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_BSC_PAY }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_ICT }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_JOB_PAY }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_BNS }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_ISR }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_TAX }" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.DSN_SLR_TOT }" type="number"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty list }">
                    <tr><td colspan="8" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    
    <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
    <!-- bonus modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="bonusMoadl" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeBonusModal();" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.title.bonus.regist" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="well">
                                <form name="bonusForm" id="bonusForm" class="form-horizontal">
                                    <input type="hidden" name="DSN_SLR_DT" value="" />
                                    <input type="hidden" name="ADM_MST_ID" value="" />
                                    <fieldset>
                                        <legend id="bonusMoadlTitle"></legend>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.bonus" /></label>
                                            <div class="col-lg-8"><input type="text" name="DSN_SLR_BNS" class="form-control number" value="" /></div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="javascript:goBonusModify();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// bonus modal -->
    </c:if>
    

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
        , $dateTitle = $("#dateTitle")
        , $listArea = $("#listArea")
        , $bonusMoadl = $("#bonusMoadl")
        , $bonusMoadlTitle = $("#bonusMoadlTitle")
        , $bonusForm = $("#bonusForm");
	
	// 급여 목록 요청
	requestList = function (gubun, type, dateStr) {
		
		var params = new Object();
		if (typeof(dateStr) != "undefined") {
			params["searchDay"] = dateStr;
		} else {
			var $year = $dataForm.find("input[name='year']")
                , $month = $dataForm.find("input[name='month']");
            
            var date = new Date(stringUtil.formatDateStr($year.val() + $month.val() + "01", "MM/dd/yyyy"));
            if (type == "year") {
                if (gubun == "prev") {
                    date.setFullYear(date.getFullYear() - 1);
                } else if (gubun == "next") {
                    date.setFullYear(date.getFullYear() + 1);
                }
            } else if (type == "month") {
                if (gubun == "prev") {
                    date.setMonth(date.getMonth() - 1);
                } else if (gubun == "next") {
                    date.setMonth(date.getMonth() + 1);
                }
            }
            if (date > new Date()) {
                return;
            }
            
            var year = Number(date.getFullYear())
                , month = Number(date.getMonth()) + 1;
            year = year.toString();
            month = month < 10 ? "0" + month.toString() : month.toString();
            
            $year.val(year);
            $month.val(month);
            $dateTitle.text(year + ". " + month + ".");
            
            params["searchDay"] = year + month;
		}
		
		$.postSyncJsonAjax("/employee/salaryListAjax.do", params, function (list) {
			
			var str = "<tr><td colspan=\"8\" class=\"text-center\"><spring:message code="common.list.empty" /></td></tr>";
		    if (typeof(list) != "undefined") {
		    	if (list.length > 0) {
		    	    str = "";
		    		$.each(list, function (i, row) {
		    			str += "<tr>";
		    			<c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
		    			str += "<td class=\"text-center\">";
		    			str += "<a href=\"javascript:;\" onclick=\"openBonusModal(this);\">";
		    			str += "<input type=\"hidden\" class=\"DSN_SLR_DT\" value=\"" + row.DSN_SLR_DT + "\" />";
		    			str += "<input type=\"hidden\" class=\"DSN_SLR_BNS\" value=\"" + row.DSN_SLR_BNS + "\" />";
		    			str += "<input type=\"hidden\" class=\"ADM_MST_ID\" value=\"" + row.ADM_MST_ID + "\" />";
		    			str += "<input type=\"hidden\" class=\"ADM_MST_NM\" value=\"" + row.ADM_MST_NM + "\" />";
		    			str += row.ADM_MST_NM;
		    			str += "</a>";
		    			str += "</td>";
		    			</c:if>
		    			<c:if test="${adminGbn ne Code.ADMIN_TYPE_ADMIN }">
		    			str += "<td class=\"text-center\">" + row.ADM_MST_NM + "</td>";
		    			</c:if>
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_BSC_PAY) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_ICT) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_JOB_PAY) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_BNS) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_ISR) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_TAX) + "</td>";
		    			str += "<td class=\"text-center\">" + stringUtil.setComma(row.DSN_SLR_TOT) + "</td>";
		    			str += "</tr>";
	                });
		    	}
		    }
		    $listArea.empty();
		    $listArea.append(str);
		});
	};
	
	// 보너스 모달 열기
	openBonusModal = function (obj) {
		var $inputs = $(obj).children("input[type='hidden']");
		$bonusForm.find("input[name='DSN_SLR_DT']").val($inputs.filter(".DSN_SLR_DT").val());
		$bonusForm.find("input[name='ADM_MST_ID']").val($inputs.filter(".ADM_MST_ID").val());
		$bonusForm.find("input[name='DSN_SLR_BNS']").val($inputs.filter(".DSN_SLR_BNS").val());
		$bonusMoadlTitle.text($inputs.filter(".ADM_MST_NM").val())
		$bonusMoadl.show();
	};
	
	// 보너스 모달 닫기
	closeBonusModal = function () {
		$bonusMoadl.hide();
	};
	
	// 보너스 폼 유효성 규칙 정의
    $bonusForm.validate({
        rules: {
        	DSN_SLR_BNS: {required:true}
        }
        , messages: {
        	DSN_SLR_BNS: {required:"<spring:message code="common.title.bonus" /><spring:message code="common.validate.input" />"}
        }
    });
	
	// 보너스 수정
	goBonusModify = function () {
	    if ($bonusForm.valid()) {
	    	if (confirm("<spring:message code="common.alert.confirm.save" />")) {
	    		$.postSyncJsonAjax("/employee/salaryModifyAjax.do", $bonusForm.serialize(), function (data) {
	    			alert(data.isSuccess ? "<spring:message code="common.alert.save.success" />" : "<spring:message code="common.alert.save.fail" />");
	    			requestList(null, null, $bonusForm.find("input[name='DSN_SLR_DT']").val());
	    		});
	    	}
	    }
	};
	
});
</script>
<%-- // script 종료 --%>
</body>
</html>