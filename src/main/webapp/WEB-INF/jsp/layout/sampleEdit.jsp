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

    <div class="page-header">
        <div class="row">
            <div class="col-lg-8 col-md-7 col-sm-6">
                <h1>고객관리</h1>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-6">
                <div class="well">
                    <form class="form-horizontal">
                    <fieldset>
                    <legend>상세/수정</legend>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">이름</label>
                            <div class="col-lg-10">
                                <input type="text" class="form-control" value="홍길동">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">성별</label>
                            <div class="col-lg-10">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1">
                                          남
                                    </label>
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2" checked="checked">
                                          여
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="select" class="col-lg-2 control-label">자녀수</label>
                            <div class="col-lg-10">
                                <select class="form-control" id="select">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword" class="col-lg-2 control-label">취미</label>
                            <div class="col-lg-10">
                                <div class="checkbox">
                                <label><input type="checkbox" name="optiohCheckbox" checked="checked"> 취미1</label>
                                <label><input type="checkbox" name="optiohCheckbox" checked="checked"> 취미2</label>
                                <label><input type="checkbox" name="optiohCheckbox"> 취미3</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="textArea" class="col-lg-2 control-label">비고</label>
                            <div class="col-lg-10">
                                <textarea class="form-control" rows="3" id="textArea">비고</textarea>
                                <span class="help-block">최대 1000자</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a href="javascript:;" class="btn btn-primary">목록</a>
                                <a href="javascript:;" class="btn btn-info">저장</a>
                                <a href="javascript:;" class="btn btn-danger">삭제</a>
                            </div>
                        </div>
                    </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
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