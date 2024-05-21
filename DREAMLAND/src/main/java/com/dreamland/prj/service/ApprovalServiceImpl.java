package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class ApprovalServiceImpl implements FaqBoardService {
	private final FaqBoardMapper faqBoardMapper;
	private final MyPageUtils myPageUtils;
	

	
}
