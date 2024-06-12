package com.dreamland.prj.service;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface EmployeeService {
  
  // 직원등록시 부서, 직급 가져오기
  void getDeptAndPos(Model model);
  
  
  // 직원등록
  void addEmployee(MultipartFile profilePath
                 , HttpServletRequest request, HttpServletResponse response);  

  
}
