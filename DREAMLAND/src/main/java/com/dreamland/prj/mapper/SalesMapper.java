package com.dreamland.prj.mapper;


import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.dreamland.prj.dto.ProductDto;
import com.dreamland.prj.dto.SalesDto;

@Mapper
public interface SalesMapper {
	
	int insertSales(SalesDto sales);
	int insertProduct(ProductDto product);
	List<Map<String, Object>> findAllproduct();
	
	BigDecimal findTodaySalesTotal();
  BigDecimal findCurrentMonthSalesTotal();
  BigDecimal findCurrentYearSalesTotal();
  BigDecimal findCurrentWeekSalesTotal();
  
  List<Map<String, Object>> findMonthlySalesTotals();
  List<Map<String, Object>> findyearlySalesTotals();

  List<Map<String, Object>> findPartSales(Map<String, Object> params);
  
  List<Map<String, Object>> findHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> findTHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> findTrHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> findFHunPartSales(Map<String, Object> params);
  List<Map<String, Object>> findFvHunPartSales(Map<String, Object> params);

  int getProductCount();
  List<ProductDto> getProductList(Map<String,  Object> map);
  int updateProduct(ProductDto product);
}
