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
}
