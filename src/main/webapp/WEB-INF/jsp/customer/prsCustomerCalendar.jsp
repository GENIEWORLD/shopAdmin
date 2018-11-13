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
                <h2><spring:message code="customer.prs.customer.title" /></h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <ul class="nav nav-tabs">
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/prsCustomerList.do"><spring:message code="common.btn.list" /></a></li>
                <li class="active"><a href="javascript:;"><spring:message code="common.btn.calendar" /></a></li>
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/customerProbability.do"><spring:message code="common.btn.probability" /></a></li>
            </ul>
        </div>
    </div>

    <div class="row">
        <div id="calendar" class="col-lg-10"></div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="MEM_MST_IDX" id="MEM_MST_IDX" value="" />
<input type="hidden" name="listPageUrl" value="/customer/prsCustomerCalendar.do" />
</form>

<%-- full calendar include 시작 --%>
<link rel='stylesheet' href='/js/plugins/fullcalendar/css/fullcalendar.min.css' />
<link rel='stylesheet' href='/js/plugins/fullcalendar/css/fullcalendar.print.min.css' media='print' />
<script src='/js/plugins/fullcalendar/lib/moment.min.js'></script>
<script src='/js/plugins/fullcalendar/fullcalendar.min.js'></script>
<%-- // full calendar include 종료 --%>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>

<script>
$(function(){
    var $dataForm = $("#dataForm");

    // 수정
    goEdit = function (memMstIdx) {
        $("#MEM_MST_IDX").val(memMstIdx);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/customer/prsCustomerEdit.do", "method":"post", "target":"_self"}).submit();
    };

    // 달력 생성
    $.postSyncJsonAjax("/customer/customerSchedultListAjax.do", {}, function(schedultList){
        $("#calendar").fullCalendar({
            header: { left: "prev,next today", center: "title", right: "month,basicWeek,basicDay" },
            navLinks: true,
            businessHours: true,
            editable: false,
            views: {
                month: { titleFormat: "YYYY.MM" },
                week: { titleFormat: "YYYY.MM.DD" },
                day: { titleFormat: "YYYY.MM.DD" }
            },
            events: schedultList,
            eventClick: function(event) {
                goEdit(event.id);
            },
            eventColor : 'white'
        });
    });
});
</script>
<%-- // script 종료 --%>
</body>
</html>