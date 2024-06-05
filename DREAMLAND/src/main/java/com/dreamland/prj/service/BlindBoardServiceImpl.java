package com.dreamland.prj.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.BlindBoardDto;
import com.dreamland.prj.dto.BlindCommentDto;
import com.dreamland.prj.dto.BlindImageDto;
import com.dreamland.prj.mapper.BlindBoardMapper;
import com.dreamland.prj.utils.MyFileUtils;
import com.dreamland.prj.utils.MyPageUtils;
import com.dreamland.prj.utils.MySecurityUtils;

import jakarta.servlet.http.HttpServletRequest;


@Transactional
@Service
public class BlindBoardServiceImpl implements BlindBoardService {
	
	private final BlindBoardMapper blindMapper;
	private final MyPageUtils myPageUtils;
	private final MyFileUtils myFileUtils;

	
	public BlindBoardServiceImpl(BlindBoardMapper blindMapper, MyPageUtils myPageUtils, MyFileUtils myFileUtils) {
		super();
		this.blindMapper = blindMapper;
		this.myFileUtils = myFileUtils;
		this.myPageUtils = myPageUtils;
	}

	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile) {

		String uploadPath = myFileUtils.getBlogImageUploadPath();
		File dir = new File(uploadPath);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		String filesystemName = myFileUtils.getFilesystemName(multipartFile.getOriginalFilename());
		
		File file = new File(dir,filesystemName);
		try {
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return new ResponseEntity<>(Map.of("src", uploadPath+"/"+filesystemName)
															,	HttpStatus.OK	);
	}

	@Override
	public int registerBlind(HttpServletRequest request) {

		// 요청 파라미터 
		String boardTitle = request.getParameter("boardTitle");
		String boardContents = request.getParameter("boardContents");
		String password =MySecurityUtils.getSha256(request.getParameter("password"));
	
		BlindBoardDto blind = BlindBoardDto.builder()
														.boardTitle(MySecurityUtils.getPreventXss(boardTitle))
														.boardContents(MySecurityUtils.getPreventXss(boardContents))
														.password(password)
													.build();
		
		int insertCount = blindMapper.insertBlindBoard(blind);
		
		for(String editorImage : getEditorImageList(boardContents)) {
			BlindImageDto blindImage = BlindImageDto.builder()
					.blindNo(blind.getBlindNo())
					.uploadPath(myFileUtils.getBlogImageUploadPath())
					.filesystemName(editorImage)
					.build();
			blindMapper.insertBlindImage(blindImage);
		}

		return insertCount;
	}
	
	
	@Transactional(readOnly=true)
	@Override
	public ResponseEntity<Map<String, Object>> getBlindList(HttpServletRequest request) {

		int total = blindMapper.getBlindCount();
		
		int display = 15;
		
		int page = Integer.parseInt(request.getParameter("page"));
		
		myPageUtils.setPaging(total, display, page);
		
		
		Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
																	 , "end", myPageUtils.getEnd());
		
		return new ResponseEntity<>(Map .of("blindList", blindMapper.getBlindList(map)
																		 , "totalPage", myPageUtils.getTotalPage()
																		 , "totalItems", total
																		 , "pageSize", display)
																		 , HttpStatus.OK);
	}
	
	@Transactional(readOnly=true)
	@Override
	public List<String> getEditorImageList(String boardContents) {
		
		List<String> editorImageList = new ArrayList<>();
		
		Document document = Jsoup.parse(boardContents);
		Elements elements = document.getElementsByTag("img");
		
		if(elements!=null) {
			for(Element element : elements) {
				String src = element.attr("src");
				String filesystemName = src.substring(src.lastIndexOf("/")+1);
				editorImageList.add(filesystemName);
			}
		}
		
		return editorImageList;
	}
	
	
	@Transactional(readOnly=true)
	@Override
	public BlindBoardDto getBlindByNo(int blindNo) {
		return blindMapper.getBlindByNo(blindNo);
	}
	
	@Override
	public int modifyBlind(HttpServletRequest request) {

		String boardTitle = request.getParameter("boardTitle");
		String boardContents = request.getParameter("boardContents");
		String password =MySecurityUtils.getSha256(request.getParameter("password"));
		int blindNo = Integer.parseInt(request.getParameter("blindNo"));
		
		List<BlindImageDto> blindImageDtoList = blindMapper.getBlindImageList(blindNo);
		List<String> blindImageList = blindImageDtoList.stream()
																			.map(blindImageDto -> blindImageDto.getFilesystemName())
																			.collect(Collectors.toList());

		List<String> editorImageList = getEditorImageList(boardContents);
		
		editorImageList.stream()	
			.filter(editorImage -> !blindImageList.contains(editorImage))
			.map(editorImage -> BlindImageDto.builder()
													.blindNo(blindNo)
													.uploadPath(myFileUtils.getBlogImageUploadPath())
													.filesystemName(editorImage)
													.build())
			.forEach(blindImageDto -> blindMapper.insertBlindImage(blindImageDto));
		
		List<BlindImageDto> removeList = blindImageDtoList.stream()
																				.filter(blindImageDto -> !editorImageList.contains(blindImageDto.getFilesystemName()))
																				.collect(Collectors.toList());
		
		for(BlindImageDto blindImageDto : removeList) {
			blindMapper.deleteBlindImage(blindImageDto.getFilesystemName());
			File file = new File(blindImageDto.getUploadPath(), blindImageDto.getFilesystemName());
			if(file.exists()) {
				file.delete();
			}
		}
		
		BlindBoardDto blind = BlindBoardDto.builder()
														.boardTitle(boardTitle)
														.boardContents(boardContents)
														.password(password)
														.blindNo(blindNo)
														.build();
		
		int modifyResult = blindMapper.updateBlind(blind);
														
		return modifyResult;
	}
	
	
	//비밀번호
	@Override
	public boolean validatePassword(int blindNo, String password) {
		String hashedPassword = MySecurityUtils.getSha256(password);
    String storedPassword = blindMapper.getPasswordByBlindNo(blindNo);
    
    return hashedPassword.equals(storedPassword);
	}
	
	
	@Override
	public int removeBlind(int blindNo) {
		
		List<BlindImageDto> blindImageDtoList = blindMapper.getBlindImageList(blindNo);
		for(BlindImageDto blindImage : blindImageDtoList) {
			File file = new File(blindImage.getUploadPath(), blindImage.getFilesystemName());
			if(file.exists()) {
				file.delete();
			}
		}
		
		blindMapper.deleteBlindImageList(blindNo);
		return blindMapper.deleteBlind(blindNo);
	}
	
	
	// 조회수
	@Override
	public int updateHit(int blindNo) {
		return blindMapper.updateHit(blindNo);
	}
	
	// 댓글
	
	@Override
	public int registerComment(HttpServletRequest request) {

		String contents = MySecurityUtils.getPreventXss(request.getParameter("contents"));
		int blindNo = Integer.parseInt(request.getParameter("blindNo"));
		String commentPassword =MySecurityUtils.getSha256(request.getParameter("commentPassword"));
		
		
		
		BlindCommentDto comment = BlindCommentDto.builder()
																	.contents(contents)
																	.blindNo(blindNo)
																	.commentPassword(commentPassword)
																.build();
		
		return blindMapper.insertComment(comment);
	}
	
	
	@Transactional(readOnly=true)
	@Override
	public Map<String, Object> getCommentList(HttpServletRequest request) {

		int blindNo = Integer.parseInt(request.getParameter("blindNo"));
		int page = Integer.parseInt(request.getParameter("page"));
		
		int total = blindMapper.getCommentCount(blindNo);
		
		int display = 10;
		
		myPageUtils.setPaging(total, display, page);
		
		Map<String, Object> map = Map.of("blindNo", blindNo
																	 , "begin", myPageUtils.getBegin()
																	 , "end", myPageUtils.getEnd());
				
		return Map.of("commentList", blindMapper.getCommentList(map)
								, "paging", myPageUtils.getAsyncPaging());
		
	}
	
	@Override
	public int registerReply(HttpServletRequest request) {
		
		String contents = request.getParameter("contents");
		int groupNo = Integer.parseInt(request.getParameter("groupNo"));
    int blindNo = Integer.parseInt(request.getParameter("blindNo"));
    String commentPassword =MySecurityUtils.getSha256(request.getParameter("commentPassword"));
    
    BlindCommentDto reply = BlindCommentDto.builder()
    															.contents(contents)
    															.groupNo(groupNo)
    															.blindNo(blindNo)
    															.commentPassword(commentPassword)
    														.build();
    
		return blindMapper.insertReply(reply);
	}
	
	@Override
	public int removeComment(int commentNo) {
		return blindMapper.deleteComment(commentNo);
	}
	
	
	@Override
	public boolean validatePw(int commentNo, String pw) {
		String hashedPassword = MySecurityUtils.getSha256(pw);
    String storedPassword = blindMapper.getPasswordByCommentNo(commentNo);
    
    return hashedPassword.equals(storedPassword);
	}
	
}
