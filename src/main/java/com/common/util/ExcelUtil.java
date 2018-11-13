package com.common.util;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import egovframework.rte.fdl.property.EgovPropertyService;
import net.sf.jxls.transformer.XLSTransformer;


@Component
public class ExcelUtil {
    
    @Resource(name="propertiesService") 
    protected EgovPropertyService propertiesService;
    
	public static void excelDownload (HttpServletResponse response, String[] rowTitle, String[] cellSize, List<Map<String, Object>> dataList, String[] dataName, String[] dataType, String fileName) {
		
		try {
			
			// Excel Write
			HSSFWorkbook workbook = new HSSFWorkbook(); 
			
			// Sheet 생성
			HSSFSheet sheet = workbook.createSheet("Sheet1"); // 시트 생성
			
			// Cell Size 설정
			for ( int i = 0 ; i < cellSize.length ; i ++ ) {
				sheet.setColumnWidth(i, (Integer.parseInt(cellSize[i]) * 100));
			}
			
			
			/* ########################### TITLE 설정 및 ROW 생성 START ########################### */
			
			// Font 설정
			HSSFFont titleFont = workbook.createFont(); // 폰트 객체 생성
			titleFont.setFontName(HSSFFont.FONT_ARIAL); // 글씨체 설정 (ARIAL)
			titleFont.setFontHeightInPoints((short) 12); //글씨 크기 설정
			titleFont.setBoldweight((short)HSSFFont.BOLDWEIGHT_BOLD); // 글씨 굵기 설정 ( bold )
			titleFont.setColor(HSSFColor.WHITE.index); // 타이틀 글자 색상 설정
			
			// 제목의 스타일 지정
			HSSFCellStyle titleStyle = workbook.createCellStyle(); // 스타일 객체 생성
			titleStyle.setFillForegroundColor(HSSFColor.DARK_TEAL.index); // 셀에 색상 적용
			titleStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); // Background Color 없음
			titleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 가운데 정렬
			titleStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 셀 선 색 설정
			titleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 셀 하단 선 긋기
			titleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); // 셀 상단 선 긋기
			titleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); // 셀 왼쪽 선 긋기
			titleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); // 셀 오른쪽 선 긋기
			titleStyle.setFont(titleFont); // 폰트 적용
			
			// Title Row 생성
			HSSFRow titleRow = sheet.createRow((short)0);
			for( int i = 0 ; i < rowTitle.length ; i ++ ) {
				/* cell에 Title 맵핑 */
				HSSFCell cell = titleRow.createCell(i);
				cell.setCellStyle(titleStyle); // 셀 스타일 정의
				cell.setCellType(HSSFCell.CELL_TYPE_STRING); // 셀 타입 정의
				cell.setCellValue(rowTitle[i]); // 셀 내용 삽입
			}
			
			/* ########################### TITLE 설정 및 ROW 생성 END ########################### */
			
			
			/* ########################### CONTENT 설정 및 ROW 생성 START ########################### */
			
			// Font 설정
			HSSFFont contentFont = workbook.createFont(); // 폰트 객체 생성
			contentFont.setFontName(HSSFFont.FONT_ARIAL); // 글씨체 설정 (ARIAL)
			contentFont.setFontHeightInPoints((short) 10); //글씨 크기 설정
			contentFont.setBoldweight((short)HSSFFont.BOLDWEIGHT_NORMAL); // 글씨 굵기 설정 ( normal )

			
			// 날짜 포맷 스타일 지정
			HSSFCellStyle dateStyle = workbook.createCellStyle(); // 셀 스타일 객체 생성
			dateStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 가운데 정렬
			dateStyle.setFont(contentFont); // 폰트 적용
			dateStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy h:mm")); // 날짜포맷으로 변경
			dateStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 셀 선 색 설정
			dateStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 셀 하단 선 긋기
			dateStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); // 셀 상단 선 긋기
			dateStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); // 셀 왼쪽 선 긋기
			dateStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); // 셀 오른쪽 선 긋기
			
			// dollar 포맷 스타일 지정 ex) 20,000
			HSSFCellStyle dollarStyle = workbook.createCellStyle(); // 셀 스타일 객체 생성
			dollarStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 가운데 정렬
			dollarStyle.setFont(contentFont); // 폰트 적용
			dollarStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0")); // dollar 포맷으로 변경
			dollarStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 셀 선 색 설정
			dollarStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 셀 하단 선 긋기
			dollarStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); // 셀 상단 선 긋기
			dollarStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); // 셀 왼쪽 선 긋기
			dollarStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); // 셀 오른쪽 선 긋기
			
			// 기본스타일 지정
			HSSFCellStyle contentStyle = workbook.createCellStyle(); // 셀 스타일 객체 생성
			contentStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 가운데 정렬
			contentStyle.setFont(contentFont); // 폰트 적용
			contentStyle.setBottomBorderColor(HSSFColor.BLACK.index); // 셀 선 색 설정
			contentStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 셀 하단 선 긋기
			contentStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); // 셀 상단 선 긋기
			contentStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); // 셀 왼쪽 선 긋기
			contentStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); // 셀 오른쪽 선 긋기
		
			// Cell에 내용 맵핑
			for( int i = 0 ; i < dataList.size() ; i ++ ) {
				
				Map<String, Object> data = dataList.get(i);
				
				// Content Row 생성
				HSSFRow contentRow = sheet.createRow(i+1);
				
				for( int j = 0 ; j < dataName.length ; j ++ ){
					
					/* cell에 Content 맵핑 */
					HSSFCell cell = contentRow.createCell(j);
					
					// data Type에 맞추어 형변환을 하고, Cell type을 정의한다.
					if ("String".equals(StringUtil.getString(dataType[j], ""))) { // 문자형
						
						cell.setCellStyle(contentStyle); // 셀 스타일 정의
						cell.setCellType(HSSFCell.CELL_TYPE_STRING); // 셀 타입 정의
						cell.setCellValue(StringUtil.getString(data.get(dataName[j]), "")); // 셀 내용 삽입
						
					} else if ("Number".equals(StringUtil.getString(dataType[j], ""))) { // 숫자형
						
						cell.setCellStyle(contentStyle); // 셀 스타일 정의
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC); // 셀 타입 정의
						cell.setCellValue(Integer.parseInt(StringUtil.getString(data.get(dataName[j]), "0"))); //셀 내용 삽입
						
					} else if ("Boolean".equals(StringUtil.getString(dataType[j], ""))) { // boolean 형
						
						cell.setCellStyle(contentStyle); // 셀 스타일 정의
						cell.setCellType(HSSFCell.CELL_TYPE_BOOLEAN); // 셀 타입 정의
						cell.setCellValue("true".equals(StringUtil.getString(data.get(dataName[j]), "false"))); // 셀 내용 삽입
						
					} else if ("Date".equals(StringUtil.getString(dataType[j], ""))) { // 날짜형
						
						SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA); // 날짜 형식 지정
						
						Date date = sdf.parse(StringUtil.getString(data.get(dataName[j]), "20140127000000")); // 날짜 객체 생성
						cell.setCellStyle(dateStyle); // 셀 스타일 정의
						cell.setCellValue(date); // 셀 내용 삽입
						
					} else if ("Dollar".equals(StringUtil.getString(dataType[j], ""))){ // 화폐형
						
						cell.setCellStyle(dollarStyle); // 셀 스타일 정의
						cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC); // 셀 타입 정의
						cell.setCellValue(Long.parseLong(StringUtil.getString(data.get(dataName[j]), "0"))); // 셀 내용 삽입
						
					} else { // 문자형으로 정의
						
						cell.setCellStyle(contentStyle); // 셀 스타일 정의
						cell.setCellType(HSSFCell.CELL_TYPE_STRING); // 셀 타입 정의
						cell.setCellValue(StringUtil.getString(data.get(dataName[j]), "")); // 셀 내용 삽입
					}
				}
			}
		
			// ContetnType, Header 정보 설정
			response.setContentType("application/vnd.ms-excel");
	        response.setHeader("Content-Disposition", "attachment; filename="+fileName+".xls");
	        OutputStream os = response.getOutputStream();
	        
	        // Excel File 다운로드
			workbook.write(os);
			os.close();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static List<Map<String, Object>> excelRead(CommonsMultipartFile file, String [] columName) {
		
		List<Map<String, Object>> list = null; 
		Map <String, Object> dataMap = null;
		
		try {
			
			// file load
			POIFSFileSystem fs = new POIFSFileSystem(file.getInputStream());
			
			// 워크북 생성
			HSSFWorkbook workbook = new HSSFWorkbook(fs);
			
			// 함수 계산 객체
			FormulaEvaluator fe = workbook.getCreationHelper().createFormulaEvaluator();
			
			for( int s = 0 ; s < workbook.getNumberOfSheets() ; s++ ) { // Sheet Start
				
				list = new ArrayList<Map<String,Object>>();
				
				// 시트 추출
				HSSFSheet sheet = workbook.getSheetAt(s);

				for ( int r = 1 ; r < sheet.getPhysicalNumberOfRows() ; r++ ) { // Row Start
					
					dataMap = new HashMap<String, Object>();
					
					// 시트에대한 행 추출
					HSSFRow row = sheet.getRow(r);
					if ( row != null) { // Row Null Check Start
					    
						for ( int c = 0 ; c < columName.length ; c++ ) { // Cell Start
							
							// 행에대한 셀을 추출
							HSSFCell cell = row.getCell(c);
							
							if ( cell != null) { // Cell Null Check Start
								
								HSSFCellStyle style = cell.getCellStyle();
								// 셀 타입에 따라값 처리
								switch ( cell.getCellType() ) {
									
									// String 타입
									case HSSFCell.CELL_TYPE_STRING : 
										dataMap.put(columName[c], cell.getStringCellValue());
										
										break;
										
									// Date or Number
									case HSSFCell.CELL_TYPE_NUMERIC : 
										/*
										 * 날짜 타입 포맷 (아래와 같은 형식이 아닐 경우 String값으로 치환됨)
										 * ex ) 2013년 10월 10일 12:34:56 PM, 2013-10-22  12:34:56 PM
										 * 
										 */
										if ("m/d/yy".equals(style.getDataFormatString()) || 
												"reserved-0x1f".equals(style.getDataFormatString())) { // 날짜 타입
											SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA); // 날짜 형식 지정
											dataMap.put(columName[c], sdf.format(cell.getDateCellValue()));
										} else { // 정수

											dataMap.put(columName[c], NumberFormat
															.getNumberInstance()
															.format(cell.getNumericCellValue())
															.replaceAll(",", ""));
										}
										break;
										
									// Boolean 타입
									case HSSFCell.CELL_TYPE_BOOLEAN : 
										dataMap.put(columName[c], cell.getBooleanCellValue());
										break;
										
									// 함수 타입
									case HSSFCell.CELL_TYPE_FORMULA :
										
										// 함수 타입에 따라 처리
										switch (fe.evaluateFormulaCell(cell)) {
											
											// Number
											case HSSFCell.CELL_TYPE_NUMERIC :
												dataMap.put(columName[c], NumberFormat
														.getNumberInstance()
														.format(cell.getNumericCellValue())
														.replaceAll(",", ""));
												break;
												
											// String
											case HSSFCell.CELL_TYPE_STRING :
												dataMap.put(columName[c], cell.getStringCellValue());
												break;
											
											//Boolean
											case HSSFCell.CELL_TYPE_BOOLEAN :
												dataMap.put(columName[c], cell.getBooleanCellValue());
												break;
										}
										break;
										
									// 공백일 경우
									case HSSFCell.CELL_TYPE_BLANK : break;
									// Error 일 경우
									case HSSFCell.CELL_TYPE_ERROR : break;
									
									// 그 밖의 타입은 String
									default : 
										dataMap.put(columName[c], cell.getStringCellValue());
										break;
								}
							} // Cell Null Check End
						} // Cell End
						if(!dataMap.isEmpty()){
							list.add(dataMap);
						}
					} // Row End
				} // Row Null Check End
			} // Sheet End

		} catch(Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public void excelDownloadForJXTL (HttpServletRequest request, HttpServletResponse response, String templateName, Map<String, Object> dataMap) throws Exception {
	    if (!"".equals(templateName)) {
	        InputStream is = null;
	        OutputStream os  = null;
	        try {
	            String templatePath = this.propertiesService.getString("excel.template.path");
	            is = new BufferedInputStream(new FileInputStream(templatePath + templateName + ".xlsx"));
	            os = response.getOutputStream();
	            Workbook workbook = new XLSTransformer().transformXLS(is, dataMap);
	            
	            // ContetnType, Header 정보 설정
	            response.setContentType("application/vnd.ms-excel");
	            response.setHeader("Content-Disposition", "attachment; filename=" + templateName + ".xlsx");
	            
	            workbook.write(os); 
	            os.flush();
	        } catch (Exception e) {
	            e.printStackTrace();
	            throw e;
	        } finally {
	            if (os != null) { try { os.close(); } catch (Exception e) {} }
	            if (is != null) { try { is.close(); } catch (Exception e) {} }
	        }
	    } else {
	        throw new Exception("엑셀 템플릿명 누락");
	    }
	}
}
