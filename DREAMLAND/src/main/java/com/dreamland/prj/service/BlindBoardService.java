package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.BlindBoardDto;

import jakarta.servlet.http.HttpServletRequest;


public interface BlindBoardService {
	ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
	int registerBlind(HttpServletRequest request);
	ResponseEntity<Map<String, Object>> getBlindList(HttpServletRequest request);
	List<String> getEditorImageList(String boardContents);
	
	BlindBoardDto getBlindByNo(int blindNo);
	
	int modifyBlind(HttpServletRequest request);
	
	//게시글 비밀번호
	boolean validatePassword(int blindNo, String password);
	int removeBlind(int blindNo);
	// 조회수
	int updateHit(int blindNo);
	// 댓글
	int registerComment(HttpServletRequest request);
	Map<String, Object> getCommentList(HttpServletRequest request);
	// 답글
	int registerReply(HttpServletRequest request);
	int removeComment(int commentNo);
	
	//댓글 비밀번호
	boolean validatePw(int commentNo, String pw);
	
	// 게시글 본인삭제
	int removeUpdate(int blindNo);

	//
	ResponseEntity<Map<String, Object>> getBlindListHot(HttpServletRequest request);

}
