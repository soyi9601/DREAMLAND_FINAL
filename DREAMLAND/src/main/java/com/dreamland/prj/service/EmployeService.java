package com.dreamland.prj.service;

import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface EmployeService {

  // 가입 및 탈퇴
  // ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
  // ResponseEntity<Map<String, Object>> sendCode(Map<String, Object> params);
  void addEmployee(MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response);  

  // 로그인 및 로그아웃
  EmployeeDto signin(String username);
   
  // 부서, 직급 가져오기
  String getDeptNameByDeptNo(int deptNo);
  String getPosNameByPosNo(int posNo);
  
  
   
  
  
}
