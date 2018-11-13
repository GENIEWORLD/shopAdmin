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
            <ul class="nav nav-tabs">
                <li class="active"><a href="javascript:;"><spring:message code="common.btn.list" /></a></li>
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/prsCustomerCalendar.do"><spring:message code="common.btn.calendar" /></a></li>
                <li><a href="<c:out value="${serverSslDomain}"/>/customer/customerProbability.do"><spring:message code="common.btn.probability" /></a></li>
            </ul>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.search" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <form name="searchForm" id="searchForm">
                    <input type="hidden" name="cPage" value="1"/>
                    <input type="hidden" name="viewChoices" value="<c:out value="${commandMap.viewChoices}"/>" />
                    <fieldset class="form-horizontal">
                        <div class="form-group">
                            <label class="col-lg-2 control-label"><spring:message code="common.title.search.woard" /></label>
                            <div class="col-lg-2">
                                <select class="form-control" name="searchType" id="searchType">
                                    <option value="" <c:if test="${empty commandMap.searchType}">selected="selected"</c:if>><spring:message code="common.title.check" /></option>
                                    <option value="name" <c:if test="${commandMap.searchType eq 'name'}">selected="selected"</c:if>><spring:message code="common.title.member.name" /></option>
                                    <option value="no" <c:if test="${commandMap.searchType eq 'no'}">selected="selected"</c:if>><spring:message code="common.title.member.no" /></option>
                                    <option value="designer" <c:if test="${commandMap.searchType eq 'designer'}">selected="selected"</c:if>><spring:message code="common.title.designer" /></option>
                                </select>
                            </div>
                            <div class="col-lg-6">
                                <input type="text" name="searchWoard" id="searchWoard" class="form-control" value="<c:out value="${commandMap.searchWoard}"/>" maxlength="20" />
                            </div>
                        </div>
                        <div class="form-group text-right">
                            <div class="col-lg-10 col-lg-offset-2">
                                <a class="btn btn-success" href="javascript:goSearch();"><spring:message code="common.btn.search" /></a>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>
    </div>

    <div class="row" id="customerList" style="display:none;">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /></h3>
            </div>
            <div class="form-group text-right">
                <div class="col-lg-offset-2">
                    <a class="btn btn-default" href="javascript:goExcelDown();"><spring:message code="common.btn.exceldown" /></a>
                    <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset class="form-horizontal">
                    <div class="form-group">
                        <label class="col-lg-2 control-label"><spring:message code="common.title.check" /><spring:message code="common.btn.view" /></label>
                        <div class="col-lg-8">
                            <div class="checkbox">
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceName"><spring:message code="common.title.member.name" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceHp"><spring:message code="common.title.hp" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceDesigner"><spring:message code="common.title.designer" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceVisit"><spring:message code="common.title.visit.date" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceWedding"><spring:message code="common.title.wedding.date" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceVendor"><spring:message code="common.title.vendor" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoicePossible"><spring:message code="common.title.possible" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoiceGift"><spring:message code="common.title.gift" /></label>
                                <label><input type="checkbox" name="viewChoice" value="viewChoicePickup"><spring:message code="common.title.pickup.possible" /></label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a class="btn btn-success" href="javascript:goChoiceView();"><spring:message code="common.title.check" /><spring:message code="common.btn.view" /></a>
                        </div>
                    </div>
                </fieldset>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center viewChoiceName" style="display:none;"><spring:message code="common.title.member.name" /></th>
                        <th class="text-center viewChoiceHp" style="display:none;"><spring:message code="common.title.hp" /></th>
                        <th class="text-center viewChoiceDesigner" style="display:none;"><spring:message code="common.title.designer" /></th>
                        <th class="text-center viewChoiceVisit" style="display:none;"><spring:message code="common.title.visit.date" /></th>
                        <th class="text-center viewChoiceWedding" style="display:none;"><spring:message code="common.title.wedding.date" /></th>
                        <th class="text-center viewChoiceVendor" style="display:none;"><spring:message code="common.title.vendor" /></th>
                        <th class="text-center viewChoicePossible" style="display:none;"><spring:message code="common.title.possible" /></th>
                        <th class="text-center viewChoiceGift" style="display:none;"><spring:message code="common.title.gift" /></th>
                        <th class="text-center viewChoicePickup" style="display:none;"><spring:message code="common.title.pickup.possible" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${list}" varStatus="i">
                    <tr>
                        <td class="text-center viewChoiceName" style="display:none;">
                            <a href="javascript:goEdit('<c:out value="${row.MEM_MST_IDX}"/>');">
                                <c:out value="${row.MEM_MST_NM}"/>
                            </a>
                        </td>
                        <td class="text-center viewChoiceHp" style="display:none;"><c:out value="${row.MEM_MST_TEL}"/></td>
                        <td class="text-center viewChoiceDesigner" style="display:none;"><c:out value="${row.ADM_MST_NM}"/></td>
                        <td class="text-center viewChoiceVisit" style="display:none;"><c:out value="${row.MEM_MST_VST}"/></td>
                        <td class="text-center viewChoiceWedding" style="display:none;"><c:out value="${row.MEM_MST_WED}"/></td>
                        <td class="text-center viewChoiceVendor" style="display:none;"><c:out value="${row.COM_INF_NM}"/></td>
                        <td class="text-center viewChoicePossible" style="display:none;"><img src="/img/icon/RAT_<c:out value="${row.MEM_MST_RAT}"/>.png" /></td>
                        <td class="viewChoiceGift" style="display:none;">
                            <c:if test="${!empty row.MEM_MST_GFT}">
                                <c:set var="giftSetCnt" value="0" />
                                <c:set var="giftCuffsCnt" value="0" />

                                <c:forEach var="set" items="${codes.GIFT_KIND_SET}" varStatus="j">
                                    <c:if test="${fn:indexOf(row.MEM_MST_GFT, set.CMN_COM_IDX) ne -1}">
                                        <c:choose>
                                            <c:when test="${giftSetCnt eq 0}">
                                                <spring:message code="common.title.gift.set" /> : <c:out value="${set.CMN_COM_NM}" />
                                            </c:when>
                                            <c:otherwise>
                                                , <c:out value="${set.CMN_COM_NM}" />
                                            </c:otherwise>
                                        </c:choose>
                                        <c:set var="giftSetCnt" value="${giftSetCnt + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:forEach var="cuffs" items="${codes.GIFT_KIND_CUFFS}" varStatus="j">
                                    <c:if test="${fn:indexOf(row.MEM_MST_GFT, cuffs.CMN_COM_IDX) ne -1}">
                                        <c:choose>
                                            <c:when test="${giftCuffsCnt eq 0}">
                                                <c:if test="${giftSetCnt > 0}"><br/></c:if>
                                                <spring:message code="common.title.cuffs" /> : <c:out value="${cuffs.CMN_COM_NM}" />
                                            </c:when>
                                            <c:otherwise>
                                                , <c:out value="${cuffs.CMN_COM_NM}" />
                                            </c:otherwise>
                                        </c:choose>
                                        <c:set var="giftCuffsCnt" value="${giftCuffsCnt + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_SOCKS) ne -1}">
                                    <c:if test="${giftSetCnt > 0 or giftCuffsCnt > 0}"><br/></c:if>
                                    <spring:message code="common.title.socks" />
                                </c:if>
                                <c:if test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_ETC) ne -1}">
                                    <c:choose>
                                        <c:when test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_SOCKS) ne -1}">
                                            , <spring:message code="common.title.etc" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${giftSetCnt > 0 or giftCuffsCnt > 0}"><br/></c:if>
                                            <spring:message code="common.title.etc" />
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:if>
                        </td>
                        <td class="text-center viewChoicePickup" style="display:none;"><c:out value="${row.MEM_MST_GFT_YN}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                    <tr><td colspan="9" class="text-center"><spring:message code="common.list.empty" /></td></tr>
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
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-primary" href="javascript:goForm();"><spring:message code="common.btn.create" /></a>
            </div>
        </div>
    </div>
