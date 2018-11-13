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
                <h2><spring:message code="order.reservation.title" /></h2>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="form-group text-right">
            <div class="col-lg-8 col-lg-offset-2">
                <a href="javascript:openModal('reservationForm');" class="btn btn-info"><spring:message code="common.btn.create" /></a>
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
    
    <!-- regist modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="reservationForm" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal('reservationForm');" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.title.reservation.regist" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="well">
                                <form name="registForm" id="registForm" class="form-horizontal">
                                    <input type="hidden" name="MEM_MST_IDX" value="" />
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.member" /></label>
                                            <div class="col-lg-8">
                                                <span id="memberName"></span>
                                                <a href="javascript:goMemberSearch();" class="btn btn-success"><spring:message code="common.btn.search" /></a>
                                            </div>
                                        </div>
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
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.reservation.day" /></label>
                                            <div class="col-lg-8 input-group">
                                                <input type="text" name="ORD_RSV_DATE" class="form-control datepicker" value=""  readonly="readonly" style="margin-left: 3%;"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.hour" /></label>
                                            <div class="col-lg-8">
                                                <select name="ORD_RSV_HOR" id="ORD_RSV_HOR" class="form-control">
                                                <c:forEach var="hour" begin="0" end="23">
                                                <c:if test="${hour lt 10  }"><c:set var="hour" value="0${hour}"/></c:if>
                                                <option value="<c:out value="${hour }"/>"><c:out value="${hour }"/></option>
                                                </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.minute" /></label>
                                            <div class="col-lg-8">
                                                <select name="ORD_RSV_MIM" id="ORD_RSV_MIM" class="form-control">
                                                    <c:forEach var="minute" begin="0" end="59">
                                                    <c:if test="${minute lt 10  }"><c:set var="minute" value="0${minute}"/></c:if>
                                                    <option value="<c:out value="${minute }"/>"><c:out value="${minute }"/></option>
                                                    </c:forEach>
                                                </select>
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
    
    <!-- view modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="reservationList" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal('reservationList');" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.btn.holiday" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="list-group">
                                <span id="reservationTitle" class="list-group-item active">Cras justo odio</span>
                                <span id="reservationListArea"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // view modal -->

    <input type="hidden" id="searchYear" value="<c:out value="${commandMap.searchYear }"/>" />
    <input type="hidden" id="searchMonth" value="<c:out value="${commandMap.searchMonth }"/>" />

    <form name="removeForm" id="removeForm">
    <input type="hidden" name="ORD_RSV_IDX" value="" />
    </form>

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
        , $registForm = $("#registForm")
        , $removeForm = $("#removeForm");
    
    var $reservationTitle = $("#reservationTitle")
        , $reservationListArea = $("#reservationListArea");
    
    var $searchYear = $("#searchYear")
       , $searchMonth = $("#searchMonth")
        
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
        	requestList("view", event.ORD_RSV_YER, event.ORD_RSV_MON, event.ORD_RSV_DAY);
        }
    });
    
    $(document).on("click", ".fc-prev-button, .fc-next-button", function () {
        var view = $calendar.fullCalendar("getView")
            , date = view.title.split(".");
        requestList("calendar", date[0], date[1]);          
        return false;
    });
    
    // 납품예약 목록 요청
    requestList = function (type, searchYear, searchMonth, searchDay) {
        var param = new Object();
        if (typeof(searchYear) != "undefind" && typeof(searchMonth) != "undefined") {
            param["searchYear"] = searchYear;
            param["searchMonth"] = searchMonth;
            $searchYear.val(searchYear);
            $searchMonth.val(searchMonth);
        }
        if (typeof(searchDay) != "undefined") {
        	param["searchDay"] = searchDay;
        }
        $.postSyncJsonAjax("/order/orderReservationListAjax.do", param, function(list){
        	if (type == "calendar") {
        		$calendar.fullCalendar("removeEvents");
                $calendar.fullCalendar("addEventSource", list);
                $calendar.fullCalendar("rerenderEvents", list);        		
        	} else if (type == "view") {
        		$reservationTitle.text(searchYear + "." + searchMonth + "." + searchDay + ".");
        		var str = "<span class=\"list-group-item\"><spring:message code="common.list.empty"/></span>";
        		if (list.length > 0) {
        			str = "";
        			$.each(list, function (i, row) {
        				str += "<span class=\"list-group-item\">"
        				str += row.ORD_RSV_HOR + ":" + row.ORD_RSV_MIM;
        				str += "-" + row.MEM_MST_NM + "(" + row.MEM_MST_CD + ")";
        				str += "-" + row.ADM_MST_NM + "  ";
        				str += "<a href=\"javascript:goRemove('" + row.ORD_RSV_IDX + "');\" class=\"btn btn-danger btn-xs\"><spring:message code="common.btn.delete" /></a>";
        				str += "</span>";
        			});
        		}
        		$reservationListArea.empty();
        		$reservationListArea.append(str);
        		openModal("reservationList");
        	}
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
    
    // 휴일 등록/수정/삭제 처리
    reservationProc = function ($form, url) {
        $.postSyncJsonAjax(url, $form.serialize(), function(data){
            alert(data.isSuccess ? "<spring:message code="common.alert.save.success" />" : "<spring:message code="common.alert.save.fail" />");
            requestList("calendar", $searchYear.val(), $searchMonth.val());
        });
    };
    
    
    // 납품예약 등록 폼 유효성 규칙 정의
    $registForm.validate({
        rules: {
        	ADM_MST_ID: {required:true}
            , ORD_RSV_DATE: {required:true}
            , ORD_RSV_HOR: {required:true}
            , ORD_RSV_MIM: {required:true}
        }
        , messages: {
        	ADM_MST_ID: {required:"<spring:message code="common.title.employee" /><spring:message code="common.validate.select" />"}
            , ORD_RSV_DATE: {required:"<spring:message code="common.title.reservation.day" /><spring:message code="common.validate.select" />"}
            , ORD_RSV_MIM: {required:"<spring:message code="common.title.hour" /><spring:message code="common.validate.select" />"}
            , ORD_RSV_MIM: {required:"<spring:message code="common.title.minute" /><spring:message code="common.validate.select" />"}
        }
    });
    
    // 납품예약 등록
    goRegist = function () {
    	if ($registForm.find("input[name='MEM_MST_IDX']").val() == "") {
    		alert("<spring:message code="common.title.member" /><spring:message code="common.validate.select" />");
    		return;
    	}
        if ($registForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
            	reservationProc($registForm, "/order/orderReservationRegistAjax.do");
            }
        }
    };
    
    // 납품예약 삭제
    goRemove = function (ORD_RSV_IDX) {
        if (confirm("<spring:message code="common.alert.confirm.delete" />")) {
        	$removeForm.find("input[name='ORD_RSV_IDX']").val(ORD_RSV_IDX);
        	reservationProc($removeForm, "/order/orderReservationRemoveAjax.do");
        	closeModal("reservationList");
        }
    };
    // 회원검색 팝업    
    goMemberSearch = function () {
    	window.open("<c:out value="${serverDomain}"/>/order/memberSearch.do", "memberSearchPopup", "width=800, height=800,top=0, left=0, scrollbars=yes, status=no, toolbar=no, resizable=no, location=no, menu=no");
    };
    
    // 회원정보 저장
    setMemberInfo = function (MEM_MST_IDX, MEM_MST_CD, MEM_MST_NM) {
    	$registForm.find("input[name='MEM_MST_IDX']").val(MEM_MST_IDX);
    	$registForm.find("#memberName").text(MEM_MST_NM);
    }
    
    requestList("calendar");
});
</script>
<%-- // script 종료 --%>
</body>
</html>