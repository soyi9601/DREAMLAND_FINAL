package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;

import jakarta.servlet.http.HttpServletRequest;

public interface LoginService {
  
  EmployeeDto getEmployeeByEmail(String email);
  
  void getDeptAndPos(Model model);
  
  // 마이페이지 수정
  void modifyUserInfo(MultipartFile profilePath
                    , MultipartFile signPath 
                    , HttpServletRequest request);
  // 비밀번호 수정
  int modifyPassword(HttpServletRequest request, PrincipalUser user);
  
  // 이메일 체크
  ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
  // 임시 비밀번호 발급
  ResponseEntity<Map<String, Object>> sendTempPw(Map<String, Object> params);

}