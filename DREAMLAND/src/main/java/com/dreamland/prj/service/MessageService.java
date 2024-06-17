package com.dreamland.prj.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
/******************************************
 * 
 * - 쪽지 서비스
 *   ㄴ 보내기/답장하기/보관하기/삭제하기
 *   ㄴ 받은쪽지함/보낸쪽지함/보관함/휴지통
 * 작성자 : 고은정
 * 
 * ****************************************/
public interface MessageService {
  
  // 받는사람 리스트 가져오기
  List<EmployeeDto> getEmployeeList(Map<String, Object> param);
  
  // 쪽지 보내기
  int insertMessage(HttpServletRequest request);
  
  // 받은쪽지함
  Map<String, Object> getReceiveCount(int empNo);   // 받은 쪽지 개수
  void getReceiveMessage(Model model);  // 받은 쪽지 리스트 페이징 처리
  
  // 보낸쪽지함
  int getSendCount(int empNo);  // 보낸 쪽지 개수
  void getSendMessage(Model model);   // 보낸 쪽지 리스트 페이징 처리
  
  // 상세보기
  void getMessageDetailByReceive(Model model);  // 받은쪽지함에서
  void getMessageDetailBySend(Model model);     // 보낸쪽지함에서
  
  // 중요보관함
  int saveRecMessage(HttpServletRequest request);   // 받은쪽지함에서 보관
  int saveSendMessage(HttpServletRequest request);  // 보낸쪽지함에서 보관
  void getStarMessage(Model model);                 // 보관 쪽지 리스트 페이징 처리
  Map<String, Object> getStarCount(int empNo);      // 보관된 쪽지 개수
  
  // 삭제
  int deleteRecMessage(HttpServletRequest request);   // 받은쪽지함에서 삭제
  int deleteSendMessage(HttpServletRequest request);  // 보낸쪽지함에서 삭제
  void getDeleteMessage(Model model);                 // 휴지통 리스트 페이징 처리
  Map<String, Object> getDeleteCount(int empNo);      // 삭제된 쪽지 개수
  
  // 스케줄러 삭제
  void realDeleteMessage();
  
  // 답장
  void setReply(Model model);
  
}
