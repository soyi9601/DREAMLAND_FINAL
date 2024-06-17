package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;

public interface IndexService {

  EmployeeDto loadUser(String email);      // 직원 조회
  
  void workIn(int empNo);                  // 출근
  Map<String, Object> workOut(int empNo);  // 퇴근
  
  boolean hasCheckedWorkIn(int empNo);     // 출근 버튼 눌렀는지 체크
  boolean hasCheckedWorkOut(int empNo);    // 퇴근 버튼 눌렀는지 체크
  void updateCheckedWorkOut();             // 스케쥴러 - 퇴근 버튼 체크
  
  ResponseEntity<Map<String, Object>> getNoticeList(HttpServletRequest request);  // 공지사항 조회
  
  int getReceiveCount(int empNo);       // 쪽지 건수 확인
  
  int getWaitCount(int empNo);          // 내가 승인 해야 할 결재 문서 건수
  int getMyApvCount(int empNo);         // 내가 올린 결재 문서 건수
  
  // List<ScheduleDto> loadSkdList(EmployeeDto emp);    // 나의 일정 조회
}
