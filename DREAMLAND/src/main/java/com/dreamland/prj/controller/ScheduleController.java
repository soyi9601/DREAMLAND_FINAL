package com.dreamland.prj.controller;

import java.util.Enumeration;

import org.apache.taglibs.standard.lang.jstl.EnumeratedMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.dto.ScheduleDto;
import com.dreamland.prj.service.FaqBoardService;
import com.dreamland.prj.service.ScheduleService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@RequestMapping("/schedule")
@RequiredArgsConstructor
@Controller
public class ScheduleController {
	private final ScheduleService scheduleService;
	
	// 테스트 페이지이동
	@GetMapping("/calendar")
	public String calendarPage() {
	  return "schedule/calendar";
	}
	@PostMapping(value="/register.do", produces="application/json")
  public String register(@RequestParam HttpServletRequest request, RedirectAttributes redirectAttributes) {
	  
	// 요청 파라미터 로그 출력
    System.out.println("Request Parameters:");
    Enumeration<String> parameterNames = request.getParameterNames();
    while (parameterNames.hasMoreElements()) {
        String paramName = parameterNames.nextElement();
        System.out.println(paramName + ": " + request.getParameter(paramName));
    }
	  
    redirectAttributes.addFlashAttribute("insertCount", scheduleService.registerSkd(request));
	  //scheduleService.registerSkd(request);
	  return "redirect:/schedule/calendar";
  }
	  
}