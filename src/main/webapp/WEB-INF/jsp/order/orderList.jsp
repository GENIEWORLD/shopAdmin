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
                <h2 id="typography"><spring:message code="gnb.menu3.title" /></h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header"><h3>Search</h3></div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <form name="searchForm" id="searchForm" class="form-horizontal">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label for="searchOrdMstGivYn0" class="col-lg-2 control-label"><spring:message code="common.title.give" /></label>
                            <div class="col-lg-8 input-group">
                                <div class="radio">
                                    <label><input type="radio" name="searchOrdMstGivYn" id="searchOrdMstGivYn0" value="" <c:if test="${empty commandMap.searchOrdMstGivYn }">checked="checked"</c:if>><spring:message code="common.title.all" /></label>
                                    <label><input type="radio" name="searchOrdMstGivYn" id="searchOrdMstGivYn1" value="Y" <c:if test="${commandMap.searchOrdMstGivYn eq 'Y'}">checked="checked"</c:if>><spring:message code="common.title.give" /></label>
                                    <label><input type="radio" name="searchOrdMstGivYn" id="searchOrdMstGivYn2" value="N" <c:if test="${commandMap.searchOrdMstGivYn eq 'N'}">checked="checked"</c:if>><spring:message code="common.title.non.give" /></label>
                                </div>
                            </div>
                        </div>                    
                        <div class="form-group">
                            <label for="searchMemMstCd" class="col-lg-2 control-label"><spring:message code="common.title.member.no" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchMemMstCd" id="searchMemMstCd" class="form-control" value="<c:out value="${commandMap.searchMemMstCd }"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchMemMstNm" class="col-lg-2 control-label"><spring:message code="common.title.member.name" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchMemMstNm" id="searchMemMstNm" class="form-control" value="<c:out value="${commandMap.searchMemMstNm }"/>" />
                            </div>
                        </div>    
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <div class="form-group">
                            <label for="searchOrdShop" class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchOrdShop" id="searchOrdShop">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <c:forEach var="row" items="${storeList}" varStatus="i">
                                    <option value="<c:out value="${row.STR_MST_IDX}" />" <c:if test="${row.STR_MST_IDX eq commandMap.searchOrdShop}"> selected="selected"</c:if>><c:out value="${row.STR_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        </c:if> 
                        <div class="form-group">
                            <label for="searchOrdState" class="col-lg-2 control-label"><spring:message code="common.title.state" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchOrdState" id="searchOrdState">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <c:forEach var="row" items="${codes.ORDER}" varStatus="i">
                                    <c:if test="${row.CMN_COM_IDX ne Code.ORDER_STATE_COMPLETE }">
                                    <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq commandMap.searchOrdState}"> selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:if>
                                    </c:forEach>
                                </select>                                     
                            </div>
                        </div> 
                        <div class="form-group text-right">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a class="btn btn-success" href="javascript:goSearch();"><spring:message code="common.btn.search" /></a>
                                <a class="btn btn-default" href="javascript:goExcelDown();"><spring:message code="common.btn.exceldown" /></a>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>
    <form name="changeForm" id="changeForm">
        <div class="row">
            <div class="col-lg-10">
                <div class="page-header">
                    <h3><spring:message code="common.btn.list" /></h3>
                    <div class="form-group text-right">
                        <a class="btn btn-primary" href="javascript:goRegist();"><spring:message code="common.btn.create" /></a>
                    </div>
                </div>
            </div>
            <div class="col-lg-10 table-responsive">
                <table class="table table-striped table-hover ">
                    <thead>
                        <tr>
                            <th><div class="checkbox"><label><input type="checkbox" class="checkAll"></label></div></th>
                            <th><spring:message code="common.title.member.no" /></th>
                            <th><spring:message code="common.title.name" /></th>
                            <th><spring:message code="common.title.hp" /></th>
                            <th><spring:message code="common.title.designer" /></th>
                            <th><spring:message code="common.title.order.count" /></th>
                            <th><spring:message code="common.title.service" /></th>
                            <th><spring:message code="common.title.order.date" /></th>
                            <th><spring:message code="common.title.release.date" /></th>
                            <th><spring:message code="common.title.pickup.date" /></th>
                            <th><spring:message code="common.title.state" /></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty list }">
                        <c:forEach var="row" items="${list }" varStatus="i">
                         <tr <c:if test="${row.ORD_MST_GIV_YN == 'Y' }"> class="danger" </c:if>>
                            <td>                      
                                <div class="checkbox">
                                    <label>
                                    <input type="checkbox" class="checkRow" name="ORD_MST_IDX" value="<c:out value="${row.ORD_MST_IDX }" />">
                                    </label>
                                </div>
                          </td>
                            <td><a href="javascript:goEdit('<c:out value="${row.ORD_MST_IDX }" />');"><c:out value="${row.MEM_MST_CD }"/></a></td>
                            <td><c:out value="${row.MEM_MST_NM }"/></td>
                            <td><c:out value="${row.MEM_MST_TEL }"/></td>
                            <td><c:out value="${row.DSN_NM }"/></td>
                            <td>
                                <c:set var="isFirst" value="${true }" />
                                <c:if test="${row.ORD_MST_JK gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>JK :<c:out value="${row.ORD_MST_JK }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_P gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>P :<c:out value="${row.ORD_MST_P }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_V gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>V :<c:out value="${row.ORD_MST_V }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_Y gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>Y :<c:out value="${row.ORD_MST_Y }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_C gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>C :<c:out value="${row.ORD_MST_C }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_SC gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>SC :<c:out value="${row.ORD_MST_SC }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_SH gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>SH :<c:out value="${row.ORD_MST_SH }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_O gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>O :<c:out value="${row.ORD_MST_O }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                            </td>
                            <td>
                                <c:set var="isFirst" value="${true }" />
                                <c:if test="${row.ORD_MST_NKT gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>T :<c:out value="${row.ORD_MST_NKT }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_BWT gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>B :<c:out value="${row.ORD_MST_BWT }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${row.ORD_MST_HKC gt 0 }">
                                <c:if test="${not isFirst }">, </c:if>H :<c:out value="${row.ORD_MST_HKC }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                                <c:if test="${not empty row.ORD_MST_SVC_ETC }">
                                <c:if test="${not isFirst }">, </c:if>ETC :<c:out value="${row.ORD_MST_SVC_ETC }"/>
                                <c:if test="${isFirst }"><c:set var="isFirst" value="${false }"/></c:if>
                                </c:if>
                            </td>
                            <td><c:out value="${row.ORD_MST_REG_DT }"/></td>
                            <td><c:out value="${row.ORD_MST_RLS_DT }"/></td>
                            <td><c:out value="${row.ORD_MST_PIK_DT }"/></td>
                            <td><c:out value="${row.ORD_MST_ORD }"/></td>
                        </tr>
                        </c:forEach>
                        </c:if>
                        <c:if test="${empty list }">
                        <tr><td colspan="12" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    
        <div class="row">
            <div class="col-lg-10 text-center">
                <ul class="pagination">
                    <ui:paging paging="${paging}" jsFunction="goPage"/>
                </ul>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="form-group input-group">
                <span class="input-group-addon"><spring:message code="common.title.state"/></span>
                <select name="ORD_MST_ORD_STE" id="ORD_MST_ORD_STE" class="form-control">
                    <option value=""><spring:message code="common.title.order" /><spring:message code="common.title.state" /></option>
                    <c:forEach var="row" items="${codes.ORDER}" varStatus="i">
                    <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                    </c:forEach>
                </select>
                <span class="input-group-btn">
                    <a class="btn btn-info" href="javascript:goChange();"><spring:message code="common.btn.save" /></a>
                </span>
            </div>
        </div>
        <div class="form-group text-right">
            <div class="col-lg-5 col-lg-offset-2">
                <a class="btn btn-primary" href="javascript:goRegist();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
    </form>
