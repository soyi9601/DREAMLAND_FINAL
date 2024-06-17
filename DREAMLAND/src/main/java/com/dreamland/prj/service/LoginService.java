package com.dreamland.prj.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/******************************************
 * 
 * - 로그인
 * - 마이페이지 정보 수정
 * - 임시비밀번호 발급
 * 작성자 : 고은정
 * 
 * ****************************************/
public interface LoginService {
  
  EmployeeDto getEmployeeByEmail(String email);
  
  // 부서/직급 정보 가져오기
  void getDeptAndPos(Model model);
  
  // 마이페이지 수정
  void modifyUserInfo(MultipartFile profilePath 
                    , HttpServletRequest request);
  // 비밀번호 수정
  int modifyPassword(HttpServletRequest request, PrincipalUser user);
  
  // 이메일 체크
  ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
  
  // 임시 비밀번호 발급
  ResponseEntity<Map<String, Object>> sendTempPw(Map<String, Object> params);

}