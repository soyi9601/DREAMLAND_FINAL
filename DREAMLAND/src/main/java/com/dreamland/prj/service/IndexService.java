package com.dreamland.prj.service;

import com.dreamland.prj.dto.EmployeeDto;

public interface IndexService {

  EmployeeDto loadUser(String email);   // 직원 조회
  
  void workIn(int empNo);               // 출근
  void workOut(int empNo);              // 퇴근
  
}
