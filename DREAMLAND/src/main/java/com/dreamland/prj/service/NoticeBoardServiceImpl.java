package com.dreamland.prj.service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.NoticeAttachDto;
import com.dreamland.prj.dto.NoticeBoardDto;
import com.dreamland.prj.mapper.NoticeBoardMapper;
import com.dreamland.prj.utils.MyBoardPageUtils;
import com.dreamland.prj.utils.MyFileUtils;

import jakarta.servlet.http.HttpServletRequest;


@Transactional
@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	
	private final NoticeBoardMapper noticeMapper;
	private final MyBoardPageUtils myBoardPageUtils;
	private final MyFileUtils myFileUtils;
	
	public NoticeBoardServiceImpl(NoticeBoardMapper noticeMapper, MyBoardPageUtils myBoardPageUtils, MyFileUtils myFileUtils) {
		super();
		this.noticeMapper = noticeMapper;
		this.myBoardPageUtils = myBoardPageUtils;
		this.myFileUtils = myFileUtils;
	}

	@Override
	public boolean registerNotice(MultipartHttpServletRequest multipartRequest) {
		
		String boardTitle = multipartRequest.getParameter("boardTitle");
		String boardContents = multipartRequest.getParameter("boardContents");
		int empNo = Integer.parseInt(multipartRequest.getParameter("empNo"));
		
		//자꾸 null값이 들어와서 수정함
		String signalParam = multipartRequest.getParameter("signal");
		int signal = signalParam != null ? Integer.parseInt(signalParam) : 0;
		
		EmployeeDto emp = new EmployeeDto();
		emp.setEmpNo(empNo);
		
		NoticeBoardDto notice = NoticeBoardDto.builder()
																.boardTitle(boardTitle)
																.boardContents(boardContents)
																.employee(emp)
																.signal(signal)
															.build();
		
		int insertNoticeCount = noticeMapper.insertNoticeBoard(notice);
		
		// 첨부파일 처리하기
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
					
					// 썸네일 굳이 만들지 않을 것, 필요 없음
					NoticeAttachDto attach = NoticeAttachDto.builder()
																.uploadPath(uploadPath)
																.filesystemName(filesystemName)
																.originalFilename(originalFilename)
																.noticeNo(notice.getNoticeNo())
															.build();
					
					insertAttachCount += noticeMapper.insertNoticeAttach(attach);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}  // if 코드
		
		} // for multipartFile코드
		
		return (insertNoticeCount == 1) && (insertAttachCount == files.size());
		
		
	} 
	
	@Transactional(readOnly=true)
	@Override
	public void loadNoticeList(Model model) {
		
		Map<String, Object> modelMap = model.asMap();
		HttpServletRequest request = (HttpServletRequest) modelMap.get("request");
		
		int total = noticeMapper.getNoticeCount();
		
		Optional<String> optDisplay = Optional.ofNullable(request.getParameter("display"));
		int display = Integer.parseInt(optDisplay.orElse("15"));
		
		Optional<String> optPage = Optional.ofNullable(request.getParameter("page"));
		int page = Integer.parseInt(optPage.orElse("1"));
		
		myBoardPageUtils.setPaging(total, display, page);
		
    String sort = "desc";
    
    Map<String, Object> map = Map.of("begin", myBoardPageUtils.getBegin()
    															 , "end"  , myBoardPageUtils.getEnd()
    															 , "sort", sort);
		
    model.addAttribute("beginNo", total - (page - 1) * display);
    model.addAttribute("noticeBoardList", noticeMapper.getNoticeList(map));
    model.addAttribute("paging", myBoardPageUtils.getPaging(request.getContextPath() + "/board/notice/list.do", sort, display));
    model.addAttribute("display", display);
    model.addAttribute("sort", sort);
    model.addAttribute("page", page);
		
	}
	
	@Transactional(readOnly=true)
	@Override
	public void loadNoticeByNo(int noticeNo, Model model) {
		model.addAttribute("notice", noticeMapper.getNoticeByNo(noticeNo));
		model.addAttribute("attachList",noticeMapper.getAttachList(noticeNo));
	}
	
	@Override
	public ResponseEntity<Resource> download(HttpServletRequest request) {

		int attachNo = Integer.parseInt(request.getParameter("attachNo"));
		NoticeAttachDto attach = noticeMapper.getAttachByNo(attachNo);
		
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
    
 // 다운로드용 응답 헤더 설정 
    HttpHeaders responseHeader = new HttpHeaders();
    responseHeader.add("Content-Type", "application/octet-stream");
    responseHeader.add("Content-Disposition", "attachment; filename=" + originalFilename);
    responseHeader.add("Content-Length", file.length() + "");
    
 // 다운로드 진행
    return new ResponseEntity<Resource>(resource, responseHeader, HttpStatus.OK);
	}
	
	@Override
	public ResponseEntity<Resource> downloadAll(HttpServletRequest request) {

	// 다운로드 할 모든 첨부 파일들의 정보를 DB 에서 가져오기
    int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
    List<NoticeAttachDto> attachList = noticeMapper.getAttachList(noticeNo);
    
    // 첨부 파일 없을시 종료
    if(attachList.isEmpty()) {
      return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
    }
    
    // 저장 경로
    File tempDir = new File(myFileUtils.getTempPath());
    if(!tempDir.exists()) {
      tempDir.mkdirs();
    }
    
    // 임시 zip 파일 이름
    String tempFilename = myFileUtils.getTempFilename() + ".zip";
    
    // 임시 zip 파일 File 객체
    File tempFile = new File(tempDir, tempFilename);
    
    
    try {
    	// ZipOutputStream 객체 생성
      ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(tempFile));
		
      for (NoticeAttachDto attach : attachList) {
        
        // zip 파일에 포함할 ZipEntry 객체 생성
        ZipEntry zipEntry = new ZipEntry(attach.getOriginalFilename());
        
        // zip 파일에 ZipEntry 객체 명단 추가 (파일의 이름만 등록한 상황)
        zout.putNextEntry(zipEntry);
        
        // 실제 첨부 파일을 zip 파일에 등록 (첨부 파일을 읽어서 zip 파일로 보냄)
        BufferedInputStream in = new BufferedInputStream(new FileInputStream(new File(attach.getUploadPath(), attach.getFilesystemName())));
        zout.write(in.readAllBytes());
        
        // 사용한 자원 정리
        in.close();
        zout.closeEntry();
  
      }  // for
      
      // zout 자원 반납
      zout.close();
    
    
    } catch (Exception e) {
			e.printStackTrace();
		}
    
    // 다운로드 할 zip File 객체 -> Resource 객체
    Resource resource = new FileSystemResource(tempFile);
    
    // 다운로드용 응답 헤더 설정 (HTTP 참조)
    HttpHeaders responseHeader = new HttpHeaders();
    responseHeader.add("Content-Disposition", "attachment; filename=" + tempFilename);
    responseHeader.add("Content-Length", tempFile.length() + "");
    
    // 다운로드 진행
    return new ResponseEntity<Resource>(resource, responseHeader, HttpStatus.OK);
	
	}
	
	@Transactional(readOnly=true)
	@Override
	public NoticeBoardDto getNoticeByNo(int noticeNo) {
		return noticeMapper.getNoticeByNo(noticeNo);
	}

	@Override
	public int modifyNotice(NoticeBoardDto notice) {
		return noticeMapper.updateNotice(notice);
	}
	
	@Override
	public int deleteAttach(int attachNo) {
		return noticeMapper.deleteAttach(attachNo);
	}
	
	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<Map<String, Object>> getAttachList(int noticeNo) {
		return ResponseEntity.ok(Map.of("attachList", noticeMapper.getAttachList(noticeNo)));
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

            NoticeAttachDto attach = NoticeAttachDto.builder()
                .uploadPath(uploadPath)
                .originalFilename(originalFilename)
                .filesystemName(filesystemName)
                .noticeNo(Integer.parseInt(multipartRequest.getParameter("noticeNo")))
                .build();

            attachCount += noticeMapper.insertNoticeAttach(attach);
        }
    }
    return ResponseEntity.ok(Map.of("attachResult", files.size() == attachCount));
		
	}
	
	@Override
	public ResponseEntity<Map<String, Object>> removeAttach(int attachNo) {
		NoticeAttachDto attach = noticeMapper.getAttachByNo(attachNo);
		File file = new File(attach.getUploadPath(),attach.getFilesystemName());
		if(file.exists()) {
			file.delete();
		}
		int deleteCount = noticeMapper.deleteAttach(attachNo);
		return ResponseEntity.ok(Map.of("deleteCount",deleteCount));
	}

	
	@Override
	public int removeNotice(int noticeNo) {

		List<NoticeAttachDto> attachList = noticeMapper.getAttachList(noticeNo);
		for(NoticeAttachDto attach : attachList) {
			
			File file = new File(attach.getUploadPath(), attach.getFilesystemName());
			if(file.exists()) {
				file.delete();
			}
		}
		return noticeMapper.deleteNotice(noticeNo);
	}
	
	@Override
	public int updateHit(int noticeNo) {
		return noticeMapper.updateHit(noticeNo);
	}

	
}
