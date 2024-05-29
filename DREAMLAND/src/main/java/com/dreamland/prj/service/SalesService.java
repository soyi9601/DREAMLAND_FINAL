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
}
