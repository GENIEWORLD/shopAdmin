<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
/******************************
 * 뒤로가기 제어
 ******************************/
if("<c:out value="${param.noHistoryBack}" />" == "Y"){
    history.pushState(null, null, location.href);
    
    window.onpopstate = function(event) {
        window.history.forward();
    };
}
</script>
<script>
$(function(){
    // Logout
    goLogout = function(){
        location.replace("<c:out value="${serverDomain}" />/login/logout.do");
    };
});
</script>
<!-- css style -->
<script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/assets/js/custom.js"></script>

<!-- 개발 -->
<script src="/js/common.js"></script>
<script src="/js/jquery.ajax.js"></script>
<script src="/js/jquery.cookie.js"></script>
<script src="/js/jquery.validate.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/jquery.datepicker.extend.js"></script>