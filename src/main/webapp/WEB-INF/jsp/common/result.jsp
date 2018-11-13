<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
</head>
<body>
<body>
<script>
/* 뒤로가기 방지 */
history.pushState(null, null, location.href);

window.onpopstate = function(event) {
    window.history.forward();
};
</script>
<c:choose>
<c:when test="${!empty closeMsg}">
<script type="text/javascript">
    $(document).ready(function () {
        <c:if test="${not empty closeMsg}">
        alert("<spring:message code="${closeMsg}" />");
        </c:if>
    <c:if test="${!empty parentReload}">
        <c:choose>
            <c:when test="${!empty returnUrl}">
                opener.document.location.href = "<c:out value="${returnUrl}" />";
            </c:when>
            <c:otherwise>
                parent.opener.location.reload();
            </c:otherwise>
        </c:choose>
    </c:if>
    <c:if test="${!empty parentFunction}">
        parent.opener.parentFunction();
    </c:if>    
    
        window.close();
    });
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
    $(document).ready(function () {
        <c:if test="${not empty alertMsg}">
        alert("<spring:message code="${alertMsg}" />");
        </c:if>
        
        <c:if test="${not empty messages}">
        alert("<spring:message code="${messages}" />");
        </c:if>

        <c:if test="${not empty script}">
            <c:out value="${script}" escapeXml="false"/>
        </c:if>
        $("#frmExec").submit();
    });
</script>
<form id="frmExec" name="frmExec" method="${not empty methodType ? methodType : 'post'}" action="${returnUrl}">
<div style="display: none;">
    <input type="hidden" name="noHistoryBack" value="Y" />
    <c:forEach items="${commandMap}" var="item">
        <c:if test="${item.key ne 'BM_IDX' }">
            <c:set var="arrayCnt" value="${fn:indexOf(item.value, 'Ljava.lang.String')}" />

            <c:choose>
                <c:when test="${arrayCnt > 0}">
                     <c:forEach items="${item.value}" var="val">
                        <input type="hidden" id="<c:out value="${item.key }"/>" name="<c:out value="${item.key}"/>" value="<c:out value="${fn:trim(val)}" escapeXml="true"/>"/>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <input type="hidden" id="<c:out value="${item.key }"/>" name="<c:out value="${item.key}"/>" value="<c:out value="${fn:trim(item.value)}" escapeXml="true"/>"/>
                </c:otherwise>
            </c:choose>
    </c:if>
    </c:forEach>
</div>
</form>
</c:otherwise>
</c:choose>
</body>
</html>