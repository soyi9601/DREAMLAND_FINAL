package com.dreamland.prj.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.ProductDto;
import com.dreamland.prj.service.SalesService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class SalesController {

  private final SalesService salesService;
  
  //상품 등록 페이지를 보여주는 메서드
  @GetMapping("/productreg.page")
  public String productregpage() {
      return "sales/productreg";
  }
  
  //상품 등록을 처리하는 메서드
  @PostMapping("/productreg.do")
  public String productreg(HttpServletRequest request, RedirectAttributes redirectAttributes) {
  	int insertCount = salesService.registerProduct(request); // 상품 등록 서비스를 호출
		if (insertCount == 0) {
       redirectAttributes.addFlashAttribute("errorMessage", "판매 등록 중 오류가 발생했습니다.");
       return "redirect:/sales/productreg.page"; // 오류 메시지와 함께 상품 등록 페이지로 리다이렉트
		}
  	redirectAttributes.addFlashAttribute("insertProduct", insertCount); // 등록된 상품 수를 리다이렉트 시에 전달
    return "redirect:/sales/productlist.do";	// 상품 목록 페이지로 리다이렉트
  }
  
  // 판매 등록 페이지를 보여주는 메서드
  @GetMapping("/salesreg.page")
  public String showAddSalesForm(Model model) {
      List<Map<String, Object>> product = salesService.getAllproduct(); // 모든 상품 정보를 조회
      model.addAttribute("product", product); // 상품 정보를 모델에 추가      
      return "sales/salesreg"; 
  }
  
  //판매 등록을 처리하는 메서드
  @PostMapping("/salesreg.do")
  public String salesreg(HttpServletRequest request, RedirectAttributes redirectAttributes) {
  		int insertCount = salesService.registerSales(request); // 판매 등록 서비스를 호출
  		if (insertCount > 0) {
         redirectAttributes.addFlashAttribute("successMessage", "판매가 성공적으로 등록되었습니다.");
     } else {
         redirectAttributes.addFlashAttribute("errorMessage", "판매 등록 중 오류가 발생했습니다.");
     }
      return "redirect:/sales/salesreg.page";
  }
  
  
  //모든 판매 상세 정보를 조회하는 메서드
  @GetMapping("/Allsales.page")
  public String getSalesDetails(Model model) {
  	// 일간,월간,연간 매출
  	BigDecimal TodaySalesTotal        = salesService.findTodaySalesTotal();
  	BigDecimal CurrentWeekSalesTotal  = salesService.findCurrentWeekSalesTotal();
  	BigDecimal CurrentMonthSalesTotal = salesService.findCurrentMonthSalesTotal();
  	BigDecimal CurrentYearSalesTotal  = salesService.findCurrentYearSalesTotal();
  	model.addAttribute("TodaySalesTotal", TodaySalesTotal); // 일간 매출을 모델에 추가
  	model.addAttribute("CurrentWeekSalesTotal", CurrentWeekSalesTotal); // 주간 매출을 모델에 추가
  	model.addAttribute("CurrentMonthSalesTotal", CurrentMonthSalesTotal); // 월간 매출을 모델에 추가
  	model.addAttribute("CurrentYearSalesTotal", CurrentYearSalesTotal);  // 연간 매출을 모델에 추가
		
  	Map<String, Object> params = new HashMap<>();
  	
  	List<Map<String, Object>> monthlySalesTotals = salesService.findMonthlySalesTotals(); // 월간 매출을 조회
  	model.addAttribute("monthlySalesTotals", monthlySalesTotals);
  	List<Map<String, Object>> yearlySalesTotals = salesService.findyearlySalesTotals();  // 연간 매출을 조회
  	model.addAttribute("yearlySalesTotals", yearlySalesTotals);
  	
  	List<Map<String, Object>> getPartSales = salesService.getPartSales(params); // 파트별 매출을 조회
  	model.addAttribute("getPartSales", getPartSales);
  	
  	List<Map<String, Object>>  getHunPartSales = salesService.getHunPartSales(params); // 5100파트 매출을 조회
  	List<Map<String, Object>>  getTHunPartSales = salesService.getTHunPartSales(params); // 5200파트 매출을 조회
  	List<Map<String, Object>>  getTrHunPartSales = salesService.getTrHunPartSales(params); // 5300파트 매출을 조회
  	List<Map<String, Object>>  getFHunPartSales = salesService.getFHunPartSales(params); // 5400파트 매출을 조회
  	List<Map<String, Object>>  getFvHunPartSales = salesService.getFvHunPartSales(params); // 5500파트 매출을 조회
  	model.addAttribute("getHunPartSales", getHunPartSales);
  	model.addAttribute("getTHunPartSales", getTHunPartSales);
  	model.addAttribute("getTrHunPartSales", getTrHunPartSales);
  	model.addAttribute("getFHunPartSales", getFHunPartSales);
  	model.addAttribute("getFvHunPartSales", getFvHunPartSales);
  	
  	return "sales/Allsales";
 
  }	
  
  //상품 목록을 조회하는 메서드
  @GetMapping("/productlist.do")
	public String list(HttpServletRequest request, Model model) {
  	model.addAttribute("request", request);
		salesService.loadProductList(model); // 상품 목록을 로드하는 서비스 메서드를 호출
		return "sales/productlist";
	}
  
  //상품 정보를 업데이트하는 메서드
  @PostMapping("/updateProduct.do")
  public String productupdate(HttpServletRequest request, RedirectAttributes redirectAttributes) {
  	
  	String[] productNoArray = request.getParameterValues("productChk"); // 체크된 상품 번호 배열
		
		List<String> productNos = new ArrayList<>(); // 상품 번호 리스트를 생성
		
		for (int i = 0; i < productNoArray.length; i++) {
			productNos.add(productNoArray[i]); // 상품 번호를 리스트에 추가
    }
		
		// ProductDto 객체 생성
		ProductDto product = ProductDto.builder()
																	 .delyn("Y")
																	 .productNoList(productNos)
																	 .build();
		
		salesService.updateProduct(product);
			

			return "redirect:/sales/productlist.do";
  }
      
 }
 
  
  

