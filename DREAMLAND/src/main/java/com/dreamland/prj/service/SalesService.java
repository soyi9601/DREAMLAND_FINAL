package com.dreamland.prj.service;



import java.math.BigDecimal;
import java.util.List;
import java.util.Map;



import jakarta.servlet.http.HttpServletRequest;


public interface SalesService {
	
	int registerProduct(HttpServletRequest request);
	int registerSales(HttpServletRequest request);
	List<Map<String, Object>> getAllproduct();
	
	BigDecimal findTodaySalesTotal();
  BigDecimal findCurrentMonthSalesTotal();
  BigDecimal findCurrentYearSalesTotal();
  BigDecimal findCurrentWeekSalesTotal();
  
  List<Map<String, Object>> findMonthlySalesTotals();
  List<Map<String, Object>> findyearlySalesTotals();
  
  List<Map<String, Object>> getPartSales(Map<String, Object> params);
  
  List<Map<String, Object>> getHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getTHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getTrHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getFHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> getFvHunPartSales(Map<String, Object> params);
}
