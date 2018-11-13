$.ajaxSetup ({
    // Disable caching of AJAX responses */
    cache: false
});

/**
 * Debug Log
 */
if (!window.console) {
  var Console = function() {
   return {
    log : function(message) {},
    info : function(message) {},
    warn : function(message) {},
    error : function(message) {}
   };
  };
  console = Console();
}
/*
 * 메뉴 Link
 * */
function goMenuLink(menuCode, link){
    $("#selectMenuCode").val(menuCode);
    $("#frmMainLayout").attr("action", link).submit();
}
/*
 * 현재 메뉴 코드 조회
 * */
function getSelectMenuCode(){
    return $("#selectMenuCode").val();
}
/*
 * 전송시 공통 처리
 * */
function setSubmit(obj){
    var selectMenuCode = getSelectMenuCode();
    if (selectMenuCode == undefined || selectMenuCode == "undefined"){
        selectMenuCode = "001000000";
    }
    obj.find("input[name='selectMenuCode']").remove();
    obj.append("<input type='hidden' id='selectMenuCode' name='selectMenuCode' value='"+selectMenuCode+"' />");
    return false;
}

// 공통 Ready
$(document).ready(function(){
    $("form").on("submit", function(){
        setSubmit($(this));
    });

    //숫자만 입력
    $(".number").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var $this = $(this);
            $this.val($this.val().replace(/[^0-9]/g,''));
        }
    });
    
    //숫자만 입력
    $(".onlyNumber").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var $this = $(this);
            $this.val($this.val().replace(/[^0-9]/g,''));
        }
    });
});

/*
 * 날짜보기
 * strDate : 날짜(YYYYMMDD)
 * str : 구분자
 * */
function getDateView(strDate, str){
    strDate = strDate.replace(/\-/g, "");
    return strDate.substring(0, 4) + str + strDate.substring(4, 6) + str + strDate.substring(6, 8);
}
/*
 * 날짜보기
 * strDate : 날짜(YYYYMMDD HHMMSS)
 * str : 날짜 구분자
 * str2 : 시간 구분자
 * */
function getDateTimeView(strDate, str, str2){
    strDate = strDate.replace(/\-/g, "");
    return strDate.substring(0, 4) + str + strDate.substring(4, 6) + str + strDate.substring(6, 8) + " " + strDate.substring(8, 10) + str2 + strDate.substring(10, 12) + str2 + strDate.substring(12, 14);
}

//날짜 셋팅 - 초기화
function fnDateReset(v_start_name, v_end_name){
    $("#"+v_start_name  ).val("");
    $("#"+v_end_name    ).val("");
}

// 날짜 셋팅 - 오늘, 일주일, 15일, 한달, 두달
function fnDateSet(v_start_name, v_end_name, s_year, s_month, s_day, e_year, e_month, e_day, seperator){
    $("#"+v_start_name  ).val(getCalculatedDate(s_year, s_month, s_day, seperator));
    $("#"+v_end_name    ).val(getCalculatedDate(e_year, e_month, e_day, seperator));
}
function getCalculatedDate(iYear, iMonth, iDay, seperator){
    //현재 날짜 객체를 얻어옴.
    var gdCurDate = new Date();

    //현재 날짜에 날짜 게산.
    gdCurDate.setYear ( gdCurDate.getFullYear() + iYear );
    gdCurDate.setMonth( gdCurDate.getMonth()    + iMonth);
    gdCurDate.setDate ( gdCurDate.getDate()     + iDay  );

    //실제 사용할 연, 월, 일 변수 받기.
    var giYear  = gdCurDate.getFullYear();
    var giMonth = gdCurDate.getMonth()+1;
    var giDay   = gdCurDate.getDate();

    //월, 일의 자릿수를 2자리로 맞춘다.
    giMonth = "0" + giMonth;
    giMonth = giMonth.substring(giMonth.length-2,giMonth.length);
    giDay   = "0" + giDay;
    giDay   = giDay.substring(giDay.length-2,giDay.length);

    //display 형태 맞추기.
    return giYear + seperator + giMonth + seperator +  giDay;
}

/**
 * 글자제한
 * onkeyup="getStrByte(this,'#byte', 200, 3);"
 * 
 * focus 원치 않는 경우에만 noFocusYn 파라미터를 추가해준다. 
 * (ex: 화면 초기 로딩시 textarea byte수 보여줘야 하는 경우)
 * getStrByte(this,'#byte', 200, 3, 'Y');
 */
