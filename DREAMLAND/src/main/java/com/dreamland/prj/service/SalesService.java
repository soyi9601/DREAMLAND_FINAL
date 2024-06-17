package com.dreamland.prj.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.ProductDto;

import jakarta.servlet.http.HttpServletRequest;


public interface SalesService {
	
	int registerProduct(HttpServletRequest request); //상품 등록
	int registerSales(HttpServletRequest request); //매출 등록
	List<Map<String, Object>> getAllproduct(); //모든 상품 목록
	
	
	BigDecimal findTodaySalesTotal(); //오늘의 전체 매출 합계
  BigDecimal findCurrentMonthSalesTotal(); //현재 월의 전체 매출 합계
  BigDecimal findCurrentYearSalesTotal();	//현재 연도의 전체 매출 합계
  BigDecimal findCurrentWeekSalesTotal(); //현재 주의 전체 매출 합계
  
  //이번 달의 매출을 일별/이번 년도의 매출을 월별
  List<Map<String, Object>> findMonthlySalesTotals();
  List<Map<String, Object>> findyearlySalesTotals();
  
  //파트별 매출
  List<Map<String, Object>> getPartSales(Map<String, Object> params);
  
  //특정 파트별 매출
  List<Map<String, Object>> getHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getTHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getTrHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getFHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getFvHunPartSales(Map<String, Object> params);

  void loadProductList(Model model);	//상품목록 
  int updateProduct(ProductDto product); //업데이트된 상품
}
