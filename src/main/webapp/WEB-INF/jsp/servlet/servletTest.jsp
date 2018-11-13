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
                <h1>servlet Test</h1>
            </div>
        </div>
    
        <div class="row">
            <div class="col-lg-10">
                <div class="well">
                    <form name="servletForm" id="servletForm" method="post" class="form-horizontal">
                    <fieldset>
                    <legend>servlet Test</legend>
                        <div class="form-group">
                            <label class="col-lg-2">Random</label>
                            <div class="col-lg-8">
                                <input type="text" name="testInput" id="testInput" value="">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-10">
                                <a id="btnReqRandomNumber" href="javascript:goReqRandomNumber();" class="btn btn-primary btn-lg" style="disaplay:none";>reqRandomNumber</a>
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

<%-- servlet Test --%>
<iframe name="servletFrame" id="servletFrame" height="0" width="0" src="/servletTest"></iframe>
<script>
$(function(){
    // servlet Test
    goReqRandomNumber = function(){
        $("#btnReqRandomNumber").attr("disabled", true);
        $("#testInput").val("");
        $("#servletFrame").contents().find("#randomNum").remove();
        $("#servletForm").attr({"action":"<c:out value="${serverSslDomain}" />/servletTest", "target":"servletFrame", "method":"post"}).submit();
        servletValueStart();
    };
    
    // servlet Test Value
    servletValueStart();
    function servletValueStart(){
        var randomNum = $("#servletFrame").contents().find("#randomNum").val();
        if(typeof randomNum != "undefined"){
            $("#testInput").val($("#servletFrame").contents().find("#randomNum").val());
            $("#btnReqRandomNumber").attr("disabled", false);
        }else{
            setTimeout(servletValueStart, 1000);
        }
    };
});
</script>
<%-- --%>
</body>
</html>