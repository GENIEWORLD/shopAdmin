<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
</head>
<body>
<script>
/* 뒤로가기 방지 */
history.pushState(null, null, location.href);

window.onpopstate = function(event) {
    window.history.forward();
};
</script>
<script type="text/javascript">
    alert("<spring:message code="error.session" />");
    location.href='/';
</script>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- footer 종료 --%>
</body>
</html>