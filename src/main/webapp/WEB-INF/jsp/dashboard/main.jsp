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
                <h2><spring:message code="dashBoard.main.title" /></h2>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="board.notice.title" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.title" /></th>
                        <th class="text-center"><spring:message code="common.title.shop" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.id" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.date" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty noticeTopList }">
                    <c:forEach var="row" items="${noticeTopList }" varStatus="i">
                    <tr <c:if test="${row.LATELY_YN eq 'Y'}">class="success"</c:if>>
                        <c:choose>
                            <c:when test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                                <td class="text-center"><a href="javascript:goNoticeEdit('<c:out value="${row.BRD_NTS_IDX }" />');"><c:out value="${row.BRD_NTS_TITLE }"/></a></td>
                            </c:when>
                            <c:otherwise>
                                <td class="text-center"><a href="javascript:goNoticeView('<c:out value="${row.BRD_NTS_IDX }" />');"><c:out value="${row.BRD_NTS_TITLE }"/></a></td>
                            </c:otherwise>
                        </c:choose>
                        <td class="text-center">
                            <c:if test="${row.STR_MST_IDX ne '0' }"><c:out value="${row.STR_MST_NM  }" /></c:if>
                            <c:if test="${row.STR_MST_IDX eq '0' }"><spring:message code="common.title.shop.all.name" /></c:if>
                        </td>
                        <td class="text-center"><c:out value="${row.BRD_NTS_REG_ID }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.BRD_NTS_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty noticeTopList}">
                    <tr><td colspan="4" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="product.stock.soldout.title" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.product.code" /></th>
                        <th class="text-center"><spring:message code="common.title.product.name" /></th>
                        <th class="text-center"><spring:message code="common.title.store.name" /></th>
                        <th class="text-center"><spring:message code="common.title.stock" /></th>
                        <th class="text-center"><spring:message code="common.title.product.status" /></th>
                        <th class="text-center"><spring:message code="common.title.stock.soldout.date" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty stockSoldOutList }">
                    <c:forEach var="row" items="${stockSoldOutList }" varStatus="i">
                    <tr <c:if test="${not empty row.ALERT_CLASS }">class="<c:out value="${row.ALERT_CLASS }"/>"</c:if>>
                        <td class="text-center"><a href="javascript:goProductEdit('<c:out value="${row.PRD_MST_CD }" />');"><c:out value="${row.PRD_MST_CD }"/></a></td>
                        <td class="text-center"><c:out value="${row.PRD_MST_NM }" /></td>
                        <td class="text-center"><c:out value="${row.STR_MST_NM }"/></td>
                        <td class="text-center"><fmt:formatNumber value="${row.SKU_MST_STC }" type="number"/></td>
                        <td class="text-center"><c:out value="${row.SKU_MST_STATUS_NM }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.SKU_MST_SOLD_OUT_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty stockSoldOutList}">
                    <tr><td colspan="6" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.title.sales" /></h3>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover ">
                <thead>
                    <tr>
                        <th class="text-center"><spring:message code="common.title.cash" /></th>
                        <th class="text-center"><spring:message code="common.title.card" /></th>
                        <th class="text-center"><spring:message code="common.title.weixin" /></th>
                        <th class="text-center"><spring:message code="common.title.jjeupu" /></th>
                        <th class="text-center"><spring:message code="common.title.honbooe" /></th>
                        <th class="text-center"><spring:message code="common.title.ttajung" /></th>
                        <th class="text-center"><spring:message code="common.title.etc" /></th>
                        <th class="text-center"><spring:message code="common.title.balance" /></th>
                        <th class="text-center"><spring:message code="common.title.incen" /></th>
                        <th class="text-center"><spring:message code="common.title.total" /></th>
                        <th class="text-center"><spring:message code="common.title.pay.price" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${!empty salesTotalSum}">
                    <tr>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_CSH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_CRD_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_WXN_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_ZFU_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_HBH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_DZH_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_PAY_ETC_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_BAL_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.COM_INCEN_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.ORD_MST_SAL_SUM}" type="number"/></td>
                        <td class="text-center"><fmt:formatNumber value="${salesTotalSum.PROFIT_SUM }" type="number"/></td>
                    </tr>
                    </c:if>
                    <c:if test="${empty salesTotalSum}">
                    <tr><td colspan="11" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

<%-- // contents 종료 --%>
<%-- footer 시작 --%>
<%@ include file="/WEB-INF/jsp/include/footer.jsp" %>
<%-- // footer 종료 --%>
</div>

<form name="dataForm" id="dataForm">
<input type="hidden" name="BRD_NTS_IDX" value="" />
<input type="hidden" name="PRD_MST_CD" value=""/>
</form>

<%-- script 시작 --%>
<%@ include file="/WEB-INF/jsp/include/script.jsp" %>
<script>
$(function(){
    var $dataForm = $("#dataForm");

    <c:choose>
    <c:when test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
        // 공지사항 수정페이지 이동
        goNoticeEdit = function (BRD_NTS_IDX) {
            $dataForm.find("input[name='BRD_NTS_IDX']").val(BRD_NTS_IDX);
            $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeEdit.do", "method":"post", "target":"_self"}).submit();
        };
    </c:when>
    <c:otherwise>
        // 공지사항 상세페이지 이동
        goNoticeView = function (BRD_NTS_IDX) {
            $dataForm.find("input[name='BRD_NTS_IDX']").val(BRD_NTS_IDX);
            $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/board/noticeView.do", "method":"post", "target":"_self"}).submit();
        };
    </c:otherwise>
    </c:choose>
    // 상품 상세로 이동
    goProductEdit = function (PRD_MST_CD) {
    	$dataForm.find("input[name='PRD_MST_CD']").val(PRD_MST_CD);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/product/productEdit.do", "method":"post", "target":"_self"}).submit();
    };
    
});
</script>
<%-- // script 종료 --%>
</body>
</html>