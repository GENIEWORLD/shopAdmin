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
                <h2><spring:message code="product.product.title" /></h2>
            </div>
        </div>
    </div>

    <form name="searchForm" id="searchForm">
    <input type="hidden" name="searchStrMstIdx" value="<c:out value="${commandMap.searchStrMstIdx }"/>" />
    <input type="hidden" name="cPage" value="<c:out value="${commandMap.cPage }"/>" />
    <input type="hidden" name="searchStartDate" value="<c:out value="${commandMap.searchStartDate }"/>" />
    <input type="hidden" name="searchEndDate" value="<c:out value="${commandMap.searchEndDate }"/>" />
    <input type="hidden" name="searchPrdMstCd" value="<c:out value="${commandMap.searchPrdMstCd }"/>" />
    <input type="hidden" name="searchPrdMstNm" value="<c:out value="${commandMap.searchPrdMstNm }"/>" />
    <input type="hidden" name="searchPrdMstGbn" value="<c:out value="${commandMap.searchPrdMstGbn }"/>" />
    <input type="hidden" name="searchSkuMstStatus" value="<c:out value="${commandMap.searchSkuMstStatus }"/>" />
    </form>

    <div class="row">
        <div class="col-lg-10">
            <div class="well">
                <form name="dataForm" id="dataForm" class="form-horizontal">
                <input type="hidden" name="PRD_MST_CD" value="<c:out value="${info.PRD_MST_CD }"/>" />
                <span id="removeStoreArea"></span>
                <fieldset>
                    <legend><spring:message code="common.brn.modify" /></legend>
                    <div class="form-group">
                        <label for="PRD_MST_NM" class="col-lg-2 text-right"><spring:message code="common.title.product.code" /></label>
                        <div class="col-lg-8">
                            <label><c:out value="${info.PRD_MST_CD }"/></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 text-right"><spring:message code="common.title.product.name" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="PRD_MST_NM" id="PRD_MST_NM" class="form-control" value="<c:out value="${info.PRD_MST_NM }"/>" maxlength="30"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="PRD_MST_GBN" class="col-lg-2 text-right"><spring:message code="common.title.product.gbn" /></label>
                        <div class="col-lg-8">
                            <select class="form-control" name="PRD_MST_GBN" id="PRD_MST_GBN">
                                <option value=""><spring:message code="common.title.check"/></option>
                                <c:forEach var="row" items="${codes.PRODUCT_GBN}" varStatus="i">
                                <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq info.PRD_MST_GBN }">selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="PRD_MST_CPN" class="col-lg-2 text-right"><spring:message code="common.title.product.company" /></label>
                        <div class="col-lg-8">
                            <input type="text" name="PRD_MST_CPN" id="PRD_MST_CPN" class="form-control" value="<c:out value="${info.PRD_MST_CPN }"/>" maxlength="30"/>
                        </div>
                    </div>
                    <c:if test="${not empty info.STOCK_LIST }">
                    <c:forEach var="stockRow" items="${info.STOCK_LIST }" varStatus="y">
                    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN or (sessionInfo.admingGbn eq Code.ADMIN_TYPE_DESIGNER and sessionInfo.strMstIdx eq stockRow.STR_MST_IDX)}">
                    <div class="stock-wrap">
                        <div class="form-group stock-form">
                            <label for="STR_MST_IDXs<c:out value="${y.index }"/>" class="col-lg-2 text-right">
                                <c:if test="${y.first }">
                                <spring:message code="common.title.stock.manage" />
                                </c:if>
                            </label>
                            <div class="col-lg-8">
                                <label for="STR_MST_IDXs<c:out value="${y.index }"/>" class="col-lg-2 control-label"><spring:message code="common.title.store.name" /></label>
                                <input type="hidden" name="SKU_MST_IDXs" value="<c:out value="${stockRow.SKU_MST_IDX }"/>" />
                                <div class="col-lg-4">
                                    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                                    <select name="STR_MST_IDXs" id="STR_MST_IDXs<c:out value="${y.index }"/>" class="form-control">
                                        <option value=""><spring:message code="common.title.check"/></option>
                                        <c:forEach var="row" items="${storeList }" varStatus="i">
                                        <option value="<c:out value="${row.STR_MST_IDX }"/>" <c:if test="${row.STR_MST_IDX eq stockRow.STR_MST_IDX }">selected="selected"</c:if>><c:out value="${row.STR_MST_NM }"/></option>
                                        </c:forEach>
                                    </select>
                                    </c:if>
                                    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_DESIGNER}">
                                    <label class="control-label"><c:out value="${sessionInfo.strMstNm }"/></label>
                                    <input type="hidden" name="STR_MST_IDXs" value="<c:out value="${sessionInfo.strMstIdx }"/>" />
                                    </c:if>
                                </div>
                                <label for="SKU_MST_STATUS<c:out value="${y.index }"/>" class="col-lg-2 control-label"><spring:message code="common.title.product.status" /></label>
                                <div class="col-lg-4">
                                    <select name="SKU_MST_STATUSs" id="SKU_MST_STATUSs<c:out value="${y.index }"/>" class="form-control">
                                        <option value=""><spring:message code="common.title.check"/></option>
                                        <c:forEach var="row" items="${codes.PRODUCT_STATUS}" varStatus="i">
                                        <option value="<c:out value="${row.CMN_COM_IDX}" />" <c:if test="${row.CMN_COM_IDX eq stockRow.SKU_MST_STATUS }">selected="selected"</c:if>><c:out value="${row.CMN_COM_NM}" /></option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group stock-form">
                            <label for="SKU_MST_PRCs<c:out value="${y.index }"/>" class="col-lg-2 text-right"></label>
                            <div class="col-lg-8">
                                <label for="SKU_MST_PRCs<c:out value="${y.index }"/>" class="col-lg-2 control-label"><spring:message code="common.title.product.price" /></label>
                                <div class="col-lg-4">
                                    <input type="text" name="SKU_MST_PRCs" id="SKU_MST_PRCs<c:out value="${y.index }"/>" class="form-control number" value="<c:out value="${stockRow.SKU_MST_PRC }"/>" maxlength="9"/>
                                </div>
                                <label for="SKU_MST_STCs<c:out value="${y.index }"/>" class="col-lg-2 control-label"><spring:message code="common.title.stock" /></label>
                                <div class="col-lg-4">
                                    <input type="text" name="SKU_MST_STCs" id="SKU_MST_STCs<c:out value="${y.index }"/>" class="form-control number" value="<c:out value="${stockRow.SKU_MST_STC }"/>" maxlength="4"/>
                                </div>
                            </div>
                        </div>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <div class="form-group stock-form">
                            <label class="col-lg-2 text-right"></label>
                            <div class="col-lg-8 text-right">
                                <c:if test="${y.first }">
                                <a href="javascript:;" onclick="addStockForm(this);" class="btn btn-primary"><spring:message code="common.btn.add"/></a>
                                </c:if>
                                <c:if test="${not y.first }">
                                <a href="javascript:;" onclick="removeStockForm(this, '<c:out value="${stockRow.STR_MST_IDX }"/>');" class="btn btn-danger"><spring:message code="common.btn.delete"/></a>
                                </c:if>
                            </div>
                        </div>
                        </c:if>
                    </div>
                    </c:if>
                    </c:forEach>
                    </c:if>
                    <c:if test="${empty info.STOCK_LIST }">
                    <div class="stock-wrap">
                        <div class="form-group stock-form">
                            <label for="STR_MST_IDXs0" class="col-lg-2 text-right"><spring:message code="common.title.stock.manage" /></label>
                            <div class="col-lg-8">
                                <label for="STR_MST_IDXs0" class="col-lg-2 control-label"><spring:message code="common.title.store.name" /></label>
                                <input type="hidden" name="SKU_MST_IDXs" value="0" />
                                <div class="col-lg-4">
                                    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                                    <select name="STR_MST_IDXs" id="STR_MST_IDXs0" class="form-control">
                                        <option value=""><spring:message code="common.title.check"/></option>
                                        <c:forEach var="row" items="${storeList }" varStatus="i">
                                        <option value="<c:out value="${row.STR_MST_IDX }"/>"><c:out value="${row.STR_MST_NM }"/></option>
                                        </c:forEach>
                                    </select>
                                    </c:if>
                                    <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_DESIGNER}">
                                    <label class="control-label"><c:out value="${sessionInfo.strMstNm }"/></label>
                                    <input type="hidden" name="STR_MST_IDXs" value="<c:out value="${sessionInfo.strMstIdx }"/>" />
                                    </c:if>
                                </div>
                                <label for="SKU_MST_STATUSs0" class="col-lg-2 control-label"><spring:message code="common.title.product.status" /></label>
                                <div class="col-lg-4">
                                    <select name="SKU_MST_STATUSs" id="SKU_MST_STATUSs0" class="form-control">
                                        <option value=""><spring:message code="common.title.check"/></option>
                                        <c:forEach var="row" items="${codes.PRODUCT_STATUS}" varStatus="i">
                                        <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-group stock-form">
                            <label for="SKU_MST_PRCs0" class="col-lg-2 text-right"></label>
                            <div class="col-lg-8">
                                <label for="SKU_MST_PRCs0" class="col-lg-2 control-label"><spring:message code="common.title.product.price" /></label>
                                <div class="col-lg-4">
                                    <input type="text" name="SKU_MST_PRCs" id="SKU_MST_PRCs0" class="form-control number" value="0" maxlength="9"/>
                                </div>
                                <label for="SKU_MST_STCs0" class="col-lg-2 control-label"><spring:message code="common.title.stock" /></label>
                                <div class="col-lg-4">
                                    <input type="text" name="SKU_MST_STCs" id="SKU_MST_STCs0" class="form-control number" value="0" maxlength="4"/>
                                </div>
                            </div>
                        </div>
                        <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                        <div class="form-group stock-form">
                            <label class="col-lg-2 text-right"></label>
                            <div class="col-lg-8 text-right">
                                <a href="javascript:;" onclick="addStockForm(this);" class="btn btn-primary"><spring:message code="common.btn.add"/></a>
                            </div>
                        </div>
                        </c:if>
                    </div>
                    </c:if>
                    <div class="form-group text-right">
                        <div class="col-lg-10 col-lg-offset-2">
                            <a href="javascript:goList();" class="btn btn-primary"><spring:message code="common.btn.list"/></a>
                            <a href="javascript:goModify();" class="btn btn-info"><spring:message code="common.btn.save"/></a>
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
<script src="/js/jquery.tmpl.min.js"></script>
<script id="stockFormTemplate" type="text/x-jquery-tmpl">
<div class="stock-wrap">
    <div class="form-group stock-form">
        <label for="STR_MST_IDXs\${NUM}" class="col-lg-2 text-right"></label>
        <input type="hidden" name="SKU_MST_IDXs" value="0" />
        <div class="col-lg-8">
            <label for="STR_MST_IDXs\${NUM}" class="col-lg-2 control-label"><spring:message code="common.title.store.name" /></label>
            <div class="col-lg-4">
                <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_ADMIN}">
                <select name="STR_MST_IDXs" id="STR_MST_IDXs\${NUM}" class="form-control">
                    <option value=""><spring:message code="common.title.check"/></option>
                    <c:forEach var="row" items="${storeList }" varStatus="i">
                    <option value="<c:out value="${row.STR_MST_IDX }"/>"><c:out value="${row.STR_MST_NM }"/></option>
                    </c:forEach>
                </select>
                </c:if>
                <c:if test="${sessionInfo.admingGbn eq Code.ADMIN_TYPE_DESIGNER}">
                <label class="control-label"><c:out value="${sessionInfo.strMstNm }"/></label>
                <input type="hidden" name="STR_MST_IDXs" value="<c:out value="${sessionInfo.strMstIdx }"/>" />
                </c:if>
            </div>
            <label for="SKU_MST_STATUSs\${NUM}" class="col-lg-2 control-label"><spring:message code="common.title.product.status" /></label>
            <div class="col-lg-4">
                <select name="SKU_MST_STATUSs" id="SKU_MST_STATUSs\${NUM}" class="form-control">
                    <option value=""><spring:message code="common.title.check"/></option>
                    <c:forEach var="row" items="${codes.PRODUCT_STATUS}" varStatus="i">
                    <option value="<c:out value="${row.CMN_COM_IDX}" />"><c:out value="${row.CMN_COM_NM}" /></option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <div class="form-group stock-form">
        <label for="SKU_MST_PRCs\${NUM}" class="col-lg-2 text-right"></label>
        <div class="col-lg-8">
            <label for="SKU_MST_PRCs0" class="col-lg-2 control-label"><spring:message code="common.title.product.price" /></label>
            <div class="col-lg-4">
                <input type="text" name="SKU_MST_PRCs" id="SKU_MST_PRCs\${NUM}" class="form-control number" value="0" maxlength="9"/>
            </div>
            <label for="SKU_MST_STCs\${NUM}" class="col-lg-2 control-label"><spring:message code="common.title.stock" /></label>
            <div class="col-lg-4">
                <input type="text" name="SKU_MST_STCs" id="SKU_MST_STCs\${NUM}" class="form-control number" value="0" maxlength="4"/>
            </div>
        </div>
    </div>
    <div class="form-group stock-form">
        <label class="col-lg-2 text-right"></label>
        <div class="col-lg-8 text-right">
            <a href="javascript:;" onclick="removeStockForm(this);" class="btn btn-danger"><spring:message code="common.btn.delete"/></a>
        </div>
    </div>
