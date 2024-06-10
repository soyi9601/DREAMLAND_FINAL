package com.dreamland.prj.service;

import java.io.File;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.DepartmentDto;
import com.dreamland.prj.dto.FacilityAttachDto;
import com.dreamland.prj.dto.FacilityDto;
import com.dreamland.prj.mapper.FacilityMapper;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MyPageUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class FacilityServiceImpl implements FacilityService {

	private final FacilityMapper facilityMapper;
	private final MyPageUtils myPageUtils;
	private final MyFileUtils myFileUtils;
	
	public FacilityServiceImpl(FacilityMapper facilityMapper, MyPageUtils myPageUtils, MyFileUtils myFileUtils) {
		super();
		this.facilityMapper = facilityMapper;
		this.myPageUtils = myPageUtils;
		this.myFileUtils = myFileUtils;
	}
	
	@Override
	public boolean registerFacility(MultipartHttpServletRequest multipartRequest) {
		
		// FACILITY 테이블에 추가하기
		String facilityName = multipartRequest.getParameter("facilityName"); 
		String remarks = multipartRequest.getParameter("remarks"); 
		int deptNo = Integer.parseInt(multipartRequest.getParameter("deptNo"));
		
		String managementParam = multipartRequest.getParameter("management");
		int management = managementParam != null ? Integer.parseInt(managementParam) : 0;
		
		DepartmentDto dept = new DepartmentDto();
		dept.setDeptNo(deptNo);
		
		FacilityDto facility = FacilityDto.builder()
															.facilityName(facilityName)
															.remarks(remarks)
															.management(management)
															.department(dept)
														.build();
		
		System.out.println("INSERT 이전" + facility.getFacilityName());
		int insertFacilityCount = facilityMapper.insertFacility(facility);
		System.out.println("INSERT 이후" + facility.getFacilityName());
		
		// 첨부 파일 처리하기
		List<MultipartFile> files = multipartRequest.getFiles("files");
		
		int insertAttachCount;
		if(files.get(0).getSize() == 0) {
			insertAttachCount = 1;
		} else {
			insertAttachCount = 0;
		}
		
		for(MultipartFile multipartFile : files) {
			if(multipartFile != null && !multipartFile.isEmpty()) {
				String uploadPath = myFileUtils.getUploadPath();
				File dir = new File(uploadPath);
				if(!dir.exists()) {
					dir.mkdirs();
				}
				
				String originalFilename = multipartFile.getOriginalFilename();
				String filesystemName = myFileUtils.getFilesystemName(originalFilename);
				File file = new File(dir, filesystemName);
				
				try {
					multipartFile.transferTo(file);
					
					FacilityAttachDto FacilityAttach = FacilityAttachDto.builder()
																						 		.uploadPath(uploadPath)
																						 		.filesystemName(filesystemName)
																						 		.originalFilename(originalFilename)
																						 		.facilityNo(facility.getFacilityNo())
																						 	.build();
					
					insertAttachCount += facilityMapper.insertFacilityAttach(FacilityAttach);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return (insertFacilityCount == 1) && (insertAttachCount == files.size());
	}

	@Transactional(readOnly=true)
	@Override
	public void loadFacilityList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		int total = facilityMapper.getFacilityCount();
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("10"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myPageUtils.setPaging(total, display, page);
		
		String sort = "desc";
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
																	 , "end"  , myPageUtils.getEnd()
																	 , "sort" , sort);
		
		model.addAttribute("beginNo", total - (page -1) * display);
		model.addAttribute("loadFacilityList", facilityMapper.getFacilityList(map));
		model.addAttribute("paging", myPageUtils.getPaging(request.getContextPath() + "/upload/list.do", sort, display));
		model.addAttribute("display", display);
		model.addAttribute("sort", sort);
		model.addAttribute("page", page);
	}

	@Transactional(readOnly=true)
	@Override
	public void loadFacilityByNo(int facilityNo, Model model) {
		model.addAttribute("facility", facilityMapper.getFacilityByNo(facilityNo));
		model.addAttribute("attachList", facilityMapper.getAttachList(facilityNo));
	}
	
	@Override
	public ResponseEntity<Resource> download(HttpServletRequest request) {

		int attachNo = Integer.parseInt(request.getParameter("attachNo"));
		FacilityAttachDto attach = facilityMapper.getAttachByNo(attachNo);
		
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
			//Edg
			else if(userAgent.contains("Edg")) {
				originalFilename = URLEncoder.encode(originalFilename, "UTF_8");
			}
			//Other
			else {
				originalFilename = new String(originalFilename.getBytes("UTF-8"), "ISO-8858-1");
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
	
	@Transactional(readOnly=true)
	@Override
	public FacilityDto getFacilityByNo(int facilityNo) {
		return facilityMapper.getFacilityByNo(facilityNo);
	}
	
	@Override
	public int modifyFacility(FacilityDto facility) {
		return facilityMapper.updateFacility(null);
	}
	
	@Override
	public int deleteAttach(int attachNo) {
		return facilityMapper.deleteAttach(attachNo);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> getAttachList(int facilityNo) {
		return ResponseEntity.ok(Map.of("attachList", facilityMapper.getAttachList(facilityNo)));
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception {

		List<MultipartFile> files = multipartRequest.getFiles("files");
		int attachCount = 0;
		for (MultipartFile multipartFile : files) {
			if (multipartFile != null && !multipartFile.isEmpty()) {
				String uploadPath = myFileUtils.getUploadPath();
				File dir = new File(uploadPath);
				if (!dir.exists()) {
						dir.mkdirs();
				}
				
				String originalFilename = multipartFile.getOriginalFilename();
				String filesystemName = myFileUtils.getFilesystemName(originalFilename);
				File file = new File(dir, filesystemName);
				
				multipartFile.transferTo(file);
				
				FacilityAttachDto attach = FacilityAttachDto.builder()
																	 		.uploadPath(uploadPath)
																	 		.originalFilename(originalFilename)
																	 		.filesystemName(filesystemName)
																	 		.facilityNo(Integer.parseInt(multipartRequest.getParameter("facilityNo")))
																	 		.build();
				
				attachCount += facilityMapper.insertFacilityAttach(attach);
			}
		}
		return ResponseEntity.ok(Map.of("attachResult", files.size() == attachCount));
	}

	@Override
	public ResponseEntity<Map<String, Object>> removeAttach(int attachNo) {
		
		FacilityAttachDto attach = facilityMapper.getAttachByNo(attachNo);
		
		File file = new File(attach.getUploadPath(), attach.getFilesystemName());
		if(file.exists()) {
			file.delete();
		}
		
		int deleteCount = facilityMapper.deleteAttach(attachNo);
		
		return ResponseEntity.ok(Map.of("deleteCount", deleteCount));
	}
	
	@Override
	public int removeFacility(int FacilityNo) {
		
		List<FacilityAttachDto> attachList = facilityMapper.getAttachList(FacilityNo);
		for(FacilityAttachDto attach : attachList) {
			
			File file = new File(attach.getUploadPath(), attach.getFilesystemName());
			if(file.exists()) {
				file.delete();
			}
		}
		 facilityMapper.deleteAttach(FacilityNo);
		 
		return facilityMapper.deleteFacility(FacilityNo);
	}
}
