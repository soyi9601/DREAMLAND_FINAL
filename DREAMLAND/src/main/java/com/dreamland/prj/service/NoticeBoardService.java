package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dreamland.prj.dto.NoticeAttachDto;
import com.dreamland.prj.dto.NoticeBoardDto;

import jakarta.servlet.http.HttpServletRequest;

@Transactional
@Service
public interface NoticeBoardService {
	boolean registerNotice(MultipartHttpServletRequest multipartRequest);
	void loadNoticeList(Model model); // 게시물목록
	
	void loadNoticeByNo(int noticeNo, Model model); // 게시물각각
	
  ResponseEntity<Resource> download(HttpServletRequest request);
  ResponseEntity<Resource> downloadAll(HttpServletRequest request);
  
  NoticeBoardDto getNoticeByNo(int noticeNo);
  int modifyNotice(NoticeBoardDto notice);
  int deleteAttach(int attachNo);
  
  
   ResponseEntity<Map<String, Object>> getAttachList(int noticeNo);
  // NoticeAttachDto loadAttachList(int noticeNo);
  
  ResponseEntity<Map<String, Object>> addAttach(MultipartHttpServletRequest multipartRequest) throws Exception;
  ResponseEntity<Map<String, Object>> removeAttach(int attachNo);
  int removeNotice(int noticeNo);
  
  int updateHit(int noticeNo);
}
