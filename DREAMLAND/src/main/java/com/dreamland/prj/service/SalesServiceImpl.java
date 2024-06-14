package com.dreamland.prj.service;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
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
	private final MyPageUtils myPageUtils;
	
	public SalesServiceImpl(SalesMapper salesMapper, MyPageUtils myPageUtils){
		this.salesMapper = salesMapper;
		this.myPageUtils = myPageUtils;
	}
	
	@Override
	public int registerProduct(HttpServletRequest request) {

	    // 사용자가 입력한 qty
	    String[] productSctCdArray = request.getParameterValues("productSctCd");
	    String[] priceArray = request.getParameterValues("price");
	    String[] productNMArray = request.getParameterValues("productNM");
	    String[] deptNoArray = request.getParameterValues("deptNo");
	    int insertCount = 0;
	    // ProductDto 객체 생성
	    List<ProductDto> products = new ArrayList<>();

	    for (int i = 0; i < productSctCdArray.length; i++) {
	        int productSctCd = Integer.parseInt(productSctCdArray[i]);
	        int price = Integer.parseInt(priceArray[i]);
	        int deptNo = Integer.parseInt(deptNoArray[i]);
	        String productNM = productNMArray[i];   

	        // 유효성 검사: 파트번호가 5000부터 6000 사이인지 확인
	        if (deptNo < 5000 || deptNo > 6000) {
	          // 유효하지 않은 파트번호이므로 해당 제품을 무시하고 다음 제품으로 넘어감
	        	continue;
	        }

	        DepartmentDto departmentDto = new DepartmentDto();
	        departmentDto.setDeptNo(deptNo);

	        // ProductDto 객체 생성
	        ProductDto product = ProductDto.builder()
	                                       .productSctCd(productSctCd)
	                                       .department(departmentDto)
	                                       .productNM(productNM)
	                                       .price(price)
	                                       .build();
	        products.add(product);
	    }

	    // DB에 저장
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
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    
	    // SalesDto 객체 생성
	    List<SalesDto> saleses = new ArrayList<>();

	    try {
	        LocalDate localDate = LocalDate.parse(salesDate, formatter);
	        java.sql.Date sqlDate = java.sql.Date.valueOf(localDate);
	        
	        for (int i = 0; i < qtyArray.length; i++) {
	            int qty = Integer.parseInt(qtyArray[i]);
	            int productNo = Integer.parseInt(productNoArray[i]);
	            int deptNo = Integer.parseInt(deptNoArray[i]);
	            
	     

	            if (qty > 0) {
	                DepartmentDto departmentDto = new DepartmentDto();
	                departmentDto.setDeptNo(deptNo);
	                ProductDto productDto = new ProductDto();
	                productDto.setProductNo(productNo);
	                
	                // SalesDto 객체 생성
	                SalesDto sales = SalesDto.builder()
	                                         .qty(qty)
	                                         .product(productDto)
	                                         .department(departmentDto)
	                                         .salesDate(sqlDate)
	                                         .build();
	                
	                saleses.add(sales);
	            }
	        }
	        
	    } catch (DateTimeParseException e) {
	        e.printStackTrace();
	        return 0; // 날짜 형식이 잘못되었을 경우
	    } catch (NumberFormatException e) {
	        e.printStackTrace();
	        return 0; // 숫자 형식이 잘못되었을 경우
	    }

	    // DB에 저장
	    int insertCount = 0;
	    for (SalesDto sales : saleses) {
	        try {
	            insertCount += salesMapper.insertSales(sales);
	        } catch (Exception e) {
	            e.printStackTrace();
	            // 개별 SalesDto 저장 실패 시 로그를 남기고 계속 진행할지, 중단할지 결정
	            // return 0; // 전체 실패 처리할 경우 사용
	        }
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

	@Override
	public List<Map<String, Object>> getPartSales(Map<String, Object> params) {
		return salesMapper.findPartSales(params);
	}
	
	@Override
	public List<Map<String, Object>> findMonthlySalesTotals() {
		return salesMapper.findMonthlySalesTotals();
	}
	@Override
	public List<Map<String, Object>> findyearlySalesTotals() {
		return salesMapper.findyearlySalesTotals();
	}
	
	
	
	@Override
	public List<Map<String, Object>> getHunPartSales(Map<String, Object> params) {
		return salesMapper.findHunPartSales(params);}
	@Override
	public List<Map<String, Object>> getTHunPartSales(Map<String, Object> params) {
		return salesMapper.findTHunPartSales(params);}
	@Override
	public List<Map<String, Object>> getTrHunPartSales(Map<String, Object> params) {
		return salesMapper.findTrHunPartSales(params);}
	@Override
	public List<Map<String, Object>> getFHunPartSales(Map<String, Object> params) {
		return salesMapper.findFHunPartSales(params);}
	@Override
	public List<Map<String, Object>> getFvHunPartSales(Map<String, Object> params) {
		return salesMapper.findFvHunPartSales(params);}

	@Transactional(readOnly = true)
	@Override
	public void loadProductList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		int total = salesMapper.getProductCount();
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("20"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myPageUtils.setPaging(total, display, page);
		
		String sort = "desc";
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
																	 , "end"  , myPageUtils.getEnd()
																	 , "sort" , sort);
		
		model.addAttribute("beginNo", total - (page - 1) * display);
		model.addAttribute("loadProductList", salesMapper.getProductList(map));
		model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/sales/productlist.do", sort, display));
		model.addAttribute("display", display);
		model.addAttribute("sort", sort);
		model.addAttribute("page", page);	
	}
	
	@Override
	public int updateProduct(ProductDto product) {
		return salesMapper.updateProduct(product);
	}
}
