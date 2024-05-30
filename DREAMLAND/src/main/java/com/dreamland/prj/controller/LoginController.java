package com.dreamland.prj.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.dreamland.prj.config.DBConnectionProvider;
import com.dreamland.prj.dto.EmployeeDto;
import com.dreamland.prj.dto.PrincipalUser;
import com.dreamland.prj.service.EmployeeServiceImpl;
import com.dreamland.prj.service.LoginServiceImpl;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
  
  @Autowired
  private LoginServiceImpl loginService;
  
  // 로그인 실패 출력
  @GetMapping("/auth/login")
  public String login(@RequestParam(value="error", required=false) String error
                    , @RequestParam(value="exception", required=false) String exception
                    , Model model) {
    model.addAttribute("error", error);
    model.addAttribute("exception", exception);
    return "login/loginPage";
  }
  
  // 마이페이지 수정
  @PostMapping("/user/modify.do")
  public String modifyUserInfo(@RequestParam("profilePath") MultipartFile profilePath
                             , @RequestParam("signPath") MultipartFile signPath,
                             HttpServletRequest request) {
    loginService.modifyUserInfo(profilePath, signPath, request);
    EmployeeDto employee = loginService.getEmployeeByEmail(request.getParameter("email"));
   
    
    return "redirect:/user/mypage";
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
  


    
}