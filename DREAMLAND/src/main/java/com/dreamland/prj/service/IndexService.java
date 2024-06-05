package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;

public interface IndexService {

  EmployeeDto loadUser(String email);   // 직원 조회
  /*
  void workIn(int empNo);               // 출근
  void workOut(int empNo);              // 퇴근
  */
  ResponseEntity<Map<String, Object>> getNoticeList(HttpServletRequest request);
}
