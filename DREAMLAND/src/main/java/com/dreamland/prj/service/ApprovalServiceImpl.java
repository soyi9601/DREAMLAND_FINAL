package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.mapper.ApprovalMapper;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	private final ApprovalMapper approvalMapper; 
	

	@Override
	public int registerApproval(HttpServletRequest request) {
		
		// 사용자가 입력한 contents
		String title =  request.getParameter("title");
		
	    String contents =  request.getParameter("contents");
	    
	    String approver =  request.getParameter("approver");
	    String approver2 =  request.getParameter("approver2");
	    String approver3 =  request.getParameter("approver3");	    
	    String approver4 =  request.getParameter("approver4");
	    
	    String wathcer  =  request.getParameter("wathcer");
	    
	    
	    // 뷰에서 전달된 userNo
	    String userNo = request.getParameter("userNo");
	    approvalMapper.getEmployee(userNo);
	    String appKinds = request.getParameter("appKinds");
	    
	    
	    
	    // UserDto 객체 생성 (userNo 저장)
	    UserDto user = new UserDto();
	    user.setUserNo(userNo);
	    
	    // DB 에 저장할 BbsDto 객체
	    BbsDto bbs = BbsDto.builder()
	                    .contents(contents)
	                    .user(user)
	                  .build();
	    
	    return bbsMapper.insertBbs(bbs);
		
		return 0;
	}

	
}
