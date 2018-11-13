<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<body>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<form name="dataForm" id="dataForm" method="post">
<input type="hidden" name="noHistoryBack" value="Y" />
</form>
<script>
/* 뒤로가기 방지 */
history.pushState(null, null, location.href);

window.onpopstate = function(event) {
    window.history.forward();
};
</script>
<script>
$(function(){
    var $frm = $("#dataForm");

    if("<c:out value="${loginResult.loginSuccess}" />" == "Y"){
        $frm.attr({"action":"<c:out value="${serverDomain}" />/dashboard/main.do", "target":"_self", "method":"post"}).submit();
    }else{
        <c:if test="${!empty loginResult.resultMsg}">
        alert("<spring:message code="${loginResult.resultMsg}" />");
        </c:if>
        $frm.attr({"action":"<c:out value="${serverDomain}" />/login/login.do", "target":"_self", "method":"post"}).submit();
    }
});
</script>
</body>