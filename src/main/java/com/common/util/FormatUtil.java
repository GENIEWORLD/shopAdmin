package com.common.util;

public class FormatUtil {

    /**
     * yyyyMMdd 형식의 날짜문자열을 원하는 캐릭터(ch)로 쪼개 돌려준다<br/>
    * <pre>
    * ex) 20030405, ch(.) -> 2003.04.05
    * ex) 200304, ch(.) -> 2003.04
    * ex) 20040101,ch(/) --> 2004/01/01 로 리턴
    * </pre>
    * 
    * @param date yyyyMMdd 형식의 날짜문자열
    * @param ch 구분자
    * @return 변환된 문자열
     */
    public static String formatDate(String sDate, String ch) {
    	String dateStr = DateUtil.validChkDate(sDate);

        String str = dateStr.trim();
        String yyyy = "";
        String mm = "";
        String dd = "";

        if (str.length() == 8) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000"))
                return "";

            mm = str.substring(4, 6);
            if (mm.equals("00"))
                return yyyy;

            dd = str.substring(6, 8);
            if (dd.equals("00"))
                return yyyy + ch + mm;

            return yyyy + ch + mm + ch + dd;
        } else if (str.length() == 6) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000"))
                return "";

            mm = str.substring(4, 6);
            if (mm.equals("00"))
                return yyyy;

