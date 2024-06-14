package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface EmployeeService {
  
  // 직원등록시 부서, 직급 가져오기
  void getDeptAndPos(Model model);
  
  // 세부부서 가져오기
  ResponseEntity<Map<String, Object>> getDetailDepart(HttpServletRequest request);
  
  
  // 직원등록
  void addEmployee(MultipartFile profilePath
                 , HttpServletRequest request, HttpServletResponse response);  
  
  // 이메일 중복체크
  ResponseEntity<Map<String, Object>> emailCheck(HttpServletRequest request);

  
}
