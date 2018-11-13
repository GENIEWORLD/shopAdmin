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
                <h2><spring:message code="customer.buy.customer.title" /></h2>
            </div>
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

    <spring:message var="giftSet" code="common.title.gift.set" />
    <spring:message var="giftCuffs" code="common.title.cuffs" />
    <spring:message var="giftSocks" code="common.title.socks" />
    <spring:message var="giftEtc" code="common.title.etc" />
    
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.member.no" /></th>
                        <th class="text-center"><spring:message code="common.title.member.name" /></th>
                        <th class="text-center"><spring:message code="common.title.hp" /></th>
                        <th class="text-center"><spring:message code="common.title.designer" /></th>
                        <th class="text-center"><spring:message code="common.title.wedding.date" /></th>
                        <th class="text-center"><spring:message code="common.title.vendor" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${list}" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${row.MEM_MST_CD}"/></td>
                        <td class="text-center">
                            <c:set var="giftStr" value=""/>
                            <c:if test="${!empty row.MEM_MST_GFT}">
                                <c:set var="giftSetCnt" value="0" />
                                <c:set var="giftCuffsCnt" value="0" />
                                <c:forEach var="set" items="${codes.GIFT_KIND_SET}" varStatus="j">
                                    <c:if test="${fn:indexOf(row.MEM_MST_GFT, set.CMN_COM_IDX) ne -1}">
                                        <c:choose>
                                            <c:when test="${giftSetCnt eq 0}">
                                                <c:set var="giftStr" value="${giftSet} : ${set.CMN_COM_NM}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="giftStr" value="${giftStr}, ${set.CMN_COM_NM}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:set var="giftSetCnt" value="${giftSetCnt + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:forEach var="cuffs" items="${codes.GIFT_KIND_CUFFS}" varStatus="j">
                                    <c:if test="${fn:indexOf(row.MEM_MST_GFT, cuffs.CMN_COM_IDX) ne -1}">
                                        <c:choose>
                                            <c:when test="${giftCuffsCnt eq 0}">
                                                <c:if test="${giftSetCnt > 0}"><c:set var="giftStr" value="${giftStr}|"/></c:if>
                                                <c:set var="giftStr" value="${giftStr}${giftCuffs} : ${cuffs.CMN_COM_NM}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="giftStr" value="${giftStr}, ${cuffs.CMN_COM_NM}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:set var="giftCuffsCnt" value="${giftCuffsCnt + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_SOCKS) ne -1}">
                                    <c:if test="${giftSetCnt > 0 or giftCuffsCnt > 0}"><c:set var="giftStr" value="${giftStr}|"/></c:if>
                                </c:if>
                                <c:if test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_ETC) ne -1}">
                                    <c:choose>
                                        <c:when test="${fn:indexOf(row.MEM_MST_GFT, Code.GIFT_KIND_SOCKS) ne -1}">
                                            <c:set var="giftStr" value="${giftStr}, ${giftEtc}"/>
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test="${giftSetCnt > 0 or giftCuffsCnt > 0}"><c:set var="giftStr" value="${giftStr}|"/></c:if>
                                            <c:set var="giftStr" value="${giftStr}${giftEtc}"/>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </c:if>
                            <a href="javascript:;" class="reqCustomerOrderList" data-memMstIdx="<c:out value="${row.MEM_MST_IDX}" />" data-memMstCd="<c:out value="${row.MEM_MST_CD}" />" data-memMstNm="<c:out value="${row.MEM_MST_NM}" />" data-memMstTel="<c:out value="${row.MEM_MST_TEL }"/>" data-memMstWed="<c:out value="${row.MEM_MST_WED }"/>" data-memMstGft="<c:out value="${giftStr }"/>">
                                <c:out value="${row.MEM_MST_NM}"/>
                            </a>
                            <input type="hidden" class="memMstCsl" value="<c:out value="${row.MEM_MST_CSL }"/>" />
                        </td>
                        <td class="text-center"><c:out value="${row.MEM_MST_TEL}"/></td>
                        <td class="text-center"><c:out value="${row.ADM_MST_NM}"/></td>
                        <td class="text-center"><c:out value="${row.MEM_MST_WED}"/></td>
                        <td class="text-center"><c:out value="${row.COM_INF_NM}"/></td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty list}">
                    <tr><td colspan="6" class="text-center"><spring:message code="common.list.empty" /></td></tr>
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

    <div class="row" id="orderListDiv" style="display:none;">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.order" /><spring:message code="common.btn.list" /></h3>
            </div>
        </div>
        <div class="col-lg-10">
            <div class="well">
                <fieldset>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" id="memMstCd"></label>
                        <label class="col-lg-3 control-label" id="memMstNm"></label>
                        <label class="col-lg-3 control-label" id="memMstTel"></label>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-5 control-label" id="memMstWed"></label>
                        <label class="col-lg-5 control-label" id="memMstGft"></label>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-10 control-label" id="memMstCsl"></label>
                    </div>
                </fieldset>
            </div>
        </div>
        <div class="col-lg-10 table-responsive" id="orderListHtmlDiv">
        </div>
        <div class="form-group text-right">
            <div class="col-lg-10">
                <a class="btn btn-default" href="javascript:closeOrderList();"><spring:message code="common.btn.close" /></a>
            </div>
        </div>
    </div>
    
    
    <!-- modify modal -->
    <div class="row">
        <div class="col-lg-10">
            <div id="buyCustomerEdit" class="modal">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <a href="javascript:closeModal();" class="close" data-dismiss="modal" aria-hidden="true">×</a>
                            <h4 class="modal-title"><spring:message code="common.title.holiday.proc" /></h4>
                        </div>
                        <div class="modal-body">
                            <div class="well">
                                <form name="editForm" id="editForm" class="form-horizontal">
                                    <input type="hidden" name="MEM_MST_IDX" value=""/>
                                    <fieldset>
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label"><spring:message code="common.title.member.no" /></label>
                                            <div class="col-lg-8">
                                                <input type="text" name="MEM_MST_CD" class="form-control" value="" maxlength="20"/>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <a href="javascript:goModify();" class="btn btn-info"><spring:message code="common.btn.save" /></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--// modify modal -->

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage}"/>" />
<input type="hidden" name="searchType" value="<c:out value="${commandMap.searchType}"/>" />
<input type="hidden" name="searchWoard" value="<c:out value="${commandMap.searchWoard}"/>" />
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $searchForm = $("#searchForm")
        , $dataForm = $("#dataForm")
        , $editForm = $("#editForm");

    var $buyCustomerEdit =$("#buyCustomerEdit");
    
    // 검색 엔터 이벤트 
    $searchForm.find("input").not(".datepicker").keydown(function (e) {
        if(e.keyCode == 13) {
            goSearch();
        }
    });

    // 검색
    goSearch = function () {
        $searchForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/buyCustomerList.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/buyCustomerList.do", "method":"post", "target":"_self"}).submit();
    };

    // 고객 주문 목록 보기
    $(".reqCustomerOrderList").on("click", function(e){
        e.preventDefault();

        $("#orderListHtmlDiv").empty();
        $("#memMstCd").text("");
        $("#memMstNm").text("");

        var memMstIdx = $(this).attr("data-memMstIdx");
        var memMstCd = $(this).attr("data-memMstCd");
        var memMstNm = $(this).attr("data-memMstNm");
        var memMstTel = $(this).attr("data-memMstTel");
        var memMstWed = $(this).attr("data-memMstWed");
        var memMstGft = $(this).attr("data-memMstGft");
        var memMstCsl = $(this).siblings("input.memMstCsl").val();
        
        
        // 고객 주문 목록 조회
        $.postSyncHtmlAjax("/order/customerOrderListAjax.do", {memMstIdx : memMstIdx}, function(orderListHtml){
            $("#orderListHtmlDiv").html(orderListHtml);
        });

        $("#memMstCd").html("<spring:message code="common.title.member.no" /> : " + memMstCd + "  <a href=\"javascript:openModal('" + memMstIdx + "', '" + memMstCd + "', 'memMstNo');\" class=\"btn btn-primary btn-xs\"><spring:message code="common.brn.modify" /></a>");
        $("#memMstNm").html("<spring:message code="common.title.member.name" /> : " + memMstNm + "  <a href=\"javascript:openModal('" + memMstIdx + "', '" + memMstNm + "', 'memMstNm');\" class=\"btn btn-primary btn-xs\"><spring:message code="common.brn.modify" /></a>");
        $("#memMstTel").html("<spring:message code="common.title.hp" /> : " + memMstTel + "  <a href=\"javascript:openModal('" + memMstIdx + "', '" + memMstTel + "', 'memMstTel');\" class=\"btn btn-primary btn-xs\"><spring:message code="common.brn.modify" /></a>");
        $("#memMstWed").text("<spring:message code="common.title.wedding.date" /> : " + memMstWed);
        $("#memMstGft").text("<spring:message code="common.title.gift" /> : " + memMstGft);
        $("#memMstCsl").text("<spring:message code="common.title.note" /> : " + memMstCsl);
        
        $("#orderListDiv").show();
        $("#orderListDiv").get(0).scrollIntoView();
    });

    // 고객 주문 목록 닫기
    closeOrderList = function(){
        $("#orderListDiv").hide();
        $("#orderListHtmlDiv").empty();
        $("#memMstCd").text("");
        $("#memMstNm").text("");
    };
    
    // 모달 팝업 OPEN
    openModal = function (memMstIdx, val, type) {
    	var $target = $editForm.find("input.form-control")
    	$editForm.find("input[name='MEM_MST_IDX']").val(memMstIdx);
    	$editForm.find("input.form-control").val(memMstCd);
    	if (type == "memMstNo") {
    		$target.attr("name", "MEM_MST_CD").val(val)
    	} else if (type == "memMstNm") {
    		$target.attr("name", "MEM_MST_NM").val(val);
    	} else if (type == "memMstTel") {
    		$target.attr("name", "MEM_MST_TEL").val(val);
    	}
        $buyCustomerEdit.show();
    };
    
    // 모달 팝업 CLOSE
    closeModal = function () {
        $buyCustomerEdit.hide();
    };
    
    // 폼체크
    $editForm.validate({
        rules: {
            MEM_MST_CD : {required:true}
        },
        messages :{
            MEM_MST_CD : {required:"<spring:message code="common.title.member.no" /><spring:message code="common.validate.input" />"}
        }
    });

    
    // 회원번호 수정
    goModify = function () {
    	if ($editForm.valid()) {
    		if (confirm("<spring:message code="common.alert.confirm.save" />")) {
    			$editForm.attr({"action":"<c:out value="${serverSslDomain}"/>/customer/buyCustomerModify.do", "method":"post", "target":"_self"}).submit();
    		}
    	}
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>