<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="MEM_MST_IDX" id="MEM_MST_IDX" value="" />
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

    // 검색 엔터 이벤트 
    $searchForm.find("input").not(".datepicker").keydown(function (e) {
        if(e.keyCode == 13) {
            goSearch();
        }
    });

    // 검색
    goSearch = function () {
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/prsCustomerList.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/prsCustomerList.do", "method":"post", "target":"_self"}).submit();
    };

    // 등록
    goForm = function () {
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/customer/prsCustomerForm.do", "method":"post", "target":"_self"}).submit();
    };

    // 수정
    goEdit = function (memMstIdx) {
        $("#MEM_MST_IDX").val(memMstIdx);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/customer/prsCustomerEdit.do", "method":"post", "target":"_self"}).submit();
    };

    // 선택보기 초기설정
    initViewChoice();
    function initViewChoice(){
        var viewChoices = "<c:out value="${commandMap.viewChoices}"/>";
        $.each(viewChoices.split(","), function(idx, viewChoiceValue){
            $("."+viewChoiceValue).show();
            $("input[name=viewChoice]").filter("[value="+viewChoiceValue+"]").prop("checked", true);
        });
        $("#customerList").show();
    };

    // 선택보기
    goChoiceView = function(){
        var viewChoiceCnt = $("input[name=viewChoice]:checked").length;
        var viewChoices = "";
        var viewChoiceValue = "";

        if(viewChoiceCnt == 0){ // 선택이 없는경우 전부노출
            $.each($("input[name=viewChoice]"), function(idx, obj){
                viewChoiceValue = $(obj).val();

                $(obj).prop("checked", true);
                $("."+viewChoiceValue).show();

                if(viewChoices != ""){
                    viewChoices = viewChoices + "," + viewChoiceValue
                }else{
                    viewChoices = viewChoiceValue;
                }
            });
        }else{ // 선택노출
            $.each($("input[name=viewChoice]"), function(idx, obj){
                viewChoiceValue = $(obj).val();

                if($(obj).is(":checked")){
                    $("."+viewChoiceValue).show();

                    if(viewChoices != ""){
                        viewChoices = viewChoices + "," + viewChoiceValue
                    }else{
                        viewChoices = viewChoiceValue;
                    }
                }else{
                    $("."+viewChoiceValue).hide();
                }
            });
        }

        $("input[name=viewChoices]").val(viewChoices);
    };
    
    // 엑셀 다운로드
    goExcelDown = function () {
    	$dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/prsCustomerExcelList.do", "method":"post", "target":"_self"}).submit();
    };
    
});
</script>
<%-- // script 종료 --%>
</body>
</html>