</div>
</script>
<script>
$(function(){

    var $dataForm = $("#dataForm")
       , $searchForm = $("#searchForm");

    var $container = $(".container")
        , $stockFormTemplate = $("#stockFormTemplate");

    var $removeStoreArea = $("#removeStoreArea");
    
    // 재고폼 추가
    addStockForm = function (obj) {
    	$dataForm.find(".stock-wrap:last").after($stockFormTemplate.tmpl({NUM:$container.find(".stock-form").length}));
    };
    
    // 재고폼 삭제
    removeStockForm = function (obj, STR_MST_IDX) {
    	if (typeof(STR_MST_IDX) != "undefined") {
    		$removeStoreArea.append("<input type=\"hidden\" name=\"DEL_STR_MST_IDXs\" value=\"" + STR_MST_IDX + "\" />")
    	}
    	$(obj).closest(".stock-wrap").remove();
    };
    
    // 상품관리 목록 이동
    goList = function () {
        $searchForm.attr({"action":"<c:out value="${serverDomain}"/>/product/productList.do", "method":"post", "target":"_self"}).submit();
    };

    // 상품관리 매장 재고 중복체크 룰 설정
    $.validator.addMethod("storeDuplication", function(value, element) {

        var $el = $(element)
            , $stockFormArea = $el.closest(".stock-form").siblings(".stock-form")
            , $timeOptionItems = $stockFormArea.find("select[name='STR_MST_IDXs']");
        
        var isValid = true;
        var $array = $.makeArray ( $timeOptionItems.map( function () {
            return $(this).find("option:selected").map( function () {
                return this.value;
            }).get().join();
        }));
        $array.push($el.val());
        
        var tempArray = [];
        $.each($array, function (i, item) {
            if ($.inArray(item, tempArray) === -1) {
                tempArray.push(item);
            } else {
                isValid = false;
                return false;
            }
        });
        return this.optional(element) || isValid;
        
    }, "<spring:message code="common.validate.dup.store" />");
    
    // 상품관리 폼 유효성 규칙 정의
    $dataForm.validate({
        rules: {
            PRD_MST_NM: {required:true}
            , PRD_MST_GBN: {required:true}
            , PRD_MST_CPN: {required:false}
            , STR_MST_IDXs: {required:true, storeDuplication:true}
            , SKU_MST_STATUSs: {required:true}
            , SKU_MST_PRCs: {required:true}
            , SKU_MST_STCs: {required:true}
        }
        , messages: {
            PRD_MST_NM: {required:"<spring:message code="common.title.product.name" /><spring:message code="common.validate.input" />"}
            , PRD_MST_GBN: {required:"<spring:message code="common.title.product.gbn" /><spring:message code="common.validate.select" />"}
            , PRD_MST_CPN: {required:"<spring:message code="common.title.product.company" /><spring:message code="common.validate.input" />"}
            , STR_MST_IDXs: {required:"<spring:message code="common.title.store.name" /><spring:message code="common.validate.select" />"}
            , SKU_MST_STATUSs: {required:"<spring:message code="common.title.product.status" /><spring:message code="common.validate.select" />"}
            , SKU_MST_PRCs: {required:"<spring:message code="common.title.product.price" /><spring:message code="common.validate.input" />"}
            , SKU_MST_STCs: {required:"<spring:message code="common.title.stock" /><spring:message code="common.validate.input" />"}
        }
    });

    // 상품관리 수정
    goModify = function () {
        if ($dataForm.valid()) {
            if (confirm("<spring:message code="common.alert.confirm.save" />")) {
                $dataForm.attr({"action":"<c:out value="${serverDomain}"/>/product/productModify.do", "method":"post", "target":"_self"}).submit();
            }           
        }
    };
});
</script>
<%-- // script 종료 --%>
</body>
</html>