package com.dreamland.prj.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.service.ApprovalService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequestMapping("/approval")
@RequiredArgsConstructor
@Controller
public class ApprovalController {
	
	private final ApprovalService approvalService;
	
	@GetMapping("/appWrite")
	public String appWrite(HttpServletRequest request, Model model) {
		if(!(request.getParameter("apvNo").equals("000"))) {
			approvalService.loadTempApp(request, model);
		}
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
	
	@GetMapping("/appReferList" )
	public String appReferList(HttpServletRequest request, Model model) {
		return "approval/appReferList";
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
	
	@GetMapping(value="/tempMyList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> tempMyList(HttpServletRequest request) {
		return approvalService.loadtempMyAppList(request);
	}
	
	
	
	@GetMapping(value="/totalMyReferList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> totalMyReferList(HttpServletRequest request) {
		return approvalService.loadtotalMyReferAppList(request);
	}
	
	@GetMapping(value="/waitMyReferList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> confirmMyReferList(HttpServletRequest request) {
		return approvalService.loadconfirmMyReferAppList(request);
	}
	
	@GetMapping(value="/completeMyReferList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> completeMyReferList(HttpServletRequest request) {
		return approvalService.loadCompleteMyReferAppList(request);
	}
	
	@GetMapping(value="/rejectedMyReferList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> rejectedMyReferList(HttpServletRequest request) {
		return approvalService.loadrejectedMyReferAppList(request);
	}
	

	
	
	@GetMapping("/detail.do")
	public String detail(HttpServletRequest request, Model model) {
		approvalService.loadAppByNo(request, model);
		return "approval/appDetail";
	}
	
	@PostMapping("/approval.do")
	public String approval(MultipartHttpServletRequest multipartRequest) {
		approvalService.registerAppletter(multipartRequest);
		return "approval/appList";
	}
	
	@PostMapping("/leave.do")
	public String leave(MultipartHttpServletRequest multipartRequest) {
		approvalService.registerAppLeave(multipartRequest);
		return "approval/appList";
	}
	
	@GetMapping("/approve.do")
	public String approve(HttpServletRequest request) {
		approvalService.apvApprove(request);
		return "approval/appList";
	}

	@GetMapping("/revoke.do")
	public String appRevoke(HttpServletRequest request) {
		approvalService.apvRevoke(request);
		return "approval/appMyList";
	}
	
	@GetMapping("/download.do")
	  public ResponseEntity<Resource> download(HttpServletRequest request) {
			return approvalService.download(request);
	}
	
		
	@GetMapping(value="/deleteAttach.do", produces="application/json")
	public ResponseEntity<Map<String, Object>>  deleteAttach(HttpServletRequest request) {
		  boolean success = approvalService.deleteAttach(request);
	        Map<String, Object> response = new HashMap<>();
	        if (success) {
	            response.put("success", true);
	            response.put("message", "Attachment deleted successfully");
	        } else {
	            response.put("success", false);
	            response.put("message", "Failed to delete attachment");
	        }
	        return ResponseEntity.ok(response);
	}

	@GetMapping(value= "/employeeList.do", produces="application/json")
	public ResponseEntity<Map<String, Object>> employeeList(HttpServletRequest request) {
		return approvalService.employeeList(request);
	}
}