            return yyyy + ch + mm;
        } else if (str.length() == 4) {
            yyyy = str.substring(0, 4);
            if (yyyy.equals("0000"))
                return "";
            else
                return yyyy;
        } else
            return "";
    }    
    
    /**
     * HH24MISS 형식의 시간문자열을 원하는 캐릭터(ch)로 쪼개 돌려준다 <br>
     * <pre>
     *     ex) 151241, ch(/) -> 15/12/31
     * </pre>
     *
     * @param str HH24MISS 형식의 시간문자열
     * @param ch 구분자
     * @return 변환된 문자열
     */
     public static String formatTime(String sTime, String ch) {
     	String timeStr = DateUtil.validChkTime(sTime);
        return timeStr.substring(0, 2) + ch + timeStr.substring(2, 4) + ch + timeStr.substring(4, 6);
     }    
    
 	/**
 	 * yyyyMMdd 형태의 날짜를 년,월,일을 넣어서 표시한다.
 	 *
 	 * <pre>
 	 * strDate = FormatUtil.formatHangulDate("20140806163450"); // 2014년 08월 06일 16시 34분 50초
 	 * </pre>
 	 * 
 	 * @param val 입력일자(yyyyMMddHHmmss)
 	 * @return 구분자가 들어간 날짜형태
 	 */
 	public static String formatHangulDate(String val) {
		if (val == null) {
			return "";
		} else {
			val = val.trim();
			if (val.indexOf("-") > 0) {
				return val;
			} else if (val.length() == 6) {
				StringBuffer sbString = new StringBuffer(val.substring(0, 4));
				sbString.append("년 ").append(val.substring(4, 6)).append("월");
				return sbString.toString();
			} else if (val.length() == 8) {
				StringBuffer sbString = new StringBuffer(val.substring(0, 4));
				sbString.append("년 ").append(val.substring(4, 6)).append("월 ").append(val.substring(6, 8)).append("일");
				return sbString.toString();
			} else if (val.length() == 12) {
				StringBuffer sbString = new StringBuffer(val.substring(0, 4));
				sbString.append("년 ").append(val.substring(4, 6)).append("월 ").append(val.substring(6, 8)).append("일 ");
				sbString.append(val.substring(8, 10)).append("시 ").append(val.substring(10, 12)).append("분");
				return sbString.toString();
			} else if (val.length() == 14) {
				StringBuffer sbString = new StringBuffer(val.substring(0, 4));
				sbString.append("년 ").append(val.substring(4, 6)).append("월 ").append(val.substring(6, 8)).append("일 ");
				sbString.append(val.substring(8, 10)).append("시 ").append(val.substring(10, 12)).append("분 ").append(val.substring(12, 14)).append("초");
				return sbString.toString();
			} else {
				return val;
			}
		}
	}

 	/**
    * 기능 : 3개의 문자열로 나뉘어져 있는 전화번호를 "-"으로 연결된 하나의 문자열로 변환하여 반환한다.
    * 입력화면에서 나뉘어져 있는 각각의 전화번호 필드를 DB의 하나의 Column에 넣을때 사용한다.
    * param    str1      지역번호
    * param    str2      국번
    * param    str3      번호
    *@return   String    하나의 문자열로 연결된 문자열
    */
    public static String convTelNumber(String str1, String str2, String str3) {
        str1 = (str1 == null) ? "" : str1;
        str2 = (str2 == null) ? "" : str2;
        str3 = (str3 == null) ? "" : str3;
        return str1 + "-" + str2 + "-" + str3;
    }

    /**
    * 기능 : 3개의 문자열로 나뉘어져 있는 전화번호를 "-"으로 연결된 하나의 문자열로 변환하여 반환한다.
    * 입력화면에서 나뉘어져 있는 각각의 전화번호 필드를 DB의 하나의 Column에 넣을때 사용한다.
    * param    str1      지역번호
    * param    str2      국번
    * param    str3      번호
    *@return   String[]  전화번호 데이터
    */
    public static String[] convTelNumber(String telNumber) {
        String[] str = new String[]{"", "", ""};
        if(telNumber != null) {
            int index   = 0;
            String temp = "";
            int maxLen  = telNumber.length();
            for(int i=0; i<maxLen; i++) {
                temp = telNumber.substring(i, i+1);
                if("-".equals(temp)) {
                    str[index] += "";
                    index++;
                }
                else {
                    str[index] += temp;
                }
            }
        }

        return str;
    }


	/**
	 * 전화번호를 포멧을 주어 반환한다.
	 * 
	 * <pre>
	 * str = FormatUtil.convTelNumber("0111234567");
	 * </pre>
	 * 
	 * @param val 전화번호
	 * @return 형식이 지정된 전화번호
	 */
	public static String convTelNumber(String telNumber, String delimeter)
	{
		String resultText = "";
		resultText = telNumber.replaceAll(delimeter, "");
		
		if(resultText.indexOf(")") >= 0 || resultText.indexOf("-") >= 0 || resultText.length() < 7) {
			return telNumber;
		} else {
			int totalSize = resultText.length();
			if ( resultText.substring(0, 2).equals("02") && totalSize > 7 ) {
				resultText = resultText.substring(0, 2) + delimeter + resultText.substring(2, totalSize- 4) + delimeter + resultText.substring(totalSize - 4, totalSize);
			} else {
				String areaNum = resultText.substring(0, 3);
				if(totalSize > 8 && 
						(areaNum.equals("031") || areaNum.equals("032") || areaNum.equals("033") || 
								areaNum.equals("041") || areaNum.equals("042") || areaNum.equals("043") || 
								areaNum.equals("051") || areaNum.equals("052") || areaNum.equals("053") || areaNum.equals("054") || areaNum.equals("055") ||
								areaNum.equals("061") || areaNum.equals("062") || areaNum.equals("063") || areaNum.equals("064") || 
								areaNum.equals("010") || areaNum.equals("011") || areaNum.equals("016") || areaNum.equals("017") || areaNum.equals("018") || areaNum.equals("019") ||
								areaNum.equals("012") || areaNum.equals("015" ))) {
					resultText = resultText.substring(0, 3) + delimeter + resultText.substring(3, totalSize- 4) + delimeter + resultText.substring(totalSize - 4, totalSize);
				} else {
					return telNumber;
				}
			}
			return resultText;
		}		
	}

	/**
    * 기능 : 우편번호 6자리를 받아 3자리씩 끊어 flag로 구분하여 연결한 문자열로 반환한다.
    * param    zipcode   우편번호(하나의 문자열)
    *@return   String[]  우편번호
    */
    public static String convZipcode(String zipcode, String flag) {
        String newZipcode = "";
        if(zipcode != null && zipcode.length() != 0) {
            zipcode = zipcode.trim();
            int len = zipcode.length();
            if(len >= 6) {
                newZipcode = zipcode.substring(0, 3) + flag + zipcode.substring(3, 6);
            }
            else if(len >= 3) {
                newZipcode = zipcode.substring(0, 3) + flag + zipcode.substring(3, len);
            }
            else {
                newZipcode = zipcode.substring(0, len) + flag + "";
            }
        }

        return newZipcode;
    }


    /**
    * 기능 : 우편번호 6자리를 받아 size가 2인 1차원 배열에 3자리씩 끊어 담아 반환한다.
    * param    zipcode   우편번호(하나의 문자열)
    * param    flag      구분자
    *@return   String[]  우편번호
    */
    public static String[] convZipcode(String zipcode) {
        String[] str = new String[]{"", ""};
        if(zipcode != null && zipcode.length() != 0) {
            zipcode = zipcode.trim();
            int len = zipcode.length();
            if(len >= 6) {
                str[0] = zipcode.substring(0, 3);
                str[1] = zipcode.substring(3, 6);
            }
            else if(len >= 3) {
                str[0] = zipcode.substring(0, 3);
                str[1] = zipcode.substring(3, len);
            }
            else {
                str[0] = zipcode.substring(0, len);
                str[1] = "";
            }
        }

        return str;
    }

    /**
    * 기능 : 숫자 3자리 당 콤마(,) 찍어 줌   ex) ###,###,###.#####
    * param    val     문자형 숫자
    * @return  결과값
    */
    public static String formatNumber(String val) {
        String ls_sign = "";
        String ls_num01 = "";
        String ls_num02 = "";
        if (StringUtil.nullCheck(val) == false && val.length() > 0) {
            if ((val.substring(0,1)).equals("-")) {
                ls_sign = "-";
                val = val.substring(1,val.length());
            }
            if ((val.indexOf(".")) != -1) {
                if ((val.length()-1) > val.indexOf(".")) ls_num02 = val.substring(val.indexOf("."), val.length());
                if ((val.indexOf(".")) == 0) val   = "0";
                else val   = val.substring(0, val.indexOf("."));
            }
            if ((val.length()) > 0) {
                for (int i = 0; i < val.length(); i++) {
                    if (i > 0 && ((val.length()-i) % 3) == 0) ls_num01 += ",";
                    ls_num01 += val.charAt(i);
                }
            }
        }
        val = ls_num01 +ls_num02;
        if (val.equals("") || val.equals("0")) return val;
        else return (ls_sign+val);
    }

	/**
	 * 카드번호를 포멧을 주어 반환한다.
	 * 
	 * <pre>
	 * str = FormatUtil.convCardNumber("1234567812345678");
	 * </pre>
	 * 
	 * @param val 카드번호
	 * @return 형식이 지정된 카드번호
	 */
	public static String convCardNumber(String val) {
		String delimeter = "-";
		String resultText = "";
		resultText = val.replaceAll(delimeter, "");
		if(resultText.indexOf(")") >= 0 || resultText.indexOf("-") >= 0 || resultText.length() < 5) {
			return val;
		} else {
			int totalSize = resultText.length();
			if(totalSize >= 13) {
				resultText = resultText.substring(0,4) + delimeter + resultText.substring(4,8) + delimeter + resultText.substring(8,12) + delimeter + resultText.substring(12);
			} 
		}			
		return resultText;
	}

	/**
	 * 이름의 2번째 자리를 "*" 마킹하여 반환한다.
	 * 
	 * <pre>
	 * str = FormatUtil.markingName("홍길동");
	 * </pre>
	 * 
	 * @param val 이름
	 * @return "*" 마킹한 이름 홍*동
	 */
	public static String markingName(String val) {
		String resultText = "";
		if(val.length() < 2) {
			resultText = val;
		} else if(val.length() == 2) {
			resultText = val.substring(0,1) + "*";
		} else {
			resultText = val.substring(0,1) + "*" + val.substring(2);
		}			
		return resultText;
	}

	/**
	 * 아이디의 마지막 4자리를 "*" 마킹하여 반환한다.
	 * 
	 * <pre>
	 * str = FormatUtil.markingId("honggildong");
	 * </pre>
	 * 
	 * @param val ID
	 * @return "*" 마킹한 ID honggil****
	 */
	public static String markingId(String val) {
		String resultText = "";
		if(val.length() <= 4) {
			resultText = val;
		} else {
			resultText = val.substring(0,val.length() - 4) + "****";
		}			
		return resultText;
	}

	/**
	 * 주소의 마지막 단락만 "****" 마킹하여 반환한다.
	 * 
	 * <pre>
	 * str = FormatUtil.markingAddress("101동 1111호");
	 * </pre>
	 * 
	 * @param val 주소
	 * @return "****" 마킹한 주소 101동 ****
	 */
	public static String markingAddress(String val) {
		String resultText = "";
		if(val.length() == 0) {
			resultText = val;
		} else {
			String[] arrVal = val.split(" ");
			arrVal[arrVal.length-1] = "****";
			for(String arrText : arrVal){
				resultText += arrText + " ";
			}
		}
		return resultText;
	}
}