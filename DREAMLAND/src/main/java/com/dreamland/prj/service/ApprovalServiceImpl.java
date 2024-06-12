package com.dreamland.prj.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.AppleaveDto;
import com.dreamland.prj.dto.AppletterDto;
import com.dreamland.prj.dto.ApprovalDto;
import com.dreamland.prj.dto.ApvAttachDto;
import com.dreamland.prj.dto.ApvWriterDto;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.FaqBoardDto;
import com.dreamland.prj.dto.NoticeAttachDto;
import com.dreamland.prj.mapper.ApprovalMapper;
import com.dreamland.prj.mapper.FaqBoardMapper;
import com.dreamland.prj.utils.MyAppPageUtils;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ApprovalServiceImpl implements ApprovalService {
	
	private final ApprovalMapper approvalMapper; 
	private final MyAppPageUtils myPageUtils;
	private final MyFileUtils myFileUtils;
	
	
	@Override
 	public boolean registerAppletter(MultipartHttpServletRequest multipartRequest) {
	    String apvNo2 = multipartRequest.getParameter("apvNo");
        int insertNoticeCount;
        int insertAttachCount;
        List<MultipartFile> files;
        
    	// 사용자가 입력한 contents
		String title =  multipartRequest.getParameter("title");
	    String contents =  multipartRequest.getParameter("contents");
	    
	    int temp  =  Integer.parseInt(multipartRequest.getParameter("temp"));
	    
	    
	
	    String approver =  approvalMapper.getEmployeeNo( multipartRequest.getParameter("approver"));
	    Optional<String> approver22 = Optional.ofNullable(multipartRequest.getParameter("approver2"));
	    String approver2 =  approvalMapper.getEmployeeNo(approver22.orElse(" ")) ;
	    Optional<String> approver33 = Optional.ofNullable(multipartRequest.getParameter("approver3"));
	    String approver3 =  approvalMapper.getEmployeeNo(approver33.orElse(" "));
	    Optional<String> approver44 = Optional.ofNullable(multipartRequest.getParameter("approver4"));
	    String approver4 =  approvalMapper.getEmployeeNo(approver44.orElse(" "));
	    approver2 = approver2 != null ? approver2 : " ";
	    approver3 = approver3 != null ? approver3 : " ";
	    approver4 = approver4 != null ? approver4 : " ";
	    String approvers = approver2 + " " + approver3 + " " + approver4;

	    String referrer  =  multipartRequest.getParameter("referrer");
        String[] array = referrer.split(" ");
        System.out.println(approvers);
        String[] array2 = approvers.split(" ");

	    if(apvNo2.equals("")) {
	        ApprovalDto app = ApprovalDto.builder()
					.empNo(Integer.parseInt(approver))
					.apvTitle(title)
					.apvKinds("0")
					.apvCheck(temp)
					.build();
	        insertNoticeCount = approvalMapper.insertApproval(app);
	        int apvNo = approvalMapper.getApvNo();
	        if(!(array[0].equals(""))) {
	        	for (String refer : array) {
	        		approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer), apvNo);
	        	}}
	        
		    for(int i=0; i<array2.length; i++) {
			    ApvWriterDto appwriter = ApvWriterDto.builder()
						 .apvNo(apvNo)
						 .writerList(i)
						 .empNo(Integer.parseInt(array2[i]))
						  .build();
			    approvalMapper.insertApvWriter(appwriter);
		    }
			    AppletterDto appletter = AppletterDto.builder()
			    		.apvNo(apvNo)
	                    .detail(contents)
	                  .build();
			  approvalMapper.insertApvLetter(appletter);
			    // 첨부파일 처리하기
			   files = multipartRequest.getFiles("files");
				
				if(files.get(0).getSize() == 0) {
					insertAttachCount = 1; 
				} else {
					insertAttachCount = 0;
				}
				
				for(MultipartFile multipartFile : files) {
					
					if(multipartFile != null && !multipartFile.isEmpty()) {
						
						String uploadPath = myFileUtils.getUploadPath();
						File dir = new File(uploadPath);
						System.out.println("====="+dir.getAbsolutePath());
						
						if(!dir.exists()) {
							dir.mkdirs();
						} 
						
						String originalFilename = multipartFile.getOriginalFilename();
						String filesystemName = myFileUtils.getFilesystemName(originalFilename);
						File file = new File(dir, filesystemName);
						
						try {
							multipartFile.transferTo(file);
							
							// 썸네일 굳이 만들지 않을 것, 필요 없을듯
							
							ApvAttachDto attach = ApvAttachDto.builder()
									                                    .apvNo(apvNo)
																		.uploadPath(uploadPath)
																		.filesystemName(filesystemName)
																		.originalFilename(originalFilename)
																	.build();
							insertAttachCount += approvalMapper.insertApvAttach(attach);
						} catch (Exception e) {
							e.printStackTrace();
						}
					}  // if 코드
				} // for multipartFile코드	
	    } else {
	    	
	    	 ApprovalDto app2 = ApprovalDto.builder().apvNo(Integer.parseInt(apvNo2))
	    			 .apvCheck(temp)
	    			 .apvTitle(title)
	    			 .apvKinds("0")
	    			 .build();
	    	
	    	
	        insertNoticeCount = approvalMapper.modifyApproval(app2);
	        approvalMapper.deleteApvRef(Integer.parseInt(apvNo2));
	        approvalMapper.deleteApvWriter(Integer.parseInt(apvNo2));
	        
	        if(!(array[0].equals(""))) {
	        for (String refer : array) {
	        	approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer), Integer.parseInt(apvNo2));
	        }}
		    	    
		
		    for(int i=0; i<array2.length; i++) {
		    	ApvWriterDto a = ApvWriterDto.builder()
   			         .apvNo(Integer.parseInt(apvNo2))
   			         .writerList(i)
   			         .empNo(Integer.parseInt(array2[i]))
   			         .build();
	    approvalMapper.insertApvWriter(a);
		    	
		    }

			  approvalMapper.modifyApvLetter(apvNo2,contents );
			  System.out.println("실행4"); 
			    // 첨부파일 처리하기
			   files = multipartRequest.getFiles("files");
				
				
				if(files.get(0).getSize() == 0) {
					insertAttachCount = 1; 
				} else {
					insertAttachCount = 0;
				}
				
				for(MultipartFile multipartFile : files) {
					
					if(multipartFile != null && !multipartFile.isEmpty()) {
						
						String uploadPath = myFileUtils.getUploadPath();
						File dir = new File(uploadPath);
						System.out.println("====="+dir.getAbsolutePath());
						
						if(!dir.exists()) {
							dir.mkdirs();
						} 
						
						String originalFilename = multipartFile.getOriginalFilename();
						String filesystemName = myFileUtils.getFilesystemName(originalFilename);
						File file = new File(dir, filesystemName);
						
						try {
							multipartFile.transferTo(file);
							
							
							ApvAttachDto attach = ApvAttachDto.builder()
									                                    .apvNo(Integer.parseInt(apvNo2))
																		.uploadPath(uploadPath)
																		.filesystemName(filesystemName)
																		.originalFilename(originalFilename)
																	.build();
							insertAttachCount += approvalMapper.insertApvAttach(attach);
							
						} catch (Exception e) {
							e.printStackTrace();
						}
					}  
				} 
	    }
			return (insertNoticeCount == 1) && (insertAttachCount == files.size());
	}
	
	@Override
	public boolean registerAppLeave(MultipartHttpServletRequest multipartRequest) {
		String apvNo2 = multipartRequest.getParameter("apvNo");
        int insertNoticeCount;
        int insertAttachCount;
        List<MultipartFile> files;
        
		String title =  multipartRequest.getParameter("title");
		
	    String contents =  multipartRequest.getParameter("contents");
	    int temp  =  Integer.parseInt(multipartRequest.getParameter("temp"));
	    
		
	    String approver =  approvalMapper.getEmployeeNo( multipartRequest.getParameter("approver"));
	    Optional<String> approver22 = Optional.ofNullable(multipartRequest.getParameter("approver2"));
	    String approver2 =  approvalMapper.getEmployeeNo(approver22.orElse(" ")) ;
	    Optional<String> approver33 = Optional.ofNullable(multipartRequest.getParameter("approver3"));
	    String approver3 =  approvalMapper.getEmployeeNo(approver33.orElse(" "));
	    Optional<String> approver44 = Optional.ofNullable(multipartRequest.getParameter("approver4"));
	    String approver4 =  approvalMapper.getEmployeeNo(approver44.orElse(" "));
	    approver2 = approver2 != null ? approver2 : " ";
	    approver3 = approver3 != null ? approver3 : " ";
	    approver4 = approver4 != null ? approver4 : " ";
	    String approvers = approver2 + " " + approver3 + " " + approver4;

	    String referrer  =  multipartRequest.getParameter("referrer");
        String[] array = referrer.split(" ");
        System.out.println(approvers);
        String[] array2 = approvers.split(" ");
        
        String leavestart ;
        String leaveend ;
        String halfday;
	    // 뷰에서 전달된 userNo
	    String leavekind = multipartRequest.getParameter("leavekind");
	    if(leavekind.equals("0")) {
	    	
	    	 leavestart = multipartRequest.getParameter("leavestart");
	    	 leaveend = multipartRequest.getParameter("leaveend");
	    	 halfday = "0";
	    	 
	    } else {
	    	 leavestart = multipartRequest.getParameter("leavestart");
	    	 leaveend = leavestart;
	         halfday = multipartRequest.getParameter("halfday");
	    }
	   
        
	    ApprovalDto app = ApprovalDto.builder()
				.empNo(Integer.parseInt(approver))
				.apvTitle(title)
				.apvKinds("1")
				.apvCheck(temp)
				.build();
		

        if(apvNo2.equals("") ) {

	    insertNoticeCount = approvalMapper.insertApproval(app);
	   

        int apvNo = approvalMapper.getApvNo();
        
        
        if(!(array[0].equals(""))) {
        for (String refer : array) {
        	approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer), apvNo);
        }}
        
        
        
	    for(int i=0; i<array2.length; i++) {
	    	
		    ApvWriterDto appwriter = ApvWriterDto.builder()
					 .apvNo(apvNo)
					 .writerList(i)
					 .empNo(Integer.parseInt(array2[i]))
					  .build();
		    approvalMapper.insertApvWriter(appwriter);
	    	
	    }
	    
	    
        
	    AppleaveDto appleave = AppleaveDto.builder()
	    		.apvNo(apvNo)
	    		.empNo(Integer.parseInt(approver))
				.leaveClassify(leavekind)
				.leaveStart(leavestart)
				.leaveEnd(leaveend)
				.halfday(halfday)
				.detail(contents)
				.build();
	    
        
	    approvalMapper.insertApvLeave(appleave);	
	    
 
		 files = multipartRequest.getFiles("files");
		
		if(files.get(0).getSize() == 0) {
			insertAttachCount = 1; 
		} else {
			insertAttachCount = 0;
		}
		
		for(MultipartFile multipartFile : files) {
			
			if(multipartFile != null && !multipartFile.isEmpty()) {
				
				String uploadPath = myFileUtils.getUploadPath();
				File dir = new File(uploadPath);
				System.out.println("====="+dir.getAbsolutePath());
				
				if(!dir.exists()) {
					dir.mkdirs();
				} 
				
				String originalFilename = multipartFile.getOriginalFilename();
				String filesystemName = myFileUtils.getFilesystemName(originalFilename);
				File file = new File(dir, filesystemName);
				
				try {
					multipartFile.transferTo(file);
					
					ApvAttachDto attach = ApvAttachDto.builder()
							                                    .apvNo(apvNo)
																.uploadPath(uploadPath)
																.filesystemName(filesystemName)
																.originalFilename(originalFilename)
															.build();
					
					insertAttachCount += approvalMapper.insertApvAttach(attach);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}  
		}
		} else {
			 ApprovalDto app2 = ApprovalDto.builder().apvNo(Integer.parseInt(apvNo2))
	    			 .apvCheck(temp)
	    			 .apvTitle(title)
	    			 .apvKinds("1")
	    			 .build();
	    	
	    	
		   insertNoticeCount = approvalMapper.modifyApproval(app2);
	        approvalMapper.deleteApvRef(Integer.parseInt(apvNo2));
	        approvalMapper.deleteApvWriter(Integer.parseInt(apvNo2));
	        if(!(array[0].equals(""))) {
	        	
	        for (String refer : array) {
	        	approvalMapper.insertApvRef(approvalMapper.getEmployeeNo(refer), Integer.parseInt(apvNo2));
	        }}
		    	    
		    for(int i=0; i<array2.length; i++) {
		    	
		    	ApvWriterDto a = ApvWriterDto.builder()
		    			         .apvNo(Integer.parseInt(apvNo2))
		    			         .writerList(i)
		    			         .empNo(Integer.parseInt(array2[i]))
		    			         .build();
			    approvalMapper.insertApvWriter(a);
		    	
		    }
		    
		    AppleaveDto appleave = AppleaveDto.builder()
		    		.apvNo(Integer.parseInt(apvNo2))
					.leaveClassify(leavekind)
					.leaveStart(leavestart)
					.leaveEnd(leaveend)
					.halfday(halfday)
					.detail(contents)
					.build();
		    	
		    approvalMapper.modifyApvLeave(appleave);	
		    
			// 첨부파일 처리하기
			 files = multipartRequest.getFiles("files");
			
			if(files.get(0).getSize() == 0) {
				insertAttachCount = 1; 
			} else {
				insertAttachCount = 0;
			}
			
			for(MultipartFile multipartFile : files) {
				
				if(multipartFile != null && !multipartFile.isEmpty()) {
					
					String uploadPath = myFileUtils.getUploadPath();
					File dir = new File(uploadPath);
					System.out.println("====="+dir.getAbsolutePath());
					
					if(!dir.exists()) {
						dir.mkdirs();
					} 
					String originalFilename = multipartFile.getOriginalFilename();
					String filesystemName = myFileUtils.getFilesystemName(originalFilename);
					File file = new File(dir, filesystemName);
					
					try {
						multipartFile.transferTo(file);
						ApvAttachDto attach = ApvAttachDto.builder()
								                                    .apvNo(Integer.parseInt(apvNo2))
																	.uploadPath(uploadPath)
																	.filesystemName(filesystemName)
																	.originalFilename(originalFilename)
																.build();
						
						insertAttachCount += approvalMapper.insertApvAttach(attach);
						
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		return (insertNoticeCount == 1) && (insertAttachCount == files.size());
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
	public ResponseEntity<Map<String, Object>> loadtempMyAppList(HttpServletRequest request) {
		 String empNo = request.getParameter("empNo");
		   int total = approvalMapper.getMyTempApvCount(empNo);
		    
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
              , "approvalList" , approvalMapper.getMyTempApvList(map) 
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


	@Override
	public ResponseEntity<Resource> download(HttpServletRequest request) {

		int attachNo = Integer.parseInt(request.getParameter("attachNo"));
		ApvAttachDto attach = approvalMapper.getAttachByNo(attachNo);
		
		File file = new File(attach.getUploadPath(), attach.getFilesystemName());
        Resource resource = new FileSystemResource(file);
    
        if(!resource.exists()) {
    	  return new ResponseEntity<>(HttpStatus.NOT_FOUND);
         }
		
        String originalFilename = attach.getOriginalFilename();
        String userAgent = request.getHeader("User-Agent");
    
        try {
        	//IE
        	if(userAgent.contains("Trident")) {
        		originalFilename = URLEncoder.encode(originalFilename, "UTF-8").replace("+", " "); 
        	}
        	// Edge
        	else if(userAgent.contains("Edg")) {
        		originalFilename = URLEncoder.encode(originalFilename, "UTF-8");
        	}
        	// Other
        	else {
        		originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8859-1");
        	}
        	} catch (Exception e) {
			e.printStackTrace();
        	}
    
        // 다운로드용 응답 헤더 설정 (HTTP 참조)
        HttpHeaders responseHeader = new HttpHeaders();
        responseHeader.add("Content-Type", "application/octet-stream");
        responseHeader.add("Content-Disposition", "attachment; filename=" + originalFilename);
        responseHeader.add("Content-Length", file.length() + "");
        
	    // 다운로드 진행
	        return new ResponseEntity<Resource>(resource, responseHeader, HttpStatus.OK);
		}
	
    @Override
    public void loadTempApp(HttpServletRequest request, Model model) {
    	int apvNo = Integer.parseInt(request.getParameter("apvNo"));
		String Apvstate = request.getParameter("kind");
	    ApprovalDto a = approvalMapper.getApvDetailByNo(apvNo);
	    String title = a.getApvTitle();
	    String Apvkind = a.getApvKinds();
	    List<String> b = approvalMapper.getApprover(apvNo);
	    
	    String writer = approvalMapper.getEmployeeName(a.getEmpNo()+"");
	    
        Map<String, Object> map = new HashMap<>();
        map.put("writer", writer);
        
		for(int i=0; i< b.size(); i++) {
			map.put("approver" + (i+1), approvalMapper.getEmployeeName( b.get(i)));
			map.put("approverPosName" + (i+1), approvalMapper.getEmployeePosName( b.get(i)));
		}
		
		if(Apvkind.equals("0")) {
			 model.addAttribute("approval", approvalMapper.getApvAppDetailByNo(apvNo));
		} else {

				DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

				AppleaveDto alev = approvalMapper.getApvLeaveDetailByNo(apvNo);
				String LeaveStart = alev.getLeaveStart();
				String LeaveEnd = alev.getLeaveEnd();
				
				LocalDateTime RLeaveStart = LocalDateTime.parse(LeaveStart, inputFormatter);
				LocalDateTime RLeaveEnd = LocalDateTime.parse(LeaveEnd, inputFormatter);
				LocalDate Startdate = RLeaveStart.toLocalDate();
				LocalDate Enddate = RLeaveEnd.toLocalDate();
				String formattedStartDate = Startdate.format(outputFormatter);
				String formattedEndDate = Enddate.format(outputFormatter);
				
				alev.setLeaveStart(formattedStartDate);
				alev.setLeaveEnd(formattedEndDate);
				model.addAttribute("approval", alev);
		}
		
		 StringBuilder sb = new StringBuilder();
		 List<String> referrer = approvalMapper.getReferrer(apvNo);
		 for(String refer : referrer) {
			 sb.append(approvalMapper.getEmployeeName(refer));
			 sb.append(" ");
		 }
		
	    System.out.println(approvalMapper.getAttachList(apvNo));
		model.addAttribute("attachList", approvalMapper.getAttachList(apvNo));
		model.addAttribute("title", title);
		model.addAttribute("kind", Apvkind);
		model.addAttribute("kind2", Apvstate);
		model.addAttribute("referrer", sb.toString());
	    model.addAttribute("appovers", map);
    	
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
	    
        Map<String, Object> map = new HashMap<>();
        map.put("writer", writer);
        
		for(int i=0; i< b.size(); i++) {
			map.put("approver" + (i+1), approvalMapper.getEmployeeName( b.get(i)));
			map.put("approverPosName" + (i+1), approvalMapper.getEmployeePosName( b.get(i)));
		}
		
		if(ApvCheck == 2) {
			 ApvWriterDto RempNo = approvalMapper.getReturnApprover(apvNo);
			 model.addAttribute("reject", 1);
			 model.addAttribute("returner", approvalMapper.getEmployeeName(RempNo.getEmpNo()+""));
			 model.addAttribute("returnReason", RempNo.getReturnReason());
		} else if(ApvCheck == 3) {
			 model.addAttribute("reject", 2);
			 
		} else {
			 model.addAttribute("reject", 0);
		}
		
		
		if(Apvkind.equals("0")) {
			 model.addAttribute("approval", approvalMapper.getApvAppDetailByNo(apvNo));
		} else {
			DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

			AppleaveDto alev = approvalMapper.getApvLeaveDetailByNo(apvNo);
			String LeaveStart = alev.getLeaveStart();
			String LeaveEnd = alev.getLeaveEnd();
			
			LocalDateTime RLeaveStart = LocalDateTime.parse(LeaveStart, inputFormatter);
			LocalDateTime RLeaveEnd = LocalDateTime.parse(LeaveEnd, inputFormatter);
			LocalDate Startdate = RLeaveStart.toLocalDate();
			LocalDate Enddate = RLeaveEnd.toLocalDate();
			String formattedStartDate = Startdate.format(outputFormatter);
			String formattedEndDate = Enddate.format(outputFormatter);
			
			alev.setLeaveStart(formattedStartDate);
			alev.setLeaveEnd(formattedEndDate);
			 model.addAttribute("approval", alev);
		}
		

		 StringBuilder sb = new StringBuilder();
		 List<String> referrer = approvalMapper.getReferrer(apvNo);
		 for(String refer : referrer) {
			 sb.append(approvalMapper.getEmployeeName(refer));
			 sb.append(" ");
		 }
	    System.out.println(approvalMapper.getAttachList(apvNo));
		model.addAttribute("attachList", approvalMapper.getAttachList(apvNo));
		model.addAttribute("title", title);
		model.addAttribute("kind", Apvkind);
		model.addAttribute("kind2", Apvstate);
		model.addAttribute("referrer", sb.toString());
	    model.addAttribute("appovers", map);
	    
	}

	@Override
	public int apvApprove(HttpServletRequest request) {
		int apvNo = Integer.parseInt(request.getParameter("apvNo"));
		int flag = 0;
		String empNo = request.getParameter("empNo");
		String apvKind = request.getParameter("apvKind");
		String leavekind = request.getParameter("leavekind");
		String returnReason = request.getParameter("rejectedReason");
		approvalMapper.updateApprover(apvNo,empNo,returnReason);
		

		if(returnReason.equals("0")) {
			List<String> b = approvalMapper.getApprovers(apvNo);
		 	for(int i=0; i< b.size(); i++) {
		 		if (b.get(i).equals("100")) {flag ++;}
		    }
		 	if(flag == 0) {
		 		
		 		if(apvKind.equals("1")) {
		 			approvalMapper.updateApproval(apvNo,1);
		 			approvalMapper.updateApvLeave(apvNo);
		 			AppleaveDto a = approvalMapper.getApvLeaveDetailByNo(apvNo);
		 			// (임의) 포맷형, 시작일, 종료일
		 			String dateFormatType = "yyyy-MM-dd HH:mm:ss";
		 			String strDate = a.getLeaveStart();
		 			String endDate = a.getLeaveEnd();
		 			String empNo2 = a.getEmpNo() + "";
		 			
		 			if(leavekind.equals("1")) {
		 				
		 				approvalMapper.updateEmployee(empNo2,  (float) 0.5);
		 				
		 			} else {
		 				
		 				// 포맷 정의
		 				try {
		 					SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatType);
		 					Date from = simpleDateFormat.parse(strDate);
		 					Date to = simpleDateFormat.parse(endDate);
		 					long diff = to.getTime() - from.getTime();
		 					long re = diff / 86400000L +1;		 
		 					approvalMapper.updateEmployee(empNo2, re);
		 					
		 				} catch (ParseException e) {
		 					// TODO Auto-generated catch block
		 					e.printStackTrace();
		 				}
		 				
		 			}
			    
		 		}else {
		 			approvalMapper.updateApproval(apvNo,1);
		 		}
		 	}
		
		} else {
		    approvalMapper.updateApproval(apvNo, 2);
		}
		return 0;
	}
	
	@Override
	public boolean  deleteAttach(HttpServletRequest request) {
		String apvNo    = request.getParameter("apvNo");
		String attachNo = request.getParameter("attachNo");
		return approvalMapper.deleteAttach(apvNo, attachNo) > 0;
	}

	@Override
	public int apvRevoke(HttpServletRequest request) {
		String apvNo = request.getParameter("apvNo");
		String apvKind = request.getParameter("apvKind");
		approvalMapper.revokeApproval(apvNo);
		
		if(apvKind.equals("1")) {
			
		approvalMapper.revokeApvLeave(apvNo);
		
			AppleaveDto a = approvalMapper.getApvLeaveDetailByNo(Integer.parseInt(apvNo));
			// (임의) 포맷형, 시작일, 종료일
			String dateFormatType = "yyyy-MM-dd HH:mm:ss";
			
			
			String strDate = a.getLeaveStart();
			String endDate = a.getLeaveEnd();
			String empNo = a.getEmpNo() +"";
			
			if(strDate.equals(endDate)) {
				
				approvalMapper.updateEmployee(empNo, (float)-0.5);
				
			} else {
				
				// 포맷 정의
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormatType);
				try {
					Date from = simpleDateFormat.parse(strDate);
					Date to = simpleDateFormat.parse(endDate);
					long diff = to.getTime() - from.getTime();
					long re = -(diff / 86400000L +1);		 
					
					approvalMapper.updateEmployee(empNo, re);
					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		
		
		}
		
		return 0;
	} 
	
	@Override
	public ResponseEntity<Map<String, Object>> employeeList(HttpServletRequest request) {
		return new ResponseEntity<>(Map.of("employeeList", approvalMapper.getEmployeeList()
				                           ,"departmentList", approvalMapper.getDepartmentList())
				                           , HttpStatus.OK);
	} 

	@Override
	public void deleteApp(HttpServletRequest request) {
		int apvNo = Integer.parseInt(request.getParameter("apvNo"));
		
		approvalMapper.deleteApvWriter(apvNo);
		approvalMapper.deleteApvRef(apvNo);
		approvalMapper.deleteApp(apvNo);
	}


}
	
