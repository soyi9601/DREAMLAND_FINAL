package com.dreamland.prj.service;

import org.springframework.ui.Model;

import com.dreamland.prj.dto.FaqBoardDto;

import jakarta.servlet.http.HttpServletRequest;

public interface ApprovalService {
	int registerApproval(HttpServletRequest request);

}
