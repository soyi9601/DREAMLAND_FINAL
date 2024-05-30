package com.dreamland.prj.service;

import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface LoginService {
  
  EmployeeDto getEmployeeByEmail(String email);
  
  void modifyUserInfo(MultipartFile profilePath
                    , MultipartFile signPath 
                    , HttpServletRequest request);
  
  int modifyPassword(HttpServletRequest request, PrincipalUser user);

}