function getStrByte(obj, tgt, size, korSize, noFocusYn) {
    var korByte = korSize != undefined && korSize != "" ? parseInt(korSize, 10) : 3; //한글 바이트 (기본값 3)
    
    var str = obj.value;
    var str_max = size; 
    var p = 0;
    var bytes = 0;
    var len_num = 0;  
    var str2 = "";
 
    if(str != ""){
        for(p=0; p<str.length; p++) {
            (str.charCodeAt(p) > 255) ? bytes+=korByte : bytes++; //한글은 korByte, 영문, 숫자, 공백은 1byte
            if(bytes <= str_max){
                len_num = p + 1;
            }else{
                alert(size + " byte를 초과 입력할수 없습니다.\n초과된 내용은 자동으로 삭제 됩니다.");
                str2 = str.substr(0, len_num);
                obj.value = str2;
                break;
            }
            $(tgt).text(bytes);
        }
    }else{
        $(tgt).text("0");
    }
    
    if(noFocusYn == undefined || noFocusYn != "Y"){
        obj.focus();
    }
}
/**
 * 가격숫자만 입력가능체크 및 콤마
 * @param obj
 * @param fLen
 * @returns {Boolean}
 */
function addComma(obj,fLen)
{ 
   if(event.keyCode == 37 || event.keyCode == 39 ) 
   {                                              
      return;
   }
   var fLen = fLen || 2; 
   var strValue = obj.value.replace(/,|\s+/g,'');
   var strBeforeValue = (strValue.indexOf('.') != -1)? strValue.substring(0,strValue.indexOf('.')) :strValue ;
   var strAfterValue  = (strValue.indexOf('.') != -1)? strValue.substr(strValue.indexOf('.'),fLen+1) : '' ;
   if(isNaN(strValue))
   {
      alert('숫자만 입력가능합니다.');
      obj.value = "";
      return false;
   }
   var intLast =  strBeforeValue.length-1;
   var arrValue = new Array;
   var strComma = '';

   for(var i=intLast,j=0; i >= 0; i--,j++)
   { 
         
          if( j !=0 && j%3 == 0) 
          {   
              strComma = ',';
          }
          else
          {
              strComma = '';
          } 
          arrValue[arrValue.length] = strBeforeValue.charAt(i) + strComma  ;
   }
   obj.value=  arrValue.reverse().join('') +  strAfterValue;
}
/**
 * 콤마 만들기
 * @param x
 * @returns
 */
function setComma(x){
       var pattern = /(^[+-]?\d+)(\d{3})/;
       x += '';
       while (pattern.test(x)){
           x = x.replace(pattern, '$1' + ',' + '$2');
       }
       return x;
}
/**
 * 콤마제거
 * @param val
 * @returns
 */
function removeComma(val) {
    //console.log("val " + val);
    if (val == "" || val == undefined){
        val ="";
        
    }
    //self.focus();
    return val.split(",").join("");
}

//콤마제거후 숫자리턴
function getInt(val) {
    
    if (val == "" || val == undefined || val == null){
        val ="0";
    }
    return val.split(",").join("");
}

// 회원정보 상세팝업
function goMemberViewPopup(serverDomain, memId) {
	popup(serverDomain+"/am/member/infoMemberPopup.do?MEM_MST_MEM_ID=" + memId, "1200", "700", "yes", "goMemberViewPopup");
}

// 블랙리스트설정팝업
function goMemberBlkPopup(serverDomain, memId) {
	popup(serverDomain+"/am/member/infoMemberBlkPopup.do?MEM_MST_MEM_ID=" + memId, "600", "450", "no", "goMemberBlkPopup");
}

// 주문정보 상세팝업
function goOrderViewPopup(serverDomain, ordMstCd) {
    popup(serverDomain+"/am/order/orderPopup.do?ORD_MST_CD="+ordMstCd, "1500", "700", "yes", "orderView");
}

// 입점업체 검색팝업
function goVendorPopup (eachYn) {
    popup(serverDomain+"/am/vendor/searchVendorPopup.do??menuPath=targetForm&eachYn=" + eachYn, "900", "700", "yes", "vendorPopup");
}