<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>


<form name="dataForm" id="dataForm">
<input type="hidden" name="ORD_MST_IDX" value="" />
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
<input type="hidden" name="searchOrdMstGivYn" value="<c:out value="${commandMap.searchOrdMstGivYn }"/>" />
<input type="hidden" name="searchMemMstCd" value="<c:out value="${commandMap.searchMemMstCd }"/>" />
<input type="hidden" name="searchMemMstNm" value="<c:out value="${commandMap.searchMemMstNm }"/>" />
<input type="hidden" name="searchOrdState" value="<c:out value="${commandMap.searchOrdState }"/>" />
<input type="hidden" name="searchOrdShop" value="<c:out value="${commandMap.searchOrdShop }"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm")
        , $dataForm = $("#dataForm")
        , $changeForm = $("#changeForm")
        ;
    // 검색 엔터 이벤트 
    $searchForm.find("input").not(".datepicker").keydown(function (e) {
        if(e.keyCode == 13) {
            goSearch();
        }
    });
    // 검색
    goSearch = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/order/orderList.do", "method":"post", "target":"_self"}).submit();
    };
    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/order/orderList.do", "method":"post", "target":"_self"}).submit();
    };
    // 등록페이지 이동
    goRegist = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/order/orderForm.do", "method":"post", "target":"_self"}).submit();
    };
    // 수정페이지 이동
    goEdit = function (ORD_MST_IDX) {
        $dataForm.find("input[name='ORD_MST_IDX']").val(ORD_MST_IDX);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/order/orderEdit.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 주문상태변경 이동
    goChange = function () {
        if ($changeForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $changeForm.attr({"action":"<c:out value="${serverDomain}"/>/order/updateOrderState.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };    
    
    // 엑셀다운
    goExcelDown = function(type){
        $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/order/orderListExcelDownload.do", "method":"post", "target":"_self"}).submit();
    };    
    
    //체크박스 전체선택
    $.checkBoxSelect("checkAll", "checkRow");
    
    // 주문 입력값 체크
    $changeForm.validate({
        rules: {
        	ORD_MST_ORD_STE: {required:true}
           ,ORD_MST_IDX: {required:true}
        }
        , messages: {
        	ORD_MST_ORD_STE: {required:"<spring:message code="common.title.order" /><spring:message code="common.title.state" /><spring:message code="common.validate.select" /> "}
           ,ORD_MST_IDX: {required:"<spring:message code="common.title.order" /><spring:message code="common.validate.select" /> "}
        }
    });    
});
</script>
<%-- // script 종료 --%>
</body>
</html>