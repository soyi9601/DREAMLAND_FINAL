package com.dreamland.prj.service;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.ProductDto;
import com.dreamland.prj.dto.SalesDto;
import com.dreamland.prj.mapper.SalesMapper;
import com.dreamland.prj.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;


@Service
public class SalesServiceImpl implements SalesService {

	private final SalesMapper salesMapper;
	
	
	public SalesServiceImpl(SalesMapper salesMapper, MyPageUtils myPageUtils){
		this.salesMapper = salesMapper;
	}
	
	@Override
	public int registerProduct(HttpServletRequest request) {
		
	    // 사용자가 입력한 qty
	    String[] productNoArray = request.getParameterValues("productNo");
	    String[] priceArray = request.getParameterValues("price");
	    String[] goodsArray = request.getParameterValues("goods");
	

	    // ProductDto 객체 생성
	    List<ProductDto> products = new ArrayList<>();

	    for (int i = 0; i < productNoArray.length; i++) {
	        int productNo = Integer.parseInt(productNoArray[i]);
	        int price = Integer.parseInt(priceArray[i]);
	        String goods = goodsArray[i];	        

	        // ProductDto 객체 생성
	        ProductDto product = ProductDto.builder()
	                                       .productNo(productNo)
	                                       .goods(goods)
	                                       .price(price)
	                                       .build();
	        products.add(product);
	    }
	    
	    // DB에 저장
	    int insertCount = 0;
	    for (ProductDto product : products) {
	        insertCount += salesMapper.insertProduct(product);
	    }

	    return insertCount;
	}
	
	@Override
	public int registerSales(HttpServletRequest request) {
		
		// 사용자가 입력한 qty
    String[] qtyArray = request.getParameterValues("qty");
    String[] productNoArray = request.getParameterValues("productNo");
    String[] deptNoArray = request.getParameterValues("deptNo");
    String salesDate = request.getParameter("salesDate");
  	
    // 날짜 형식 지정
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // SalesDto 객체 생성
    List<SalesDto> saleses = new ArrayList<>();

    try {
    	java.util.Date utilDate = dateFormat.parse(salesDate);
      Date sqlDate = new Date(utilDate.getTime());
    
    for (int i = 0; i < qtyArray.length; i++) {
        int qty = Integer.parseInt(qtyArray[i]);
        int productNo = Integer.parseInt(productNoArray[i]);
        int deptNo = Integer.parseInt(deptNoArray[i]);	        

        
        
        DepartmentDto departmentDto = new DepartmentDto();
        departmentDto.setDeptNo(deptNo);
        ProductDto productDto = new ProductDto();
        productDto.setProductNo(productNo);
        
				// SalesDto 객체 생성
        SalesDto sales = SalesDto.builder()
                                 .qty(qty)
                                 .product(productDto)
                                 .dept(departmentDto)
                                 .salesDate(sqlDate)
                                 .build();
        
        saleses.add(sales);
    }
    
    } catch (ParseException e) {
    	e.printStackTrace();
    }
    
    
    		

    // DB에 저장
    int insertCount = 0;
    for (SalesDto sales : saleses) {
        insertCount += salesMapper.insertSales(sales);
    }

    return insertCount;
    
}
	
	@Override
	public List<Map<String, Object>> getAllproduct() {
		return salesMapper.findAllproduct();
	}
	
	@Override
	public BigDecimal findTodaySalesTotal() {
		return salesMapper.findTodaySalesTotal();
	}
	
	@Override
	public BigDecimal findCurrentWeekSalesTotal() {
		return salesMapper.findCurrentWeekSalesTotal();
	}
	
	@Override
	public BigDecimal findCurrentMonthSalesTotal() {
		return salesMapper.findCurrentMonthSalesTotal();
	}
	
	@Override
	public BigDecimal findCurrentYearSalesTotal() {
		return salesMapper.findCurrentYearSalesTotal();
	}

}
