<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%-- head 시작 --%>
<%@ include file="/WEB-INF/jsp/include/head.jsp" %>
<%-- // head 종료 --%>
</head>
<body>
<div class="container">
    <div class="page-header">
        <div class="row">
            <div class="col-lg-10">
                <h1><spring:message code="login.page.title" /></h1>
            </div>
        </div>
    
        <div class="row">
            <div class="col-lg-10">
                <div class="well">
                    <form name="dataForm" id="dataForm" method="post" class="form-horizontal">
                    <fieldset>
                    <legend>Account</legend>
                        <div class="form-group text-right">
                            <div class="col-lg-10">
                                <a href="<c:out value="${serverSslDomain}" />/login/login.do?lang=ko"><img src="<c:out value="${serverSslDomain}" />/img/common/kr.png"/></a>
                                <a href="<c:out value="${serverSslDomain}" />/login/login.do?lang=ch"><img src="<c:out value="${serverSslDomain}" />/img/common/cn.png"/></a>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2">ID</label>
                            <div class="col-lg-8">
                                <input type="text" name="adminId" id="adminId" value="sksji900" class="form-control" placeholder="ID">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2">Password</label>
                            <div class="col-lg-8">
                                <input type="password" name="adminPw" id="adminPw" value="didwo602" class="form-control" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-lg-10">
                                <a href="javascript:goLogin();" class="btn btn-primary btn-lg">Login</a>
                            </div>
                        </div>
                    </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- footer 종료 --%>
</div>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $frm = $("#dataForm");

    goLogin = function(){
        if($frm.valid()){
            $frm.attr({"action":"<c:out value="${serverSslDomain}" />/login/loginProc.do", "target":"_self", "method":"post"}).submit();
        }
    };

    // 폼체크
    $frm.validate({
        rules: {
            adminId : {required:true},
            adminPw : {required:true}
        },
        messages :{
            adminId : {required:"<spring:message code="login.proc.login_id_invalid" />" },
            adminPw : {required:"<spring:message code="login.proc.login_pw_invalid" />"}
        }
    });

    // 엔터이벤트
    $("#adminId, #adminPw").on("keydown", function(e){
        if(e.keyCode == 13){
            goLogin();  
            return false;
        }
    });
});
</script>
<%-- // script 종료 --%>
</body>
</html>