<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table class="table table-striped table-hover ">
    <thead>
        <tr>
            <th class="text-center"><spring:message code="common.title.buy.content" /></th>
            <th class="text-center"><spring:message code="common.title.give" /></th>
            <th class="text-center"><spring:message code="common.title.order.date" /></th>
            <th class="text-center"><spring:message code="common.title.release.date" /></th>
            <th class="text-center"><spring:message code="common.title.pickup.date" /></th>
            <th class="text-center"><spring:message code="common.title.selling.price" /></th>
            <th class="text-center"><spring:message code="common.title.balance" /></th>
            <th class="text-center"><spring:message code="common.title.order.type" /></th>
        </tr>
    </thead>
    <tbody>
        <c:set var="productKindCnt" value="0"/>
        <c:set var="orderKindCnt" value="0"/>
        <c:forEach var="row" items="${list}" varStatus="i">
        <c:set var="productKindCnt" value="0"/>
        <c:set var="orderKindCnt" value="0"/>
        <tr>
            <td>
                <c:if test="${!empty row.ORD_MST_JK and row.ORD_MST_JK > 0}">
                    JK : <fmt:formatNumber value="${row.ORD_MST_JK}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_P and row.ORD_MST_P > 0}">
                    <c:if test="${productKindCnt > 0}">, </c:if>
                    P : <fmt:formatNumber value="${row.ORD_MST_P}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_V and row.ORD_MST_V > 0}">
                    <c:if test="${productKindCnt > 0}">, </c:if>
                    V : <fmt:formatNumber value="${row.ORD_MST_V}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_Y and row.ORD_MST_Y > 0}">
                    <c:if test="${productKindCnt > 0}">, </c:if>
                    Y : <fmt:formatNumber value="${row.ORD_MST_Y}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_C and row.ORD_MST_C > 0}">
                    <c:choose>
                        <c:when test="${productKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${productKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    C : <fmt:formatNumber value="${row.ORD_MST_C}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_SC and row.ORD_MST_SC > 0}">
                    <c:choose>
                        <c:when test="${productKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${productKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    SC : <fmt:formatNumber value="${row.ORD_MST_SC}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_SH and row.ORD_MST_SH > 0}">
                    <c:choose>
                        <c:when test="${productKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${productKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    SH : <fmt:formatNumber value="${row.ORD_MST_SH}" type="number"/>
                    <c:set var="productKindCnt" value="${productKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_O and row.ORD_MST_O > 0}">
                    <c:choose>
                        <c:when test="${productKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${productKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    O : <fmt:formatNumber value="${row.ORD_MST_O}" type="number"/>
                </c:if>
            </td>
            <td class="text-center"><c:out value="${row.ORD_MST_GIV_YN}" /></td>
            <td class="text-center"><ui:formatDate value="${row.ORD_MST_ORD_DT}" pattern="yyyy-MM-dd"/></td>
            <td class="text-center"><ui:formatDate value="${row.ORD_MST_RLS_DT}" pattern="yyyy-MM-dd"/></td>
            <td class="text-center"><ui:formatDate value="${row.ORD_MST_PIK_DT}" pattern="yyyy-MM-dd"/></td>
            <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_SAL}" type="number"/></td>
            <td class="text-center"><fmt:formatNumber value="${row.ORD_MST_BAL}" type="number"/></td>
            <td>
                <c:if test="${!empty row.ORD_MST_CSH and row.ORD_MST_CSH > 0}">
                    <spring:message code="common.title.cash" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_CRD and row.ORD_MST_CRD > 0}">
                    <c:if test="${orderKindCnt > 0}">, </c:if>
                    <spring:message code="common.title.card" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_WXN and row.ORD_MST_WXN > 0}">
                    <c:if test="${orderKindCnt > 0}">, </c:if>
                    <spring:message code="common.title.weixin" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_ZFU and row.ORD_MST_ZFU > 0}">
                    <c:if test="${orderKindCnt > 0}">, </c:if>
                    <spring:message code="common.title.jjeupu" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_DZH and row.ORD_MST_DZH > 0}">
                    <c:choose>
                        <c:when test="${orderKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${orderKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    <spring:message code="common.title.ttajung" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_HBH and row.ORD_MST_HBH > 0}">
                    <c:choose>
                        <c:when test="${orderKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${orderKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    <spring:message code="common.title.honbooe" />
                    <c:set var="orderKindCnt" value="${orderKindCnt + 1}"/>
                </c:if>
                <c:if test="${!empty row.ORD_MST_PAY_ETC and row.ORD_MST_PAY_ETC > 0}">
                    <c:choose>
                        <c:when test="${orderKindCnt eq 4}"><br/></c:when>
                        <c:otherwise><c:if test="${orderKindCnt > 0}">, </c:if></c:otherwise>
                    </c:choose>
                    <spring:message code="common.title.etc" />
                </c:if>
            </td>
        </tr>
        <tr>
            <td colspan="8"><spring:message code="common.title.note" /> : <ui:replaceLineBreak content="${row.ORD_MST_ETC}"/></td>
        </tr>
        </c:forEach>
        <c:if test="${empty list}">
        <tr><td colspan="8" class="text-center"><spring:message code="common.list.empty" /></td></tr>
        </c:if>
    </tbody>
</table>