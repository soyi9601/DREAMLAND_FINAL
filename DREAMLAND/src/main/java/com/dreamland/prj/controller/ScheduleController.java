package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.service.ScheduleService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/schedule")
@RequiredArgsConstructor
@Controller
public class ScheduleController {
	private final ScheduleService scheduleService;
	
//	// 일정 페이지이동
//	@GetMapping("/calendar")
//	public String calendarPage() {
//	  return "schedule/calendar";
//	}
	
  // 일정 조회
  @GetMapping(value="/calendar.do", produces="application/json")
  public String list(HttpServletRequest request, Model model) {
    scheduleService.loadSkdList(request, model);
    return "schedule/calendar";
  }
	
//일정 등록
 @PostMapping(value = "/register.do", produces="application/json")
 public ResponseEntity<Map<String, Object>> register(HttpServletRequest requset) {
   return ResponseEntity.ok(Map.of("insertSkdCount", scheduleService.registerSkd(requset)));
   
 }
  
  
//	// 일정 등록
//	@PostMapping(value = "/register.do", produces="application/json")
//  public String register(HttpServletRequest request, RedirectAttributes redirectAttributes) {
//	  
//	  // 요청 파라미터 로그 출력
//    System.out.println("Request Parameters:");
//    Enumeration<String> parameterNames = request.getParameterNames();
//    while (parameterNames.hasMoreElements()) {
//        String paramName = parameterNames.nextElement();
//        System.out.println(paramName + ": " + request.getParameter(paramName));
//    }
//	  
//    redirectAttributes.addFlashAttribute("insertCount", scheduleService.registerSkd(request));
//
//	  return "redirect:/schedule/calendar.do";
//  }
	
}