package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/appMyList" )
	public String appMyList(HttpServletRequest request, Model model) {
		return "approval/appMyList";
	}
	
	@GetMapping("/popup")
	public String popup() {
		return "approval/popup";
	}
	
	
	
	@GetMapping(value="/totalList.do", produces="application/json")
	  public ResponseEntity<Map<String, Object>> appTotalList(HttpServletRequest request, Model model) {
	    model.addAttribute("request", request);
		return approvalService.loadAppList(model);
	}
	
	@GetMapping(value="/waitList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> waitList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadWaitAppList(model);
	}
	
	@GetMapping(value="/confirmList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> confirmlList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadConfirmAppList(model);
	}
	
	@GetMapping(value="/completeList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> completeList(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return approvalService.loadCompleteAppList(model);
	}
	
	
	
	
	@GetMapping(value="/totalMyList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> totalMyList(HttpServletRequest request) {
		return approvalService.loadtotalMyAppList(request);
	}
	
	@GetMapping(value="/waitMyList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> confirmMyList(HttpServletRequest request) {
		return approvalService.loadconfirmMyAppList(request);
	}
	
	@GetMapping(value="/completeMyList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> completeMyList(HttpServletRequest request) {
		return approvalService.loadCompleteMyAppList(request);
	}
	
	@GetMapping(value="/rejectedMyList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> rejectedMyList(HttpServletRequest request) {
		return approvalService.loadrejectedMyAppList(request);
	}
	
	
	
	
	
	@GetMapping("/detail.do")
	public String detail(HttpServletRequest request, Model model) {
		approvalService.loadAppByNo(request, model);
		return "approval/appDetail";
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
	
	@GetMapping("/approve.do")
	public String approve(HttpServletRequest request) {
	  System.out.println("실행됐슈1");
		approvalService.apvApprove(request);
		return "approval/appList";
	}
	


}
