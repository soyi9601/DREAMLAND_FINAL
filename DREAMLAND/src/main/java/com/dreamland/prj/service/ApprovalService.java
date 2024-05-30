package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;

public interface ApprovalService {
	int registerAppletter(HttpServletRequest request);
	int registerAppLeave(HttpServletRequest request);
	int apvApprove(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadAppList(Model model);
	ResponseEntity<Map<String, Object>> loadWaitAppList(Model model);
	ResponseEntity<Map<String, Object>> loadConfirmAppList(Model model);
	ResponseEntity<Map<String, Object>> loadCompleteAppList(Model model);
	public void loadAppByNo(HttpServletRequest request, Model model);
		

}
