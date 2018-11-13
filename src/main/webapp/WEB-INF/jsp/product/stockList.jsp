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
                <h2><spring:message code="common.title.stock.manage" /></h2>
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
                <form name="searchForm" id="searchForm" class="form-horizontal">
                    <input type="hidden" name="cPage" value="1"/>
                    <fieldset>
                        <div class="form-group">
                            <label for="searchStartDate" class="col-lg-2 control-label"><spring:message code="common.title.search.date" /></label>
                            <div class="col-lg-8 input-group">
                                <span class="input-group-addon"><spring:message code="common.title.start.date" /></span>
                                <input type="text" name="searchStartDate" id="searchStartDate" class="form-control datepicker start" value="<c:out value="${commandMap.searchStartDate }"/>"  readonly="readonly"/>
                                <span class="input-group-addon"><spring:message code="common.title.end.date" /></span>
                                <input type="text" name="searchEndDate" id="searchEndDate" class="form-control datepicker end" value="<c:out value="${commandMap.searchEndDate }"/>" readonly="readonly"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchPrdMstCd" class="col-lg-2 control-label"><spring:message code="common.title.product.code" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchPrdMstCd" id="searchPrdMstCd" class="form-control" value="<c:out value="${commandMap.searchPrdMstCd }"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchPrdMstNm" class="col-lg-2 control-label"><spring:message code="common.title.product.name" /></label>
                            <div class="col-lg-8 input-group">
                                <input type="text" name="searchPrdMstNm" id="searchPrdMstNm" class="form-control" value="<c:out value="${commandMap.searchPrdMstNm }"/>" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="searchSkuMstStatus" class="col-lg-2 control-label"><spring:message code="common.title.product.status" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchSkuMstStatus" id="searchSkuMstStatus">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <c:forEach var="row" items="${codes.PRODUCT_STATUS }" varStatus="i">
                                    <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq commandMap.searchSkuMstStatus}">selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <div class="form-group">
                            <label for="searchStrMstIdx" class="col-lg-2 control-label"><spring:message code="common.title.shop" /></label>
                            <div class="col-lg-8 input-group">
                                <select class="form-control" name="searchStrMstIdx" id="searchStrMstIdx">
                                    <option value=""><spring:message code="common.title.all" /></option>
                                    <c:forEach var="row" items="${storeList}" varStatus="i">
                                    <option value="<c:out value="${row.STR_MST_IDX}" />" <c:if test="${row.STR_MST_IDX eq commandMap.searchStrMstIdx}">selected="selected"</c:if>><c:out value="${row.STR_MST_NM}" /></option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        </c:if>
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
    
    <form name="dataForm" id="dataForm">
    
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
    <input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
    <input type="hidden" name="searchPrdMstCd" value="<c:out value="${commandMap.searchPrdMstCd }"/>" />
    <input type="hidden" name="searchPrdMstNm" value="<c:out value="${commandMap.searchPrdMstNm }"/>" />
    <input type="hidden" name="searchSkuMstStatus" value="<c:out value="${commandMap.searchSkuMstStatus }"/>" />
    <input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
    
    <div class="row">
        <div class="col-lg-10">
            <div class="page-header">
                <h3><spring:message code="common.btn.list" /></h3>
                <div class="form-group text-right">
                    <a class="btn btn-primary" href="javascript:goModify();"><spring:message code="common.brn.modify" /></a>
                </div>
            </div>
        </div>
        <div class="col-lg-10 table-responsive">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th class="text-center">NO</th>
                        <th class="text-center"><spring:message code="common.title.product.code" /></th>
                        <th class="text-center"><spring:message code="common.title.product.name" /></th>
                        <th class="text-center"><spring:message code="common.title.shop" /></th>
                        <th class="text-center"><spring:message code="common.title.product.status" /></th>
                        <th class="text-center"><spring:message code="common.title.product.price" /></th>
                        <th class="text-center"><spring:message code="common.title.stock" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.id" /></th>
                        <th class="text-center"><spring:message code="common.title.reg.date" /></th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty list }">
                    <c:forEach var="row" items="${list }" varStatus="i">
                    <tr>
                        <td class="text-center"><c:out value="${paging.listNum-i.index }"/></td>
                        <td class="text-center"><c:out value="${row.PRD_MST_CD }"/></td>
                        <td class="text-center"><c:out value="${row.PRD_MST_NM }"/></td>
                        <td class="text-center"><c:out value="${row.STR_MST_NM }"/></td>
                        <td class="text-center col-lg-2">
                            <select name="SKU_MST_STATUSs" class="form-control">
                                <option value=""><spring:message code="common.title.check"/></option>
                                <c:forEach var="codeRow" items="${codes.PRODUCT_STATUS}" varStatus="i">
                                <option value="<c:out value="${codeRow.CMN_COM_IDX}"/>" <c:if test="${codeRow.CMN_COM_IDX eq row.SKU_MST_STATUS }">selected="selected"</c:if>><c:out value="${codeRow.CMN_COM_NM}" /></option>
                                </c:forEach>
                            </select>
                        </td>
                        <td class="text-center col-lg-2">
                            <input type="text" name="SKU_MST_PRCs" class="form-control" value="<c:out value="${row.SKU_MST_PRC }"/>" maxlength="9"/>
                        </td>
                        <td class="text-center col-lg-1">
                            <input type="hidden" name="SKU_MST_IDXs" value="<c:out value="${row.SKU_MST_IDX }"/>" />
                            <input type="text" name="SKU_MST_STCs" class="form-control" value="<c:out value="${row.SKU_MST_STC }"/>" maxlength="4"/>
                        </td>
                        <td class="text-center"><c:out value="${row.SKU_MST_REG_ID }"/></td>
                        <td class="text-center"><ui:formatDate value="${row.SKU_MST_REG_DT }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                    </tr>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty list }">
                    <tr><td colspan="9" class="text-center"><spring:message code="common.list.empty" /></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
    </form>
    
    <div class="row">
        <div class="col-lg-10 text-center">
            <ul class="pagination">
                <ui:paging paging="${paging }" jsFunction="goPage"/>
            </ul>
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
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/product/stockList.do", "method":"post", "target":"_self"}).submit();
    };

    // 페이지 이동
    goPage = function (cPage) {
        $dataForm.find("input[name='cPage']").val(cPage);
        $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/product/stockList.do", "method":"post", "target":"_self"}).submit();
    };
    
    // 재고관리 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
        	SKU_MST_STATUSs: {required:true}
            , SKU_MST_STCs: {required:true}
            , SKU_MST_PRCs:{required:true}
        }
        , messages: {
        	SKU_MST_STATUSs: {required:"<spring:message code="common.title.product.status" /><spring:message code="common.validate.select" />"}
            , SKU_MST_STCs: {required:"<spring:message code="common.title.stock" /><spring:message code="common.validate.input" />"}
            , SKU_MST_PRCs:{required:"<spring:message code="common.title.product.price" /><spring:message code="common.validate.input" />"}
        }
    });
 
    // 재고 수정
    goModify = function () {
    	if ($dataForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/product/stockModify.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };
    
});
</script>
<%-- // script 종료 --%>
</body>
</html>