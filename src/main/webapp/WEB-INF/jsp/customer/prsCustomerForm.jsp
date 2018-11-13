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
            <div class="well">
                <form name="dataForm" id="dataForm" method="post">
                    <input type="hidden" name="MEM_MST_LVL" id="MEM_MST_LVL" value="<c:out value="${Code.CUSTOMER_PROSPECT}"/>" />
                    <input type="hidden" name="MEM_MST_GFT" id="MEM_MST_GFT" value="" />
                    <fieldset class="form-horizontal">
                        <legend><spring:message code="common.btn.create" /></legend>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.member.no" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="MEM_MST_CD" class="form-control" value="" maxlength="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.name" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="MEM_MST_NM" class="form-control" value="" maxlength="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.designer" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="ADM_MST_ID" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${designerList}" varStatus="i">
                                    <option value="<c:out value="${row.ADM_MST_ID}" />"><c:out value="${row.ADM_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.hp" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="MEM_MST_TEL" class="form-control" value="" maxlength="20"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.wedding.date" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="MEM_MST_WED" class="form-control datepicker" value="" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.visit.date" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="MEM_MST_VST" class="form-control datepicker" value="<c:out value="${today }"/>" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="STR_MST_IDX" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${storeList}" varStatus="i">
                                    <option value="<c:out value="${row.STR_MST_IDX}" />"><c:out value="${row.STR_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.vendor" /></label>
                            <div class="col-lg-8 input-group">
                                <select name="COM_INF_IDX" class="form-control">
                                    <option value=""><spring:message code="common.title.check" /></option>
                                    <c:forEach var="row" items="${vendorList}" varStatus="i">
                                    <option value="<c:out value="${row.COM_INF_IDX}" />"><c:out value="${row.COM_INF_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.gift" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="checkbox">
                                    <p>
                                        <label><spring:message code="common.title.gift.set" /> : </label>
                                        <c:forEach var="row" items="${codes.GIFT_KIND_SET}" varStatus="i">
                                        <label><input type="checkbox" name="GIFT_KIND_SET" value="<c:out value="${row.CMN_COM_IDX}" />"/><c:out value="${row.CMN_COM_NM}" /></label>
                                        </c:forEach>
                                    </p>
                                    <p>
                                        <label><spring:message code="common.title.cuffs" /> : </label>
                                        <c:forEach var="row" items="${codes.GIFT_KIND_CUFFS}" varStatus="i">
                                        <label><input type="checkbox" name="GIFT_KIND_CUFFS" value="<c:out value="${row.CMN_COM_IDX}" />"/><c:out value="${row.CMN_COM_NM}" /></label>
                                        </c:forEach>
                                    </p>
                                    <p>
                                        <label>&nbsp;</label>
                                        <label><input type="checkbox" name="GIFT_KIND_SOCKS" value="<c:out value="${Code.GIFT_KIND_SOCKS}" />" /><spring:message code="common.title.socks" /></label>
                                        <label><input type="checkbox" name="GIFT_KIND_ETC" value="<c:out value="${Code.GIFT_KIND_ETC}" />" /><spring:message code="common.title.etc" /></label>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.possible" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="MEM_MST_RAT" value="<c:out value="${Code.CUSTOMER_RAT_R}" />"/><img src="/img/icon/RAT_<c:out value="${Code.CUSTOMER_RAT_R}"/>.png" /></label>
                                    <label><input type="radio" name="MEM_MST_RAT" value="<c:out value="${Code.CUSTOMER_RAT_Y}" />"/><img src="/img/icon/RAT_<c:out value="${Code.CUSTOMER_RAT_Y}"/>.png" /></label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.pickup.possible" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="MEM_MST_GFT_YN" value="Y" />Y</label>
                                    <label><input type="radio" name="MEM_MST_GFT_YN" value="N" />N</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="textArea" class="col-lg-2 control-label"><spring:message code="common.title.note" /></label>
                            <div class="col-lg-8 input-group">
                                <textarea class="form-control" rows="3" name="MEM_MST_CSL" maxlength="500"></textarea>
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list" /></a>
                                <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="searchForm" id="searchForm">
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage}"/>" />
<input type="hidden" name="searchType" value="name"/>
<input type="hidden" name="searchWoard" value="<c:out value="${commandMap.searchWoard}"/>" />
<input type="hidden" name="viewChoices" value="<c:out value="${commandMap.viewChoices}"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm")
    , $dataForm = $("#dataForm");

    // 폼체크
    $dataForm.validate({
        rules: {
            MEM_MST_CD : {required:true},
            MEM_MST_NM : {required:true},
            ADM_MST_ID : {required:true},
            MEM_MST_TEL : {required:true},
            MEM_MST_WED : {required:true},
            MEM_MST_VST : {required:true},
            STR_MST_IDX : {required:true},
            COM_INF_IDX : {required:true},
            MEM_MST_RAT : {required:true},
            MEM_MST_GFT_YN : {required:true}
        },
        messages :{
            MEM_MST_CD : {required:"<spring:message code="common.title.member.no" /><spring:message code="common.validate.input" />"},
            MEM_MST_NM : {required:"<spring:message code="common.title.name" /><spring:message code="common.validate.input" />"},
            ADM_MST_ID : {required:"<spring:message code="common.title.designer" /><spring:message code="common.validate.select" />"},
            MEM_MST_TEL : {required:"<spring:message code="common.title.hp" /><spring:message code="common.validate.input" />"},
            MEM_MST_WED : {required:"<spring:message code="common.title.wedding.date" /><spring:message code="common.validate.select" />"},
            MEM_MST_VST : {required:"<spring:message code="common.title.visit.date" /><spring:message code="common.validate.select" />"},
            STR_MST_IDX : {required:"<spring:message code="common.title.shop" /><spring:message code="common.validate.select" />"},
            COM_INF_IDX : {required:"<spring:message code="common.title.vendor" /><spring:message code="common.validate.select" />"},
            MEM_MST_RAT : {required:"<spring:message code="common.title.possible" /><spring:message code="common.validate.select" />"},
            MEM_MST_GFT_YN : {required:"<spring:message code="common.title.pickup.possible" /><spring:message code="common.validate.select" />"}
        }
    });

    // 저장
    goRegist = function(){
        if($dataForm.valid()){
            if(confirm("<spring:message code="common.alert.confirm.save" />")){
                var memMstGft = "";
                // 선물 set
                $.each($("input[name=GIFT_KIND_SET]"), function(idx, obj){
                    if($(obj).is(":checked")){
                        if(memMstGft != ""){
                            memMstGft = memMstGft + "," + $(obj).val();
                        }else{
                            memMstGft = $(obj).val();;
                        }
                    }
                })

                // 커프스
                $.each($("input[name=GIFT_KIND_CUFFS]"), function(idx, obj){
                    if($(obj).is(":checked")){
                        if(memMstGft != ""){
                            memMstGft = memMstGft + "," + $(obj).val();
                        }else{
                            memMstGft = $(obj).val();
                        }
                    }
                })

                // 양말
                if($("input[name=GIFT_KIND_SOCKS]").is(":checked")){
                    if(memMstGft != ""){
                        memMstGft = memMstGft + "," + $("input[name=GIFT_KIND_SOCKS]").val();
                    }else{
                        memMstGft = $("input[name=GIFT_KIND_SOCKS]").val();
                    }
                }

                // 기타
                if($("input[name=GIFT_KIND_ETC]").is(":checked")){
                    if(memMstGft != ""){
                        memMstGft = memMstGft + "," + $("input[name=GIFT_KIND_ETC]").val();
                    }else{
                        memMstGft = $("input[name=GIFT_KIND_ETC]").val();
                    }
                }

                $("#MEM_MST_GFT").val(memMstGft);

                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/customer/prsCustomerRegist.do", "method":"post", "target":"_self"}).submit();
            }
        }
    };

    // 목록
    goList = function(){
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/customer/prsCustomerList.do", "method":"post", "target":"_self"}).submit();
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>,