// 카테고리 검색팝업
function goCategoryPopup (callbackFun, eachYn) {
    popup(serverDomain+"/am/display/categoryProductPopup.do?callbackFun=" + callbackFun + "&eachYn=" + eachYn, "800", "250", "yes", "categoryPopup");
}
// 상품검색 팝업
function goProductPopup (callbackFun, eachYn) {
    popup(serverDomain+"/am/product/basicProductPopup.do?callbackFun=" + callbackFun + "&eachYn=" + eachYn, "1500", "800", "yes", "productPopup");
}

// 검색폼 초기화
function searchClear(formId){
    $("#"+formId).find("input[type=text]").val("");
    $("#"+formId).find("select").find("option:eq(0)").prop("selected", true);
    $("#"+formId).find(":checkbox").prop("checked", false);
    
    var tmpRadioNm = "";
    
    $.each($("#"+formId).find(":radio"),function(idx,item){
        if(tmpRadioNm != $(item).attr("name")){
            $("#"+formId).find("input[name=" + $(item).attr("name") + "]:eq(0)").prop("checked", true);
        }
        tmpRadioNm = $(item).attr("name");
    });
}

/**
 * jquery 함수
 */
(function($) {
    $.fn.extend(jQuery, {
        /**
         * check 박스 전체 선택 해제 
         * 사용법 : $.checkBoxSelect("allSelect", "select") 전체선택 클래스, 선택 클래스 
         */
        checkBoxSelect : function(allSelect, select){
            //전체선택  이벤트 호출
            $(document).on("click", "."+allSelect, function (){
                $.checkBoxAllSelect(allSelect, select);
            });
            
            //개별선택 이벤트 호출
            $(document).on("click", "."+select, function (){
                $.checkBoxUnitSelect(allSelect, select);
            });
            
            //로딩
            if($("."+allSelect).is(":checked")){
                $.checkBoxAllSelect(allSelect, select);
            }else{
                $.checkBoxUnitSelect(allSelect, select);
            }
        },
        
        //전체 선택
        checkBoxAllSelect : function(allSelect, select){
            var totalCount = $("."+select).length; 
            if( totalCount <= 0 ){
                $("."+allSelect).prop("checked", false);
                return; 
            }
            if($("."+allSelect).is(":checked")){
                $("."+select).prop("checked", true);
            }else{
                $("."+select).prop("checked", false);
            }           
        },
        
        //개별 선택
        checkBoxUnitSelect : function(allSelect, select){
            var checkdLength = $("."+select + ":checked").length;
            var totalCount = $("."+select).length; 
            
            //선택된 checkbox 확인
            if(checkdLength > 0 && checkdLength == totalCount){
                $("."+allSelect).prop("checked", true);
            }else{
                $("."+allSelect).prop("checked", false);
            }
        }
    }); 

    /**
     * 상품 카테고리 Select box
     * */
    getCategoryList = function(obj, upIdx, selectIdx, serverDomain, env)
    {
        var title = "1차 카테고리";
        if(obj.indexOf("2") > -1)
        {
            title = "2차 카테고리";
        }
        if(obj.indexOf("3") > -1)
        {
            title = "3차 카테고리";
        }
        if(obj.indexOf("4") > -1)
        {
            title = "4차 카테고리";
        }
        if(obj.indexOf("5") > -1)
        {
            title = "5차 카테고리";
        }
        
        if(env==null || env==' ') env='P';
        
        $.ajax({
            type    : "POST",
            url     : serverDomain + "/am/product/subCategoryProductAjax.do",
            data    :  { "PRD_CTG_IDX":upIdx, "PRD_CTG_ENV":env},
            dataType : "JSON",
            async   : false,
            success : function(data)
            {
                var selected = "";
                $("#"+obj).empty().append("<option value=''>"+title+"</option>");
                $.each(data.categoryList, function(i,item) 
                {
                    if (item.PRD_CTG_IDX == selectIdx)
                    {
                        selected = "selected";
                    } 
                    else 
                    {
                        selected = "";
                    }
                    $("#"+obj).append("<option value='"+item.PRD_CTG_IDX+"' "+selected+">"+item.PRD_CTG_NM+"</option>");
                });

            },
            error   : function(xhr,status,error)
            { 
                alert("상품 카테고리 호출 중 에러가 발생하였습니다.");
                //alert("code:"+xhr.status); 
            }
        });
    };
    
    /**
     * 스펙 카테고리 Select box
     * */
    getSpecList = function(obj, upIdx, selectIdx, serverDomain, env)
    {
        var title = "전체";
        if(obj.indexOf("2") > -1)
        {
            title = "1차 분류";
        }
        if(obj.indexOf("3") > -1)
        {
            title = "2차 분류";
        }
        if(obj.indexOf("4") > -1)
        {
            title = "3차 분류";
        }
        
        if(env==null || env==' ') env='P';
        
        $.ajax({
            type    : "POST",
            url     : serverDomain + "/am/product/subSpecManagementProductAjax.do",
            data    :  { "SPC_MST_IDX":upIdx, "SPC_MST_ENV":env},
            dataType : "JSON",
            async   : false,
            success : function(data)
            {
                var selected = "";
                $("#"+obj).empty().append("<option value=''>"+title+"</option>");
                $.each(data.categoryList, function(i,item) 
                {
                    if (item.SPC_MST_IDX == selectIdx)
                    {
                        selected = "selected";
                    } 
                    else 
                    {
                        selected = "";
                    }
                    $("#"+obj).append("<option value='"+item.SPC_MST_IDX+"' "+selected+">"+item.SPC_MST_NM+"</option>");
                });

            },
            error   : function(xhr,status,error)
            { 
                alert("스펙 카테고리 호출 중 에러가 발생하였습니다.");
                //alert("code:"+xhr.status); 
            }
        });
    };
    
    /**
     * 품목 카테고리 Select box
     * */
    getItemList = function(obj, upIdx, selectIdx, serverDomain, env,showType)
    {
        var title = "전체";
        if(obj.indexOf("2") > -1)
        {
            title = "1차 분류";
        }
        if(obj.indexOf("3") > -1)
        {
            title = "2차 분류";
        }
        if(obj.indexOf("4") > -1)
        {
            title = "3차 분류";
        }
        
        if(env==null || env==' ') env='P';
        if(showType==null || showType==' ' || showType ==undefined) showType='default';
        
        $.ajax({
            type    : "POST",
            url     : serverDomain + "/am/product/subItemManagementAjax.do",
            data    :  { "ITM_CTG_IDX":upIdx, "ITM_CTG_ENV":env},
            dataType : "JSON",
            async   : false,
            success : function(data)
            {
                if(obj.indexOf("2") > -1 && upIdx == "")
                {
                    $("#applyItemCategoryList").html("<tr><td colspan=5>구분을 선택해주세요.</td></tr>");
                }
                
                if(obj == "applyItemCategoryList"){
                    var itmHtml = "";
                    var itmLen = data.categoryList.length;
                    var cols = 0;
                    if(showType == "checkbox"){
                        var arrySelectIdx = selectIdx.replace("[","").replace("]","").split(",");
                    }
                    $.each(data.categoryList, function(i,item) 
                    {
                        if(showType == "checkbox"){
                            itmHtml = itmHtml + "<input type=\"checkbox\" name=\"searchErpMstNfis\" id=\"searchErpMstNfis_"+i+"\" value=\""+item.ITM_CTG_ERP_CD+"\" ";
                            for(ii = 0; ii <arrySelectIdx.length; ii++){
                                if($.trim(arrySelectIdx[ii]) == item.ITM_CTG_ERP_CD){
                                    itmHtml = itmHtml + "checked=true";
                                }
                            }
                            itmHtml = itmHtml + "/> ";
                            itmHtml = itmHtml + "<label for=\"searchErpMstNfis_"+i+"\" > "+ item.ITM_CTG_NM + "</label>";
                        }else{
                            if(i == 0 || i % 5 == 0){
                                itmHtml = itmHtml + "<tr>";
                            }
                            
                            if((i+ 1) == itmLen){
                                cols = (5 - (itmLen % 5) + 1);
                                itmHtml = itmHtml + "<td colspan="+cols+" class=\"left\" style=\"padding-left:25px;\">" + item.ITM_CTG_NM + "</td>";
                            }else{
                                itmHtml = itmHtml + "<td>" + item.ITM_CTG_NM + "</td>";
                            }
                            
                            if((i + 1) % 5 == 0 || (i + 1) == itmLen) {
                                itmHtml = itmHtml + "</tr>";
                            }
                        }
                    });
                    //기본TR삭제
                    $("#itemCategoryNodata").remove();
                    $("#applyItemCategoryList").html(itmHtml);
                }else{
                   var selected = "";
                    $("#"+obj).empty().append("<option value=''>"+title+"</option>");
                    $.each(data.categoryList, function(i,item) 
                    {
                        if (item.ITM_CTG_IDX == selectIdx)
                        {
                            selected = "selected";
                        } 
                        else 
                        {
                            selected = "";
                        }
                        $("#"+obj).append("<option value='"+item.ITM_CTG_IDX+"' "+selected+">"+item.ITM_CTG_NM+"</option>");
                    });
               }
               
            },
            error   : function(xhr,status,error)
            { 
                alert("품목 카테고리 호출 중 에러가 발생하였습니다.");
                //alert("code:"+xhr.status); 
            }
        });
    };

    /**
     * 상품구분 Select box
     * */
    getGdsSctnList = function(obj, brandCd, selectCd, serverDomain)
    {
        var title = "전체";
        
        $.ajax({
            type    : "POST",
            url     : serverDomain + "/am/product/subGdsSctnProductAjax.do",
            data    :  { "BRAND_CD":brandCd },
            dataType : "JSON",
            async   : false,
            success : function(data)
            {
                var selected = "";
                $("#"+obj).empty().append("<option value=''>"+title+"</option>");
                $.each(data.gdsSctnList, function(i,item) 
                {
                    if (item.GDS_SCTN_CD == selectCd)
                    {
                        selected = "selected";
                    } 
                    else 
                    {
                        selected = "";
                    }
                    $("#"+obj).append("<option value='"+item.GDS_SCTN_CD+"' "+selected+">"+item.GDS_SCTN_NM+"</option>");
                });

            },
            error   : function(xhr,status,error)
            { 
                alert("상품구분 호출 중 에러가 발생하였습니다.");
                //alert("code:"+xhr.status); 
            }
        });
    };
    
    // 검색결과 없는 경우 colspan 처리
    var $td_no_result = $("td.td_no_result");
    $td_no_result.prop("colspan", $td_no_result.parents("table:first").find("tr:eq(0)").children().length);
    
})(jQuery);

