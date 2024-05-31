package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.service.WorkService;

import lombok.RequiredArgsConstructor;

@RequestMapping("/work")
@RequiredArgsConstructor
@Controller
public class WorkController {
  private final WorkService workService;
	
//	// 일정 페이지이동
//	@GetMapping("/calendar")
//	public String calendarPage() {
//	  return "schedule/calendar";
//	}
	
  
}