package com.common.model;

public class Code {

    // 목록 title length
    public static final int product_title_length_max = 20;

    // 로그인(아이디누락, 비밀번호누락, 아이디/비밀번호확인, 사용중지계정)
    public static final String login_id_invalid = "login.proc.login_id_invalid";// 로그인 아이디 필요
    public static final String login_pw_invalid = "login.proc.login_pw_invalid";// 로그인 비밀번호 필요
    public static final String login_id_pw_incorrect = "login.proc.login_id_pw_incorrect";// 아이디/비밀번호확인
    public static final String login_stop_login = "login.proc.login_stop_login";// 계정중지
    public static final String login_success = "login.proc.login_success";// 로그인성공

    // 관리자 등급 목록(관리자, 디자이너..)
    public static final int ADMIN_TYPE = 9;
    public static final int ADMIN_TYPE_ADMIN = 10; // 관리자
    public static final int ADMIN_TYPE_DESIGNER = 11; // 디자이너

    // 구매, 가망 구분
    public static final String CUSTOMER_BUY = "B"; // 구매
    public static final String CUSTOMER_PROSPECT = "P"; // 가망

    // 가능여부(구매가능성)
    public static final String CUSTOMER_RAT_R = "R"; // 구매확율 0% > <img src="/img/icon/RAT_<c:out value="${Code.CUSTOMER_RAT_R}"/>.png" /> or <img src="/img/icon/RAT_<c:out value="${MEM_MST_RAT}"/>.png" />
    public static final String CUSTOMER_RAT_Y = "Y"; // 구매확율 50% > <img src="/img/icon/RAT_<c:out value="${Code.CUSTOMER_RAT_Y}"/>.png" /> or <img src="/img/icon/RAT_<c:out value="${MEM_MST_RAT}"/>.png" />
    public static final String CUSTOMER_RAT_G = "G"; // 구매확율 100% > <img src="/img/icon/RAT_<c:out value="${Code.CUSTOMER_RAT_G}"/>.png" /> or <img src="/img/icon/RAT_<c:out value="${MEM_MST_RAT}"/>.png" />

    // 매장 목록 코드
    public static final int STORE = 1;

    // 선물종류 코드
    public static final int GIFT_KIND = 20;
    public static final int GIFT_KIND_SET = 21; // 선물SET
    public static final int GIFT_KIND_CUFFS = 22; // 커프스
    public static final int GIFT_KIND_SOCKS = 31; // 양말
    public static final int GIFT_KIND_ETC = 32; // 기타

    // 일일일지 업무 코드
    public static final int DAY_WORK_GBN = 42;
    public static final int DAY_WORK_GBN_ADV = 43; // 상담
    public static final int DAY_WORK_GBN_SAL = 44; // 판매

    // 가계부 항목 코드
    public static final int LEDGERLIST_GBN = 48; // 가계부 항목
    public static final int LEDGERLIST_GBN_SLR = 49; // 급여
    
    // 주문상태
    public static final int ORDER = 33;
    public static final int ORDER_STATE_COMPLETE = 40; // 납품완료
    
    // 인센티브 구분
    public static final int INCEN_TYPE = 63;
    public static final int INCEN_TYPE_INDIVIDUAL = 64; // 개인 인센티브
    public static final int INCEN_TYPE_SHOP = 65; // 지점 인센티브
    // 매출구분
    public static final String SALES_TYPE_INDIVIDUAL = "I"; // 개인매출
    public static final String SALES_TYPE_SOP = "S"; // 지점매출
    // 급여구분
    public static final String SALARY_TYPE_INDIVIDUAL = "I"; // 개인급여
    public static final String SALARY_TYPE_SHOP = "S"; // 지점급여
    
    public static final int STORE_GRADE_CODE = 76; // 매장등급코드
    
    // 상품구분
    public static final int PRODUCT_GBN = 79; // 상품구분
    public static final int PRODUCT_GBN_FABRIC = 80; //원단
    
    // 상품상태
    public static final int PRODUCT_STATUS = 81; // 상품상태
    public static final int PRODUCT_STATUS_SALE = 82; // 판매중
    public static final int PRODUCT_STATUS_STOP = 83; // 판매중지
    public static final int PRODUCT_STATUS_TEMPORARILY_OUT = 84; // 일시품절
    public static final int PRODUCT_STATUS_SOLD_OUT = 85; // 품절
}