//우편번호 팝업 
function goSearchZipCodeAdmin(serverDomain, searchGubun) 
{ 
    window.open(serverDomain + "/am/common/commonZipCodePopup.do?searchGubun="+searchGubun, "searchZipCodePopup", "width=600, height=700, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbars=yes");
} 



/*
 * ClassName : stringUtil
 * Description : 문자열 관련 Class
 */
var stringUtil = {
    /* 문자열확인 후 문자열 또는 기본값 리턴
    str:체크 문자열 def:기본값 */
    getString: function(str, def) {
        if (str != undefined && str && str != "" && str != "null") {
            return $.trim(str);
        } else {
            return $.trim(def);
        }
    },
    /* 정수형 확인 후 정수형 또는 기본값 리턴
    num:체크 정수형 / def:기본값 */
    getInt: function(num, def) {
        var val = parseInt(num, 10);

        if (isNaN(val)) {
            return def;
        } else {
            return val;
        }
    },
    /* 공백제거
    str: 공백 제거 할 문자열*/
    trim: function(str) {
        return $.trim(str);
    },
    /* Date
     */
    getDateView: function(regdt) {

        var yyyy = regdt.substring(0, 4);
        var MM = regdt.substring(4, 6) - 1;
        var dd = regdt.substring(6, 8);
        var hh = regdt.substring(8, 10);
        var mm = regdt.substring(10, 12);
        var ss = regdt.substring(12, 14);

        var nowDate = new Date();
        var regDate = new Date(yyyy, MM, dd, hh, mm, ss);

        var ss = Math.floor(nowDate.getTime() - regDate.getTime()) / 1000;
        var mm = Math.floor(ss / 60);
        var hh = Math.floor(mm / 60);
        var day = Math.floor(hh / 24);

        var diff_hour = Math.floor(hh % 24);
        var diff_minute = Math.floor(mm % 60);
        var diff_second = Math.floor(ss % 60);

        //console.log( regdt + ' 계산 시간   : ' + day +  '일 ' + diff_hour  + ' 시간 ' + diff_minute + ' 분 ' + diff_second  + ' 초 ');
        var returnDate = "";
        if (day > 1 || diff_hour > 1) {
            returnDate = regDate.format("yyyy.MM.dd HH:mm");
        } else {
            returnDate = diff_minute + "분 전";
        }

        return returnDate;
    },
    /* Format Date
     */
    formatDate: function(regdt, f) {
        //console.log(regdt)
        var yyyy = regdt.substring(0, 4);
        var yy = regdt.substring(2, 4);
        var MM = regdt.substring(4, 6);
        var dd = regdt.substring(6, 8);
        var hh = regdt.substring(8, 10);
        var mm = regdt.substring(10, 12);
        var ss = regdt.substring(12, 14);

        return f.replace(/(yyyy|yy|MM|dd|hh|mm|ss)/gi, function($1) {
            switch ($1) {
                case "yyyy":
                    return yyyy;
                case "yy":
                    return yy.zf(2);
                case "MM":
                    return MM.zf(2);
                case "dd":
                    return dd.zf(2);
                case "hh":
                    return hh.zf(2);
                case "mm":
                    return mm.zf(2);
                case "ss":
                    return ss.zf(2);
                default:
                    return $1;
            }
        });
    },
    formatDateStr: function (regdt, f) {
        var yyyy = regdt.substring(0, 4);
        var yy = regdt.substring(2, 4);
        var MM = regdt.substring(4, 6);
        var dd = regdt.substring(6, 8);
        var hh = regdt.substring(8, 10);
        var mm = regdt.substring(10, 12);
        var ss = regdt.substring(12, 14);
        
        return f.replace(/(yyyy|yy|MM|dd|hh|mm|ss)/gi, function($1) {
            switch ($1) {
                case 'yyyy':
                    return yyyy;
                case 'yy':
                    return yy;
                case 'MM':
                    return MM;
                case 'dd':
                    return dd;
                case 'hh':
                    return hh;
                case 'mm':
                    return mm;
                case 'ss':
                    return ss;
                default:
                    return $1;
            }
        });
    },
    /* set Comma */
    setComma: function(num) {
        var pattern = /(^[+-]?\d+)(\d{3})/;
        num += '';
        while (pattern.test(num)) {
            num = num.replace(pattern, '$1' + ',' + '$2');
        }
        return num;
    },
    /* remove Comma */
    removeComma: function(num) {
        return num.replace(/,/gi, "");
    }
};

