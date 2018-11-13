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
                <h2><spring:message code="common.btn.order.add" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchGivYn" value="<c:out value="${commandMap.searchGivYn }"/>" />
    <input type="hidden" name="searchMemMstCd" value="<c:out value="${commandMap.searchMemMstCd }"/>" />
    <input type="hidden" name="searchMemMstNm" value="<c:out value="${commandMap.searchMemMstNm }"/>" />
    <input type="hidden" name="searchOrdState" value="<c:out value="${commandMap.searchOrdState }"/>" />
    <input type="hidden" name="searchOrdShop" value="<c:out value="${commandMap.searchOrdShop }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <fieldset>
                    <legend><spring:message code="common.btn.create" /></legend>
                    <div class="form-group">
                        <label for="MEM_MST_IDX" class="col-lg-2 control-label"><spring:message code="common.title.member.no" /></label>
                        <div class="col-lg-2">
                            <input type="text" name="MEM_MST_CD" id="MEM_MST_CD" class="form-control" value="" readonly="readonly"/>
                            <input type="hidden" name="MEM_MST_IDX" id="MEM_MST_IDX" class="form-control" value=""/>
                            <input type="hidden" name="MEM_MST_LVL" id="MEM_MST_LVL" class="form-control" value=""/>
                        </div>
                        <div class="col-lg-1">
                            <a href="javascript:searchMember();" class="btn btn-primary"><spring:message code="common.btn.search" /></a>
                        </div>                        
                        <label for="ADM_MST_ID" class="col-lg-2 control-label"><spring:message code="common.title.designer" /></label>
                        <div class="col-lg-3">
                            <select name="ADM_MST_ID" id="ADM_MST_ID" class="form-control">
                                <option value=""><spring:message code="common.title.check" /></option>
                                <c:forEach var="row" items="${designerList}" varStatus="i">
                                <option value="<c:out value="${row.ADM_MST_ID}" />" <c:if test="${row.ADM_MST_ID eq orderInfo.ADM_MST_ID}">selected="selected"</c:if>><c:out value="${row.ADM_MST_NM}" /></option>
                                </c:forEach>
                            </select>                            
                            
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="MEM_MST_NM" class="col-lg-2 control-label"><spring:message code="common.title.name" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="MEM_MST_NM" id="MEM_MST_NM" class="form-control" value="" readonly="readonly"/>
                        </div>
                        <label for="ORD_MST_WDP" class="col-lg-2 control-label"><spring:message code="common.title.wedding.planne" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_WDP" id="ORD_MST_WDP" class="form-control" value="" maxlength="20"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="MEM_MST_TEL" class="col-lg-2 control-label"><spring:message code="common.title.hp" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="MEM_MST_TEL" id="MEM_MST_TEL" class="form-control" value="" readonly="readonly"/>
                        </div>
                        <label for="MEM_MST_WED" class="col-lg-2 control-label"><spring:message code="common.title.wedding.date" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="MEM_MST_WED" id="MEM_MST_WED" class="form-control" value="" readonly="readonly"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="COM_INF_IDX" class="col-lg-2 control-label"><spring:message code="common.title.vendor" /></label>
                        <div class="col-lg-3">
                            <select name="COM_INF_IDX" id="COM_INF_IDX" class="form-control">
                                <option value=""><spring:message code="common.title.check" /></option>
                                <c:forEach var="row" items="${vendorList}" varStatus="i">
                                <option value="<c:out value="${row.COM_INF_IDX}" />" <c:if test="${row.COM_INF_IDX eq orderInfo.COM_INF_IDX}"> selected="selected"</c:if>><c:out value="${row.COM_INF_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                        <label for="STR_MST_IDX" class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                        <div class="col-lg-3">
                            <select class="form-control" name="STR_MST_IDX" id="STR_MST_IDX">
                                <c:forEach var="row" items="${storeList}" varStatus="i">
                                <option value="<c:out value="${row.STR_MST_IDX}" />" <c:if test="${row.STR_MST_IDX eq orderInfo.STR_MST_IDX}"> selected="selected"</c:if>><c:out value="${row.STR_MST_NM}" /></option>
                                </c:forEach>
                            </select>                            
                        </div>                        
                    </div>     
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.order.count" /></label>
                        <label for="ORD_MST_JK" class="col-lg-1 control-label">JK</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_JK" id="ORD_MST_JK" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_P" class="col-lg-1 control-label">P</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_P" id="ORD_MST_P" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_V" class="col-lg-1 control-label">V</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_V" id="ORD_MST_V" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_Y" class="col-lg-1 control-label">Y</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_Y" id="ORD_MST_Y" class="form-control number" value="0" maxlength="2"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label"></label>
                        <label for="ORD_MST_C" class="col-lg-1 control-label">C</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_C" id="ORD_MST_C" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_SC" class="col-lg-1 control-label">SC</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_SC" id="ORD_MST_SC" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_SH" class="col-lg-1 control-label">SH</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_SH" id="ORD_MST_SH" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_O" class="col-lg-1 control-label">O</label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_O" id="ORD_MST_O" class="form-control number" value="0" maxlength="2"/>
                        </div>                        
                    </div> 
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.service" /></label>
                        <label for="ORD_MST_NKT" class="col-lg-1 control-label"><spring:message code="common.title.necktie" /></label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_NKT" id="ORD_MST_NKT" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_BWT" class="col-lg-1 control-label"><spring:message code="common.title.bow.tie" /></label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_BWT" id="ORD_MST_BWT" class="form-control number" value="0" maxlength="2"/>
                        </div>
                        <label for="ORD_MST_HKC" class="col-lg-1 control-label"><spring:message code="common.title.haenggeochip" /></label>
                        <div class="col-lg-1">
                            <input type="text" name="ORD_MST_HKC" id="ORD_MST_HKC" class="form-control number" value="0" maxlength="2"/>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label class="col-lg-2 control-label"></label>
                        <label for="ORD_MST_SVC_ETC" class="col-lg-1 control-label"><spring:message code="common.title.etc" /></label>
                        <div class="col-lg-7">
                            <input type="text" name="ORD_MST_SVC_ETC" id="ORD_MST_SVC_ETC" class="form-control" value="" maxlength="20"/>
                        </div>                        
                    </div>                     
                    <div class="form-group">
                        <label for="ORD_MST_ORD_DT" class="col-lg-2 control-label"><spring:message code="common.title.order.date" /></label>
                        <div class="col-lg-3 input-group">
                            <input type="text" name="ORD_MST_ORD_DT" class="form-control datepicker" value="<c:out value="${empty commandMap.ORD_MST_ORD_DT ? today : commandMap.ORD_MST_ORD_DT }" />" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ORD_MST_RLS_DT" class="col-lg-2 control-label"><spring:message code="common.title.release.date" /></label>
                        <div class="col-lg-3 input-group">
                            <input type="text" name="ORD_MST_RLS_DT" class="form-control datepicker" value="<c:out value="${commandMap.ORD_MST_RLS_DT}" />" readonly="readonly"/>
                        </div>                        
                    </div>   
                    <div class="form-group">
                        <label for="ORD_MST_PIK_DT" class="col-lg-2 control-label"><spring:message code="common.title.pickup.date" /></label>
                        <div class="col-lg-3 input-group">
                            <input type="text" name="ORD_MST_PIK_DT" class="form-control datepicker" value="<c:out value="${commandMap.ORD_MST_PIK_DT}" />" readonly="readonly"/>
                        </div>                        
                    </div>  
                    <div class="form-group">
                        <label for="ORD_MST_ORD_STE" class="col-lg-2 control-label"><spring:message code="common.title.state" /></label>
                        <div class="col-lg-3">
                                <select class="form-control" name="ORD_MST_ORD_STE" id="ORD_MST_ORD_STE">
                                    <c:forEach var="row" items="${codes.ORDER}" varStatus="i">
                                    <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq commandMap.ORD_MST_ORD_STE}"> selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:forEach>
                                </select>                                     
                        </div>                        
                    </div>                      
                    <div class="form-group">
                        <label for="ORD_MST_SAL" class="col-lg-2 control-label"><spring:message code="common.title.selling.price" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_SAL" id="ORD_MST_SAL" class="form-control number" value=""  maxlength="9"/>
                        </div>
                        <label for="ORD_MST_BAL" class="col-lg-2 control-label"><spring:message code="common.title.balance" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_BAL" id="ORD_MST_BAL" class="form-control number" value=""  maxlength="9"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="ORD_MST_GIV_YN" class="col-lg-2 control-label"><spring:message code="common.title.give" /></label>
                        <div class="col-lg-3">
                            <div class="radio">
                                <label><input type="radio" name="ORD_MST_GIV_YN" value="N" checked="checked"/><spring:message code="common.title.non.give" /></label>
                                <label><input type="radio" name="ORD_MST_GIV_YN" value="Y" /><spring:message code="common.title.give" /></label>                                
                            </div>
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.order.type" /></label>
                    </div>                       
                    <div class="form-group">
                        <label for="ORD_MST_CSH" class="col-lg-2 control-label"><spring:message code="common.title.cash" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_CSH" id="ORD_MST_CSH" class="form-control number" value="0"  maxlength="9"/>
                        </div>
                        <label for="ORD_MST_CRD" class="col-lg-2 control-label"><spring:message code="common.title.card" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_CRD" id="ORD_MST_CRD" class="form-control number" value="0"  maxlength="9"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="ORD_MST_WXN" class="col-lg-2 control-label"><spring:message code="common.title.weixin" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_WXN" id="ORD_MST_WXN" class="form-control number" value="0"  maxlength="9"/>
                        </div>
                        <label for="ORD_MST_ZFU" class="col-lg-2 control-label"><spring:message code="common.title.jjeupu" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_ZFU" id="ORD_MST_ZFU" class="form-control number" value="0"  maxlength="9"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="ORD_MST_DZH" class="col-lg-2 control-label"><spring:message code="common.title.ttajung" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_DZH" id="ORD_MST_DZH" class="form-control number" value="0"  maxlength="9"/>
                        </div>
                        <label for="ORD_MST_HBH" class="col-lg-2 control-label"><spring:message code="common.title.honbooe" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_HBH" id="ORD_MST_HBH" class="form-control number" value="0"  maxlength="9"/>
                        </div>                        
                    </div>
                    <div class="form-group">
                        <label for="ORD_MST_PAY_ETC" class="col-lg-2 control-label"><spring:message code="common.title.etc" /></label>
                        <div class="col-lg-3">
                            <input type="text" name="ORD_MST_PAY_ETC" id="ORD_MST_PAY_ETC" class="form-control" value="0"  maxlength="9"/>
                        </div>
                    </div>                    
                    <div class="form-group">
                        <label for="ORD_MST_ETC" class="col-lg-2 control-label"><spring:message code="common.title.note" /></label>
                        <div class="col-lg-8">
                            <textarea name="ORD_MST_ETC" id="ORD_MST_ETC" class="form-control" rows="5" maxlength="500"></textarea>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list"/></a>
                            <a href="javascript:goRegist();" class="btn btn-info"><spring:message code="common.btn.save"/></a>
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

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){

    var $dataForm = $("#dataForm")
       , $searchForm = $("#searchForm");
    
    // 회원 조회 팝업
    searchMember = function () {
        window.open('','popup','width=800, height=800,top=0, left=0, scrollbars=yes, status=no, toolbar=no, resizable=no, location=no, menu=no');
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/order/memberSearch.do", "method":"post", "target":"popup"}).submit();
    };
    
    setMemberInfo = function (MEM_MST_IDX, MEM_MST_CD, MEM_MST_NM, MEM_MST_TEL, MEM_MST_WED, ADM_MST_ID, COM_INF_IDX, MEM_MST_LVL ) {
    	$("#MEM_MST_IDX").val(MEM_MST_IDX);
        $("#MEM_MST_CD").val(MEM_MST_CD);
        $("#MEM_MST_NM").val(MEM_MST_NM);
        $("#MEM_MST_TEL").val(MEM_MST_TEL);
        $("#MEM_MST_WED").val(MEM_MST_WED);
        $("#ADM_MST_ID").val(ADM_MST_ID);
        $("#COM_INF_IDX").val(COM_INF_IDX);
        $("#MEM_MST_LVL").val(MEM_MST_LVL);
    };

    // 주문 목록 이동
    goList = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/order/orderList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 주문 입력값 체크
    $dataForm.validate({
        rules: {
        	MEM_MST_CD: {required:true}
            , ADM_MST_ID: {required:true}
            , ORD_MST_WDP: {required:false}
            , COM_INF_IDX: {required:true}
            , STR_MST_IDX: {required:true}
            , ORD_MST_ORD_DT: {required:true}
//             , ORD_MST_RLS_DT: {required:true}
//             , ORD_MST_PIK_DT: {required:true}
            , ORD_MST_ORD_STE: {required:true}
            , ORD_MST_SAL: {required:true}
            , ORD_MST_BAL: {required:false}
            , ORD_MST_GIV_YN: {required:true}
        }
        , messages: {
        	MEM_MST_CD: {required:"<spring:message code="common.title.member.no" /><spring:message code="common.validate.input" /> "}
            , ADM_MST_ID: {required:"<spring:message code="common.title.designer" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_WDP: {required:"<spring:message code="common.title.wedding.planne" /><spring:message code="common.validate.input" /> "}
            , COM_INF_IDX: {required:"<spring:message code="common.title.check" /><spring:message code="common.validate.input" /> "}
            , STR_MST_IDX: {required:"<spring:message code="common.title.shop" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_ORD_DT: {required:"<spring:message code="common.title.order.date" /><spring:message code="common.validate.input" /> "}
//             , ORD_MST_RLS_DT: {required:"<spring:message code="common.title.release.date" /><spring:message code="common.validate.input" /> "}
//             , ORD_MST_PIK_DT: {required:"<spring:message code="common.title.pickup.date" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_ORD_STE: {required:"<spring:message code="common.title.state" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_SAL: {required:"<spring:message code="common.title.selling.price" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_BAL: {required:"<spring:message code="common.title.balance" /><spring:message code="common.validate.input" /> "}
            , ORD_MST_GIV_YN: {required:"<spring:message code="common.title.give" /><spring:message code="common.validate.input" /> "}
            
        }
    });
    
    // 주문 등록
    goRegist = function () {
        if ($dataForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/order/insertOrder.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>