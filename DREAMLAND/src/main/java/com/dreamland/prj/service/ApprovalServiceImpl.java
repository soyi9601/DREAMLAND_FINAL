package com.dreamland.prj.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.AppletterDto;
import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.ApvWriterDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.mapper.ApprovalMapper;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyAppPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	private final ApprovalMapper approvalMapper; 
	private final MyAppPageUtils myPageUtils;
	

	@Override
 	public int registerAppletter(HttpServletRequest request) {
		
		// 사용자가 입력한 contents
		String title =  request.getParameter("title");
	    String contents =  request.getParameter("contents");
	    
	    int approver  =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver")));
	    int approver2 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver2")));
	    int approver3 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver3")));
	    int approver4 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver4")));
	    
	    int [] approvers = {approver2, approver3, approver4};
	    
	    String referrer  =  request.getParameter("referrer");

        String[] array = referrer.split(" ");
        
        ApprovalDto app = ApprovalDto.builder()
				.empNo(approver)
				.apvTitle(title)
				.apvKinds("0")
				.build();

        approvalMapper.insertApproval(app);

        int apvNo = approvalMapper.getApvNo();
        // 배열 출력
        for (String refer : array) {
        	approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer), apvNo);
        }
	    	    
	    // 뷰에서 전달된 userNo
  
	
	   
	    
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
                    .detail(contents)
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
	    
	    int approver =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver")));
	    int approver2 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver2")));
	    int approver3 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver3")));
	    int approver4 =  Integer.parseInt(approvalMapper.getEmployeeNo(request.getParameter("approver4")));
	    
	    int [] approvers = {approver2, approver3, approver4};
	    
	    String referrer  =  request.getParameter("referrer");
	    
        String[] array = referrer.split(" ");
        
	    ApprovalDto app = ApprovalDto.builder()
				.empNo(approver)
				.apvTitle(title)
				.apvKinds("1")
				.build();
	    System.out.println(1231241);
	    approvalMapper.insertApproval(app);
	   

        int apvNo = approvalMapper.getApvNo();
        // 배열 출력
        for (String refer : array) {
        	approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer),apvNo);
        }
	    
	    
	    // 뷰에서 전달된 userNo
	    String leavekind = request.getParameter("leavekind");
	    String leavestart = request.getParameter("leavestart");
	    String leaveend = request.getParameter("leaveend");
	   
	    
	    

	    
	    for(int i=0; i<approvers.length; i++) {
	    	
		    ApvWriterDto appwriter = ApvWriterDto.builder()
					 .apvNo(apvNo)
					 .writerList(i)
					 .empNo(approvers[i])
					  .build();
		    approvalMapper.insertApvWriter(appwriter);
	    	
	    }

	    
	    AppleaveDto appleave = AppleaveDto.builder()
	    		.apvNo(apvNo)
				.leaveClassify(leavekind)
				.leaveStart(leavestart)
				.leaveEnd(leaveend)
				.detail(contents)
				.build();
	    	
	    approvalMapper.insertApvLeave(appleave);		
		return 0;
	}

	@Override
	public  ResponseEntity<Map<String, Object>> loadAppList(Model model) {

		    Map<String, Object> modelMap = model.asMap();
		    HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
			String empNo = request.getParameter("empNo");

			
		    
		    int total = approvalMapper.getApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map .of("beginNo", total - (page - 1) * display
                    ,"paging",myPageUtils.getPaging(sort, display)
                    , "approvalList" , approvalMapper.getApvList(map)
                    , "sort", sort
                    ,"page", page), HttpStatus.OK);
		
	}
	
	public  ResponseEntity<Map<String, Object>> loadWaitAppList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		String empNo = request.getParameter("empNo");
		int total = approvalMapper.getWaitApvCount(empNo);
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("20"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		
		myPageUtils.setPaging(total, display, page);
		
		Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		String sort = optSort.orElse("DESC");
		
		
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
				, "end", myPageUtils.getEnd()
				, "sort", sort
				, "empNo", empNo);
		
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
		return new ResponseEntity<>(Map .of("beginNo", total - (page - 1) * display
				,"paging",myPageUtils.getPaging( sort, display)
				, "approvalList" , approvalMapper.getWaitApvList(map)
				, "sort", sort
				,"page", page), HttpStatus.OK);
		
	}
	
	public  ResponseEntity<Map<String, Object>> loadConfirmAppList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		String empNo = request.getParameter("empNo");
		
		int total = approvalMapper.getConfirmApvCount(empNo);
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("20"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myPageUtils.setPaging(total, display, page);
		
		Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		String sort = optSort.orElse("DESC");
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
				, "end", myPageUtils.getEnd()
				, "sort", sort
				, "empNo", empNo);
		
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
		return new ResponseEntity<>(Map .of("beginNo", total - (page - 1) * display
				,"paging",myPageUtils.getPaging(sort, display)
				, "approvalList" , approvalMapper.getConfirmApvList(map)
				, "sort", sort
				,"page", page), HttpStatus.OK);
		
	}
	
	public  ResponseEntity<Map<String, Object>> loadCompleteAppList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		String empNo = request.getParameter("empNo");
		
		int total = approvalMapper.getCompleteApvCount(empNo);
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("20"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myPageUtils.setPaging(total, display, page);
		
		Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		String sort = optSort.orElse("DESC");
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
				, "end", myPageUtils.getEnd()
				, "sort", sort
				, "empNo", empNo);
		
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
		return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
				,"paging",myPageUtils.getPaging(sort, display)
				, "approvalList" , approvalMapper.getCompleteApvList(map)
				, "sort", sort
				,"page", page), HttpStatus.OK);
		
	}
    
	public void loadAppByNo(HttpServletRequest request, Model model) {
	    
		int apvNo = Integer.parseInt(request.getParameter("apvNo"));
		String Apvstate = request.getParameter("kind");
	    ApprovalDto a = approvalMapper.getApvDetailByNo(apvNo);
	    String title = a.getApvTitle();
	    String Apvkind = a.getApvKinds();
	    int ApvCheck = a.getApvCheck();
	    List<String> b = approvalMapper.getApprover(apvNo);
	    
	    String writer = approvalMapper.getEmployeeName(a.getEmpNo()+"");
	    String approver1 =approvalMapper.getEmployeeName(b.get(0));
	    String approver2 =approvalMapper.getEmployeeName(b.get(1));
	    String approver3 = approvalMapper.getEmployeeName(b.get(2));
	    
		Map<String, Object> map = Map.of("writer", writer
				, "approver1",approver1
				, "approver2", approver2
				, "approver3", approver3);
		if(ApvCheck == 2) {
			 ApvWriterDto RempNo = approvalMapper.getReturnApprover(apvNo);
			 model.addAttribute("reject", 1);
			 model.addAttribute("returner", approvalMapper.getEmployeeName(RempNo.getEmpNo()+""));
			 model.addAttribute("returnReason", RempNo.getReturnReason());
		} else {
			 model.addAttribute("reject", 0);
		}
		
		if(Apvkind.equals("0")) {
			 model.addAttribute("approval", approvalMapper.getApvAppDetailByNo(apvNo));
		} else {
			 model.addAttribute("approval", approvalMapper.getApvLeaveDetailByNo(apvNo));
		}
		
		model.addAttribute("title", title);
		model.addAttribute("kind", Apvkind);
		model.addAttribute("kind2", Apvstate);
	    model.addAttribute("appovers", map);
	    
	}

	@Override
	public int apvApprove(HttpServletRequest request) {
		int apvNo = Integer.parseInt(request.getParameter("apvNo"));
		int flag = 0;
		String empNo = request.getParameter("empNo");
		String returnReason = request.getParameter("rejectedReason");
		approvalMapper.updateApprover(apvNo,empNo,returnReason);
		
		if(returnReason.equals("0")) {
			List<String> b = approvalMapper.getApprovers(apvNo);
		 	for(int i=0; i< b.size(); i++) {
		 		if (b.get(i).equals("100")) {flag ++;}
		    }
		 	if(flag == 0) {approvalMapper.updateApproval(apvNo,1);}
		
		} else {
		    approvalMapper.updateApproval(apvNo, 2);
		}
		return 0;
	}
	
	
	@Override
	public ResponseEntity<Map<String, Object>> loadtotalMyAppList(HttpServletRequest request) {
			String empNo = request.getParameter("empNo");
		    int total = approvalMapper.getMyApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
                   , "paging",myPageUtils.getPaging(sort, display)
                   , "approvalList" , approvalMapper.getMyApvList(map)
                   , "sort", sort
                   , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadconfirmMyAppList(HttpServletRequest request) {
		
		String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyWaitApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
                , "paging",myPageUtils.getPaging(sort, display)
                , "approvalList" , approvalMapper.getMyWaitApvList(map)
                , "sort", sort
                , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadCompleteMyAppList(HttpServletRequest request) {
		
		   String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyCompleApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
                , "paging",myPageUtils.getPaging(sort, display)
                , "approvalList" , approvalMapper.getMyCompleteApvList(map)
                , "sort", sort
                , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadrejectedMyAppList(HttpServletRequest request) {
		
		String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyRejectApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
                , "paging",myPageUtils.getPaging(sort, display)
                , "approvalList" , approvalMapper.getMyRejectedApvList(map) 
                , "sort", sort
                , "page", page), HttpStatus.OK);
	}
   
	@Override
	public ResponseEntity<Map<String, Object>> loadtotalMyReferAppList(HttpServletRequest request) {
		
		String empNo = request.getParameter("empNo");
	    int total = approvalMapper.getMyReferApvCount(empNo);
	    
	    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
	    int display = Integer.parseInt(optDisplay.orElse("20"));
	    
	    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
	    int page = Integer.parseInt(optPage.orElse("1"));

	    myPageUtils.setPaging(total, display, page);
	    
	    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
	    String sort = optSort.orElse("DESC");
	    
	    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
	                                   , "end", myPageUtils.getEnd()
	                                   , "sort", sort
	                                   , "empNo", empNo);
	    
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
	    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
               , "paging",myPageUtils.getPaging(sort, display)
               , "approvalList" , approvalMapper.getMyReferApvList(map)
               , "sort", sort
               , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadconfirmMyReferAppList(HttpServletRequest request) {
		
		String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyReferWaitApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
             , "paging",myPageUtils.getPaging(sort, display)
             , "approvalList" , approvalMapper.getMyReferWaitApvList(map)
             , "sort", sort
             , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadCompleteMyReferAppList(HttpServletRequest request) {
		

		   String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyReferCompleApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
             , "paging",myPageUtils.getPaging(sort, display)
             , "approvalList" , approvalMapper.getMyReferCompleteApvList(map)
             , "sort", sort
             , "page", page), HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> loadrejectedMyReferAppList(HttpServletRequest request) {
		
		String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyReferRejectApvCount(empNo);
		    
		    Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		    int display = Integer.parseInt(optDisplay.orElse("20"));
		    
		    Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		    int page = Integer.parseInt(optPage.orElse("1"));

		    myPageUtils.setPaging(total, display, page);
		    
		    Optional<String> optSort = Optional.ofNullable(request.getParameter("sort"));
		    String sort = optSort.orElse("DESC");
		    
		    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
		                                   , "end", myPageUtils.getEnd()
		                                   , "sort", sort
		                                   , "empNo", empNo);
		    
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
		    return new ResponseEntity<>(Map.of("beginNo", total - (page - 1) * display
             , "paging",myPageUtils.getPaging(sort, display)
             , "approvalList" , approvalMapper.getMyReferRejectedApvList(map) 
             , "sort", sort
             , "page", page), HttpStatus.OK);
	}

}
	
	