Date.prototype.Format = function(fmt)
{ 
    var o = {
        "M+" : this.getMonth()+1,                 //
        "d+" : this.getDate(),                    //
        "h+" : this.getHours(),                   //
        "m+" : this.getMinutes(),                 //
        "s+" : this.getSeconds(),                 //
        "q+" : Math.floor((this.getMonth()+3)/3), //
        "S"  : this.getMilliseconds()             //
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}

/*스마트 에디터 display:none 에서 show 로 바뀔때 height 값 0으로 되는 부분 수정하는 function
 *  textareaId 해당 textarea id
 * h 원하는 height 값
 * editorNum 해당 editor 번호(없는 경우 입력 안한다)
 * */
function showSmartEditor(textareaId, h, editorNum){
    //oEditors.getById['PRD_MST_DETAIL_DESC'].exec('CHANGE_EDITING_MODE', ['WYSIWYG']); //클릭 안되는 문제 해결
    
    //가로폭 조정
    $('#'+textareaId).next().contents().find("#smart_editor2").css("width","100%");
    $('#'+textareaId).next().contents().find(".se2_input_area").css("width","100%");
    
    //$('#PRD_MST_DETAIL_DESC').next().css("height",$('#PRD_MST_DETAIL_DESC').height() + 300);
    //$('#PRD_MST_DETAIL_DESC').next().contents().find("#se2_iframe").css("height",$('#PRD_MST_DETAIL_DESC').height() + 300);
    
    //세로폭 조정
    $('#'+textareaId).next().height($('#'+textareaId).height() + (h+50)); //height값 강제 지정
    
    var editor;
    if(editorNum == undefined){
        editor = eval("oEditors");
    }else{
        editor = eval("oEditors"+editorNum);
    }   
    
    editor.getById[textareaId].exec('MSG_EDITING_AREA_RESIZE_STARTED', []); 
    editor.getById[textareaId].exec('RESIZE_EDITING_AREA', [0, $('#'+textareaId).height()+h]); 
    editor.getById[textareaId].exec('MSG_EDITING_AREA_RESIZE_ENDED', []);
}
