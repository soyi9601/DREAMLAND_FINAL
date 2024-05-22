package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
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
	
	@GetMapping("/appList")
	public String appList() {
		return "approval/appList";
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
