<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <a href="<c:out value="${serverSslDomain}"/>" class="navbar-brand">La bellino | <c:out value="${sessionInfo.adminId}" /></a>
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#navbar-main">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
        </div>
        <div class="navbar-collapse collapse" id="navbar-main">
            <ul class="nav navbar-nav">
                <li><a href="<c:out value="${serverSslDomain}" />/dashboard/main.do"><spring:message code="gnb.menu1.title" /></a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menu2"><spring:message code="gnb.menu2.title" /> <span class="caret"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="menu2">
                        <li><a href="<c:out value="${serverSslDomain}" />/customer/buyCustomerList.do"><spring:message code="gnb.menu2.sub1.title" /></a></li>
                        <li><a href="<c:out value="${serverSslDomain}" />/customer/prsCustomerList.do"><spring:message code="gnb.menu2.sub2.title" /></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menu3"><spring:message code="gnb.menu3.title" /> <span class="caret"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="menu3">
                        <li><a href="<c:out value="${serverSslDomain}" />/order/orderList.do"><spring:message code="gnb.menu3.title" /></a></li>
                        <li><a href="<c:out value="${serverSslDomain}" />/order/orderReservationList.do"><spring:message code="gnb.menu3.sub3.title" /></a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menu4"><spring:message code="gnb.menu4.title" /> <span class="caret"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="menu4">
                        <li><a href="<c:out value="${serverSslDomain}" />/employee/salaryList.do"><spring:message code="gnb.menu4.sub1.title" /></a></li>
                        <li><a href="<c:out value="${serverSslDomain}" />/employee/holidayList.do"><spring:message code="gnb.menu4.sub2.title" /></a></li>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN }">
                        <li><a href="<c:out value="${serverSslDomain}" />/employee/managerList.do"><spring:message code="gnb.menu4.sub3.title" /></a></li>
                        </c:if>
                    </ul>
                </li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menu5"><spring:message code="gnb.menu5.title" /> <span class="caret"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="menu5">
                        <li><a href="<c:out value="${serverSslDomain}" />/sales/employeeSalesList.do"><spring:message code="gnb.menu5.sub1.title" /></a></li>
                        <c:if test="${sessionInfo.salesYn eq 'Y'}">
                        <li><a href="<c:out value="${serverSslDomain}" />/sales/storeSalesList.do"><spring:message code="gnb.menu5.sub2.title" /></a></li>
                        </c:if>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <li><a href="<c:out value="${serverSslDomain}" />/sales/vendorIncenList.do"><spring:message code="gnb.menu5.sub3.title" /></a></li>
                        </c:if>
                        <li><a href="<c:out value="${serverSslDomain}" />/sales/dailyReportList.do"><spring:message code="gnb.menu5.sub4.title" /></a></li>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <li><a href="<c:out value="${serverSslDomain}" />/sales/ledgerList.do"><spring:message code="gnb.menu5.sub5.title" /></a></li>
                        </c:if>
                    </ul>
                </li>
                <c:if test="${sessionInfo.noticeYn eq 'Y'}">
                <li><a href="<c:out value="${serverSslDomain}" />/board/noticeList.do"><spring:message code="gnb.menu6.title" /></a></li>
                </c:if>
                <li><a href="<c:out value="${serverSslDomain}" />/manage/storeList.do"><spring:message code="gnb.menu7.title" /></a></li>
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" id="menu8"><spring:message code="gnb.menu8.title" /> <span class="caret"></span></a>
                    <ul class="dropdown-menu" aria-labelledby="menu8">
                        <li><a href="<c:out value="${serverSslDomain}" />/product/productList.do"><spring:message code="gnb.menu8.sub1.title" /></a></li>
                        <li><a href="<c:out value="${serverSslDomain}" />/product/stockList.do"><spring:message code="gnb.menu8.sub2.title" /></a></li>
                    </ul>
                </li>
            </ul>
            <ui class="nav navbar-nav navbar-right">
                <li>
                    <span class="btn">
                        <a href="<c:out value="${serverSslDomain}" />/dashboard/main.do?lang=ko"><img src="<c:out value="${serverSslDomain}" />/img/common/kr.png"/></a>
                        <a href="<c:out value="${serverSslDomain}" />/dashboard/main.do?lang=ch"><img src="<c:out value="${serverSslDomain}" />/img/common/cn.png"/></a>
                        <a href="javascript:goLogout();"><img src="<c:out value="${serverSslDomain}" />/img/common/logout.png"/></a>
                    </span>
                </li>
            </ui>
        </div>
    </div>
</div>