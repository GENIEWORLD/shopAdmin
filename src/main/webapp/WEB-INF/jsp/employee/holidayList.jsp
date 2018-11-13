<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<link rel="stylesheet" href="/js/plugins/fullcalendar/css/fullcalendar.min.css">
<link rel="stylesheet" href="/js/plugins/fullcalendar/css/fullcalendar.print.min.css" media="print">
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
                <h2><spring:message code="employee.holiday.title" /></h2>
            </div>
        </div>
    </div>
    
    <c:if test="${adminGbn eq Code.ADMIN_TYPE_DESIGNER }">
    <div class="row">
        <div class="col-lg-10">
            <div class="alert alert-dismissible alert-success">
                <p><spring:message code="common.title.that.month.holiday"/> : <span id="thatHoliday">0</span></p>
                <p><spring:message code="common.title.remnants.holiday"/> : <span id="remnantsHoliday">0</span></p>
            </div>
        </div>
    </div>
    </c:if>
    
    <div class="row">
        <div class="form-group text-right">
            <div class=" col-lg-8 col-lg-offset-2">
                <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
                <a href="javascript:openModal('holidayMasterForm');" class="btn btn-info"><spring:message code="common.btn.that.month.holiday" /></a>
                </c:if>
                <a href="javascript:openModal('holidayForm');" class="btn btn-info"><spring:message code="common.btn.holiday" /></a>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header"><h1></h1></div>
        </div>
    </div>
    
    <div class="row">
        <div id="calendar" class="col-lg-10"></div>
    </div>
    
    
    <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
    <!-- master modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="holidayMasterForm" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal('holidayMasterForm');" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.btn.that.month.holiday" /></h4>
                        </div>
                        <div class="modal-body pre-scrollable">
                            <div class="well">
                                <form name="masterForm" id="masterForm" class="form-horizontal">
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-lg-4 control-label"><spring:message code="common.title.holiday" /></label>
                                            <div class="col-lg-6">
                                                <input type="hidden" name="HLD_MST_YER" value="" />
                                                <input type="hidden" name="HLD_MST_MON" value="" />
                                                <input type="text" name="HLD_MST_CNT" class="form-control number" value=""/>
                                            </div>
                                        </div>
                                        <input type="hidden" name="DSN_HLD_YER" value="" />
                                        <input type="hidden" name="DSN_HLD_MON" value="" />
                                        <div id="remainArea"></div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="javascript:goMasterMerge();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// master modal -->
    </c:if>
    
    <!-- regist modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="holidayForm" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal('holidayForm');" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.btn.holiday" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="well">
                                <form name="registForm" id="registForm" class="form-horizontal">
                                    <fieldset>
                                        <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.employee" /></label>
                                            <div class="col-lg-8">
                                                <select name="ADM_MST_ID" id="ADM_MST_ID" class="form-control">
                                                    <option value=""><spring:message code="common.title.check"/></option>
                                                    <c:forEach var="row" items="${adminList }" varStatus="i">
                                                    <option value="<c:out value="${row.ADM_MST_ID }"/>"><c:out value="${row.ADM_MST_NM }"/></option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        </c:if>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.start.date" /></label>
                                            <div class="col-lg-8 input-group">
                                                <input type="text" name="HLD_INF_SRT_DT" class="form-control datepicker start" value=""  readonly="readonly"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.end.date" /></label>
                                            <div class="col-lg-8 input-group">
                                                <input type="text" name="HLD_INF_END_DT" class="form-control datepicker end" value="" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// regist modal -->
    
    <!-- modify modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="holidayEdit" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal('holidayEdit');" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.title.holiday.proc" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="well">
                                <form name="editForm" id="editForm" class="form-horizontal">
                                    <input type="hidden" name="HLD_INF_IDX" value="" />
                                    <input type="hidden" name="ADM_MST_ID" value="" />
                                    <fieldset>
                                        <legend id="holidayEditTitle"></legend>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.start.date" /></label>
                                            <div class="col-lg-8 input-group">
                                                <input type="text" name="HLD_INF_SRT_DT" class="form-control datepicker start" value=""  readonly="readonly"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.end.date" /></label>
                                            <div class="col-lg-8 input-group">
                                                <input type="text" name="HLD_INF_END_DT" class="form-control datepicker end" value="" readonly="readonly"/>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN or (adminGbn eq Code.ADMIN_TYPE_DESIGNER and holidayDelYn eq 'Y') }">
                            <a href="javascript:goRemove();" id="holidayRemoveButton" class="btn btn-danger"><spring:message code="common.btn.delete" /></a>
                            </c:if>
                            <a href="javascript:goModify();" id="holidayModifyButton" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// modify modal -->

    <input type="hidden" id="searchYear" value="<c:out value="${commandMap.searchYear }"/>" />
    <input type="hidden" id="searchMonth" value="<c:out value="${commandMap.searchMonth }"/>" />

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script src="/js/plugins/fullcalendar/lib/moment.min.js"></script>
<script src="/js/plugins/fullcalendar/fullcalendar.min.js"></script>
<script>
$(function(){
	
	var $calendar = $("#calendar")
        , $masterForm = $("#masterForm")
        , $registForm = $("#registForm")
        , $editForm = $("#editForm");
	
	var $searchYear = $("#searchYear")
	   , $searchMonth = $("#searchMonth")
	
	var $holidayRemoveButton = $("#holidayRemoveButton")
	   , $holidayModifyButton = $("#holidayModifyButton");
	
    // 달력 날짜 설정  
    setHolidayDate = function (date) {
		if (typeof($masterForm) != "undefined") {
			$masterForm.find("input[name='HLD_MST_YER']").val(date[0]);
	        $masterForm.find("input[name='HLD_MST_MON']").val(date[1]);
	        $masterForm.find("input[name='DSN_HLD_YER']").val(date[0]);
	        $masterForm.find("input[name='DSN_HLD_MON']").val(date[1]);			
		}
	};
        
    // 달력 생성
    $calendar.fullCalendar({
        header : { left: "prev,next", center: "title", right: "month,basicWeek,basicDay" }
        , navLinks : true
        , businessHours : true
        , editable : false
        , displayEventTime  : false
        , views : {
            month : { titleFormat: "YYYY.MM" }
            , week : { titleFormat: "YYYY.MM.DD" }
            , day : { titleFormat: "YYYY.MM.DD" }
        }
        , events : {}
        , eventClick : function (event) {
            openModal("holidayEdit");
            setHolidayData(event);
        }
        , eventAfterAllRender : function (view) {
        	setHolidayDate(view.title.split("."));
        }
    });
	
    $(document).on("click", ".fc-prev-button, .fc-next-button", function () {
    	var view = $calendar.fullCalendar("getView")
            , date = view.title.split(".");
        setHolidayDate(date);
        requestList(date[0], date[1]);    		
        return false;
    });
	
    // 휴일 목록 요청
    requestList = function (searchYear, searchMonth) {
		var param = new Object();
		if (typeof(searchYear) != "undefind" && typeof(searchMonth) != "undefined") {
			param["searchYear"] = searchYear;
			param["searchMonth"] = searchMonth;
			$searchYear.val(searchYear);
			$searchMonth.val(searchMonth);
		}
        $.postSyncJsonAjax("/employee/holidayInfoAjax.do", param, function(data){
        	<c:if test="${adminGbn eq Code.ADMIN_TYPE_DESIGNER }">
        	$("#thatHoliday").text(data.holidayMasterInfo.HLD_MST_CNT);
        	$("#remnantsHoliday").text(data.holidayRemainList[0].HLD_RMN_CNT);
        	</c:if>
            <c:if test="${adminGbn eq Code.ADMIN_TYPE_ADMIN }">
            setMaterData(data.holidayMasterInfo, data.holidayRemainList);
            </c:if>
            $calendar.fullCalendar("removeEvents");
            $calendar.fullCalendar("addEventSource", data.holidayList);
            $calendar.fullCalendar("rerenderEvents", data.holidayList);
        });
    };
    
    // 모달 팝업 열기 
    openModal = function (target) {
    	$("#" + target).show();
    };
	
    // 모달 팝업 닫기
    closeModal = function (target) {
    	$("#" + target).hide();
    };
    
    // 휴일 마스터 정보 셋팅
    setMaterData = function (info, list) {
    	$masterForm.find("input[name='HLD_MST_CNT']").val((typeof(info.HLD_MST_CNT) != "undefined") ? info.HLD_MST_CNT : 0);
        if (typeof(list) != "undefined") {
    	    var str = "";
    	    $.each(list, function (i, row){
                str += "<div class=\"form-group\">";
                str += "<label class=\"col-lg-4 control-label\">" + row.ADM_MST_NM + "</label>";
                str += "<div class=\"col-lg-6\">";
                str += "<input type=\"text\" name=\"DSN_HLD_CNTs\" class=\"form-control number\" value=\"" + row.HLD_RMN_CNT + "\"/>";
                str += "<input type=\"hidden\" name=\"DSN_HLD_IDs\" value=\"" + row.ADM_MST_ID + "\" />"
                str += "</div>";
                str += "</div>";
    		});
    	    var $remainArea = $masterForm.find("#remainArea");
    	    if (typeof($remainArea) != "undefined") {
    	        $remainArea.empty();
    	        $remainArea.append(str);
    	    }
    	}
    };
    
    // 휴일 마스터 폼 유효성 규칙 정의
    $masterForm.validate({
        rules: {
        	HLD_MST_CNT: {required:true}
            , DSN_HLD_CNTs: {required:true}
        }
        , messages: {
        	HLD_MST_CNT: {required:"<spring:message code="common.title.holiday" /><spring:message code="common.validate.input" />"}
            , DSN_HLD_CNTs: {required:"<spring:message code="common.title.holiday" /><spring:message code="common.validate.input" />"}
        }
    });
    
    // 휴일 등록/수정/삭제 처리
    holidayProc = function ($form, url) {
    	$.postSyncJsonAjax(url, $form.serialize(), function(data){
            alert(data.isSuccess ? "<spring:message code="common.alert.save.success" />" : "<spring:message code="common.alert.save.fail" />");
            requestList($searchYear.val(), $searchMonth.val());
        });
    };
    
    // 휴일 마스터 정보 MERGE
    goMasterMerge = function () {
    	if ($masterForm.valid()) {
    		if (confirm("<spring:message code="common.alert.confirm.save" />")) {
    			holidayProc($masterForm, "/employee/holidayMaterMergeAjax.do");
            }
    	}
    };
    
    // 휴일 등록 폼 유효성 규칙 정의
    $registForm.validate({
        rules: {
        	ADM_MST_ID: {required:true}
            , HLD_INF_SRT_DT: {required:true}
            , HLD_INF_END_DT: {required:true}
        }
        , messages: {
        	ADM_MST_ID: {required:"<spring:message code="common.title.employee" /><spring:message code="common.validate.input" />"}
            , HLD_INF_SRT_DT: {required:"<spring:message code="common.title.start.date" /><spring:message code="common.validate.input" />"}
            , HLD_INF_END_DT: {required:"<spring:message code="common.title.end.date" /><spring:message code="common.validate.input" />"}
        }
    });
    
    // 휴일 등록
    goRegist = function () {
    	if ($registForm.valid()) {
    		if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                holidayProc($registForm, "/employee/holidayRegistAjax.do");
            }
    	}
    };
    
    // 휴일정보 셋팅
    setHolidayData = function (event) {
    	var startDate = new Date(event.start)
            , endDate = new Date(event.end == null ? event.start : event.end);
         startDate.setUTCHours(0);
         endDate.setUTCHours(0);
        $editForm.find("#holidayEditTitle").text(event.title);
        $editForm.find("input[name='ADM_MST_ID']").val(event.ADM_MST_ID);
        $editForm.find("input[name='HLD_INF_IDX']").val(event.HLD_INF_IDX);
        $editForm.find("input[name='HLD_INF_SRT_DT']").val(startDate.Format("yyyy-MM-dd"));
        $editForm.find("input[name='HLD_INF_END_DT']").val(endDate.Format("yyyy-MM-dd"));
        <c:if test="${adminGbn eq Code.ADMIN_TYPE_DESIGNER}">
        if (event.ADM_MST_ID != "<c:out value="${adminId }"/>") {
        	$holidayRemoveButton.hide();
        	$holidayModifyButton.hide();
        } else {
        	$holidayRemoveButton.show();
        	$holidayModifyButton.show();
        }
        </c:if>
    };
    
    // 휴일 수정 폼 유효성 규칙 정의
    $editForm.validate({
    	rules: {
    		HLD_INF_SRT_DT: {required:true}
            , HLD_INF_END_DT: {required:true}
        }
        , messages: {
        	HLD_INF_SRT_DT: {required:"<spring:message code="common.title.start.date" /><spring:message code="common.validate.input" />"}
            , HLD_INF_END_DT: {required:"<spring:message code="common.title.end.date" /><spring:message code="common.validate.input" />"}
        }
    });
    
    // 휴일 수정
    goModify = function () {
    	if ($editForm.valid()) {
    	    if (confirm("<spring:message code="common.alert.confirm.save" />")) {
    	        holidayProc($editForm, "/employee/holidayModifyAjax.do");
    	    }
    	}
    };
    // 휴일 삭제
    goRemove = function () {
    	if (confirm("<spring:message code="common.alert.confirm.delete" />")) {
    		holidayProc($editForm, "/employee/holidayRemoveAjax.do");
    	}
    };
    
    requestList();
});
</script>
<%-- // script 종료 --%>
</body>
</html>