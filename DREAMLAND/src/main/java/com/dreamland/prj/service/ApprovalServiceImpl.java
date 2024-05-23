package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.AppletterDto;
import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.ApvWriterDto;
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
	private final MyPageUtils myPageUtils;
	

	@Override
 	public int registerAppletter(HttpServletRequest request) {
		
		// 사용자가 입력한 contents
		String title =  request.getParameter("title");
		
	    String contents =  request.getParameter("contents");
	    
	    int approver =  Integer.parseInt(request.getParameter("approver"));
	    int approver2 =  Integer.parseInt(request.getParameter("approver2"));
	    int approver3 =  Integer.parseInt(request.getParameter("approver3"));	    
	    int approver4 =  Integer.parseInt(request.getParameter("approver4"));
	    
	    int [] approvers = {approver, approver2, approver3, approver4};
	    
	    String wathcer  =  request.getParameter("wathcer");
	    	    
	    // 뷰에서 전달된 userNo
	    String userNo = request.getParameter("userNo");
	    
	   
	    
	    ApprovalDto app = ApprovalDto.builder()
	    						.empNo(Integer.parseInt(userNo))
	    						.apvTitle(title)
	    						.apvKinds("0")
	    						.build();
	    
	    approvalMapper.insertApproval(app);
	    int apvNo = approvalMapper.getApvNo();
	    
	    for(int i=0; i<approvers.length; i++) {
	    	
		    ApvWriterDto appwriter = ApvWriterDto.builder()
					 .apvNo(apvNo)
					 .writerList(i)
					 .empNo(approvers[i])
					  .build();
		    approvalMapper.insertApvWriter(appwriter);
		    
	    	
	    }

		    AppletterDto appletter = AppletterDto.builder()
		    		.apvNo(apvNo)
                    .letterDetail(contents)
                  .build();
		  approvalMapper.insertApvLetter(appletter);
		
		return 0;
	}
	
	@Override
	public int registerAppLeave(HttpServletRequest request) {
		
		// 사용자가 입력한 contents
		String title =  request.getParameter("title");
		
		// 사용자가 입력한 contents
	    String contents =  request.getParameter("contents");
	    
	  
	    
	    int approver =  Integer.parseInt(request.getParameter("approver"));
	    int approver2 =  Integer.parseInt(request.getParameter("approver2"));
	    int approver3 =  Integer.parseInt(request.getParameter("approver3"));	    
	    int approver4 =  Integer.parseInt(request.getParameter("approver4"));
	    
	    int [] approvers = {approver, approver2, approver3, approver4};
	    
	    String referrer  =  request.getParameter("referrer");
	    
	    
	    // 뷰에서 전달된 userNo
	    String userNo = request.getParameter("userNo");
	    String leavekind = request.getParameter("leavekind");
	    String leavestart = request.getParameter("leavestart");
	    String leaveend = request.getParameter("leaveend");
	   
	    ApprovalDto app = ApprovalDto.builder()
				.empNo(Integer.parseInt(userNo))
				.apvTitle(title)
				.apvKinds("1")
				.build();
	    
	    approvalMapper.insertApproval(app);
	    int apvNo = approvalMapper.getApvNo();
	    
	    for(int i=0; i<approvers.length; i++) {
	    	
		    ApvWriterDto appwriter = ApvWriterDto.builder()
					 .apvNo(apvNo)
					 .writerList(i)
					 .empNo(approvers[i])
					  .build();
		    approvalMapper.insertApvWriter(appwriter);
	    	
	    }

	    AppleaveDto appleave = AppleaveDto.builder()
                .leaveDeatil(contents)
				.leaveClassify(leavekind)
				.leaveStart(leavestart)
				.leaveEnd(leaveend)
				.build();
    
	    	
	    approvalMapper.insertApvLeave(appleave);		
		return 0;
	}

	@Override
	public void loadAppList(Model model) {
		
		 Map<String, Object> modelMap = model.asMap();
		    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		    
		    int total = approvalMapper.getApvCount();
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort);
		    
		    /*
		     * total = 100, display = 20
		     * 
		     * page  beginNo
		     * 1     100
		     * 2     80
		     * 3     60
		     * 4     40
		     * 5     20
		     */
		    model.addAttribute("beginNo", total - (page - 1) * display);
		    model.addAttribute("approvalList", approvalMapper.getApvList(map));
		    model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/approval/appList.do", sort, display));
		    model.addAttribute("display", display);
		    model.addAttribute("sort", sort);
		    model.addAttribute("page", page);
		
	}
}
