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
import com.dreamland.prj.utils.MyBoardPageUtils;
import com.dreamland.prj.utils.MyFileUtils;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public class FacilityServiceImpl implements FacilityService {

	private final FacilityMapper facilityMapper;
	private final MyBoardPageUtils myBoardPageUtils;
	private final MyFileUtils myFileUtils;
	
	public FacilityServiceImpl(FacilityMapper facilityMapper,MyBoardPageUtils myBoardPageUtils , MyFileUtils myFileUtils) {
		super();
		this.facilityMapper = facilityMapper;
		this.myBoardPageUtils = myBoardPageUtils;
		this.myFileUtils = myFileUtils;
	}
	
	@Override
	public boolean registerFacility(MultipartHttpServletRequest multipartRequest) {

		    String[] facilityNames = multipartRequest.getParameterValues("facilityName");
		    String[] remarksArray = multipartRequest.getParameterValues("remarks");
		    String[] deptNos = multipartRequest.getParameterValues("deptNo");
		    String[] managementParams = multipartRequest.getParameterValues("management");
		    List<MultipartFile> files = multipartRequest.getFiles("files");
		    int totalInsertedCount = 0;

		    // 시설 개수만큼 반복
		    for (int i = 0; i < facilityNames.length; i++) {
		        String facilityName = facilityNames[i];
		        String remarks = remarksArray[i];
		        int deptNo = Integer.parseInt(deptNos[i]);
		        int management = managementParams != null && i < managementParams.length && managementParams[i] != null ? Integer.parseInt(managementParams[i]) : 0;

		        DepartmentDto dept = new DepartmentDto();
		        dept.setDeptNo(deptNo);

		        FacilityDto facility = FacilityDto.builder()
		                .facilityName(facilityName)
		                .remarks(remarks)
		                .management(management)
		                .department(dept)
		                .build();

		        try {
		            int insertFacilityCount = facilityMapper.insertFacility(facility);

		            // 해당 시설의 파일들을 가져오기 (파일 필드 이름은 files + i)
	//	            List<MultipartFile> files = multipartRequest.getFiles("files");
		            int insertAttachCount = 0;
	//===============================================================	            
		            MultipartFile multipartFile = files.get(i);
		            String uploadPath = myFileUtils.getUploadPath();
                File dir = new File(uploadPath);
                if (!dir.exists()) 
                    dir.mkdirs();
                String originalFilename = multipartFile.getOriginalFilename();
                String filesystemName = myFileUtils.getFilesystemName(originalFilename);
                File file = new File(dir, filesystemName);

                multipartFile.transferTo(file);

                FacilityAttachDto facilityAttach = FacilityAttachDto.builder()
                        .uploadPath(uploadPath)
                        .filesystemName(filesystemName)
                        .originalFilename(originalFilename)
                        .facilityNo(facility.getFacilityNo())
                        .build();

                insertAttachCount += facilityMapper.insertFacilityAttach(facilityAttach);
//============================================================================                
/*
		            // 파일들을 순회하며 처리
		            for (MultipartFile multipartFile : files) {
		                if (multipartFile != null && !multipartFile.isEmpty()) {
		                    String uploadPath = myFileUtils.getUploadPath();
		                    File dir = new File(uploadPath);
		                    if (!dir.exists()) 
		                        dir.mkdirs();
		                    }

		                    String originalFilename = multipartFile.getOriginalFilename();
		                    String filesystemName = myFileUtils.getFilesystemName(originalFilename);
		                    File file = new File(dir, filesystemName);

		                    multipartFile.transferTo(file);

		                    FacilityAttachDto facilityAttach = FacilityAttachDto.builder()
		                            .uploadPath(uploadPath)
		                            .filesystemName(filesystemName)
		                            .originalFilename(originalFilename)
		                            .facilityNo(facility.getFacilityNo())
		                            .build();

		                    insertAttachCount += facilityMapper.insertFacilityAttach(facilityAttach);
		                }
		            }
*/

		            // 해당 시설의 시설 등록과 파일 등록이 모두 성공적인 경우
		            if (insertFacilityCount == 1 && insertAttachCount == files.size()) {
		                totalInsertedCount++;
		            }
		        } catch (Exception e) {
		            e.printStackTrace();
		        }
		    }

		    // 모든 시설 등록이 성공적인 경우 true 반환
		    return totalInsertedCount == facilityNames.length;
		}

	@Transactional(readOnly=true)
	@Override
	public void loadFacilityList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		// 전체 시설 개수 조회
		int total = facilityMapper.getFacilityCount();
		
		// display 파라미터 처리 (한 페이지에 보여질 개수)
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("10"));
		
		// page 파라미터 처리 (현재 페이지)
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myBoardPageUtils.setPaging(total, display, page);
		
		// 정렬 방식 설정 (현재는 항상 내림차순)
		String sort = "desc";
		
		// 맵에 페이징 정보 추가
		Map<String, Object> map = Map.of("begin", myBoardPageUtils.getBegin()
																	 , "end"  , myBoardPageUtils.getEnd()
																	 , "sort" , sort);
		
		// 모델에 필요한 속성 추가
    model.addAttribute("beginNo", total - (page - 1) * display);  // 시작 번호 계산
    model.addAttribute("loadFacilityList", facilityMapper.getFacilityList(map));  // 시설 목록 조회
    model.addAttribute("paging", myBoardPageUtils.getPaging(request.getContextPath() + "/facility/list.do", sort, display));  // 페이징 HTML 추가
    model.addAttribute("display", display);  // display 개수 추가
    model.addAttribute("sort", sort);  // 정렬 방식 추가
    model.addAttribute("page", page);  // 현재 페이지 추가
	}

	@Transactional(readOnly=true)
	@Override
	public void loadFacilityByNo(int facilityNo, Model model) {
		model.addAttribute("facility", facilityMapper.getFacilityByNo(facilityNo));
		model.addAttribute("attachList", facilityMapper.getAttachList(facilityNo));
	}
	
	@Override
	public ResponseEntity<Resource> download(HttpServletRequest request) {
		
		// 첨부 파일 번호 파라미터를 가져와 attachNo로 변환
		int attachNo = Integer.parseInt(request.getParameter("attachNo"));
		FacilityAttachDto attach = facilityMapper.getAttachByNo(attachNo);
		
		// 첨부 파일의 경로와 파일명을 기반으로 Resource 객체를 생성
		File file = new File(attach.getUploadPath(), attach.getFilesystemName());
		Resource resource = new FileSystemResource(file);
		
		// Resource가 존재하지 않으면 404 에러를 반환
		if(!resource.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		// 첨부 파일의 원본 파일명을 가져와서 다운로드할 때 필요한 파일명 변환을 수행
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
		return facilityMapper.updateFacility(facility);
	}
	
	@Override
	public int deleteAttach(int attachNo) {
		return facilityMapper.deleteAttach(attachNo);
	}
	
	@Override
	public int deleteAttach2(int attachNo) {
		return facilityMapper.deleteAttach2(attachNo);
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> getAttachList(int facilityNo) {
		return ResponseEntity.ok(Map.of("attachList", facilityMapper.getAttachList(facilityNo)));
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception {
		
		// 요청에서 파일 목록
		List<MultipartFile> files = multipartRequest.getFiles("files");
		int attachCount = 0;
		// 각 파일에 대해 처리
		for (MultipartFile multipartFile : files) {
			if (multipartFile != null && !multipartFile.isEmpty()) {
				// 파일을 업로드할 경로
				String uploadPath = myFileUtils.getUploadPath();
				File dir = new File(uploadPath);
				if (!dir.exists()) {
						dir.mkdirs();
				}
				
				// 파일의 원본 파일명과 시스템 파일명을 설정하고 파일을 업로드
				String originalFilename = multipartFile.getOriginalFilename();
				String filesystemName = myFileUtils.getFilesystemName(originalFilename);
				File file = new File(dir, filesystemName);
				
				multipartFile.transferTo(file);
				
				// 첨부 파일 정보를 생성
				FacilityAttachDto attach = FacilityAttachDto.builder()
																	 		.uploadPath(uploadPath)
																	 		.originalFilename(originalFilename)
																	 		.filesystemName(filesystemName)
																	 		.facilityNo(Integer.parseInt(multipartRequest.getParameter("facilityNo")))
																	 		.build();
				
				// 생성된 첨부 파일 정보를 데이터베이스에 저장하고 카운트를 증가
				attachCount += facilityMapper.insertFacilityAttach(attach);
			}
		}
		// 결과를 ResponseEntity 형태로 반환합니다 (첨부 파일 개수와 성공 여부를 전달합니다)
		return ResponseEntity.ok(Map.of("attachResult", files.size() == attachCount));
	}

	@Override
	public ResponseEntity<Map<String, Object>> removeAttach(int attachNo) {
		
		// 첨부 파일 번호에 해당하는 첨부 파일 정보
		FacilityAttachDto attach = facilityMapper.getAttachByNo(attachNo);
		
		// 첨부 파일을 실제 파일 시스템에서 삭제
		File file = new File(attach.getUploadPath(), attach.getFilesystemName());
		if(file.exists()) {
			file.delete();
		}
		
		// 데이터베이스에서 첨부 파일 정보를 삭제하고 삭제된 행 수를 받아옵니다
		int deleteCount = facilityMapper.deleteAttach(attachNo);
		
		// 삭제된 행 수를 ResponseEntity 형태로 반환합니다
		return ResponseEntity.ok(Map.of("deleteCount", deleteCount));
	}
	
	@Override
	public int removeFacility(int FacilityNo) {
		
		// 시설 번호에 해당하는 모든 첨부 파일 목록을 조회
		List<FacilityAttachDto> attachList = facilityMapper.getAttachList(FacilityNo);
		for(FacilityAttachDto attach : attachList) {
			
			// 각 첨부 파일을 파일 시스템에서 삭제
			File file = new File(attach.getUploadPath(), attach.getFilesystemName());
			if(file.exists()) {
				file.delete();
			}
		}
			// 데이터베이스에서 시설의 모든 첨부 파일 정보를 삭제
		 facilityMapper.deleteAttach(FacilityNo);
		
		 // 데이터베이스에서 시설 정보를 삭제하고 삭제된 행 수를 반환 
		return facilityMapper.deleteFacility(FacilityNo);
	}
}
