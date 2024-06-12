package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletRequest;

public interface ApprovalService {
	boolean registerAppletter(MultipartHttpServletRequest multipartRequest);
	boolean registerAppLeave(MultipartHttpServletRequest multipartRequest);
	int apvApprove(HttpServletRequest request);
	int apvRevoke(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadAppList(Model model);
	ResponseEntity<Map<String, Object>> loadWaitAppList(Model model);
	ResponseEntity<Map<String, Object>> loadConfirmAppList(Model model);
	ResponseEntity<Map<String, Object>> loadCompleteAppList(Model model);
	
	ResponseEntity<Map<String, Object>> loadtotalMyAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadconfirmMyAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadCompleteMyAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadrejectedMyAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadtempMyAppList(HttpServletRequest request);
	
	ResponseEntity<Map<String, Object>> loadtotalMyReferAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadconfirmMyReferAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadCompleteMyReferAppList(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> loadrejectedMyReferAppList(HttpServletRequest request);
	public void loadTempApp(HttpServletRequest request, Model model);
	public void loadAppByNo(HttpServletRequest request, Model model);
	public void deleteApp(HttpServletRequest request);
	ResponseEntity<Resource> download(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> employeeList(HttpServletRequest request);
	boolean  deleteAttach(HttpServletRequest request);
		

}
