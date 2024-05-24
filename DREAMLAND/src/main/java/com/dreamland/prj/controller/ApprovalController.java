package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dreamland.prj.service.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/approval")
@RequiredArgsConstructor
@Controller
public class ApprovalController {
	
	private final ApprovalService approvalService;
	
	@GetMapping("/appWrite")
	public String appWrite() {
		return "approval/appWrite";
	}
	
	@GetMapping("/appList" )
	  public String applist(HttpServletRequest request, Model model) {
		return "approval/appList";
	}
	
	@GetMapping(value="/totalList.do", produces="application/json")
	  public ResponseEntity<Map<String, Object>> appTotalList(HttpServletRequest request, Model model) {
	    model.addAttribute("request", request);
		return approvalService.loadAppList(model);
	}
	
	@GetMapping(value="/waitList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> waitList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadAppList(model);
	}
	
	@GetMapping(value="/comfirmlList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> comfirmlList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadAppList(model);
	}
	
	@GetMapping(value="/completeList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> completeList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadAppList(model);
	}
	
	@GetMapping("/approval.do")
	public String approval(HttpServletRequest request) {
		approvalService.registerAppletter(request);
		return "approval/appList";
	}
	
	@GetMapping("/leave.do")
	public String leave(HttpServletRequest request) {
		approvalService.registerAppLeave(request);
		return "approval/appList";
	}

}
