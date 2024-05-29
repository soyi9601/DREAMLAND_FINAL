package com.dreamland.prj.controller;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;

import com.dreamland.prj.service.SalesService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/sales")
@RequiredArgsConstructor
@Controller
public class SalesController {

  private final SalesService salesService;

  @GetMapping("/productreg.page")
  public String productregpage() {
      return "sales/productreg";
  }
  
  @PostMapping("/productreg.do")
  public String productreg(HttpServletRequest request, RedirectAttributes redirectAttributes) {
  		redirectAttributes.addFlashAttribute("insertProduct", salesService.registerProduct(request));
      return "redirect:/sales/productreg.page";
  }
  
  @GetMapping("/salesreg.page")
  public String showAddSalesForm(Model model) {
      List<Map<String, Object>> product = salesService.getAllproduct();
      model.addAttribute("product", product);      
      return "sales/salesreg"; 
  }
  
  @PostMapping("/salesreg.do")
  public String salesreg(HttpServletRequest request, RedirectAttributes redirectAttributes) {
  		redirectAttributes.addFlashAttribute("insertSales", salesService.registerSales(request));
      return "redirect:/sales/salesreg.page";
  }
  
  
  @GetMapping("/Allsales.page")
  public String getSalesDetails(Model model) {
  	
  	// 일간,월간,연간 매출
  	BigDecimal TodaySalesTotal        = salesService.findTodaySalesTotal();
  	BigDecimal CurrentWeekSalesTotal  = salesService.findCurrentWeekSalesTotal();
  	BigDecimal CurrentMonthSalesTotal = salesService.findCurrentMonthSalesTotal();
  	BigDecimal CurrentYearSalesTotal  = salesService.findCurrentYearSalesTotal();
  	model.addAttribute("TodaySalesTotal", TodaySalesTotal);
  	model.addAttribute("CurrentWeekSalesTotal", CurrentWeekSalesTotal);
  	model.addAttribute("CurrentMonthSalesTotal", CurrentMonthSalesTotal);
  	model.addAttribute("CurrentYearSalesTotal", CurrentYearSalesTotal);
		
  	
  	return "sales/Allsales";
 
  }	
  
  
 
  
  

}