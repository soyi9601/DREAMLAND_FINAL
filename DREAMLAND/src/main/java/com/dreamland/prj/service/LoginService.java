package com.dreamland.prj.service;

import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface LoginService {
  
  EmployeeDto getEmployeeByEmail(String email);
  
  void modifyUserInfo(MultipartFile profilePath, HttpServletRequest request, HttpServletResponse response);  

}
