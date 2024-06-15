package com.dreamland.prj.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.service.LoginService;
import com.dreamland.prj.service.LoginServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class LoginController {
  

  private final LoginService loginService;
  
  // 로그인 실패 출력
  @GetMapping("/auth/login")
  public String login(@RequestParam(value="error", required=false) String error
                    , @RequestParam(value="exception", required=false) String exception
                    , Model model) {
    model.addAttribute("error", error);
    model.addAttribute("exception", exception);
    return "login/loginPage";
  }
  
  // 부서/직급정보 가져오기
  @GetMapping("/user/mypage")
  public String getInfo(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    loginService.getDeptAndPos(model);
    return "user/mypage";
    
  }
  
  // 마이페이지 수정
  @PostMapping("/user/modify.do")
  public String modifyUserInfo(@RequestParam("profilePath") MultipartFile profilePath
                             , HttpServletRequest request) {
    loginService.modifyUserInfo(profilePath, request);
    EmployeeDto employee = loginService.getEmployeeByEmail(request.getParameter("email"));
   
    
    return "redirect:/user/mypage?empNo=" + employee.getEmpNo();
  }
  
  // 비밀번호 변경
  @PostMapping("/user/modifyPassword.do")
  public String modifyPassword(@AuthenticationPrincipal PrincipalUser user, HttpServletRequest request, RedirectAttributes redirectAttributes) {
    int result = loginService.modifyPassword(request, user);
    if(result == 0) {
      redirectAttributes.addFlashAttribute("msg", "현재 비밀번호를 다시 확인해주세요");
      return "redirect:/user/modifyPassword";
    } else {
      redirectAttributes.addFlashAttribute("msg", "비밀번호가  변경되었습니다.");
    }
    return "redirect:/logout";
    
  }
  
  // 임시 비밀번호 발급 - 이메일 체크
  @PostMapping(value="/login/user/checkEmail.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> checkEmail(@RequestBody Map<String, Object> params){
    return loginService.checkEmail(params);
  }
  
  // 임시 비밀번호 발급 - 이메일 전송
  @PostMapping(value="/login/user/sendTempPassword.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> sendTempPw(@RequestBody Map<String, Object> params){
    return loginService.sendTempPw(params);
  }
  


    
}