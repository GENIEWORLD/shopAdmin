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
    <div class="bs-docs-section">
        <div class="row">
            <div class="col-lg-12">
                <div class="page-header">
                    <h1 id="forms">Login</h1>
                </div>
            </div>
        </div>
    
        <div class="row">
            <div class="col-lg-6">
                <div class="well">
                    <form class="form-horizontal">
                    <fieldset>
                    <legend>Account</legend>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">ID</label>
                            <div class="col-lg-10">
                                <input type="text" class="form-control" placeholder="ID">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Password</label>
                            <div class="col-lg-10">
                                <input type="password" class="form-control" placeholder="Password">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a href="javascript:;" class="btn btn-primary">Login</a>
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

});
</script>
<%-- // script 종료 --%>
</body>
</html>