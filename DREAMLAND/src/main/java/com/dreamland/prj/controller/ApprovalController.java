package com.dreamland.prj.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/approval")
@Controller
public class ApprovalController {
	
	@GetMapping("/appWrite")
	public String getMethodName() {
		return "approval/appWrite";
	}
	

}
